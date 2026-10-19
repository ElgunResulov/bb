<?php
require_once __DIR__ . '/auth/_auth_helper.php';
require_once __DIR__ . '/auth/_mail_helper.php';
// Tam admin (1) və admin assistant (2) üçün giriş icazəsi
auth_require_admin_or_assistant('/bb/auth/login.php');
$currentUser = auth_get_user();

$userCreateError = '';
$userCreateSuccess = '';
$orderUpdateError = '';
$orderUpdateSuccess = '';
$usersList = [];
$ordersList = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'create_user') {
    require_once __DIR__ . '/config.php';
    $pdo = dbConnect();
    if (!$pdo) {
        $userCreateError = 'Veritabanı xətası.';
    } else {
        $email = isset($_POST['email']) ? trim($_POST['email']) : '';
        $name = isset($_POST['name']) ? trim($_POST['name']) : '';
        $company = isset($_POST['company']) ? trim($_POST['company']) : '';
        $password = isset($_POST['password']) ? $_POST['password'] : '';
        $password2 = isset($_POST['password2']) ? $_POST['password2'] : '';
        // Rol seçimi: user / assistant / admin
        $role = isset($_POST['role']) ? trim($_POST['role']) : 'user';
        // Default olaraq normal user
        $adminStatus = 0;
        if (auth_is_admin()) {
            // Yalnız full admin assistant və admin yarada bilər
            if ($role === 'assistant') {
                $adminStatus = 2;
            } elseif ($role === 'admin') {
                $adminStatus = 1;
            }
        }

        if (empty($email) || empty($password)) {
            $userCreateError = 'Email və parol mütləqdir.';
        } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $userCreateError = 'Düzgün email daxil edin.';
        } elseif (strlen($password) < 6) {
            $userCreateError = 'Parol ən azı 6 simvol olmalıdır.';
        } elseif ($password !== $password2) {
            $userCreateError = 'Parollar üst-üstə düşmür.';
        } else {
            try {
                $stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
                $stmt->execute([$email]);
                if ($stmt->fetch()) {
                    $userCreateError = 'Bu email artıq qeydiyyatdadır.';
                } else {
                    $stmt = $pdo->prepare("INSERT INTO users (email, password_hash, name, company, admin_status) VALUES (?, ?, ?, ?, ?)");
                    $stmt->execute([
                        $email,
                        password_hash($password, PASSWORD_DEFAULT),
                        $name !== '' ? $name : null,
                        $company !== '' ? $company : null,
                        $adminStatus
                    ]);
                    $userCreateSuccess = 'İstifadəçi uğurla yaradıldı.';
                }
            } catch (PDOException $e) {
                if ($e->getCode() == 23000) {
                    $userCreateError = 'Bu email artıq qeydiyyatdadır.';
                } else {
                    $userCreateError = 'Xəta baş verdi. Yenidən cəhd edin.';
                }
            }
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'update_user') {
    require_once __DIR__ . '/config.php';
    $pdo = dbConnect();
    if (!$pdo) {
        $userCreateError = 'Database error.';
    } else {
        $userId = isset($_POST['user_id']) ? (int)$_POST['user_id'] : 0;
        $name = isset($_POST['name']) ? trim($_POST['name']) : '';
        $company = isset($_POST['company']) ? trim($_POST['company']) : '';
        $role = isset($_POST['role']) ? trim($_POST['role']) : 'user';
        // Default olaraq normal user
        $adminStatus = 0;
        if (auth_is_admin()) {
            // Yalnız full admin rolu dəyişə bilər
            if ($role === 'assistant') {
                $adminStatus = 2;
            } elseif ($role === 'admin') {
                $adminStatus = 1;
            }
        } else {
            // Admin assistant rol dəyişməsin, mövcud admin_status-u saxla
            try {
                $stmt = $pdo->prepare("SELECT COALESCE(admin_status, 0) AS admin_status FROM users WHERE id = ?");
                $stmt->execute([$userId]);
                $row = $stmt->fetch(PDO::FETCH_ASSOC);
                if ($row) {
                    $adminStatus = (int)($row['admin_status'] ?? 0);
                }
            } catch (PDOException $e) {
                // Əgər oxuma uğursuz olarsa, default 0 qalır
            }
        }

        if ($userId <= 0) {
            $userCreateError = 'Invalid user ID.';
        } else {
            try {
                $stmt = $pdo->prepare("UPDATE users SET name = ?, company = ?, admin_status = ? WHERE id = ?");
                $stmt->execute([
                    $name !== '' ? $name : null,
                    $company !== '' ? $company : null,
                    $adminStatus,
                    $userId
                ]);
                $userCreateSuccess = 'User updated successfully.';
            } catch (PDOException $e) {
                $userCreateError = 'Failed to update user: ' . $e->getMessage();
            }
        }
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'delete_user') {
    require_once __DIR__ . '/config.php';
    $pdo = dbConnect();
    if (!$pdo) {
        $userCreateError = 'Database error.';
    } else {
        $userId = isset($_POST['user_id']) ? (int)$_POST['user_id'] : 0;
        if ($userId <= 0) {
            $userCreateError = 'Invalid user ID.';
        } else {
            try {
                $stmt = $pdo->prepare("DELETE FROM users WHERE id = ?");
                $stmt->execute([$userId]);
                $userCreateSuccess = 'User deleted successfully.';
            } catch (PDOException $e) {
                $userCreateError = 'Failed to delete user: ' . $e->getMessage();
            }
        }
    }
}

// Veritabanı bağlantısı və siyahılar
try {
    require_once __DIR__ . '/config.php';
    $pdo = dbConnect();
    if ($pdo) {
        // Mövcud istifadəçilər siyahısı
        $stmt = $pdo->query("SELECT id, email, name, company, COALESCE(admin_status, 0) AS admin_status, created_at FROM users ORDER BY id DESC");
        $usersList = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Sifarişlər üzrə admin əməliyyatları
        if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && in_array($_POST['action'], ['approve_order', 'reject_order'], true)) {
            $orderId = isset($_POST['order_id']) ? (int)$_POST['order_id'] : 0;
            if ($orderId > 0) {
                // Önce sifariş + istifadəçi məlumatını götürək
                $stmt = $pdo->prepare("
                    SELECT o.id, o.name, o.total_amount, o.status, o.order_data,
                           u.email AS user_email, u.name AS user_name, u.company AS user_company
                    FROM user_orders o
                    INNER JOIN users u ON u.id = o.user_id
                    WHERE o.id = ?
                ");
                $stmt->execute([$orderId]);
                $orderRow = $stmt->fetch(PDO::FETCH_ASSOC);

                if (!$orderRow) {
                    $orderUpdateError = 'Sifariş tapılmadı.';
                } else {
                    $newStatus = $_POST['action'] === 'approve_order' ? 1 : 2;
                    $stmt = $pdo->prepare("UPDATE user_orders SET status = ? WHERE id = ?");
                    if ($stmt->execute([$newStatus, $orderId])) {
                        $orderUpdateSuccess = $newStatus === 1 ? 'Sifariş təsdiqləndi.' : 'Sifariş rədd edildi.';

                        // Təsdiqlənəndə istifadəçiyə email göndər
                        if ($newStatus === 1 && !empty($orderRow['user_email'])) {
                            @send_order_status_email(
                                $orderRow['user_email'],
                                $newStatus,
                                $orderRow['id'],
                                $orderRow['name'] ?? null,
                                $orderRow['total_amount'] ?? null,
                                $orderRow['order_data'] ?? null
                            );
                        }
                    } else {
                        $orderUpdateError = 'Sifariş yenilənə bilmədi.';
                    }
                }
            } else {
                $orderUpdateError = 'Yanlış sifariş ID.';
            }
        }

        // Bütün sifarişlərin siyahısı (istifadəçi məlumatı ilə)
        $stmt = $pdo->query("
            SELECT o.id, o.name, o.total_amount, o.status, o.created_at,
                   u.email AS user_email, u.name AS user_name, u.company AS user_company
            FROM user_orders o
            INNER JOIN users u ON u.id = o.user_id
            ORDER BY o.created_at DESC
        ");
        $ordersList = $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
} catch (Exception $e) {
    // siyahılar göstərilə bilməsə, səhifə yenə də işləsin
}
?>
<!DOCTYPE html>
<html lang="az">

<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Tour Builder Admin Panel | Destinations Azerbaijan</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#2463eb",
                        "background-light": "#f6f6f8",
                        "background-dark": "#111621"
                    },
                    fontFamily: {
                        "display": ["Inter"]
                    },
                    borderRadius: {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                },
            },
        }
    </script>
    <style>
        :root {
            --primary: #2463eb;
            --primary-glow: rgba(36, 99, 235, 0.15);
            --primary-border: rgba(36, 99, 235, 0.3);
            --surface: #ffffff;
            --surface-2: #f8faff;
            --border: #e8ecf4;
            --text-main: #0f172a;
            --text-sub: #64748b;
            --text-muted: #94a3b8;
        }

        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            color: var(--text-main);
            min-height: 100vh;
            background: linear-gradient(135deg, #eef3ff 0%, #f6f8ff 40%, #fafbff 100%);
        }

        .admin-sidebar {
            width: 260px;
            min-height: 100vh;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border);
            box-shadow: 2px 0 24px rgba(36, 99, 235, 0.06);
            transition: width 0.3s ease, transform 0.3s ease;
            overflow: hidden;
        }

        .admin-sidebar.collapsed {
            width: 0;
            min-width: 0;
            border-right: none;
        }

        .admin-main {
            margin-left: 260px;
            min-width: 0;
            flex: 1;
            transition: margin-left 0.3s ease, width 0.3s ease;
        }

        .admin-main.sidebar-collapsed {
            margin-left: 0 !important;
            width: 100%;
        }

        .admin-nav-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 18px;
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-sub);
            border-radius: 10px;
            margin: 4px 12px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .admin-nav-item:hover {
            background: var(--primary-glow);
            color: var(--primary);
        }

        .admin-nav-item.active {
            background: linear-gradient(135deg, rgba(36, 99, 235, 0.2), rgba(79, 142, 247, 0.15));
            color: var(--primary);
        }

        .admin-nav-item .material-symbols-outlined {
            font-size: 20px;
        }

        .admin-nav-item .badge {
            font-size: 0.7rem;
            padding: 2px 6px;
            border-radius: 999px;
            background: var(--primary);
            color: white;
            margin-left: auto;
        }

        .admin-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 2px 24px rgba(36, 99, 235, 0.07), 0 1px 4px rgba(0, 0, 0, 0.04);
            border: 1px solid var(--border);
            margin-bottom: 24px;
        }

        .admin-card-title {
            font-size: 0.75rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: var(--text-main);
            margin-bottom: 16px;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--border);
        }

        .form-input-admin {
            width: 100%;
            border-radius: 10px;
            border: 1.5px solid var(--border);
            background: var(--surface-2);
            font-size: 0.85rem;
            padding: 10px 14px;
            transition: all 0.2s;
        }

        .form-input-admin:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--primary-glow);
        }

        .btn-primary-admin {
            background: linear-gradient(135deg, #2463eb, #1d4fd8);
            color: white;
            padding: 10px 20px;
            border-radius: 10px;
            font-size: 0.8rem;
            font-weight: 700;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s;
        }

        .btn-primary-admin:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(36, 99, 235, 0.4);
        }

        .btn-logout-admin {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 9px 14px;
            border: 1px solid #fecaca;
            border-radius: 10px;
            color: #dc2626;
            background: #fff;
            font-size: 0.8rem;
            font-weight: 700;
            text-decoration: none;
            transition: background-color 0.2s, border-color 0.2s, color 0.2s;
        }

        .btn-logout-admin:hover,
        .btn-logout-admin:focus-visible {
            border-color: #fca5a5;
            color: #b91c1c;
            background: #fef2f2;
            outline: none;
        }

        .btn-danger {
            background: #fee2e2;
            color: #dc2626;
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 0.75rem;
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-danger:hover {
            background: #fecaca;
        }

        .btn-edit {
            background: #dbeafe;
            color: #1d4ed8;
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 0.75rem;
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-edit:hover {
            background: #bfdbfe;
        }

        .edit-inline .form-input-admin {
            margin: 0;
        }

        .list-item-admin {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 16px;
            background: var(--surface-2);
            border-radius: 10px;
            margin-bottom: 8px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .list-item-admin:hover {
            background: #f0f5ff;
        }

        .panel-section {
            display: none;
        }

        .panel-section.active {
            display: block;
        }

        .header-logo {
            background: linear-gradient(135deg, #2463eb, #4f8ef7);
            box-shadow: 0 4px 12px rgba(36, 99, 235, 0.35);
            border-radius: 10px;
            padding: 8px;
        }

        .stat-card {
            background: linear-gradient(135deg, rgba(36, 99, 235, 0.08), rgba(79, 142, 247, 0.05));
            border: 1px solid rgba(36, 99, 235, 0.2);
            border-radius: 14px;
            padding: 20px;
            transition: all 0.2s;
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(36, 99, 235, 0.15);
        }

        .stat-card .stat-value {
            font-size: 2rem;
            font-weight: 800;
            color: var(--primary);
        }

        .stat-card .stat-label {
            font-size: 0.8rem;
            color: var(--text-sub);
            margin-top: 4px;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.85rem;
        }

        .data-table th,
        .data-table td {
            padding: 10px 14px;
            text-align: left;
            border-bottom: 1px solid var(--border);
        }

        .data-table th {
            background: var(--surface-2);
            font-weight: 700;
            color: var(--text-sub);
        }

        .data-table tr:hover td {
            background: #fafbff;
        }

        .search-input {
            border-radius: 10px;
            padding: 8px 14px;
            border: 1px solid var(--border);
            width: 100%;
            max-width: 300px;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary);
        }
    </style>
</head>

<body class="flex">
    <!-- Sidebar -->
    <aside id="admin-sidebar" class="admin-sidebar fixed left-0 top-0 h-full z-40">
        <div class="p-4 border-b border-gray-200 flex items-center justify-between">
            <a href="tour-builder.php" class="flex items-center gap-3 no-underline text-inherit">
                <div class="header-logo text-white">
                    <span class="material-symbols-outlined text-lg">travel_explore</span>
                </div>
                <div>
                    <div class="font-bold text-sm text-gray-900">Tour Admin</div>
                    <div class="text-xs text-gray-500">Destinations Azerbaijan</div>
                </div>
            </a>
            <button type="button" id="sidebar-close" class="p-2 rounded-lg hover:bg-gray-100 text-gray-600" onclick="toggleSidebar()" title="Sidebarı bağla">
                <span class="material-symbols-outlined">chevron_left</span>
            </button>
        </div>
        <nav class="py-4">
            <div class="admin-nav-item active" data-panel="dashboard">
                <span class="material-symbols-outlined">dashboard</span> Ümumi baxış
            </div>
            <div class="admin-nav-item" data-panel="hotels">
                <span class="material-symbols-outlined">hotel</span> Otellər
                <span class="badge" id="badge-hotels">0</span>
            </div>
            <div class="admin-nav-item" data-panel="activities">
                <span class="material-symbols-outlined">hiking</span> Aktivitetlər
                <span class="badge" id="badge-activities">0</span>
            </div>
            <div class="admin-nav-item" data-panel="transfers">
                <span class="material-symbols-outlined">swap_horiz</span> Transferlər
                <span class="badge" id="badge-transfers">0</span>
            </div>
            <div class="admin-nav-item" data-panel="lists">
                <span class="material-symbols-outlined">list</span> Siyahılar
            </div>
            <div class="admin-nav-item" data-panel="meals">
                <span class="material-symbols-outlined">restaurant</span> Yeməklər
                <span class="badge" id="badge-meals">0</span>
            </div>
            <div class="admin-nav-item" data-panel="orders">
                <span class="material-symbols-outlined">receipt_long</span> Orders
            </div>
            <div class="admin-nav-item" data-panel="invoices-debts">
                <span class="material-symbols-outlined">account_balance</span> Invoices & Debts
            </div>
            <div class="admin-nav-item" data-panel="users">
                <span class="material-symbols-outlined">person_add</span> İstifadəçilər
            </div>

        </nav>
        <div class="absolute bottom-0 left-0 right-0 p-4 border-t border-gray-200">
            <a href="tour-builder.php" class="btn-primary-admin w-full justify-center text-decoration-none">
                <span class="material-symbols-outlined" style="font-size:18px;">open_in_new</span> Tour Builder-a get
            </a>
        </div>
    </aside>

    <!-- Main Content -->
    <main id="admin-main" class="flex-1 p-8 admin-main">
        <header class="mb-8 flex items-center justify-between">
            <div class="flex items-center gap-4">
                <button type="button" id="sidebar-open" class="hidden p-2 rounded-lg hover:bg-gray-100 text-gray-600" onclick="toggleSidebar()" title="Sidebarı aç">
                    <span class="material-symbols-outlined">menu</span>
                </button>
                <div>
                    <h1 class="text-2xl font-extrabold text-gray-900">Tour Builder Admin Panel</h1>
                    <p class="text-sm text-gray-500 mt-1">B2B Tour Builder üçün bütün məlumatları idarə edin və ətraflı baxın.</p>
                </div>
            </div>
            <div class="flex items-center gap-3">
                <button type="button" class="btn-primary-admin" onclick="refreshAllData()">
                    <span class="material-symbols-outlined">refresh</span> Yenilə
                </button>
                <a href="auth/logout.php" class="btn-logout-admin" aria-label="Log out">
                    <span class="material-symbols-outlined" aria-hidden="true" style="font-size:18px;">logout</span>
                    Log out
                </a>
            </div>
        </header>

        <!-- Dashboard -->
        <section id="panel-dashboard" class="panel-section active">
                    <div class="admin-card">
                <h2 class="admin-card-title">Ümumi statistika</h2>
                <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-4" id="dashboard-stats">
                    <!-- Stats filled by JS -->
                </div>
            </div>
            <div class="admin-card">
                    <h2 class="admin-card-title">Quick actions</h2>
                <div class="flex flex-wrap gap-3">
                    <a href="#panel-hotels" class="btn-primary-admin" onclick="showPanel('hotels')">Go to Hotels</a>
                    <a href="#panel-activities" class="btn-primary-admin" onclick="showPanel('activities')">Go to Activities</a>
                    <a href="#panel-transfers" class="btn-primary-admin" onclick="showPanel('transfers')">Go to Transfers</a>
                    <a href="#panel-orders" class="btn-primary-admin" onclick="showPanel('orders')">Orders</a>
                    <a href="#panel-invoices-debts" class="btn-primary-admin" onclick="showPanel('invoices-debts')">Invoices & Debts</a>
                    <a href="#panel-users" class="btn-primary-admin" onclick="showPanel('users')">Create user</a>
                    <a href="#panel-excel-sql" class="btn-primary-admin" onclick="showPanel('excel-sql')">Excel import</a>
                </div>
            </div>
        </section>

        <!-- Hotels -->
        <section id="panel-hotels" class="panel-section">
            <div class="admin-card mb-6">
                <h2 class="admin-card-title">Otelləri Excel-dən yenilə</h2>
                <p class="text-sm text-gray-500 mb-4">Fayldakı mövcud qeydlər yenilənir, yenilər əlavə olunur. Faylda olmayan köhnə qeydlər silinmir.</p>
                <div class="flex flex-wrap gap-3 items-end">
                    <input type="file" id="excel-import-hotels" class="form-input-admin flex-1 min-w-[220px]" accept=".xlsx" />
                    <button type="button" class="btn-primary-admin" onclick="importExcelData('hotels')"><span class="material-symbols-outlined" style="font-size:18px;">upload_file</span> Excel yüklə</button>
                </div>
                <div id="excel-import-status-hotels" class="text-sm mt-3 hidden"></div>
            </div>
            <div class="admin-card">
                <h2 class="admin-card-title">Otel siyahısı (hotel_listing_full / tour_hotels)</h2>
                <input type="text" id="search-hotels" class="search-input mb-4" placeholder="Otel axtar..." onkeyup="filterTable('hotel-table', this.value)" />
                <div class="flex gap-4 mb-6 flex-wrap items-end">
                    <input type="text" id="input-hotel" class="form-input-admin min-w-[160px]" placeholder="Otel adı" />
                    <input type="text" id="input-hotel-room" class="form-input-admin min-w-[180px]" placeholder="Otaq növü" />
                    <input type="number" step="0.01" min="0" id="input-hotel-price" class="form-input-admin w-28" placeholder="Qiymət ($)" />
                    <button type="button" class="btn-primary-admin" onclick="addHotelRoom()">
                        <span class="material-symbols-outlined" style="font-size:18px;">add</span> Əlavə et
                    </button>
                </div>
                <div class="overflow-x-auto max-h-[500px] overflow-y-auto">
                    <table class="data-table" id="hotel-table">
                        <thead>
                            <tr>
                                <th>Otel</th>
                                <th>Otaq növü</th>
                                <th>Qiymət ($)</th>
                                <th>Əməliyyat</th>
                            </tr>
                        </thead>
                        <tbody id="table-hotels"></tbody>
                    </table>
                </div>
                <div class="text-sm text-gray-500 mt-2">* Cədvəl hotel_listing_full / hotelRoomPrices-dan. Əlavə et: hotel_listing_full-a yazır (otel + otaq növü + qiymət). tour_hotels: aşağıdakı siyahı. Excel import: Excel → SQL.</div>
            </div>
            <div class="admin-card mt-6">
                <h2 class="admin-card-title">tour_hotels (əl ilə əlavə olunanlar)</h2>
                <div id="list-hotels"></div>
            </div>
        </section>

        <!-- Activities -->
        <section id="panel-activities" class="panel-section">
            <div class="admin-card mb-6">
                <h2 class="admin-card-title">Aktivitetləri Excel-dən yenilə</h2>
                <p class="text-sm text-gray-500 mb-4">Fayldakı mövcud qeydlər yenilənir, yenilər əlavə olunur. Faylda olmayan köhnə qeydlər silinmir.</p>
                <div class="flex flex-wrap gap-3 items-end">
                    <input type="file" id="excel-import-activities" class="form-input-admin flex-1 min-w-[220px]" accept=".xlsx" />
                    <button type="button" class="btn-primary-admin" onclick="importExcelData('activities')"><span class="material-symbols-outlined" style="font-size:18px;">upload_file</span> Excel yüklə</button>
                </div>
                <div id="excel-import-status-activities" class="text-sm mt-3 hidden"></div>
            </div>
            <div class="admin-card">
                <h2 class="admin-card-title">Aktivitetlər (tour_azerbaijan_activities_2026)</h2>
                <div class="flex gap-4 mb-4 flex-wrap items-end">
                    <input type="text" id="input-activity" class="form-input-admin min-w-[220px]" placeholder="Aktivitet (ad - xidmət)" />
                    <input type="text" id="input-activity-city" class="form-input-admin w-28" placeholder="Şəhər" value="baku" />
                    <input type="number" step="0.01" min="0" id="input-activity-price" class="form-input-admin w-28" placeholder="Qiymət ($)" />
                    <button type="button" class="btn-primary-admin" onclick="addActivity()">
                        <span class="material-symbols-outlined" style="font-size:18px;">add</span> Əlavə et
                    </button>
                </div>
                <input type="text" id="search-activities" class="search-input mb-4" placeholder="Aktivitet axtar..." onkeyup="filterTable('activities-table', this.value)" />
                <div class="overflow-x-auto max-h-[500px] overflow-y-auto">
                    <table class="data-table" id="activities-table">
                        <thead>
                            <tr>
                                <th>Aktivitet</th>
                                <th>Şəhər</th>
                                <th>Qiymət ($)</th>
                                <th>Əməliyyat</th>
                            </tr>
                        </thead>
                        <tbody id="table-activities"></tbody>
                    </table>
                </div>
                <div class="text-sm text-gray-500 mt-2">Aktivitet əlavə edərkən Aktivitet, Şəhər və Qiymət ($) sahələrini doldurun. Excel import da mövcuddur.</div>
            </div>
        </section>

        <!-- Transfers -->
        <section id="panel-transfers" class="panel-section">
            <div class="admin-card mb-6">
                <h2 class="admin-card-title">Transferləri Excel-dən yenilə</h2>
                <p class="text-sm text-gray-500 mb-4">Fayldakı mövcud qeydlər yenilənir, yenilər əlavə olunur. Faylda olmayan köhnə qeydlər silinmir.</p>
                <div class="flex flex-wrap gap-3 items-end">
                    <input type="file" id="excel-import-transfers" class="form-input-admin flex-1 min-w-[220px]" accept=".xlsx" />
                    <button type="button" class="btn-primary-admin" onclick="importExcelData('transfers')"><span class="material-symbols-outlined" style="font-size:18px;">upload_file</span> Excel yüklə</button>
                </div>
                <div id="excel-import-status-transfers" class="text-sm mt-3 hidden"></div>
            </div>
            <div class="admin-card">
                <h2 class="admin-card-title">Transfer marşrutları (transfers cədvəli)</h2>
                <div id="new-route-form" class="mb-4 p-5 bg-gray-50 rounded-xl border border-gray-200 space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div>
                            <label class="block text-xs font-semibold text-gray-600 mb-1">A (From)</label>
                            <input type="text" id="new-route-a" class="form-input-admin w-full" placeholder="Başlanğıc nöqtə" />
                        </div>
                        <div>
                            <label class="block text-xs font-semibold text-gray-600 mb-1">B (To)</label>
                            <input type="text" id="new-route-b" class="form-input-admin w-full" placeholder="Varış nöqtəsi" />
                        </div>
                        <div>
                            <label class="block text-xs font-semibold text-gray-600 mb-1">Service</label>
                            <input type="text" id="new-route-service" class="form-input-admin w-full" placeholder="Xidmət tipi" />
                        </div>
                    </div>
                    <div class="border-t border-gray-200 pt-4">
                        <div class="text-xs font-semibold text-gray-600 mb-3">Vehicle qiymətləri ($)</div>
                        <div id="new-route-vehicle-inputs" class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-3 p-3 bg-white rounded-lg border border-gray-100"></div>
                    </div>
                    <div class="flex justify-end">
                        <button type="button" class="btn-primary-admin" onclick="addTransferRoute()">
                            <span class="material-symbols-outlined" style="font-size:18px;">add</span> Yeni marşrut əlavə et
                        </button>
                    </div>
                </div>
                <input type="text" id="search-transfers" class="search-input mb-4" placeholder="Marşrut axtar..." onkeyup="filterTable('transfers-table', this.value)" />
                <div class="overflow-x-auto max-h-[400px] overflow-y-auto">
                    <table class="data-table" id="transfers-table">
                        <thead id="transfers-thead">
                            <tr>
                                <th>A</th>
                                <th>B</th>
                                <th>Service</th>
                                <th>Əməliyyat</th>
                            </tr>
                        </thead>
                        <tbody id="table-transfers"></tbody>
                    </table>
                </div>
            </div>
            <div class="admin-card mt-6">
                <h2 class="admin-card-title">Transfer nöqtələri (A, B, Service) – tour_transfer_* cədvəlləri</h2>
                <p class="text-sm text-gray-500 mb-4">Əsas transfer məlumatı transfers cədvəlindən gəlir. Aşağıdakı siyahılar köməkçi cədvəllərdəndir.</p>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <div>
                        <h3 class="font-semibold text-sm mb-2">A (From)</h3>
                        <div class="flex gap-2 mb-4">
                            <input type="text" id="input-transfer-a" class="form-input-admin flex-1" placeholder="Yeni nöqtə" />
                            <button type="button" class="btn-primary-admin" onclick="addTransferPoint('transfer-a')">Əlavə et</button>
                        </div>
                        <div id="list-transfer-a" class="space-y-1 max-h-48 overflow-y-auto"></div>
                    </div>
                    <div>
                        <h3 class="font-semibold text-sm mb-2">B (To)</h3>
                        <div class="flex gap-2 mb-4">
                            <input type="text" id="input-transfer-b" class="form-input-admin flex-1" placeholder="Yeni nöqtə" />
                            <button type="button" class="btn-primary-admin" onclick="addTransferPoint('transfer-b')">Əlavə et</button>
                        </div>
                        <div id="list-transfer-b" class="space-y-1 max-h-48 overflow-y-auto"></div>
                    </div>
                    <div>
                        <h3 class="font-semibold text-sm mb-2">Service</h3>
                        <div class="flex gap-2 mb-4">
                            <input type="text" id="input-transfer-svc" class="form-input-admin flex-1" placeholder="Yeni xidmət" />
                            <button type="button" class="btn-primary-admin" onclick="addTransferPoint('transfer-service')">Əlavə et</button>
                        </div>
                        <div id="list-transfer-svc" class="space-y-1 max-h-48 overflow-y-auto"></div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Lists (Countries, Visa, Vehicles, etc.) -->
        <section id="panel-lists" class="panel-section">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="admin-card">
                    <h2 class="admin-card-title">Ölkələr</h2>
                    <div class="flex gap-2 mb-4">
                        <input type="text" id="input-countries" class="form-input-admin flex-1" placeholder="Ölkə adı" />
                        <button type="button" class="btn-primary-admin" onclick="addItem('countries')">Əlavə et</button>
                    </div>
                    <div id="list-countries"></div>
                </div>
                <div class="admin-card">
                    <h2 class="admin-card-title">Viza növləri</h2>
                    <div class="flex gap-2 mb-4">
                        <input type="text" id="input-visa" class="form-input-admin flex-1" placeholder="Viza növü" />
                        <button type="button" class="btn-primary-admin" onclick="addItem('visa')">Əlavə et</button>
                    </div>
                    <div id="list-visa"></div>
                </div>
                <div class="admin-card">
                    <h2 class="admin-card-title">Nəqliyyat növləri</h2>
                    <div class="flex gap-2 mb-4">
                        <input type="text" id="input-vehicles" class="form-input-admin flex-1" placeholder="Vehicle" />
                        <button type="button" class="btn-primary-admin" onclick="addItem('vehicles')">Əlavə et</button>
                    </div>
                    <div id="list-vehicles"></div>
                </div>
                <div class="admin-card">
                    <h2 class="admin-card-title">Su paketləri</h2>
                    <div class="flex gap-2 mb-4">
                        <input type="text" id="input-water" class="form-input-admin flex-1" placeholder="Su paketi" />
                        <button type="button" class="btn-primary-admin" onclick="addItem('water')">Əlavə et</button>
                    </div>
                    <div id="list-water"></div>
                </div>
                <div class="admin-card">
                    <h2 class="admin-card-title">Bələdçi seçimləri</h2>
                    <div class="flex flex-wrap gap-2 mb-4 items-end">
                        <input type="text" id="input-guides" class="form-input-admin flex-1 min-w-[140px]" placeholder="Bələdçi" />
                        <input type="number" step="0.01" min="0" id="input-guides-price" class="form-input-admin w-24" placeholder="Qiymət ($)" />
                        <button type="button" class="btn-primary-admin" onclick="addItem('guides')">Əlavə et</button>
                    </div>
                    <div id="list-guides"></div>
                </div>
                <div class="admin-card">
                    <h2 class="admin-card-title">Turlar (tour_activities)</h2>
                    <div class="flex gap-2 mb-4">
                        <input type="text" id="input-tours" class="form-input-admin flex-1" placeholder="Tur" />
                        <button type="button" class="btn-primary-admin" onclick="addItem('tours')">Əlavə et</button>
                    </div>
                    <div id="list-tours"></div>
                </div>
                <div class="admin-card">
                    <h2 class="admin-card-title">Girişlər / Biletlər</h2>
                    <div class="flex gap-2 mb-4">
                        <input type="text" id="input-entrances" class="form-input-admin flex-1" placeholder="Giriş" />
                        <button type="button" class="btn-primary-admin" onclick="addItem('entrances')">Əlavə et</button>
                    </div>
                    <div id="list-entrances"></div>
                </div>
                <div class="admin-card">
                    <h2 class="admin-card-title">Extra services</h2>
                    <div class="flex flex-wrap gap-2 mb-4 items-end">
                        <input type="text" id="input-extraServices" class="form-input-admin flex-1 min-w-[140px]" placeholder="Service name" />
                        <input type="number" step="0.01" min="0" id="input-extraServices-price" class="form-input-admin w-24" placeholder="Price ($)" />
                        <button type="button" class="btn-primary-admin" onclick="addExtraService()">Əlavə et</button>
                    </div>
                    <div id="list-extraServices"></div>
                </div>
            </div>
        </section>

        <!-- Orders (User Orders Approval) -->
        <section id="panel-orders" class="panel-section">
            <div class="admin-card">
                <h2 class="admin-card-title">User orders</h2>
                <?php if (!empty($orderUpdateSuccess)): ?>
                    <div class="mb-4 p-3 rounded-lg bg-green-50 text-green-700 text-sm"><?= htmlspecialchars($orderUpdateSuccess) ?></div>
                <?php endif; ?>
                <?php if (!empty($orderUpdateError)): ?>
                    <div class="mb-4 p-3 rounded-lg bg-red-50 text-red-700 text-sm"><?= htmlspecialchars($orderUpdateError) ?></div>
                <?php endif; ?>
                <div class="mb-3 flex flex-wrap gap-3 items-center">
                    <input type="text" id="search-orders" class="search-input" placeholder="Search order or user..."
                        onkeyup="filterTable('orders-table', this.value)" />
                </div>
                <div class="overflow-x-auto max-h-[500px] overflow-y-auto">
                    <table class="data-table" id="orders-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Order name</th>
                                <th>User</th>
                                <th>Date</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="table-orders">
                            <?php if (!empty($ordersList)): ?>
                                <?php foreach ($ordersList as $o): ?>
                                    <?php
                                    $status = isset($o['status']) ? (int)$o['status'] : 0;
                                    if ($status === 1) {
                                        $statusLabel = 'Approved';
                                        $statusClass = 'bg-emerald-100 text-emerald-700';
                                    } elseif ($status === 2) {
                                        $statusLabel = 'Rejected';
                                        $statusClass = 'bg-red-100 text-red-700';
                                    } else {
                                        $statusLabel = 'Pending';
                                        $statusClass = 'bg-amber-100 text-amber-700';
                                    }
                                    $canAct = ($status === 0);
                                    ?>
                                    <tr class="cursor-pointer hover:bg-blue-50/50 transition-colors" data-order-id="<?= (int)$o['id'] ?>" data-search="<?= htmlspecialchars(trim(($o['name'] ?? '') . ' ' . ($o['user_email'] ?? '') . ' ' . ($o['user_name'] ?? '') . ' ' . ($o['user_company'] ?? ''))) ?>">
                                        <td><?= (int)$o['id'] ?></td>
                                        <td><?= htmlspecialchars($o['name'] ?: ('Order #' . (int)$o['id'])) ?></td>
                                        <td>
                                            <div class="text-sm font-medium text-gray-800"><?= htmlspecialchars($o['user_name'] ?: $o['user_email']) ?></div>
                                            <?php if (!empty($o['user_company'])): ?>
                                                <div class="text-xs text-gray-500"><?= htmlspecialchars($o['user_company']) ?></div>
                                            <?php endif; ?>
                                            <div class="text-xs text-gray-500"><?= htmlspecialchars($o['user_email']) ?></div>
                                        </td>
                                        <td><?= htmlspecialchars($o['created_at']) ?></td>
                                        <td><?= $o['total_amount'] !== null ? '$' . number_format((float)$o['total_amount'], 2, '.', '') : '–' ?></td>
                                        <td>
                                            <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold <?= $statusClass ?>">
                                                <?= htmlspecialchars($statusLabel) ?>
                                            </span>
                                        </td>
                                        <td>
                                            <?php if ($canAct): ?>
                                                <div class="flex gap-2">
                                                    <form method="post" style="display:inline;">
                                                        <input type="hidden" name="action" value="approve_order" />
                                                        <input type="hidden" name="order_id" value="<?= (int)$o['id'] ?>" />
                                                        <button type="submit" class="btn-edit">Approve</button>
                                                    </form>
                                                    <form method="post" style="display:inline;">
                                                        <input type="hidden" name="action" value="reject_order" />
                                                        <input type="hidden" name="order_id" value="<?= (int)$o['id'] ?>" />
                                                        <button type="submit" class="btn-danger">Reject</button>
                                                    </form>
                                                </div>
                                            <?php else: ?>
                                                <span class="text-xs text-gray-400">No actions</span>
                                            <?php endif; ?>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            <?php else: ?>
                                <tr>
                                    <td colspan="7" class="text-sm text-gray-500 text-center py-4">No orders.</td>
                                </tr>
                            <?php endif; ?>
                        </tbody>
                    </table>
                </div>
                <!-- Modal: Order itinerary -->
                <div id="order-itinerary-modal" class="fixed inset-0 z-50 hidden flex items-center justify-center p-4 bg-black/50" role="dialog" aria-modal="true">
                    <div class="bg-white rounded-xl shadow-xl max-w-2xl w-full max-h-[85vh] flex flex-col">
                        <div class="flex items-center justify-between p-4 border-b border-gray-200">
                            <h3 class="text-lg font-bold text-gray-900">Order itinerary</h3>
                            <button type="button" id="order-itinerary-close" class="p-2 rounded-lg hover:bg-gray-100 text-gray-600" aria-label="Bağla">
                                <span class="material-symbols-outlined">close</span>
                            </button>
                        </div>
                        <div id="order-itinerary-content" class="p-4 overflow-y-auto flex-1 text-sm text-gray-700">
                            Yüklənir...
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Invoices & Debts (Admin view) -->
        <section id="panel-invoices-debts" class="panel-section">
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 items-start">
                <div class="admin-card">
                    <h2 class="admin-card-title">Payment receipts (Invoices)</h2>
                    <p class="text-sm text-gray-500 mb-2">
                        View and manage all user payment receipts uploaded for confirmed orders.
                    </p>
                    <p class="text-xs text-gray-500 mb-3">
                        Select a company on the right to see only that company's invoices.
                    </p>
                    <div class="mb-2 flex flex-wrap gap-3 items-center">
                        <label class="text-xs text-gray-600">
                            Status:
                            <select id="admin-invoice-status-filter" class="form-input-admin inline-block w-auto align-middle">
                                <option value="">All</option>
                                <option value="0">Pending</option>
                                <option value="1">Approved</option>
                                <option value="2">Rejected</option>
                            </select>
                        </label>
                        <button type="button" class="btn-primary-admin" onclick="loadAdminReceipts()">Refresh</button>
                    </div>
                    <div class="mb-3 flex flex-wrap gap-2 items-center text-xs text-gray-600">
                        <span>Selected company:</span>
                        <span id="admin-invoice-selected-label" class="font-semibold text-gray-800">All companies</span>
                        <button type="button" class="text-blue-600 hover:text-blue-800 underline" onclick="resetAdminInvoiceCompanyFilter()">Clear</button>
                    </div>
                    <div id="admin-invoice-loading" class="text-sm text-gray-500 mb-3 hidden">Loading...</div>
                    <div class="overflow-x-auto max-h-[420px] overflow-y-auto">
                        <table class="data-table" id="admin-invoice-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>User</th>
                                    <th>Order</th>
                                    <th>Amount</th>
                                    <th>Status</th>
                                    <th>File</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody id="admin-invoice-tbody">
                                <tr>
                                    <td colspan="7" class="text-sm text-gray-500 text-center py-4">No receipts loaded.</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <p id="admin-invoice-error" class="text-sm text-red-600 mt-3 hidden"></p>
                </div>

                <div class="admin-card">
                    <h2 class="admin-card-title">Debts overview</h2>
                    <p class="text-sm text-gray-500 mb-4">
                        Global view of debts per user order based on confirmed orders and approved receipts.
                    </p>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
                        <div>
                            <p class="text-xs text-gray-500 mb-1">Total debt (confirmed orders)</p>
                            <p id="admin-debts-total" class="text-2xl font-bold text-red-500">$0.00</p>
                        </div>
                        <div>
                            <p class="text-xs text-gray-500 mb-1">Pending payments (receipts pending approval)</p>
                            <p id="admin-debts-pending" class="text-2xl font-bold text-amber-500">$0.00</p>
                        </div>
                        <div>
                            <p class="text-xs text-gray-500 mb-1">Paid amount (approved receipts)</p>
                            <p id="admin-debts-paid" class="text-2xl font-bold text-emerald-500">$0.00</p>
                        </div>
                    </div>
                    <div class="overflow-x-auto max-h-[260px] overflow-y-auto mb-4">
                        <table class="data-table" id="admin-debts-table">
                            <thead>
                                <tr>
                                    <th>Company / User</th>
                                    <th>Email</th>
                                    <th>Total debt</th>
                                    <th>Pending</th>
                                    <th>Paid</th>
                                </tr>
                            </thead>
                            <tbody id="admin-debts-tbody">
                                <tr>
                                    <td colspan="5" class="text-sm text-gray-500 text-center py-4">No data loaded.</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <p id="admin-debts-error" class="text-sm text-red-600 mt-3 hidden"></p>

                    <div class="mt-6 border-t border-gray-200 pt-4">
                        <h3 class="text-xs font-semibold text-gray-700 uppercase tracking-wide mb-2">Orders & payments for selected company</h3>
                        <p id="admin-user-orders-hint" class="text-xs text-gray-500 mb-3">
                            Select a company in the table above to see all its confirmed orders and payments here.
                        </p>
                        <div id="admin-user-orders-container" class="hidden">
                            <div id="admin-user-orders-loading" class="text-sm text-gray-500 mb-2 hidden">Loading...</div>
                            <p id="admin-user-orders-error" class="text-sm text-red-600 mb-2 hidden"></p>
                            <div class="overflow-x-auto max-h-[220px] overflow-y-auto">
                                <table class="data-table" id="admin-user-orders-table">
                                    <thead>
                                        <tr>
                                            <th>Order</th>
                                            <th>Total</th>
                                            <th>Paid</th>
                                            <th>Remaining</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody id="admin-user-orders-tbody">
                                        <tr>
                                            <td colspan="5" class="text-sm text-gray-500 text-center py-4">Select a company above.</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Debts settlement modal -->
        <div id="admin-debts-modal" class="fixed inset-0 hidden items-center justify-center bg-black/40 z-50">
            <div class="bg-white rounded-2xl shadow-2xl max-w-md w-full mx-4">
                <div class="flex items-center justify-between px-5 py-3 border-b border-gray-200">
                    <div>
                        <h3 class="text-base font-semibold text-gray-900">Settle company debt</h3>
                        <p class="text-xs text-gray-500" id="admin-debts-modal-subtitle"></p>
                    </div>
                    <button type="button" id="admin-debts-modal-close" class="p-2 rounded-full hover:bg-gray-100 text-gray-500">
                        <span class="material-symbols-outlined" style="font-size:18px;">close</span>
                    </button>
                </div>
                <div class="px-5 py-4 space-y-3 text-sm text-gray-700">
                    <div>
                        <p><span class="font-medium">Company / User:</span> <span id="admin-debts-modal-name"></span></p>
                        <p><span class="font-medium">Email:</span> <span id="admin-debts-modal-email"></span></p>
                    </div>
                    <div class="grid grid-cols-3 gap-3 text-xs">
                        <div>
                            <p class="text-gray-500 mb-0.5">Total debt</p>
                            <p class="font-semibold text-red-500" id="admin-debts-modal-total"></p>
                        </div>
                        <div>
                            <p class="text-gray-500 mb-0.5">Paid</p>
                            <p class="font-semibold text-emerald-600" id="admin-debts-modal-paid"></p>
                        </div>
                        <div>
                            <p class="text-gray-500 mb-0.5">Remaining</p>
                            <p class="font-semibold text-orange-500" id="admin-debts-modal-remaining"></p>
                        </div>
                    </div>
                    <div class="pt-2 border-t border-gray-200 mt-2">
                        <p class="text-xs text-gray-500 mb-2">Choose how you want to settle this company's debt:</p>
                        <div class="space-y-3">
                            <button type="button" id="admin-debts-btn-full" class="w-full inline-flex items-center justify-center gap-2 px-3 py-2 rounded-lg bg-emerald-600 text-white text-sm font-semibold hover:bg-emerald-700 disabled:opacity-60 disabled:cursor-not-allowed">
                                <span class="material-symbols-outlined" style="font-size:18px;">done_all</span>
                                Mark as fully paid
                            </button>
                            <div class="space-y-2">
                                <div class="flex items-center gap-2">
                                    <input type="number" step="0.01" min="0" id="admin-debts-partial-amount" class="form-input-admin flex-1" placeholder="Partial payment amount (EUR)" />
                                </div>
                                <button type="button" id="admin-debts-btn-partial" class="w-full inline-flex items-center justify-center gap-2 px-3 py-2 rounded-lg bg-blue-600 text-white text-sm font-semibold hover:bg-blue-700 disabled:opacity-60 disabled:cursor-not-allowed">
                                    <span class="material-symbols-outlined" style="font-size:18px;">payments</span>
                                    Record partial payment
                                </button>
                            </div>
                        </div>
                        <p class="text-[11px] text-gray-400 mt-3">Note: settlements are stored as manual payment receipts for this company.</p>
                    </div>
                    <p id="admin-debts-modal-error" class="text-xs text-red-600 mt-1 hidden"></p>
                </div>
            </div>
        </div>

        <!-- Users (Create User + List) -->
        <section id="panel-users" class="panel-section">
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 items-start">
                <div class="admin-card">
                    <h2 class="admin-card-title">Create user (without OTP)</h2>
                    <?php if (!empty($userCreateSuccess)): ?>
                        <div class="mb-4 p-3 rounded-lg bg-green-50 text-green-700 text-sm"><?= htmlspecialchars($userCreateSuccess) ?></div>
                    <?php endif; ?>
                    <?php if (!empty($userCreateError)): ?>
                        <div class="mb-4 p-3 rounded-lg bg-red-50 text-red-700 text-sm"><?= htmlspecialchars($userCreateError) ?></div>
                    <?php endif; ?>
                    <form method="post" class="space-y-4">
                        <input type="hidden" name="action" id="user-form-action" value="create_user" />
                        <input type="hidden" name="user_id" id="user-form-id" value="" />
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Email *</label>
                            <input type="email" name="email" required autocomplete="email"
                                class="form-input-admin"
                                placeholder="email@example.com"
                                value="<?= isset($_POST['email']) && ($_POST['action'] ?? '') === 'create_user' ? htmlspecialchars($_POST['email']) : '' ?>" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Name</label>
                            <input type="text" name="name" autocomplete="name"
                                class="form-input-admin"
                                placeholder="Contact person name"
                                value="<?= isset($_POST['name']) && in_array(($_POST['action'] ?? ''), ['create_user','update_user'], true) ? htmlspecialchars($_POST['name']) : '' ?>" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Company</label>
                            <input type="text" name="company" autocomplete="organization"
                                class="form-input-admin"
                                placeholder="Company name"
                                value="<?= isset($_POST['company']) && in_array(($_POST['action'] ?? ''), ['create_user','update_user'], true) ? htmlspecialchars($_POST['company']) : '' ?>" />
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Password *</label>
                                <input type="password" name="password" id="user-form-password" minlength="6" autocomplete="new-password"
                                    class="form-input-admin"
                                    placeholder="At least 6 characters" />
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Repeat password *</label>
                                <input type="password" name="password2" id="user-form-password2" minlength="6" autocomplete="new-password"
                                    class="form-input-admin"
                                    placeholder="Repeat the password" />
                            </div>
                        </div>
                        <?php if (auth_is_admin()): ?>
                            <div class="flex flex-wrap items-center gap-4">
                                <div class="flex items-center gap-2">
                                    <input type="radio" id="role-user" name="role" value="user" class="h-4 w-4 text-blue-600 border-gray-300 focus:ring-blue-500"
                                        <?= (($_POST['role'] ?? '') === 'assistant' || ($_POST['role'] ?? '') === 'admin') ? '' : 'checked' ?> />
                                    <label for="role-user" class="text-sm text-gray-700">User</label>
                                </div>
                                <div class="flex items-center gap-2">
                                    <input type="radio" id="role-assistant" name="role" value="assistant" class="h-4 w-4 text-blue-600 border-gray-300 focus:ring-blue-500"
                                        <?= (($_POST['role'] ?? '') === 'assistant') ? 'checked' : '' ?> />
                                    <label for="role-assistant" class="text-sm text-gray-700">Admin assistant</label>
                                </div>
                                <div class="flex items-center gap-2">
                                    <input type="radio" id="role-admin" name="role" value="admin" class="h-4 w-4 text-blue-600 border-gray-300 focus:ring-blue-500"
                                        <?= (($_POST['role'] ?? '') === 'admin') ? 'checked' : '' ?> />
                                    <label for="role-admin" class="text-sm text-gray-700">Full admin</label>
                                </div>
                            </div>
                        <?php else: ?>
                            <!-- Admin assistant yalnız adi user yarada bilər -->
                            <input type="hidden" name="role" value="user" />
                            <p class="text-sm text-gray-700">Role: <span class="font-semibold">User</span> (admin assistant yalnız user yarada bilər)</p>
                        <?php endif; ?>
                        <div class="pt-2 flex items-center gap-3">
                            <button type="submit" class="btn-primary-admin" id="user-form-submit">
                                <span class="material-symbols-outlined" style="font-size:18px;">person_add</span>
                                <span id="user-form-submit-label">Create user</span>
                            </button>
                            <button type="button" class="text-xs text-gray-500 hover:text-gray-700 underline hidden" id="user-form-cancel-edit">
                                Cancel edit
                            </button>
                        </div>
                        <p class="mt-3 text-xs text-gray-500">
                            * Users created via this form do not receive an OTP email. You define their initial password.
                        </p>
                    </form>
                </div>

                <div class="admin-card">
                    <h2 class="admin-card-title">Existing users</h2>
                    <div class="mb-3">
                        <input type="text" class="form-input-admin" placeholder="Search user (name, company or email)..."
                            onkeyup="filterTable('users-table', this.value)" />
                    </div>
                    <div class="overflow-x-auto max-h-[420px] overflow-y-auto">
                        <table class="data-table" id="users-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Company</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody id="table-users">
                                <?php if (!empty($usersList)): ?>
                                    <?php foreach ($usersList as $u): ?>
                                        <tr
                                            data-search="<?= htmlspecialchars(trim(($u['name'] ?? '') . ' ' . ($u['company'] ?? '') . ' ' . ($u['email'] ?? ''))) ?>"
                                            data-user-id="<?= (int)$u['id'] ?>"
                                            data-user-email="<?= htmlspecialchars($u['email']) ?>"
                                            data-user-name="<?= htmlspecialchars($u['name'] ?? '') ?>"
                                            data-user-company="<?= htmlspecialchars($u['company'] ?? '') ?>"
                                            data-user-role="<?= (int)$u['admin_status'] ?>"
                                        >
                                            <td><?= (int)$u['id'] ?></td>
                                            <td><?= htmlspecialchars($u['name'] ?: '—') ?></td>
                                            <td><?= htmlspecialchars($u['company'] ?? '—') ?></td>
                                            <td><?= htmlspecialchars($u['email']) ?></td>
                                            <td>
                                                <?php
                                                    $role = (int)($u['admin_status'] ?? 0);
                                                    if ($role === 1):
                                                ?>
                                                    <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-semibold bg-blue-100 text-blue-700">Admin</span>
                                                <?php elseif ($role === 2): ?>
                                                    <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-semibold bg-indigo-100 text-indigo-700">Admin assistant</span>
                                                <?php else: ?>
                                                    <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-semibold bg-gray-100 text-gray-700">User</span>
                                                <?php endif; ?>
                                            </td>
                                            <td>
                                                <div class="flex flex-wrap gap-2">
                                                    <button type="button" class="btn-edit btn-edit-user text-xs">Edit</button>
                                                    <form method="post" onsubmit="return confirm('Are you sure you want to delete this user?');">
                                                        <input type="hidden" name="action" value="delete_user" />
                                                        <input type="hidden" name="user_id" value="<?= (int)$u['id'] ?>" />
                                                        <button type="submit" class="btn-danger text-xs">Delete</button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                <?php else: ?>
                                    <tr>
                                        <td colspan="6" class="text-sm text-gray-500 text-center py-4">No users.</td>
                                    </tr>
                                <?php endif; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>

        <!-- Meals -->
        <section id="panel-meals" class="panel-section">
            <div class="admin-card mb-6">
                <h2 class="admin-card-title">Yeməkləri Excel-dən yenilə</h2>
                <p class="text-sm text-gray-500 mb-4">Fayldakı mövcud qeydlər yenilənir, yenilər əlavə olunur. Faylda olmayan köhnə qeydlər silinmir.</p>
                <div class="flex flex-wrap gap-3 items-end">
                    <input type="file" id="excel-import-meals" class="form-input-admin flex-1 min-w-[220px]" accept=".xlsx" />
                    <button type="button" class="btn-primary-admin" onclick="importExcelData('meals')"><span class="material-symbols-outlined" style="font-size:18px;">upload_file</span> Excel yüklə</button>
                </div>
                <div id="excel-import-status-meals" class="text-sm mt-3 hidden"></div>
            </div>
            <div class="admin-card mb-6">
                <h2 class="admin-card-title">Yemək seçimləri şəhər üzrə</h2>
                <div id="meals-summary" class="grid grid-cols-2 md:grid-cols-4 gap-4"></div>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="admin-card">
                    <h2 class="admin-card-title">Səhər yeməyi</h2>
                    <div class="flex flex-wrap gap-2 mb-4 items-end">
                        <input type="text" id="input-meals-breakfast" class="form-input-admin flex-1 min-w-[140px]" placeholder="Seçim" />
                        <input type="text" id="input-meals-breakfast-city" class="form-input-admin w-24" placeholder="Şəhər" value="baku" />
                        <input type="number" step="0.01" min="0" id="input-meals-breakfast-price" class="form-input-admin w-24" placeholder="Qiymət ($)" />
                        <button type="button" class="btn-primary-admin" onclick="addMealOption('breakfast')">Əlavə et</button>
                    </div>
                    <div id="list-meals-breakfast"></div>
                </div>
                <div class="admin-card">
                    <h2 class="admin-card-title">Nahar</h2>
                    <div class="flex flex-wrap gap-2 mb-4 items-end">
                        <input type="text" id="input-meals-lunch" class="form-input-admin flex-1 min-w-[140px]" placeholder="Seçim" />
                        <input type="text" id="input-meals-lunch-city" class="form-input-admin w-24" placeholder="Şəhər" value="baku" />
                        <input type="number" step="0.01" min="0" id="input-meals-lunch-price" class="form-input-admin w-24" placeholder="Qiymət ($)" />
                        <button type="button" class="btn-primary-admin" onclick="addMealOption('lunch')">Əlavə et</button>
                    </div>
                    <div id="list-meals-lunch"></div>
                </div>
                <div class="admin-card">
                    <h2 class="admin-card-title">Şam yeməyi</h2>
                    <div class="flex flex-wrap gap-2 mb-4 items-end">
                        <input type="text" id="input-meals-dinner" class="form-input-admin flex-1 min-w-[140px]" placeholder="Seçim" />
                        <input type="text" id="input-meals-dinner-city" class="form-input-admin w-24" placeholder="Şəhər" value="baku" />
                        <input type="number" step="0.01" min="0" id="input-meals-dinner-price" class="form-input-admin w-24" placeholder="Qiymət ($)" />
                        <button type="button" class="btn-primary-admin" onclick="addMealOption('dinner')">Əlavə et</button>
                    </div>
                    <div id="list-meals-dinner"></div>
                </div>
            </div>
        </section>

        <!-- Excel → SQL -->
        <section id="panel-excel-sql" class="panel-section">
            <div class="admin-card">
                <h2 class="admin-card-title">Excel Upload → SQL Generate</h2>
                <p class="text-sm text-gray-500 mb-4">Excel faylını yükləyin, SQL avtomatik generasiya olunsun. Activities, Hotels və ya Transfers formatı üçün.</p>
                <div class="flex flex-wrap gap-4 items-end mb-6">
                    <div class="flex-1 min-w-[200px]">
                        <label class="block text-xs font-semibold text-gray-600 mb-1">Tip</label>
                        <select id="excel-sql-type" class="form-input-admin">
                            <option value="activities">Activities (tour_azerbaijan_activities_2026)</option>
                            <option value="hotels">Hotels (tour_hotels + tour_hotel_prices)</option>
                            <option value="transfers">Transfers (tour_transfer_point_a/b/services)</option>
                        </select>
                    </div>
                    <div class="flex-1 min-w-[200px]">
                        <label class="block text-xs font-semibold text-gray-600 mb-1">Excel faylı (.xlsx)</label>
                        <input type="file" id="excel-sql-file" class="form-input-admin" accept=".xlsx,.xls" />
                    </div>
                    <button type="button" class="btn-primary-admin" onclick="generateSqlFromExcel()">
                        <span class="material-symbols-outlined" style="font-size:18px;">code</span> SQL Generasiya et
                    </button>
                </div>
                <div id="excel-sql-status" class="text-sm text-gray-500 mb-3 hidden"></div>
                <button type="button" id="excel-sql-download" class="btn-primary-admin hidden mb-4" onclick="downloadGeneratedSql()">
                    <span class="material-symbols-outlined" style="font-size:18px;">download</span> SQL Endir
                </button>
                <textarea id="excel-sql-output" class="form-input-admin font-mono text-xs" rows="16" readonly placeholder="SQL burada görünəcək..."></textarea>
            </div>
        </section>
    </main>

    <script>
        const API_URL = 'api/tour-config.php';
        const ADMIN_DATA_URL = 'api/admin-data.php';
        const defaultData = {
            hotels: [],
            tours: [],
            entrances: [],
            countries: [],
            vehicles: [],
            water: [],
            guides: [],
            visa: [],
            extraServices: [],
            meals: {
                breakfast: [],
                lunch: [],
                dinner: []
            }
        };
        let cachedData = null;
        let adminData = null;
        let selectedMealsCity = 'baku';

        function getData(callback) {
            if (cachedData && typeof callback !== 'function') return cachedData;
            fetch(API_URL)
                .then(r => r.ok ? r.json() : Promise.reject())
                .then(data => {
                    cachedData = {
                        countries: data.countries || [],
                        visa: data.visa || [],
                        vehicles: data.vehicles || [],
                        water: data.water || [],
                        guides: data.guides || [],
                        hotels: data.hotels || [],
                        tours: data.tours || [],
                        entrances: data.entrances || [],
                        extraServices: data.extraServices || data.extras || [],
                        meals: data.meals && data.meals.breakfast ? data.meals : {
                            breakfast: [],
                            lunch: [],
                            dinner: []
                        }
                    };
                    if (typeof callback === 'function') callback(cachedData);
                })
                .catch(() => {
                    cachedData = null;
                    if (typeof callback === 'function') callback(null);
                });
        }

        function getAdminData(callback) {
            cachedData = null;
            fetch(ADMIN_DATA_URL)
                .then(r => r.ok ? r.json() : Promise.reject())
                .then(res => {
                    if (!res || !res.ok) throw new Error('API error');
                    adminData = res;
                    cachedData = {
                        countries: (res.data && res.data.countries) || [],
                        visa: (res.data && res.data.visa) || [],
                        vehicles: (res.data && res.data.vehicles) || [],
                        water: (res.data && res.data.water) || [],
                        guides: (res.data && res.data.guides) || [],
                        hotels: res.tourHotelsList || [],
                        tours: (res.data && res.data.tours) || [],
                        entrances: (res.data && res.data.entrances) || [],
                        extraServices: (res.data && (res.data.extraServices || res.data.extras)) || [],
                        meals: (res.data && res.data.mealsByCity) ? normalizeMealsFromDb(res.data.mealsByCity) : (res.data && res.data.meals) || {
                            breakfast: [],
                            lunch: [],
                            dinner: []
                        }
                    };
                    if (typeof callback === 'function') callback(res);
                })
                .catch((err) => {
                    adminData = null;
                    cachedData = null;
                    if (typeof callback === 'function') callback(null);
                });
        }

        function normalizeMealsFromDb(mealsByCity) {
            const out = {
                breakfast: [],
                lunch: [],
                dinner: []
            };
            if (!mealsByCity || typeof mealsByCity !== 'object') return out;
            const primaryCity = mealsByCity.baku ? 'baku' : (Object.keys(mealsByCity)[0] || 'baku');
            return normalizeMealsForCity(mealsByCity, primaryCity);
        }

        function normalizeMealsForCity(mealsByCity, city) {
            const out = {
                breakfast: [],
                lunch: [],
                dinner: []
            };
            if (!mealsByCity || typeof mealsByCity !== 'object') return out;
            const primary = mealsByCity[city] || {};
            ['breakfast', 'lunch', 'dinner'].forEach(t => {
                const arr = primary[t] || [];
                out[t] = Array.isArray(arr) ? arr.map(x => {
                    const obj = typeof x === 'object' && (x.value != null || x.label != null) ? x : {
                        value: x,
                        label: x
                    };
                    if (typeof obj === 'object' && !obj.city) obj.city = city;
                    return obj;
                }) : [];
            });
            return out;
        }

        function selectMealsCity(city) {
            selectedMealsCity = city || 'baku';
            ['breakfast', 'lunch', 'dinner'].forEach(type => {
                const cityInput = document.getElementById('input-meals-' + type + '-city');
                if (cityInput) cityInput.value = selectedMealsCity;
            });
            renderMealsSummary();
            renderMeals(cachedData || defaultData);
        }

        function refreshAllData() {
            getAdminData(() => {
                if (!adminData || !adminData.ok) {
                    const el = document.getElementById('dashboard-stats');
                    if (el) el.innerHTML = '<div class="col-span-full p-4 rounded-lg bg-red-50 text-red-700">Veritabanından məlumat alına bilmədi. config.php və veritabanı bağlantısını yoxlayın.</div>';
                    return;
                }
                renderAll();
                renderDashboard();
                renderHotelTable();
                renderActivitiesTable();
                renderTransfersTable();
                renderMealsSummary();
            });
        }

        function apiPost(body, done) {
            fetch(API_URL, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(body)
                })
                .then(r => r.json())
                .then(res => {
                    if (res && res.ok) cachedData = null;
                    if (typeof done === 'function') done(res);
                })
                .catch(() => {
                    if (typeof done === 'function') done({
                        ok: false
                    });
                });
        }

        function addItem(key) {
            const input = document.getElementById('input-' + key);
            const val = (input && input.value || '').trim();
            if (!val) return;

            // Guides üçün ayrıca qiymət sahəsi
            if (key === 'guides') {
                const priceInput = document.getElementById('input-guides-price');
                const priceVal = priceInput && priceInput.value !== '' && !isNaN(parseFloat(priceInput.value)) ? parseFloat(priceInput.value) : null;
                apiPost({
                    action: 'add',
                    key: key,
                    value: val,
                    price: priceVal
                }, () => {
                    if (input) input.value = '';
                    if (priceInput) priceInput.value = '';
                    refreshAllData();
                });
                return;
            }

            apiPost({
                action: 'add',
                key: key,
                value: val
            }, () => {
                input.value = '';
                refreshAllData();
            });
        }

        function addExtraService() {
            const nameInput = document.getElementById('input-extraServices');
            const priceInput = document.getElementById('input-extraServices-price');
            const nameVal = (nameInput && nameInput.value || '').trim();
            const priceVal = priceInput && priceInput.value !== '' && !isNaN(parseFloat(priceInput.value)) ? parseFloat(priceInput.value) : null;
            if (!nameVal) {
                alert('Service name is required.');
                return;
            }
            apiPost({
                action: 'add',
                key: 'extraServices',
                value: nameVal,
                price: priceVal
            }, () => {
                if (nameInput) nameInput.value = '';
                if (priceInput) priceInput.value = '';
                refreshAllData();
            });
        }

        function removeItem(key, index) {
            const data = cachedData || defaultData;
            const arr = Array.isArray(data[key]) ? data[key] : [];
            const val = arr[index];
            if (val == null) return;
            const value = typeof val === 'object' && (val.value != null || val.label != null) ? (val.value || val.label) : val;
            if (!confirm('"' + value + '" silinsin?')) return;
            apiPost({
                action: 'remove',
                key: key,
                value: value
            }, (res) => {
                if (res && res.ok) refreshAllData();
                else if (res && res.error) alert(res.error);
            });
        }

        function startEditItem(key, index) {
            const listEl = document.getElementById('list-' + key);
            if (!listEl) return;
            const items = listEl.querySelectorAll('.list-item-admin');
            const itemEl = items[index];
            if (!itemEl || itemEl.querySelector('.edit-inline')) return;
            const val = (itemEl.getAttribute('data-old-val') || '').trim();
            itemEl.innerHTML = '<div class="edit-inline flex gap-2 flex-1 items-center">' +
                '<input type="text" class="form-input-admin flex-1 edit-input" value="' + escapeHtml(val) + '" data-old-val="' + escapeHtml(val) + '" />' +
                '<button type="button" class="btn-primary-admin" onclick="saveEditItem(\'' + key + '\')">Yadda saxla</button>' +
                '<button type="button" class="btn-edit" onclick="cancelEditItem(\'' + key + '\')">Ləğv</button>' +
                '</div>';
            itemEl.querySelector('.edit-input').focus();
        }

        function saveEditItem(key) {
            const listEl = document.getElementById('list-' + key);
            const input = listEl && listEl.querySelector('.edit-input');
            if (!input) return;
            const newVal = (input.value || '').trim();
            const oldVal = input.getAttribute('data-old-val') || '';
            if (!newVal) return;
            apiPost({
                action: 'update',
                key: key,
                oldValue: oldVal,
                value: newVal
            }, () => refreshAllData());
        }

        function cancelEditItem(key) {
            refreshAllData();
        }

        function startEditMeal(mealType, index) {
            const listEl = document.getElementById('list-meals-' + mealType);
            if (!listEl) return;
            const items = listEl.querySelectorAll('.list-item-admin');
            const itemEl = items[index];
            if (!itemEl || itemEl.querySelector('.edit-inline')) return;
            const val = (itemEl.getAttribute('data-old-val') || '').trim();
            const oldCity = (itemEl.getAttribute('data-old-city') || 'baku').trim();
            const oldPrice = (itemEl.getAttribute('data-old-price') || '').trim();
            itemEl.innerHTML = '<div class="edit-inline flex gap-2 flex-1 items-center flex-wrap edit-meal-form" data-old-val="' + escapeHtml(val) + '" data-old-city="' + escapeHtml(oldCity) + '">' +
                '<input type="text" class="form-input-admin flex-1 min-w-[160px] edit-meal-name" value="' + escapeHtml(val) + '" placeholder="Seçim" />' +
                '<input type="text" class="form-input-admin w-24 edit-meal-city" value="' + escapeHtml(oldCity) + '" placeholder="Şəhər" />' +
                '<input type="number" step="0.01" min="0" class="form-input-admin w-24 edit-meal-price" value="' + escapeHtml(oldPrice) + '" placeholder="Qiymət ($)" />' +
                '<button type="button" class="btn-primary-admin" onclick="saveEditMeal(\'' + mealType + '\')">Yadda saxla</button>' +
                '<button type="button" class="btn-edit" onclick="cancelEditItem(\'meals\')">Ləğv</button>' +
                '</div>';
            itemEl.querySelector('.edit-meal-name').focus();
        }

        function saveEditMeal(mealType) {
            const form = document.querySelector('.edit-meal-form');
            const nameInput = document.querySelector('.edit-meal-name');
            const cityInput = document.querySelector('.edit-meal-city');
            const priceInput = document.querySelector('.edit-meal-price');
            if (!form || !nameInput) return;
            const oldVal = form.getAttribute('data-old-val') || '';
            const oldCity = form.getAttribute('data-old-city') || 'baku';
            const newVal = (nameInput.value || '').trim();
            const newCity = (cityInput && cityInput.value || '').trim() || 'baku';
            const newPrice = priceInput && priceInput.value !== '' && !isNaN(parseFloat(priceInput.value)) ? parseFloat(priceInput.value) : null;
            if (!newVal) return;
            apiPost({
                action: 'update',
                key: 'meals-' + mealType,
                oldValue: oldVal,
                value: newVal,
                oldCity: oldCity,
                city: newCity,
                price: newPrice
            }, () => refreshAllData());
        }

        function addMealOption(mealType) {
            const input = document.getElementById('input-meals-' + mealType);
            const cityInput = document.getElementById('input-meals-' + mealType + '-city');
            const priceInput = document.getElementById('input-meals-' + mealType + '-price');
            const val = (input && input.value || '').trim();
            const city = (cityInput && cityInput.value || '').trim() || 'baku';
            const priceVal = priceInput && priceInput.value !== '' && !isNaN(parseFloat(priceInput.value)) ? parseFloat(priceInput.value) : null;
            if (!val) {
                alert('Seçim mütləqdir.');
                return;
            }
            apiPost({
                action: 'add',
                key: 'meals-' + mealType,
                value: val,
                city: city,
                price: priceVal
            }, () => {
                if (input) input.value = '';
                if (priceInput) priceInput.value = '';
                refreshAllData();
            });
        }

        function removeMealOption(mealType, index) {
            const mealsByCity = adminData && adminData.data && adminData.data.mealsByCity ? adminData.data.mealsByCity : null;
            const meals = mealsByCity && selectedMealsCity ? normalizeMealsForCity(mealsByCity, selectedMealsCity) : (cachedData && cachedData.meals) || {
                breakfast: [],
                lunch: [],
                dinner: []
            };
            const arr = meals[mealType] || [];
            const val = arr[index];
            if (!val) return;
            const value = typeof val === 'object' && val.value != null ? val.value : val;
            const city = typeof val === 'object' && val.city ? val.city : selectedMealsCity || 'baku';
            if (!confirm('"' + value + '" silinsin?')) return;
            apiPost({
                action: 'remove',
                key: 'meals-' + mealType,
                value: value,
                city: city
            }, () => refreshAllData());
        }

        function renderList(key, data) {
            const listEl = document.getElementById('list-' + key);
            if (!listEl) return;
            data = data || cachedData || defaultData;
            let arr = data[key] || [];

            // Special rendering for guides: name + price (if any)
            if (key === 'guides') {
                listEl.innerHTML = (arr || []).map((item, i) => {
                    const name = typeof item === 'object' ? (item.label || item.value || '') : String(item);
                    const price = typeof item === 'object' && item.price != null && item.price !== ''
                        ? Number(item.price).toFixed(2)
                        : '';
                    return `
                    <div class="list-item-admin flex justify-between items-center" data-old-val="${escapeHtml(String(name))}" data-old-price="${escapeHtml(String(price))}">
                        <span>
                            ${escapeHtml(name)}${price !== '' ? ' — $' + escapeHtml(price) : ''}
                        </span>
                        <span class="flex gap-1">
                            <button type="button" class="btn-edit" onclick="startEditGuide(${i})">
                                <span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">edit</span> Redaktə
                            </button>
                            <button type="button" class="btn-danger" onclick="removeItem('guides', ${i})">
                                <span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">delete</span> Sil
                            </button>
                        </span>
                    </div>
                    `;
                }).join('');
                return;
            }

            // Special rendering for extraServices: show name + price
            if (key === 'extraServices') {
                listEl.innerHTML = (arr || []).map((item, i) => {
                    const name = typeof item === 'object' ? (item.label || item.value || '') : String(item);
                    const price = typeof item === 'object' && item.price != null && item.price !== ''
                        ? Number(item.price).toFixed(2)
                        : '';
                    return `
                    <div class="list-item-admin flex justify-between items-center" data-old-val="${escapeHtml(String(name))}" data-old-price="${escapeHtml(String(price))}">
                        <span>
                            ${escapeHtml(name)}${price !== '' ? ' — $' + escapeHtml(price) : ''}
                        </span>
                        <span class="flex gap-1">
                            <button type="button" class="btn-edit" onclick="startEditExtraService(${i})">
                                <span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">edit</span> Redaktə
                            </button>
                            <button type="button" class="btn-danger" onclick="removeItem('extraServices', ${i})">
                                <span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">delete</span> Sil
                            </button>
                        </span>
                    </div>
                    `;
                }).join('');
                return;
            }

            // Default simple list rendering
            if (Array.isArray(arr) && arr.length && typeof arr[0] === 'object' && arr[0].value != null) {
                arr = arr.map(x => x.value || x.label || x);
            }
            listEl.innerHTML = arr.map((item, i) => {
                const val = typeof item === 'object' ? (item.label || item.value || '') : item;
                return `
                <div class="list-item-admin" data-old-val="${escapeHtml(String(val))}">
                    <span>${escapeHtml(val)}</span>
                    <span class="flex gap-1">
                        <button type="button" class="btn-edit" onclick="startEditItem('${key}', ${i})">
                            <span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">edit</span> Redaktə
                        </button>
                        <button type="button" class="btn-danger" onclick="removeItem('${key}', ${i})">
                            <span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">delete</span> Sil
                        </button>
                    </span>
                </div>
                `;
            }).join('');
        }

        function startEditExtraService(index) {
            const listEl = document.getElementById('list-extraServices');
            if (!listEl) return;
            const items = listEl.querySelectorAll('.list-item-admin');
            const itemEl = items[index];
            if (!itemEl || itemEl.querySelector('.edit-inline')) return;
            const oldName = (itemEl.getAttribute('data-old-val') || '').trim();
            const oldPrice = (itemEl.getAttribute('data-old-price') || '').trim();
            itemEl.innerHTML = '<div class="edit-inline flex gap-2 flex-1 items-center flex-wrap edit-extra-form" data-old-val="' + escapeHtml(oldName) + '">' +
                '<input type="text" class="form-input-admin flex-1 min-w-[160px] edit-extra-name" value="' + escapeHtml(oldName) + '" placeholder="Service name" />' +
                '<input type="number" step="0.01" min="0" class="form-input-admin w-24 edit-extra-price" value="' + escapeHtml(oldPrice) + '" placeholder="Price ($)" />' +
                '<button type="button" class="btn-primary-admin" onclick="saveEditExtraService()">Yadda saxla</button>' +
                '<button type="button" class="btn-edit" onclick="cancelEditItem(\'extraServices\')">Ləğv</button>' +
                '</div>';
            const nameInput = itemEl.querySelector('.edit-extra-name');
            if (nameInput) nameInput.focus();
        }

        function startEditGuide(index) {
            const listEl = document.getElementById('list-guides');
            if (!listEl) return;
            const items = listEl.querySelectorAll('.list-item-admin');
            const itemEl = items[index];
            if (!itemEl || itemEl.querySelector('.edit-inline')) return;
            const oldName = (itemEl.getAttribute('data-old-val') || '').trim();
            const oldPrice = (itemEl.getAttribute('data-old-price') || '').trim();
            itemEl.innerHTML = '<div class="edit-inline flex gap-2 flex-1 items-center flex-wrap edit-guide-form" data-old-val="' + escapeHtml(oldName) + '">' +
                '<input type="text" class="form-input-admin flex-1 min-w-[160px] edit-guide-name" value="' + escapeHtml(oldName) + '" placeholder="Bələdçi" />' +
                '<input type="number" step="0.01" min="0" class="form-input-admin w-24 edit-guide-price" value="' + escapeHtml(oldPrice) + '" placeholder="Qiymət ($)" />' +
                '<button type="button" class="btn-primary-admin" onclick="saveEditGuide()">Yadda saxla</button>' +
                '<button type="button" class="btn-edit" onclick="cancelEditItem(\'guides\')">Ləğv</button>' +
                '</div>';
            const nameInput = itemEl.querySelector('.edit-guide-name');
            if (nameInput) nameInput.focus();
        }

        function saveEditGuide() {
            const form = document.querySelector('.edit-guide-form');
            if (!form) return;
            const nameInput = form.querySelector('.edit-guide-name');
            const priceInput = form.querySelector('.edit-guide-price');
            const oldVal = form.getAttribute('data-old-val') || '';
            const newName = (nameInput && nameInput.value || '').trim();
            const newPrice = priceInput && priceInput.value !== '' && !isNaN(parseFloat(priceInput.value)) ? parseFloat(priceInput.value) : null;
            if (!newName) {
                alert('Bələdçi adı mütləqdir.');
                return;
            }
            apiPost({
                action: 'update',
                key: 'guides',
                oldValue: oldVal,
                value: newName,
                price: newPrice
            }, () => refreshAllData());
        }

        function saveEditExtraService() {
            const form = document.querySelector('.edit-extra-form');
            if (!form) return;
            const nameInput = form.querySelector('.edit-extra-name');
            const priceInput = form.querySelector('.edit-extra-price');
            const oldVal = form.getAttribute('data-old-val') || '';
            const newName = (nameInput && nameInput.value || '').trim();
            const newPrice = priceInput && priceInput.value !== '' && !isNaN(parseFloat(priceInput.value)) ? parseFloat(priceInput.value) : null;
            if (!newName) {
                alert('Service name is required.');
                return;
            }
            apiPost({
                action: 'update',
                key: 'extraServices',
                oldValue: oldVal,
                value: newName,
                price: newPrice
            }, () => refreshAllData());
        }

        function renderMeals(data) {
            data = data || cachedData || defaultData;
            let meals = data.meals || {
                breakfast: [],
                lunch: [],
                dinner: []
            };
            const mealsByCity = adminData && adminData.data && adminData.data.mealsByCity ? adminData.data.mealsByCity : null;
            if (mealsByCity && selectedMealsCity && mealsByCity[selectedMealsCity]) {
                meals = normalizeMealsForCity(mealsByCity, selectedMealsCity);
            }
            ['breakfast', 'lunch', 'dinner'].forEach(type => {
                const listEl = document.getElementById('list-meals-' + type);
                if (!listEl) return;
                let arr = meals[type] || [];
                const keepObjects = arr.length && typeof arr[0] === 'object' && (arr[0].value != null || arr[0].label != null);
                if (arr.length && keepObjects) {
                    arr = arr.map(x => typeof x === 'object' ? x : {
                        value: x,
                        label: x,
                        city: 'baku',
                        price: ''
                    });
                } else {
                    arr = arr.map(x => ({
                        value: typeof x === 'object' ? (x.value || x.label || '') : x,
                        label: typeof x === 'object' ? (x.label || x.value || '') : x,
                        city: 'baku',
                        price: ''
                    }));
                }
                listEl.innerHTML = arr.map((item, i) => {
                    const val = item.value || item.label || '';
                    const city = item.city || 'baku';
                    const price = item.price != null && item.price !== '' ? item.price : '';
                    return `
                    <div class="list-item-admin" data-old-val="${escapeHtml(String(val))}" data-old-city="${escapeHtml(city)}" data-old-price="${escapeHtml(String(price))}">
                        <span>${escapeHtml(val)}</span>
                        <span class="flex gap-1">
                            <button type="button" class="btn-edit" onclick="startEditMeal('${type}', ${i})">
                                <span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">edit</span> Redaktə
                            </button>
                        <button type="button" class="btn-danger" onclick="removeMealOption('${type}', ${i})">
                            <span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">delete</span> Sil
                        </button>
                        </span>
                    </div>
                    `;
                }).join('');
            });
        }

        function renderDashboard() {
            const stats = adminData && adminData.stats ? adminData.stats : {};
            const items = [{
                    label: 'Otellər',
                    value: stats.hotels || 0,
                    icon: 'hotel'
                },
                {
                    label: 'Otaq/Qiymət',
                    value: stats.hotelPrices || 0,
                    icon: 'bed'
                },
                {
                    label: 'Aktivitetlər',
                    value: stats.activities || 0,
                    icon: 'hiking'
                },
                {
                    label: 'Transfer marşrutları',
                    value: stats.transferRoutes || 0,
                    icon: 'swap_horiz'
                },
                {
                    label: 'Ölkələr',
                    value: stats.countries || 0,
                    icon: 'public'
                },
                {
                    label: 'Viza',
                    value: stats.visa || 0,
                    icon: 'badge'
                },
                {
                    label: 'Nəqliyyat',
                    value: stats.vehicles || 0,
                    icon: 'directions_car'
                },
                {
                    label: 'Yeməklər',
                    value: stats.meals || 0,
                    icon: 'restaurant'
                },
            ];
            const el = document.getElementById('dashboard-stats');
            if (!el) return;
            el.innerHTML = items.map(s => `
                <div class="stat-card">
                    <div class="stat-value">${s.value}</div>
                    <div class="stat-label">${s.label}</div>
                    </div>
                `).join('');
            ['badge-hotels', 'badge-activities', 'badge-transfers', 'badge-meals'].forEach((id, i) => {
                const b = document.getElementById(id);
                if (b) b.textContent = [stats.hotels, stats.activities, stats.transferRoutes, stats.meals][i] || 0;
            });
        }

        const ADMIN_UPDATE_URL = 'api/admin-update.php';

        function renderHotelTable() {
            const list = adminData && adminData.hotelListingRows ? adminData.hotelListingRows : [];
            const tbody = document.getElementById('table-hotels');
            if (!tbody) return;
            tbody.innerHTML = list.map((h, i) => `
                <tr data-search="${escapeHtml((h.hotel || '') + ' ' + (h.roomType || '') + ' ' + (h.price != null ? h.price : ''))}" data-index="${i}">
                    <td><strong>${escapeHtml(h.hotel || '')}</strong></td>
                    <td>${escapeHtml(h.roomType || '')}</td>
                    <td>${h.price != null ? '$' + Number(h.price).toFixed(2) : '–'}</td>
                    <td><button type="button" class="btn-edit" onclick="startEditHotel(${i})"><span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">edit</span> Redaktə</button> <button type="button" class="btn-danger" onclick="deleteHotel(${i})"><span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">delete</span> Sil</button></td>
                </tr>
            `).join('') || '<tr><td colspan="4" class="text-gray-500">Məlumat yoxdur. Excel import edin.</td></tr>';
        }

        function startEditHotel(index) {
            const list = adminData && adminData.hotelListingRows ? adminData.hotelListingRows : [];
            const h = list[index];
            if (!h) return;
            const hotel = h.hotel || '',
                roomType = h.roomType || '',
                price = h.price != null ? h.price : '';
            const tbody = document.getElementById('table-hotels');
            const tr = tbody && tbody.querySelector('tr[data-index="' + index + '"]');
            if (!tr || tr.querySelector('.edit-inline')) return;
            tr.innerHTML = '<td colspan="4"><div class="edit-inline flex gap-2 items-center flex-wrap" data-old-hotel="' + escapeHtml(hotel) + '" data-old-room="' + escapeHtml(roomType) + '">' +
                '<input type="text" class="form-input-admin flex-1 min-w-[160px] edit-hotel-name" value="' + escapeHtml(hotel) + '" placeholder="Otel adı" />' +
                '<input type="text" class="form-input-admin flex-1 min-w-[180px] edit-hotel-room" value="' + escapeHtml(roomType) + '" placeholder="Otaq növü" />' +
                '<label class="flex items-center gap-1"><span class="text-sm text-gray-600">Qiymət ($)</span><input type="number" step="0.01" min="0" class="form-input-admin w-24 edit-hotel-price" value="' + (price !== '' ? price : '') + '" placeholder="–" /></label>' +
                '<button type="button" class="btn-primary-admin" onclick="saveEditHotel()">Yadda saxla</button>' +
                '<button type="button" class="btn-edit" onclick="refreshAllData()">Ləğv</button></div></td>';
            tr.querySelector('.edit-hotel-name').focus();
        }

        function saveEditHotel() {
            const wrap = document.querySelector('.edit-inline[data-old-hotel]');
            const nameInput = document.querySelector('.edit-hotel-name');
            const roomInput = document.querySelector('.edit-hotel-room');
            const priceInput = document.querySelector('.edit-hotel-price');
            const oldHotel = wrap ? (wrap.getAttribute('data-old-hotel') || '') : '';
            const oldRoomType = wrap ? (wrap.getAttribute('data-old-room') || '') : '';
            const newHotel = (nameInput && nameInput.value || '').trim();
            const newRoomType = (roomInput && roomInput.value || '').trim();
            const newPrice = priceInput && priceInput.value !== '' && !isNaN(parseFloat(priceInput.value)) ? parseFloat(priceInput.value) : null;
            if (!newHotel) return;
            fetch(ADMIN_UPDATE_URL, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        entity: 'hotel',
                        action: 'update',
                        oldHotel,
                        oldRoomType,
                        newHotel,
                        newRoomType,
                        newPrice
                    })
                })
                .then(r => r.json()).then(res => {
                    if (res.ok) refreshAllData();
                    else alert(res.error || 'Xəta');
                }).catch(() => alert('Xəta baş verdi'));
        }

        function addHotelRoom() {
            const hotelInput = document.getElementById('input-hotel');
            const roomInput = document.getElementById('input-hotel-room');
            const priceInput = document.getElementById('input-hotel-price');
            const hotel = (hotelInput && hotelInput.value || '').trim();
            const roomType = (roomInput && roomInput.value || '').trim();
            const priceVal = priceInput && priceInput.value !== '' ? parseFloat(priceInput.value) : null;
            if (!hotel || !roomType) {
                alert('Otel adı və otaq növü mütləqdir.');
                return;
            }
            if (priceVal == null || isNaN(priceVal) || priceVal < 0) {
                alert('Qiymət daxil edin (0 və ya daha çox).');
                return;
            }
            fetch(ADMIN_UPDATE_URL, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        entity: 'hotel',
                        action: 'add',
                        hotelName: hotel,
                        roomType: roomType,
                        price: priceVal
                    })
                })
                .then(r => r.json()).then(res => {
                    if (res.ok) {
                        if (hotelInput) hotelInput.value = '';
                        if (roomInput) roomInput.value = '';
                        if (priceInput) priceInput.value = '';
                        refreshAllData();
                    } else alert(res.error || 'Xəta');
                }).catch(() => alert('Xəta baş verdi'));
        }

        function deleteHotel(index) {
            const list = adminData && adminData.hotelListingRows ? adminData.hotelListingRows : [];
            const h = list[index];
            if (!h) return;
            const hotel = h.hotel || '',
                roomType = h.roomType || '';
            const desc = hotel + (roomType ? ' – ' + roomType : '');
            if (!confirm('Bu otel/otaq növünü silmək istəyirsiniz?\n\n' + desc + '\n\nBu əməliyyat geri alına bilməz.')) return;
            fetch(ADMIN_UPDATE_URL, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        entity: 'hotel',
                        action: 'remove',
                        oldHotel: hotel,
                        oldRoomType: roomType
                    })
                })
                .then(r => r.json()).then(res => {
                    if (res.ok) refreshAllData();
                    else alert(res.error || 'Xəta');
                }).catch(() => alert('Xəta baş verdi'));
        }

        function startEditTransferRoute(index) {
            const list = adminData && adminData.transferRoutesList ? adminData.transferRoutesList : [];
            const t = list[index];
            if (!t) return;
            const a = t.a || '',
                b = t.b || '',
                s = t.service || '';
            const vehicleCols = getVehicleColumns();
            const vPrices = t.vehiclePrices || {};
            const tbody = document.getElementById('table-transfers');
            const tr = tbody && tbody.querySelector('tr[data-index="' + index + '"]');
            if (!tr || tr.querySelector('.edit-inline')) return;
            const vInputs = vehicleCols.map(([col, label]) => {
                const p = vPrices[col];
                return '<div class="w-20"><label class="block text-xs text-gray-600">' + escapeHtml(label) + '</label><input type="number" step="0.01" min="0" class="form-input-admin w-full edit-route-vehicle" data-col="' + escapeHtml(col) + '" value="' + (p != null && p > 0 ? p : '') + '" placeholder="–" /></div>';
            }).join('');
            const totalCols = 3 + vehicleCols.length + 1;
            tr.innerHTML = '<td colspan="' + totalCols + '"><div class="edit-inline flex gap-2 items-center flex-wrap edit-route-form" data-old-a="' + escapeHtml(a) + '" data-old-b="' + escapeHtml(b) + '" data-old-s="' + escapeHtml(s) + '">' +
                '<input type="text" class="form-input-admin min-w-[100px] edit-route-a" value="' + escapeHtml(a) + '" placeholder="A" />' +
                '<input type="text" class="form-input-admin min-w-[100px] edit-route-b" value="' + escapeHtml(b) + '" placeholder="B" />' +
                '<input type="text" class="form-input-admin min-w-[100px] edit-route-s" value="' + escapeHtml(s) + '" placeholder="Service" />' +
                vInputs +
                '<button type="button" class="btn-primary-admin" onclick="saveEditTransferRoute()">Yadda saxla</button>' +
                '<button type="button" class="btn-edit" onclick="refreshAllData()">Ləğv</button></div></td>';
            tr.querySelector('.edit-route-a').focus();
        }

        function collectVehiclePrices(containerSelector, inputClass) {
            const prices = {};
            document.querySelectorAll(containerSelector + ' ' + inputClass).forEach(inp => {
                const col = inp.getAttribute('data-col');
                const v = inp.value !== '' && !isNaN(parseFloat(inp.value)) ? parseFloat(inp.value) : null;
                if (col && v !== null && v >= 0) prices[col] = v;
            });
            return prices;
        }

        function deleteTransferRoute(index) {
            const list = adminData && adminData.transferRoutesList ? adminData.transferRoutesList : [];
            const t = list[index];
            if (!t) return;
            const route = (t.a || '') + ' → ' + (t.b || '') + ' (' + (t.service || '') + ')';
            if (!confirm('Bu marşrutu silmək istəyirsiniz?\n\n' + route + '\n\nBu əməliyyat geri alına bilməz.')) return;
            fetch(ADMIN_UPDATE_URL, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        entity: 'transfer-route',
                        action: 'remove',
                        a: t.a,
                        b: t.b,
                        service: t.service
                    })
                })
                .then(r => r.json())
                .then(res => {
                    if (res.ok) refreshAllData();
                    else alert(res.error || 'Xəta baş verdi');
                })
                .catch(() => alert('Xəta baş verdi'));
        }

        function addTransferRoute() {
            const aInput = document.getElementById('new-route-a');
            const bInput = document.getElementById('new-route-b');
            const sInput = document.getElementById('new-route-service');
            const a = (aInput && aInput.value || '').trim();
            const b = (bInput && bInput.value || '').trim();
            const s = (sInput && sInput.value || '').trim();
            const prices = collectVehiclePrices('#new-route-form', '.new-route-price');
            if (!a || !b || !s) {
                alert('A, B və Service sahələri mütləqdir.');
                return;
            }
            fetch(ADMIN_UPDATE_URL, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        entity: 'transfer-route',
                        action: 'add',
                        a: a,
                        b: b,
                        service: s,
                        prices: prices
                    })
                })
                .then(r => r.json())
                .then(res => {
                    if (res.ok) {
                        if (aInput) aInput.value = '';
                        if (bInput) bInput.value = '';
                        if (sInput) sInput.value = '';
                        document.querySelectorAll('.new-route-price').forEach(inp => {
                            inp.value = '';
                        });
                        refreshAllData();
                    } else {
                        alert(res.error || 'Xəta baş verdi');
                    }
                })
                .catch(() => alert('Xəta baş verdi'));
        }

        function saveEditTransferRoute() {
            const div = document.querySelector('.edit-route-form');
            const aInput = div && div.querySelector('.edit-route-a');
            const bInput = div && div.querySelector('.edit-route-b');
            const sInput = div && div.querySelector('.edit-route-s');
            const newA = (aInput && aInput.value || '').trim();
            const newB = (bInput && bInput.value || '').trim();
            const newS = (sInput && sInput.value || '').trim();
            if (!newA || !newB || !newS) return;
            const oldA = div ? (div.getAttribute('data-old-a') || '') : '';
            const oldB = div ? (div.getAttribute('data-old-b') || '') : '';
            const oldS = div ? (div.getAttribute('data-old-s') || '') : '';
            const prices = {};
            document.querySelectorAll('.edit-route-form .edit-route-vehicle').forEach(inp => {
                const col = inp.getAttribute('data-col');
                const v = inp.value !== '' && !isNaN(parseFloat(inp.value)) ? parseFloat(inp.value) : null;
                if (col && v !== null && v >= 0) prices[col] = v;
            });
            fetch(ADMIN_UPDATE_URL, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        entity: 'transfer-route',
                        action: 'update',
                        oldA: oldA,
                        oldB: oldB,
                        oldS: oldS,
                        newA: newA,
                        newB: newB,
                        newS: newS,
                        prices: prices
                    })
                })
                .then(r => r.json()).then(res => {
                    if (res.ok) refreshAllData();
                    else alert(res.error || 'Xəta');
                }).catch(() => alert('Xəta baş verdi'));
        }

        function renderActivitiesTable() {
            const list = adminData && adminData.activitiesList ? adminData.activitiesList : [];
            const tbody = document.getElementById('table-activities');
            if (!tbody) return;
            tbody.innerHTML = list.map((a, i) => `
                <tr data-search="${escapeHtml((a.label || '') + ' ' + (a.city || '') + ' ' + (a.price || ''))}" data-index="${i}" data-value="${escapeHtml(a.value || '')}">
                    <td>${escapeHtml(a.label || '')}</td>
                    <td><span class="text-xs px-2 py-0.5 rounded bg-blue-100 text-blue-800">${escapeHtml(a.city || '')}</span></td>
                    <td>${a.price != null ? '$' + Number(a.price).toFixed(2) : '–'}</td>
                    <td><button type="button" class="btn-edit" onclick="startEditActivity(${i})"><span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">edit</span> Redaktə</button> <button type="button" class="btn-danger" onclick="deleteActivity(${i})"><span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">delete</span> Sil</button></td>
                </tr>
            `).join('') || '<tr><td colspan="4" class="text-gray-500">Məlumat yoxdur.</td></tr>';
        }

        function startEditActivity(index) {
            const list = adminData && adminData.activitiesList ? adminData.activitiesList : [];
            const a = list[index];
            if (!a) return;
            const label = a.label || '',
                city = a.city || 'baku',
                price = a.price != null ? a.price : '';
            const tbody = document.getElementById('table-activities');
            const tr = tbody && tbody.querySelector('tr[data-index="' + index + '"]');
            if (!tr || tr.querySelector('.edit-inline')) return;
            tr.innerHTML = '<td colspan="4"><div class="edit-inline flex gap-2 items-center flex-wrap edit-activity-form" data-old-value="' + escapeHtml(a.value || '') + '">' +
                '<input type="text" class="form-input-admin flex-1 min-w-[200px] edit-activity-label" value="' + escapeHtml(label) + '" placeholder="Aktivitet" />' +
                '<input type="text" class="form-input-admin w-24 edit-activity-city" value="' + escapeHtml(city) + '" placeholder="Şəhər" />' +
                '<input type="number" step="0.01" class="form-input-admin w-24 edit-activity-price" value="' + (price !== '' ? price : '') + '" placeholder="Qiymət" />' +
                '<button type="button" class="btn-primary-admin" onclick="saveEditActivity()">Yadda saxla</button>' +
                '<button type="button" class="btn-edit" onclick="refreshAllData()">Ləğv</button></div></td>';
            tr.querySelector('.edit-activity-label').focus();
        }

        function saveEditActivity() {
            const div = document.querySelector('.edit-activity-form');
            const oldValue = div ? (div.getAttribute('data-old-value') || '') : '';
            const labelInput = document.querySelector('.edit-activity-label');
            const cityInput = document.querySelector('.edit-activity-city');
            const priceInput = document.querySelector('.edit-activity-price');
            const newLabel = (labelInput && labelInput.value || '').trim();
            if (!newLabel) return;
            const newCity = (cityInput && cityInput.value || '').trim() || 'baku';
            const newPrice = priceInput && priceInput.value !== '' && !isNaN(parseFloat(priceInput.value)) ? parseFloat(priceInput.value) : null;
            fetch(ADMIN_UPDATE_URL, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        entity: 'activity',
                        action: 'update',
                        oldValue: oldValue,
                        newLabel: newLabel,
                        newCity: newCity,
                        newPrice: newPrice
                    })
                })
                .then(r => r.json()).then(res => {
                    if (res.ok) refreshAllData();
                    else alert(res.error || 'Xəta');
                }).catch(() => alert('Xəta baş verdi'));
        }

        function addActivity() {
            const activityInput = document.getElementById('input-activity');
            const cityInput = document.getElementById('input-activity-city');
            const priceInput = document.getElementById('input-activity-price');
            const label = (activityInput && activityInput.value || '').trim();
            const city = (cityInput && cityInput.value || '').trim() || 'baku';
            const priceVal = priceInput && priceInput.value !== '' ? parseFloat(priceInput.value) : null;
            if (!label) {
                alert('Aktivitet (ad - xidmət) mütləqdir.');
                return;
            }
            const parts = label.split(/\s*-\s*/).map(s => s.trim());
            const name = parts[0] || label;
            const service = parts[1] || name;
            if (priceVal != null && !isNaN(priceVal) && priceVal < 0) {
                alert('Qiymət 0 və ya daha çox olmalıdır.');
                return;
            }
            fetch(ADMIN_UPDATE_URL, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        entity: 'activity',
                        action: 'add',
                        name: name,
                        service: service,
                        city: city,
                        price: priceVal
                    })
                })
                .then(r => r.json()).then(res => {
                    if (res.ok) {
                        if (activityInput) activityInput.value = '';
                        if (priceInput) priceInput.value = '';
                        refreshAllData();
                    } else alert(res.error || 'Xəta');
                }).catch(() => alert('Xəta baş verdi'));
        }

        function deleteActivity(index) {
            const list = adminData && adminData.activitiesList ? adminData.activitiesList : [];
            const a = list[index];
            if (!a) return;
            const label = a.label || '';
            if (!confirm('Bu aktiviteti silmək istəyirsiniz?\n\n' + label + '\n\nBu əməliyyat geri alına bilməz.')) return;
            const value = a.value || '';
            if (!value) return;
            fetch(ADMIN_UPDATE_URL, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        entity: 'activity',
                        action: 'remove',
                        oldValue: value
                    })
                })
                .then(r => r.json()).then(res => {
                    if (res.ok) refreshAllData();
                    else alert(res.error || 'Xəta');
                }).catch(() => alert('Xəta baş verdi'));
        }

        const transferPointKeys = {
            'transfer-a': 'list-transfer-a',
            'transfer-b': 'list-transfer-b',
            'transfer-service': 'list-transfer-svc'
        };
        const transferPointDataKeys = {
            'transfer-a': 'transferA',
            'transfer-b': 'transferB',
            'transfer-service': 'transferServices'
        };

        function addTransferPoint(key) {
            const inputId = key === 'transfer-service' ? 'input-transfer-svc' : 'input-transfer-' + key.replace('transfer-', '');
            const input = document.getElementById(inputId);
            const val = (input && input.value || '').trim();
            if (!val) return;
            apiPost({
                action: 'add',
                key: key,
                value: val
            }, () => {
                if (input) input.value = '';
                refreshAllData();
            });
        }

        function removeTransferPoint(key, index) {
            getTransferPointData(key, (arr) => {
                const val = arr[index];
                if (!val) return;
                const value = typeof val === 'object' ? (val.value || val.label || val) : val;
                apiPost({
                    action: 'remove',
                    key: key,
                    value: value
                }, () => refreshAllData());
            });
        }

        function getTransferPointData(key, callback) {
            const dk = transferPointDataKeys[key];
            fetch(ADMIN_DATA_URL).then(r => r.ok ? r.json() : Promise.reject()).then(res => {
                const data = res.data || res;
                let arr = (data[dk] || adminData?.[dk] || adminData?.data?.[dk]) || [];
                if (Array.isArray(arr) && arr.length && typeof arr[0] === 'object') arr = arr.map(x => x.value || x.label || x);
                callback(arr);
            }).catch(() => callback([]));
        }

        function startEditTransferPoint(key, index) {
            const listId = transferPointKeys[key];
            const listEl = document.getElementById(listId);
            if (!listEl) return;
            const items = listEl.querySelectorAll('.list-item-admin');
            const itemEl = items[index];
            if (!itemEl || itemEl.querySelector('.edit-inline')) return;
            const val = (itemEl.getAttribute('data-old-val') || '').trim();
            itemEl.innerHTML = '<div class="edit-inline flex gap-2 flex-1 items-center">' +
                '<input type="text" class="form-input-admin flex-1 edit-input" value="' + escapeHtml(val) + '" data-old-val="' + escapeHtml(val) + '" />' +
                '<button type="button" class="btn-primary-admin" onclick="saveEditTransferPoint(\'' + key + '\')">Yadda saxla</button>' +
                '<button type="button" class="btn-edit" onclick="cancelEditItem(\'' + key + '\')">Ləğv</button>' +
                '</div>';
            itemEl.querySelector('.edit-input').focus();
        }

        function saveEditTransferPoint(key) {
            const listId = transferPointKeys[key];
            const listEl = document.getElementById(listId);
            const input = listEl && listEl.querySelector('.edit-input');
            if (!input) return;
            const newVal = (input.value || '').trim();
            const oldVal = input.getAttribute('data-old-val') || '';
            if (!newVal) return;
            apiPost({
                action: 'update',
                key: key,
                oldValue: oldVal,
                value: newVal
            }, () => refreshAllData());
        }

        function renderTransferPointList(key, arr) {
            const listId = transferPointKeys[key];
            const listEl = document.getElementById(listId);
            if (!listEl) return;
            const list = Array.isArray(arr) ? arr : [];
            const normalized = list.map(x => typeof x === 'object' ? (x.value || x.label || x) : x);
            listEl.innerHTML = normalized.map((item, i) => {
                const val = String(item || '');
                return '<div class="list-item-admin" data-old-val="' + escapeHtml(val) + '">' +
                    '<span>' + escapeHtml(val) + '</span>' +
                    '<span class="flex gap-1">' +
                    '<button type="button" class="btn-edit" onclick="startEditTransferPoint(\'' + key + '\', ' + i + ')"><span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">edit</span> Redaktə</button>' +
                    '<button type="button" class="btn-danger" onclick="removeTransferPoint(\'' + key + '\', ' + i + ')"><span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">delete</span> Sil</button>' +
                    '</span></div>';
            }).join('') || '<div class="text-gray-500 text-sm">Boş</div>';
        }

        function getVehicleColumns() {
            const cols = adminData && adminData.transferVehicleColumns ? adminData.transferVehicleColumns : {};
            return typeof cols === 'object' ? Object.entries(cols) : [];
        }

        function renderTransfersTable() {
            const list = adminData && adminData.transferRoutesList ? adminData.transferRoutesList : [];
            const vehicleCols = getVehicleColumns();
            const thead = document.getElementById('transfers-thead');
            if (thead) {
                const vCols = vehicleCols.map(([col, label]) => `<th class="whitespace-nowrap">${escapeHtml(label)} ($)</th>`).join('');
                thead.innerHTML = '<tr><th>A</th><th>B</th><th>Service</th>' + vCols + '<th>Əməliyyat</th></tr>';
            }
            const newInputs = document.getElementById('new-route-vehicle-inputs');
            if (newInputs) {
                newInputs.innerHTML = vehicleCols.map(([col, label]) =>
                    '<div><label class="block text-xs font-medium text-gray-600 mb-1 truncate" title="' + escapeHtml(label) + '">' + escapeHtml(label) + '</label><input type="number" step="0.01" min="0" class="form-input-admin w-full new-route-price" data-col="' + escapeHtml(col) + '" placeholder="–" /></div>'
                ).join('');
            }
            const tbody = document.getElementById('table-transfers');
            if (!tbody) return;
            const totalCols = 3 + vehicleCols.length + 1;
            tbody.innerHTML = list.map((t, i) => {
                const vPrices = t.vehiclePrices || {};
                const vCells = vehicleCols.map(([col]) => {
                    const p = vPrices[col];
                    return '<td>' + (p != null && p > 0 ? '$' + Number(p).toFixed(2) : '–') + '</td>';
                }).join('');
                return `<tr data-search="${escapeHtml((t.route || '') + ' ' + (t.a || '') + ' ' + (t.b || '') + ' ' + (t.service || ''))}" data-index="${i}" data-a="${escapeHtml(t.a || '')}" data-b="${escapeHtml(t.b || '')}" data-s="${escapeHtml(t.service || '')}">` +
                    '<td>' + escapeHtml(t.a || '') + '</td><td>' + escapeHtml(t.b || '') + '</td><td>' + escapeHtml(t.service || '') + '</td>' +
                    vCells +
                    '<td><span class="flex gap-1">' +
                    '<button type="button" class="btn-edit" onclick="startEditTransferRoute(' + i + ')"><span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">edit</span> Redaktə</button>' +
                    '<button type="button" class="btn-danger" onclick="deleteTransferRoute(' + i + ')"><span class="material-symbols-outlined" style="font-size:14px;vertical-align:middle;">delete</span> Sil</button>' +
                    '</span></td></tr>';
            }).join('') || '<tr><td colspan="' + totalCols + '" class="text-gray-500">Məlumat yoxdur.</td></tr>';
            const data = adminData && adminData.data ? adminData.data : {};
            renderTransferPointList('transfer-a', data.transferA || adminData?.transferA || []);
            renderTransferPointList('transfer-b', data.transferB || adminData?.transferB || []);
            renderTransferPointList('transfer-service', data.transferServices || adminData?.transferServices || []);
        }

        function renderMealsSummary() {
            const summary = adminData && adminData.mealsSummary ? adminData.mealsSummary : {};
            const el = document.getElementById('meals-summary');
            if (!el) return;
            el.innerHTML = Object.entries(summary).map(([city, s]) => {
                const isSelected = (city === selectedMealsCity);
                return `
                <div class="stat-card cursor-pointer hover:ring-2 hover:ring-blue-400 transition-all ${isSelected ? 'ring-2 ring-blue-500 bg-blue-50' : ''}" onclick="selectMealsCity('${escapeHtml(city)}')" role="button" tabindex="0" onkeydown="if(event.key==='Enter')selectMealsCity('${escapeHtml(city)}')">
                    <div class="font-semibold text-sm capitalize">${escapeHtml(city)}</div>
                    <div class="text-xs text-gray-500 mt-1">Səhər: ${s.breakfast || 0} | Nahar: ${s.lunch || 0} | Şam: ${s.dinner || 0}</div>
                    <div class="stat-value text-lg">${s.total || 0}</div>
                </div>
                `;
            }).join('') || '<div class="text-gray-500 col-span-4">Məlumat yoxdur.</div>';
        }

        function filterTable(tableId, q) {
            const table = document.getElementById(tableId);
            if (!table) return;
            const rows = table.querySelectorAll('tbody tr');
            const q2 = (q || '').toLowerCase().trim();
            rows.forEach(tr => {
                const text = (tr.getAttribute('data-search') || '').toLowerCase();
                tr.style.display = !q2 || text.indexOf(q2) >= 0 ? '' : 'none';
            });
        }

        function showPanel(panelId) {
            if (!panelId) return;
            document.querySelectorAll('.admin-nav-item').forEach(n => n.classList.remove('active'));
            document.querySelectorAll('.panel-section').forEach(s => s.classList.remove('active'));
            const nav = document.querySelector('.admin-nav-item[data-panel="' + panelId + '"]');
            const section = document.getElementById('panel-' + panelId);
            if (nav) nav.classList.add('active');
            if (section) section.classList.add('active');
            try {
                location.hash = '#panel-' + panelId;
            } catch (e) {}
        }

        function renderAll(data) {
            data = data || cachedData || defaultData;
            const merged = {
                ...data
            };
            if (adminData && adminData.tourHotelsList) merged.hotels = adminData.tourHotelsList;
            ['hotels', 'tours', 'entrances', 'countries', 'vehicles', 'water', 'guides', 'visa', 'extraServices'].forEach(k => renderList(k, merged));
            renderMeals(merged);
        }

        function escapeHtml(s) {
            const div = document.createElement('div');
            div.textContent = s;
            return div.innerHTML;
        }

        function toggleSidebar() {
            const sidebar = document.getElementById('admin-sidebar');
            const main = document.getElementById('admin-main');
            const openBtn = document.getElementById('sidebar-open');
            const closeBtn = document.getElementById('sidebar-close');
            const isCollapsed = sidebar.classList.toggle('collapsed');
            main.classList.toggle('sidebar-collapsed', isCollapsed);
            if (openBtn) openBtn.classList.toggle('hidden', !isCollapsed);
            if (closeBtn) closeBtn.style.display = isCollapsed ? 'none' : '';
            try {
                localStorage.setItem('admin-sidebar-collapsed', isCollapsed ? '1' : '0');
            } catch (e) {}
        }

        function initSidebar() {
            try {
                const saved = localStorage.getItem('admin-sidebar-collapsed');
                if (saved === '1') {
                    document.getElementById('admin-sidebar').classList.add('collapsed');
                    document.getElementById('admin-main').classList.add('sidebar-collapsed');
                    const openBtn = document.getElementById('sidebar-open');
                    const closeBtn = document.getElementById('sidebar-close');
                    if (openBtn) openBtn.classList.remove('hidden');
                    if (closeBtn) closeBtn.style.display = 'none';
                }
            } catch (e) {}
        }

        function initPanels() {
            const hash = (location.hash || '').replace(/^#/, '');
            const panelFromHash = hash && hash.startsWith('panel-') ? hash.substring(6) : null;
            if (panelFromHash && document.getElementById('panel-' + panelFromHash)) {
                document.querySelectorAll('.admin-nav-item').forEach(n => n.classList.remove('active'));
                document.querySelectorAll('.panel-section').forEach(s => s.classList.remove('active'));
                const nav = document.querySelector('.admin-nav-item[data-panel="' + panelFromHash + '"]');
                const section = document.getElementById('panel-' + panelFromHash);
                if (nav) nav.classList.add('active');
                if (section) section.classList.add('active');
            }
            document.querySelectorAll('.admin-nav-item').forEach(el => {
                el.addEventListener('click', function() {
                    const panelId = this.getAttribute('data-panel');
                    showPanel(panelId);
                });
            });
            window.addEventListener('hashchange', function() {
                const h = (location.hash || '').replace(/^#/, '');
                const pid = h && h.startsWith('panel-') ? h.replace('panel-', '') : null;
                if (pid) showPanel(pid);
            });
        }

        let generatedSql = '';
        let generatedFilename = 'output.sql';

        function importExcelData(type) {
            const input = document.getElementById('excel-import-' + type);
            const status = document.getElementById('excel-import-status-' + type);
            const file = input && input.files ? input.files[0] : null;
            if (!file) {
                status.textContent = 'Excel faylı seçin.';
                status.className = 'text-sm mt-3 text-amber-600';
                return;
            }
            if (!/\.xlsx$/i.test(file.name)) {
                status.textContent = 'Yalnız .xlsx faylı qəbul olunur.';
                status.className = 'text-sm mt-3 text-red-600';
                return;
            }
            status.textContent = 'Yüklənir və məlumatlar yoxlanılır...';
            status.className = 'text-sm mt-3 text-gray-500';
            const form = new FormData();
            form.append('type', type);
            form.append('files[]', file);
            fetch('api/excel-import-mysql.php', { method: 'POST', body: form })
                .then(r => r.json())
                .then(res => {
                    if (!res || !res.ok) throw new Error((res && res.error) || (res && res.results && res.results[0] && res.results[0].error) || 'Import xətası');
                    const result = (res.results && res.results[0]) || {};
                    const stats = result.stats || {};
                    const added = Number(stats.inserted || 0) + Number(stats.hotels_inserted || 0) + Number(stats.prices_inserted || 0) + Number(stats.listing_inserted || 0);
                    const updated = Number(stats.updated || 0) + Number(stats.prices_updated || 0) + Number(stats.listing_updated || 0);
                    const unchanged = Number(stats.unchanged || 0) + Number(stats.hotels_unchanged || 0) + Number(stats.prices_unchanged || 0) + Number(stats.listing_unchanged || 0);
                    status.textContent = 'Hazırdır. Əlavə: ' + added + ', yenilənən: ' + updated + ', dəyişməyən: ' + unchanged + '. Heç bir köhnə qeyd silinmədi.';
                    status.className = 'text-sm mt-3 text-green-600';
                    input.value = '';
                    refreshAllData();
                })
                .catch(err => {
                    status.textContent = 'Xəta: ' + err.message;
                    status.className = 'text-sm mt-3 text-red-600';
                });
        }

        function generateSqlFromExcel() {
            const fileInput = document.getElementById('excel-sql-file');
            const typeSelect = document.getElementById('excel-sql-type');
            const output = document.getElementById('excel-sql-output');
            const status = document.getElementById('excel-sql-status');
            const downloadBtn = document.getElementById('excel-sql-download');
            if (!fileInput || !fileInput.files || !fileInput.files[0]) {
                status.textContent = 'Please select an Excel file.';
                status.classList.remove('hidden');
                status.className = 'text-sm text-amber-600 mb-3';
                return;
            }
            status.textContent = 'Uploading...';
            status.classList.remove('hidden');
            status.className = 'text-sm text-gray-500 mb-3';
            output.value = '';
            downloadBtn.classList.add('hidden');
            const form = new FormData();
            form.append('type', typeSelect.value);
            form.append('file', fileInput.files[0]);
            fetch('api/excel-to-sql.php', {
                    method: 'POST',
                    body: form
                })
                .then(r => r.json())
                .then(res => {
                    if (res && res.ok) {
                        generatedSql = res.sql || '';
                        generatedFilename = res.filename || 'output.sql';
                        output.value = generatedSql;
                        downloadBtn.classList.remove('hidden');
                        status.textContent = 'SQL generated successfully.';
                        status.className = 'text-sm text-green-600 mb-3';
                    } else {
                        status.textContent = 'Error: ' + (res.error || 'Unknown error');
                        status.className = 'text-sm text-red-600 mb-3';
                    }
                })
                .catch(() => {
                    status.textContent = 'Network error.';
                    status.className = 'text-sm text-red-600 mb-3';
                });
        }

        function downloadGeneratedSql() {
            if (!generatedSql) return;
            const a = document.createElement('a');
            a.href = 'data:application/sql;charset=utf-8,' + encodeURIComponent(generatedSql);
            a.download = generatedFilename;
            a.click();
        }

        function formatMoneyEUR(v) {
            if (v == null || isNaN(v)) return '$0.00';
            return '$' + Number(v).toFixed(2);
        }

        // Global state for admin invoices filtering
        window.adminInvoicesSelectedUserId = null;
        window.adminCurrentUserIdForOrders = null;

        function loadAdminUserOrders(userId) {
            const container = document.getElementById('admin-user-orders-container');
            const hint = document.getElementById('admin-user-orders-hint');
            const tbody = document.getElementById('admin-user-orders-tbody');
            const loadingEl = document.getElementById('admin-user-orders-loading');
            const errorEl = document.getElementById('admin-user-orders-error');
            if (!tbody || !container) return;

            window.adminCurrentUserIdForOrders = userId;
            container.classList.remove('hidden');
            if (hint) {
                hint.textContent = 'Confirmed orders and payments for the selected company.';
            }
            if (errorEl) {
                errorEl.classList.add('hidden');
                errorEl.textContent = '';
            }
            if (loadingEl) {
                loadingEl.classList.remove('hidden');
                loadingEl.textContent = 'Loading...';
            }

            fetch('api/admin-user-orders.php?user_id=' + encodeURIComponent(userId))
                .then(function (r) { return r.json(); })
                .then(function (res) {
                    if (loadingEl) loadingEl.classList.add('hidden');
                    if (!res.ok) {
                        if (errorEl) {
                            errorEl.textContent = res.error || 'Failed to load orders.';
                            errorEl.classList.remove('hidden');
                        }
                        return;
                    }
                    const list = res.orders || [];
                    if (!list.length) {
                        tbody.innerHTML = '<tr><td colspan="5" class="text-sm text-gray-500 text-center py-4">This company has no confirmed orders.</td></tr>';
                        return;
                    }

                    tbody.innerHTML = list.map(function (o) {
                        const total = formatMoneyEUR(o.total_amount || 0);
                        const paid = formatMoneyEUR(o.paid_amount || 0);
                        const remaining = formatMoneyEUR(o.remaining_amount || 0);
                        const disabledAttr = (o.remaining_amount || 0) <= 0 ? ' disabled' : '';
                        const btnLabel = (o.remaining_amount || 0) <= 0 ? 'Paid' : 'Mark paid';
                        return (
                            '<tr data-order-id="' + o.order_id + '" data-remaining="' + (o.remaining_amount || 0) + '">' +
                                '<td>' + (o.name || ('Order #' + o.order_id)) + '</td>' +
                                '<td>' + total + '</td>' +
                                '<td>' + paid + '</td>' +
                                '<td>' + remaining + '</td>' +
                                '<td>' +
                                    '<button type="button" class="btn-primary-admin text-xs px-3 py-1"' +
                                        ' data-order-id="' + o.order_id + '"' +
                                        ' data-remaining="' + (o.remaining_amount || 0) + '"' +
                                        disabledAttr + '>' + btnLabel + '</button>' +
                                '</td>' +
                            '</tr>'
                        );
                    }).join('');

                    // Attach click handlers for per-order "Paid" buttons
                    tbody.querySelectorAll('button[data-order-id]').forEach(function (btn) {
                        btn.addEventListener('click', function () {
                            const orderId = Number(this.getAttribute('data-order-id') || '0');
                            const remaining = parseFloat(this.getAttribute('data-remaining') || '0') || 0;
                            if (!orderId || remaining <= 0) return;
                            if (!window.adminCurrentUserIdForOrders) return;
                            if (!confirm('Bu sifarişi tam ödənmiş kimi işarələmək istəyirsiniz?')) return;

                            // Birbaşa bu sifariş üçün tam qalan məbləği manual paid kimi qeyd edək
                            fetch('api/admin-debts-settle.php', {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify({
                                    user_id: window.adminCurrentUserIdForOrders,
                                    mode: 'full',
                                    order_id: orderId
                                })
                            })
                                .then(function (r) { return r.json(); })
                                .then(function (res2) {
                                    if (!res2.ok) {
                                        if (errorEl) {
                                            errorEl.textContent = res2.error || 'Failed to mark order as paid.';
                                            errorEl.classList.remove('hidden');
                                        }
                                        return;
                                    }
                                    // Yenilə həm borc xülasəsini, həm də company üçün sifarişləri və fakturaları
                                    loadAdminDebts();
                                    loadAdminUserOrders(window.adminCurrentUserIdForOrders);
                                    loadAdminReceipts();
                                })
                                .catch(function () {
                                    if (errorEl) {
                                        errorEl.textContent = 'Network error while marking order as paid.';
                                        errorEl.classList.remove('hidden');
                                    }
                                });
                        });
                    });
                })
                .catch(function () {
                    if (loadingEl) {
                        loadingEl.classList.add('hidden');
                    }
                    if (errorEl) {
                        errorEl.textContent = 'Loading error.';
                        errorEl.classList.remove('hidden');
                    }
                });
        }

        function clearAdminUserOrdersView() {
            const container = document.getElementById('admin-user-orders-container');
            const hint = document.getElementById('admin-user-orders-hint');
            const tbody = document.getElementById('admin-user-orders-tbody');
            const loadingEl = document.getElementById('admin-user-orders-loading');
            const errorEl = document.getElementById('admin-user-orders-error');
            if (container) container.classList.add('hidden');
            if (hint) {
                hint.textContent = 'Select a company in the table above to see all its confirmed orders and payments here.';
            }
            if (tbody) {
                tbody.innerHTML = '<tr><td colspan="5" class="text-sm text-gray-500 text-center py-4">Select a company above.</td></tr>';
            }
            if (loadingEl) loadingEl.classList.add('hidden');
            if (errorEl) {
                errorEl.classList.add('hidden');
                errorEl.textContent = '';
            }
            window.adminCurrentUserIdForOrders = null;
        }

        function resetAdminInvoiceCompanyFilter() {
            const labelEl = document.getElementById('admin-invoice-selected-label');
            const debtsTbody = document.getElementById('admin-debts-tbody');
            window.adminInvoicesSelectedUserId = null;
            window.adminCurrentUserIdForOrders = null;
            if (labelEl) {
                labelEl.textContent = 'All companies';
            }
            if (debtsTbody) {
                Array.prototype.forEach.call(debtsTbody.querySelectorAll('tr[data-user-id]'), function (row) {
                    row.classList.remove('bg-blue-50');
                });
            }
            clearAdminUserOrdersView();
            loadAdminReceipts();
        }

        function loadAdminReceipts() {
            const statusSelect = document.getElementById('admin-invoice-status-filter');
            const loadingEl = document.getElementById('admin-invoice-loading');
            const errorEl = document.getElementById('admin-invoice-error');
            const tbody = document.getElementById('admin-invoice-tbody');
            if (!tbody) return;

            if (errorEl) {
                errorEl.classList.add('hidden');
                errorEl.textContent = '';
            }
            if (loadingEl) {
                loadingEl.classList.remove('hidden');
                loadingEl.textContent = 'Loading...';
            }

            const params = [];
            if (statusSelect && statusSelect.value !== '') {
                params.push('status=' + encodeURIComponent(statusSelect.value));
            }
            if (window.adminInvoicesSelectedUserId && Number(window.adminInvoicesSelectedUserId) > 0) {
                params.push('user_id=' + encodeURIComponent(window.adminInvoicesSelectedUserId));
            }
            const url = 'api/admin-payment-receipts.php' + (params.length ? ('?' + params.join('&')) : '');

            fetch(url)
                .then(r => r.json())
                .then(res => {
                    if (loadingEl) loadingEl.classList.add('hidden');
                    if (!res.ok) {
                        if (errorEl) {
                            errorEl.textContent = res.error || 'Failed to load receipts.';
                            errorEl.classList.remove('hidden');
                        }
                        return;
                    }
                    const list = res.receipts || [];
                    if (!list.length) {
                        tbody.innerHTML = '<tr><td colspan="7" class="text-sm text-gray-500 text-center py-4">No receipts found.</td></tr>';
                        return;
                    }
                    tbody.innerHTML = list.map(function (r) {
                        const status = Number(r.status || 0);
                        let statusLabel = 'Pending';
                        let statusClass = 'bg-amber-100 text-amber-700';
                        if (status === 1) {
                            statusLabel = 'Approved';
                            statusClass = 'bg-emerald-100 text-emerald-700';
                        } else if (status === 2) {
                            statusLabel = 'Rejected';
                            statusClass = 'bg-red-100 text-red-700';
                        }
                        const amount = formatMoneyEUR(r.amount);
                        const orderTotal = r.order_total != null ? formatMoneyEUR(r.order_total) : '—';
                        const fileLabel = r.file_type === 'pdf' ? 'PDF' : 'Image';
                        const fileLink = r.file_path ? '<a href="' + r.file_path + '" target="_blank" class="text-xs text-blue-600 hover:underline">' + fileLabel + '</a>' : '—';
                        let actions = '';
                        if (status === 0) {
                            actions =
                                '<button type="button" class="btn-edit mb-1" data-action="approve" data-id="' + r.id + '">Approve</button>' +
                                '<button type="button" class="btn-danger" data-action="reject" data-id="' + r.id + '">Reject</button>';
                        } else {
                            actions = '<span class="text-xs text-gray-400">No actions</span>';
                        }
                        return (
                            '<tr>' +
                                '<td>' + r.id + '</td>' +
                                '<td>' + (r.user_name || r.user_email || '') + '<br><span class="text-xs text-gray-500">' + (r.user_email || '') + '</span></td>' +
                                '<td>' + (r.order_name || ('Order #' + r.order_id)) + '<br><span class="text-xs text-gray-500">Order total: ' + orderTotal + '</span></td>' +
                                '<td>' + amount + '</td>' +
                                '<td><span class="inline-flex items-center px-2.5 py-1 rounded-full text-[11px] font-semibold ' + statusClass + '">' + statusLabel + '</span></td>' +
                                '<td>' + fileLink + '</td>' +
                                '<td>' + actions + '</td>' +
                            '</tr>'
                        );
                    }).join('');

                    tbody.querySelectorAll('button[data-action]').forEach(function (btn) {
                        btn.addEventListener('click', function () {
                            const id = this.getAttribute('data-id');
                            const action = this.getAttribute('data-action');
                            if (!id || !action) return;
                            fetch('api/admin-payment-receipts.php', {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify({ id: Number(id), action: action })
                            })
                                .then(r => r.json())
                                .then(res2 => {
                                    if (!res2.ok) {
                                        if (errorEl) {
                                            errorEl.textContent = res2.error || 'Failed to update receipt.';
                                            errorEl.classList.remove('hidden');
                                        }
                                        return;
                                    }
                                    // Refresh both receipts and debts so remaining balance is updated
                                    loadAdminReceipts();
                                    loadAdminDebts();
                                    if (window.adminCurrentUserIdForOrders) {
                                        loadAdminUserOrders(window.adminCurrentUserIdForOrders);
                                    }
                                })
                                .catch(function () {
                                    if (errorEl) {
                                        errorEl.textContent = 'Network error while updating receipt.';
                                        errorEl.classList.remove('hidden');
                                    }
                                });
                        });
                    });
                })
                .catch(function () {
                    if (loadingEl) {
                        loadingEl.classList.remove('hidden');
                        loadingEl.textContent = 'Loading error.';
                    }
                });
        }

        function loadAdminDebts() {
            const totalEl = document.getElementById('admin-debts-total');
            const pendingEl = document.getElementById('admin-debts-pending');
            const paidEl = document.getElementById('admin-debts-paid');
            const tbody = document.getElementById('admin-debts-tbody');
            const errorEl = document.getElementById('admin-debts-error');
            if (!tbody) return;

            if (errorEl) {
                errorEl.classList.add('hidden');
                errorEl.textContent = '';
            }

            fetch('api/admin-order-detail.php?debts=1')
                .then(r => r.json())
                .then(res => {
                    if (!res.ok) {
                        if (errorEl) {
                            errorEl.textContent = res.error || 'Failed to load debts.';
                            errorEl.classList.remove('hidden');
                        }
                        return;
                    }
                    const summary = res.summary || {};
                    const list = res.debts || [];
                    if (totalEl) totalEl.textContent = formatMoneyEUR(summary.total_debt || 0);
                    if (pendingEl) pendingEl.textContent = formatMoneyEUR(summary.pending || 0);
                    if (paidEl) paidEl.textContent = formatMoneyEUR(summary.paid || 0);

                    if (!list.length) {
                        tbody.innerHTML = '<tr><td colspan="5" class="text-sm text-gray-500 text-center py-4">No data.</td></tr>';
                        return;
                    }

                    // Group by company/user (each login == company)
                    const byUser = {};
                    list.forEach(function (d) {
                        const key = String(d.user_id || '') + '|' + (d.user_email || '');
                        if (!byUser[key]) {
                            byUser[key] = {
                                userId: d.user_id || 0,
                                company: d.user_company || '',
                                name: d.user_name || '',
                                email: d.user_email || '',
                                total: 0,
                                pending: 0,
                                paid: 0
                            };
                        }
                        byUser[key].total += d.total_amount || 0;
                        byUser[key].pending += d.pending_amount || 0;
                        byUser[key].paid += d.paid_amount || 0;
                    });

                    const rows = Object.values(byUser);
                    // keep global copy for other components if needed
                    window.adminDebtsUsers = rows;
                    tbody.innerHTML = rows.map(function (u) {
                        const label = u.company || u.name || u.email || '—';
                        const outstanding = u.total; // API-dən artıq outstanding (qalan borc) gəlir
                        return (
                            '<tr data-user-id="' + (u.userId || 0) + '" data-user-name="' + (u.name || '') + '" data-user-company="' + (u.company || '') + '" data-user-email="' + (u.email || '') + '" data-user-total="' + (u.total || 0) + '" data-user-pending="' + (u.pending || 0) + '" data-user-paid="' + (u.paid || 0) + '">' +
                                '<td>' + label + '</td>' +
                                '<td>' + (u.email || '—') + '</td>' +
                                '<td>' + formatMoneyEUR(outstanding) + '</td>' +
                                '<td>' + formatMoneyEUR(u.pending) + '</td>' +
                                '<td>' + formatMoneyEUR(u.paid) + '</td>' +
                            '</tr>'
                        );
                    }).join('');

                    // Make rows clickable to filter invoices and show per-order details by company
                    const selectedLabelEl = document.getElementById('admin-invoice-selected-label');
                    Array.prototype.forEach.call(tbody.querySelectorAll('tr[data-user-id]'), function (tr) {
                        tr.addEventListener('click', function () {
                            const allRows = tbody.querySelectorAll('tr[data-user-id]');
                            Array.prototype.forEach.call(allRows, function (row) {
                                row.classList.remove('bg-blue-50');
                            });
                            this.classList.add('bg-blue-50');

                            const userId = Number(this.getAttribute('data-user-id') || '0');
                            const company = this.getAttribute('data-user-company') || '';
                            const name = this.getAttribute('data-user-name') || '';
                            const email = this.getAttribute('data-user-email') || '';
                            const label = company || name || email || '—';

                            window.adminInvoicesSelectedUserId = userId > 0 ? userId : null;
                            window.adminCurrentUserIdForOrders = window.adminInvoicesSelectedUserId;
                            if (selectedLabelEl) {
                                selectedLabelEl.textContent = window.adminInvoicesSelectedUserId ? label : 'All companies';
                            }
                            // load invoices and per-order breakdown for this company
                            loadAdminReceipts();
                            if (window.adminInvoicesSelectedUserId) {
                                loadAdminUserOrders(window.adminInvoicesSelectedUserId);
                            }
                        });
                    });
                })
                .catch(function () {
                    if (errorEl) {
                        errorEl.textContent = 'Loading error.';
                        errorEl.classList.remove('hidden');
                    }
                });
        }

        function initOrderItineraryModal() {
            const modal = document.getElementById('order-itinerary-modal');
            const content = document.getElementById('order-itinerary-content');
            const closeBtn = document.getElementById('order-itinerary-close');
            const tbody = document.getElementById('table-orders');
            if (!modal || !content || !tbody) return;

            function escapeHtml(s) {
                if (s == null) return '';
                const d = document.createElement('div');
                d.textContent = String(s);
                return d.innerHTML;
            }

            function renderItinerary(order) {
                const data = order.order_data || {};
                const basics = data.basics || {};
                const days = Array.isArray(data.days) ? data.days : [];
                let html = '';
                html += '<div class="space-y-3">';
                html += '<p><strong>User:</strong> ' + escapeHtml(order.user_name || order.user_email) + ' &lt;' + escapeHtml(order.user_email) + '&gt;</p>';
                if (basics.checkin || basics.checkout) {
                    html += '<p><strong>Dates:</strong> ' + escapeHtml(basics.checkin || '–') + ' → ' + escapeHtml(basics.checkout || '–') + '</p>';
                }
                if (basics.adults || basics.children) {
                    html += '<p><strong>Adults:</strong> ' + escapeHtml(basics.adults || 0) + ', <strong>Children:</strong> ' + escapeHtml(basics.children || 0) + '</p>';
                }
                html += '<hr class="border-gray-200" />';
                html += '<h4 class="font-semibold text-gray-800">Days</h4>';
                days.forEach(function(d, i) {
                    html += '<div class="p-3 bg-gray-50 rounded-lg">';
                    html += '<p class="font-medium text-gray-800">Day ' + (i + 1) + ': ' + escapeHtml(d.date || '') + ' – ' + escapeHtml(d.city || '') + '</p>';
                    if (d.hotel) html += '<p>Hotel: ' + escapeHtml(d.hotel) + (d.roomType ? ' / ' + escapeHtml(d.roomType) : '') + '</p>';
                    if (d.transferA && d.transferB) html += '<p>Transfer: ' + escapeHtml(d.transferA) + ' → ' + escapeHtml(d.transferB) + (d.transferService ? ' (' + escapeHtml(d.transferService) + ')' : '') + '</p>';
                    if (d.vehicle || (Array.isArray(d.vehicles) && d.vehicles.length)) {
                        var veh = Array.isArray(d.vehicles) ? d.vehicles : (d.vehicle ? [d.vehicle] : []);
                        if (veh.length) html += '<p>Vehicle: ' + veh.map(escapeHtml).join(', ') + '</p>';
                    }
                    if (d.tour || (Array.isArray(d.activities) && d.activities.length)) {
                        var acts = [];
                        if (Array.isArray(d.activities)) {
                            acts = d.activities.map(function(a) {
                                if (!a) return '';
                                var tour = a.tour || '';
                                var entrance = a.entrance || '';
                                if (tour && entrance) return tour + ' | ' + entrance;
                                return tour || entrance;
                            }).filter(Boolean);
                        } else if (d.tour) {
                            acts = [d.tour];
                        }
                        if (acts.length) {
                            html += '<p>Tour/Activity:<br>' + acts.map(escapeHtml).join('<br>') + '</p>';
                        }
                    }
                    if (d.meals) {
                        var lo = d.meals.lunch || {};
                        var lun = Array.isArray(lo.options) ? lo.options : (lo.option ? [lo.option] : []);
                        var dio = d.meals.dinner || {};
                        var din = Array.isArray(dio.options) ? dio.options : (dio.option ? [dio.option] : []);
                        if (lun.length || din.length) {
                            html += '<p>Meals: Lunch: ' + (lun.length ? lun.map(escapeHtml).join(', ') : '–') + ' | Dinner: ' + (din.length ? din.map(escapeHtml).join(', ') : '–') + '</p>';
                        }
                    }
                    html += '</div>';
                });
                html += '</div>';
                return html;
            }

            tbody.addEventListener('click', function(e) {
                var row = e.target.closest('tr[data-order-id]');
                if (!row) return;
                if (e.target.closest('button') || e.target.closest('form')) return;
                var id = row.getAttribute('data-order-id');
                if (!id) return;
                content.innerHTML = 'Loading...';
                modal.classList.remove('hidden');
                fetch('api/admin-order-detail.php?id=' + encodeURIComponent(id))
                    .then(function(r) {
                        return r.json();
                    })
                    .then(function(res) {
                        if (res.ok && res.order) {
                            content.innerHTML = renderItinerary(res.order);
                        } else {
                            content.innerHTML = '<p class="text-red-600">' + escapeHtml(res.error || 'Error') + '</p>';
                        }
                    })
                    .catch(function() {
                        content.innerHTML = '<p class="text-red-600">Loading error</p>';
                    });
            });

            function closeModal() {
                modal.classList.add('hidden');
            }
            if (closeBtn) closeBtn.addEventListener('click', closeModal);
            modal.addEventListener('click', function(e) {
                if (e.target === modal) closeModal();
            });
        }

        function initUserEditForm() {
            const table = document.getElementById('users-table');
            const emailInput = document.querySelector('input[name="email"]');
            const nameInput = document.querySelector('input[name="name"]');
            const companyInput = document.querySelector('input[name="company"]');
            const roleUserInput = document.getElementById('role-user');
            const roleAssistantInput = document.getElementById('role-assistant');
            const roleAdminInput = document.getElementById('role-admin');
            const actionInput = document.getElementById('user-form-action');
            const idInput = document.getElementById('user-form-id');
            const passwordInput = document.getElementById('user-form-password');
            const password2Input = document.getElementById('user-form-password2');
            const submitLabel = document.getElementById('user-form-submit-label');
            const cancelBtn = document.getElementById('user-form-cancel-edit');

            if (!table || !emailInput || !nameInput || !companyInput || !actionInput || !idInput || !submitLabel) return;

            function resetFormToCreate() {
                actionInput.value = 'create_user';
                idInput.value = '';
                if (passwordInput) passwordInput.required = true;
                if (password2Input) password2Input.required = true;
                if (passwordInput) passwordInput.value = '';
                if (password2Input) password2Input.value = '';
                if (roleUserInput) roleUserInput.checked = true;
                if (roleAssistantInput) roleAssistantInput.checked = false;
                if (roleAdminInput) roleAdminInput.checked = false;
                submitLabel.textContent = 'Create user';
                if (cancelBtn) cancelBtn.classList.add('hidden');
            }

            table.addEventListener('click', function (e) {
                const btn = e.target.closest('.btn-edit-user');
                if (!btn) return;
                const row = btn.closest('tr[data-user-id]');
                if (!row) return;

                const id = row.getAttribute('data-user-id');
                const email = row.getAttribute('data-user-email') || '';
                const name = row.getAttribute('data-user-name') || '';
                const company = row.getAttribute('data-user-company') || '';
                const role = parseInt(row.getAttribute('data-user-role') || '0', 10);

                emailInput.value = email;
                emailInput.readOnly = true;
                nameInput.value = name;
                companyInput.value = company;
                if (roleUserInput) roleUserInput.checked = (role === 0);
                if (roleAssistantInput) roleAssistantInput.checked = (role === 2);
                if (roleAdminInput) roleAdminInput.checked = (role === 1);
                actionInput.value = 'update_user';
                idInput.value = id || '';
                if (passwordInput) passwordInput.required = false;
                if (password2Input) password2Input.required = false;
                if (passwordInput) passwordInput.value = '';
                if (password2Input) password2Input.value = '';
                submitLabel.textContent = 'Update user';
                if (cancelBtn) cancelBtn.classList.remove('hidden');
            });

            if (cancelBtn) {
                cancelBtn.addEventListener('click', function () {
                    emailInput.readOnly = false;
                    emailInput.value = '';
                    nameInput.value = '';
                    companyInput.value = '';
                    if (roleUserInput) roleUserInput.checked = true;
                    if (roleAssistantInput) roleAssistantInput.checked = false;
                    if (roleAdminInput) roleAdminInput.checked = false;
                    resetFormToCreate();
                });
            }
        }

        function initDebtsModal() {
            const table = document.getElementById('admin-debts-table');
            const modal = document.getElementById('admin-debts-modal');
            const closeBtn = document.getElementById('admin-debts-modal-close');
            const subtitleEl = document.getElementById('admin-debts-modal-subtitle');
            const nameEl = document.getElementById('admin-debts-modal-name');
            const emailEl = document.getElementById('admin-debts-modal-email');
            const totalEl = document.getElementById('admin-debts-modal-total');
            const paidEl = document.getElementById('admin-debts-modal-paid');
            const remainingEl = document.getElementById('admin-debts-modal-remaining');
            const errorEl = document.getElementById('admin-debts-modal-error');
            const btnFull = document.getElementById('admin-debts-btn-full');
            const btnPartial = document.getElementById('admin-debts-btn-partial');
            const partialInput = document.getElementById('admin-debts-partial-amount');

            if (!table || !modal || !closeBtn || !nameEl || !emailEl || !totalEl || !paidEl || !remainingEl || !btnFull || !btnPartial || !partialInput) return;

            let currentUserId = 0;
            let currentRemaining = 0;

            function hideModal() {
                modal.classList.add('hidden');
                modal.classList.remove('flex');
                if (partialInput) partialInput.value = '';
                if (errorEl) {
                    errorEl.textContent = '';
                    errorEl.classList.add('hidden');
                }
            }

            function showModalForRow(row) {
                const userId = parseInt(row.getAttribute('data-user-id') || '0', 10);
                const name = row.getAttribute('data-user-name') || '';
                const company = row.getAttribute('data-user-company') || '';
                const email = row.getAttribute('data-user-email') || '';
                const total = parseFloat(row.getAttribute('data-user-total') || '0') || 0;
                const paid = parseFloat(row.getAttribute('data-user-paid') || '0') || 0;

                currentUserId = userId;
                currentRemaining = Math.max(0, total - paid);

                const label = company || name || email || '—';
                if (subtitleEl) subtitleEl.textContent = 'Manage debt for ' + label;
                nameEl.textContent = label;
                emailEl.textContent = email || '—';
                totalEl.textContent = formatMoneyEUR(total);
                paidEl.textContent = formatMoneyEUR(paid);
                remainingEl.textContent = formatMoneyEUR(currentRemaining);

                const disabled = currentRemaining <= 0;
                btnFull.disabled = disabled;
                btnPartial.disabled = disabled;

                modal.classList.remove('hidden');
                modal.classList.add('flex');
            }

            table.addEventListener('click', function (e) {
                const row = e.target.closest('tbody tr[data-user-id]');
                if (!row) return;
                showModalForRow(row);
            });

            closeBtn.addEventListener('click', hideModal);
            modal.addEventListener('click', function (e) {
                if (e.target === modal) hideModal();
            });

            function postSettle(body) {
                if (errorEl) {
                    errorEl.textContent = '';
                    errorEl.classList.add('hidden');
                }
                btnFull.disabled = true;
                btnPartial.disabled = true;
                fetch('api/admin-debts-settle.php', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(body)
                })
                    .then(function (r) { return r.json(); })
                    .then(function (res) {
                        if (!res.ok) {
                            if (errorEl) {
                                errorEl.textContent = res.error || 'Failed to settle debt.';
                                errorEl.classList.remove('hidden');
                            }
                            btnFull.disabled = false;
                            btnPartial.disabled = false;
                            return;
                        }
                        hideModal();
                        loadAdminDebts();
                    })
                    .catch(function () {
                        if (errorEl) {
                            errorEl.textContent = 'Network error while settling debt.';
                            errorEl.classList.remove('hidden');
                        }
                        btnFull.disabled = false;
                        btnPartial.disabled = false;
                    });
            }

            btnFull.addEventListener('click', function () {
                if (currentUserId <= 0 || currentRemaining <= 0) return;
                if (!confirm('Are you sure you want to mark this company as fully paid?')) return;
                if (!confirm('This will create manual payment receipts to clear all remaining debt. Continue?')) return;
                postSettle({ user_id: currentUserId, mode: 'full' });
            });

            btnPartial.addEventListener('click', function () {
                if (currentUserId <= 0 || currentRemaining <= 0) return;
                const val = parseFloat(partialInput.value || '0');
                if (!val || val <= 0) {
                    if (errorEl) {
                        errorEl.textContent = 'Please enter a positive partial payment amount.';
                        errorEl.classList.remove('hidden');
                    }
                    return;
                }
                if (val > currentRemaining + 0.00001) {
                    if (errorEl) {
                        errorEl.textContent = 'Amount cannot exceed remaining debt.';
                        errorEl.classList.remove('hidden');
                    }
                    return;
                }
                postSettle({ user_id: currentUserId, mode: 'partial', amount: val });
            });
        }

        function init() {
            initSidebar();
            initPanels();
            refreshAllData();
            initOrderItineraryModal();
            initUserEditForm();
            loadAdminReceipts();
            loadAdminDebts();
            if (window.adminCurrentUserIdForOrders) {
                loadAdminUserOrders(window.adminCurrentUserIdForOrders);
            }
            initDebtsModal();
        }

        document.addEventListener('DOMContentLoaded', init);
    </script>
</body>

</html>
