<?php
/**
 * Admin Panel – cədvəl redaktə API
 * hotel_listing_full, tour_azerbaijan_activities_2026, transfers
 */
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['ok' => false, 'error' => 'Method not allowed']);
    exit;
}

require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../auth/_auth_helper.php';

auth_require_admin_api();

$pdo = dbConnect();
if (!$pdo) {
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => 'Database connection failed']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true) ?: [];
$entity = $input['entity'] ?? '';
$action = $input['action'] ?? '';

if (!in_array($action, ['update', 'add', 'remove'], true)) {
    echo json_encode(['ok' => false, 'error' => 'Invalid action']);
    exit;
}

// Otel + otaq növü əlavə et (hotel_listing_full)
if ($entity === 'hotel' && $action === 'add') {
    $hotelName = isset($input['hotelName']) ? trim((string)$input['hotelName']) : '';
    $roomType = isset($input['roomType']) ? trim((string)$input['roomType']) : '';
    $price = isset($input['price']) && is_numeric($input['price']) ? (float)$input['price'] : null;
    if ($hotelName === '' || $roomType === '') {
        echo json_encode(['ok' => false, 'error' => 'hotelName and roomType required']);
        exit;
    }
    if ($price === null || $price < 0) {
        echo json_encode(['ok' => false, 'error' => 'Valid price required']);
        exit;
    }
    try {
        $region = isset($input['region']) ? preg_replace('/[^a-z0-9_]/', '', strtolower($input['region'])) : 'baku';
        if ($region === '') $region = 'baku';
        $stmt = $pdo->prepare("INSERT INTO hotel_listing_full (sheet_name, region, row_num, hotel_name, room_type, season_type, price) VALUES ('manual', ?, 999, ?, ?, 'peak', ?)");
        $stmt->execute([$region, $hotelName, $roomType, $price]);
        echo json_encode(['ok' => true]);
    } catch (Exception $e) {
        echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
    }
    exit;
}

// Otel + otaq növü sil (hotel_listing_full)
if ($entity === 'hotel' && $action === 'remove') {
    $oldHotel = isset($input['oldHotel']) ? trim((string)$input['oldHotel']) : '';
    $oldRoomType = isset($input['oldRoomType']) ? trim((string)$input['oldRoomType']) : '';
    if ($oldHotel === '') {
        echo json_encode(['ok' => false, 'error' => 'oldHotel required']);
        exit;
    }
    try {
        $stmt = $pdo->prepare("DELETE FROM hotel_listing_full WHERE hotel_name = ? AND room_type = ?");
        $stmt->execute([$oldHotel, $oldRoomType]);
        echo json_encode(['ok' => true]);
    } catch (Exception $e) {
        echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
    }
    exit;
}

// Otel + otaq növü + qiymət redaktə (hotel_listing_full)
if ($entity === 'hotel') {
    $oldHotel = isset($input['oldHotel']) ? trim((string)$input['oldHotel']) : (isset($input['oldName']) ? trim((string)$input['oldName']) : '');
    $oldRoomType = isset($input['oldRoomType']) ? trim((string)$input['oldRoomType']) : '';
    $newHotel = isset($input['newHotel']) ? trim((string)$input['newHotel']) : (isset($input['newName']) ? trim((string)$input['newName']) : '');
    $newRoomType = isset($input['newRoomType']) ? trim((string)$input['newRoomType']) : $oldRoomType;
    $newPrice = isset($input['newPrice']) && is_numeric($input['newPrice']) ? (float)$input['newPrice'] : (isset($input['newMinPrice']) && is_numeric($input['newMinPrice']) ? (float)$input['newMinPrice'] : null);
    if ($oldHotel === '' || $newHotel === '') {
        echo json_encode(['ok' => false, 'error' => 'oldHotel and newHotel required']);
        exit;
    }
    try {
        $pdo->beginTransaction();
        if ($oldRoomType !== '') {
            $updates = ['hotel_name = ?', 'room_type = ?'];
            $vals = [$newHotel, $newRoomType];
            if ($newPrice !== null && $newPrice >= 0) {
                $updates[] = 'price = ?';
                $vals[] = $newPrice;
            }
            $vals[] = $oldHotel;
            $vals[] = $oldRoomType;
            $stmt = $pdo->prepare("UPDATE hotel_listing_full SET " . implode(', ', $updates) . " WHERE hotel_name = ? AND room_type = ?");
            $stmt->execute($vals);
        } else {
            $stmt = $pdo->prepare("UPDATE hotel_listing_full SET hotel_name = ? WHERE hotel_name = ?");
            $stmt->execute([$newHotel, $oldHotel]);
            if ($newPrice !== null && $newPrice >= 0) {
                $sub = $pdo->prepare("SELECT id FROM hotel_listing_full WHERE hotel_name = ? AND price IS NOT NULL AND price > 0 ORDER BY price ASC LIMIT 1");
                $sub->execute([$newHotel]);
                $row = $sub->fetch(PDO::FETCH_ASSOC);
                if ($row) {
                    $up = $pdo->prepare("UPDATE hotel_listing_full SET price = ? WHERE id = ?");
                    $up->execute([$newPrice, $row['id']]);
                }
            }
        }
        $pdo->commit();
        echo json_encode(['ok' => true]);
    } catch (Exception $e) {
        $pdo->rollBack();
        echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
    }
    exit;
}

// Aktivitet əlavə et (tour_azerbaijan_activities_2026)
if ($entity === 'activity' && $action === 'add') {
    $name = isset($input['name']) ? trim((string)$input['name']) : '';
    $service = isset($input['service']) ? trim((string)$input['service']) : '';
    $city = isset($input['city']) ? preg_replace('/[^a-z0-9_]/', '', strtolower($input['city'])) : 'baku';
    $price = isset($input['price']) && is_numeric($input['price']) ? (float)$input['price'] : null;
    if ($name === '' || $service === '') {
        echo json_encode(['ok' => false, 'error' => 'name and service required']);
        exit;
    }
    if ($city === '') $city = 'baku';
    try {
        $stmt = $pdo->prepare("INSERT INTO tour_azerbaijan_activities_2026 (name, service, city, adult_price) VALUES (?, ?, ?, ?)");
        $stmt->execute([$name, $service, $city, $price]);
        echo json_encode(['ok' => true]);
    } catch (Exception $e) {
        echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
    }
    exit;
}

// Aktivitet sil (tour_azerbaijan_activities_2026)
if ($entity === 'activity' && $action === 'remove') {
    $oldValue = isset($input['oldValue']) ? (string)$input['oldValue'] : '';
    if ($oldValue === '') {
        echo json_encode(['ok' => false, 'error' => 'oldValue required']);
        exit;
    }
    $parts = explode('|', $oldValue, 2);
    $name = $parts[0] ?? '';
    $service = $parts[1] ?? '';
    if ($name === '' && $service === '') {
        echo json_encode(['ok' => false, 'error' => 'Invalid oldValue']);
        exit;
    }
    try {
        $stmt = $pdo->prepare("DELETE FROM tour_azerbaijan_activities_2026 WHERE name = ? AND service = ?");
        $stmt->execute([$name, $service]);
        echo json_encode(['ok' => true]);
    } catch (Exception $e) {
        echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
    }
    exit;
}

// Aktivitet redaktə (tour_azerbaijan_activities_2026)
if ($entity === 'activity') {
    $oldValue = isset($input['oldValue']) ? (string)$input['oldValue'] : '';
    $newLabel = isset($input['newLabel']) ? trim((string)$input['newLabel']) : '';
    $newCity = isset($input['newCity']) ? preg_replace('/[^a-z0-9_]/', '', strtolower($input['newCity'])) : 'baku';
    $newPrice = isset($input['newPrice']) ? (is_numeric($input['newPrice']) ? (float)$input['newPrice'] : null) : null;
    if ($oldValue === '' || $newLabel === '') {
        echo json_encode(['ok' => false, 'error' => 'oldValue and newLabel required']);
        exit;
    }
    $parts = explode('|', $oldValue, 2);
    $oldName = $parts[0] ?? '';
    $oldService = $parts[1] ?? '';
    $labelParts = preg_split('/\s*-\s*/', $newLabel, 2);
    $newName = trim($labelParts[0] ?? '');
    $newService = trim($labelParts[1] ?? $newName);
    if ($newName === '') $newName = $newService ?: $oldName;
    if ($newService === '') $newService = $newName ?: $oldService;
    try {
        $stmt = $pdo->prepare("UPDATE tour_azerbaijan_activities_2026 SET name = ?, service = ?, city = ?, adult_price = ? WHERE name = ? AND service = ?");
        $stmt->execute([$newName, $newService, $newCity ?: 'baku', $newPrice, $oldName, $oldService]);
        echo json_encode(['ok' => true]);
    } catch (Exception $e) {
        echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
    }
    exit;
}

// Transfer marşrutu sil (transfers cədvəli)
if ($entity === 'transfer-route' && $action === 'remove') {
    $a = isset($input['a']) ? trim((string)$input['a']) : '';
    $b = isset($input['b']) ? trim((string)$input['b']) : '';
    $s = isset($input['service']) ? trim((string)$input['service']) : '';
    if ($a === '' || $b === '' || $s === '') {
        echo json_encode(['ok' => false, 'error' => 'a, b, service required']);
        exit;
    }
    try {
        $stmt = $pdo->prepare("DELETE FROM transfers WHERE a = ? AND b = ? AND service = ?");
        $stmt->execute([$a, $b, $s]);
        echo json_encode(['ok' => true]);
    } catch (Exception $e) {
        echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
    }
    exit;
}

// Transfer marşrutu əlavə et (transfers cədvəli)
if ($entity === 'transfer-route' && $action === 'add') {
    $a = isset($input['a']) ? trim((string)$input['a']) : '';
    $b = isset($input['b']) ? trim((string)$input['b']) : '';
    $s = isset($input['service']) ? trim((string)$input['service']) : '';
    $prices = isset($input['prices']) && is_array($input['prices']) ? $input['prices'] : [];
    if ($a === '' || $b === '' || $s === '') {
        echo json_encode(['ok' => false, 'error' => 'a, b, service required']);
        exit;
    }
    require_once __DIR__ . '/tour_config_functions.php';
    $colMap = getTransferVehicleColumnsFromTable($pdo);
    try {
        $stmt = $pdo->query("SELECT COALESCE(MAX(duty_code), 0) + 1 AS next_code FROM transfers");
        $row = $stmt ? $stmt->fetch(PDO::FETCH_ASSOC) : null;
        $dutyCode = $row ? (int)($row['next_code'] ?? 1) : 1;
        $cols = ['duty_code', 'a', 'b', 'service'];
        $vals = [$dutyCode, $a, $b, $s];
        $placeholders = ['?', '?', '?', '?'];
        foreach (array_keys($colMap) as $col) {
            if (isset($prices[$col]) && is_numeric($prices[$col]) && (float)$prices[$col] >= 0) {
                $cols[] = '`' . str_replace('`', '``', $col) . '`';
                $vals[] = (float)$prices[$col];
                $placeholders[] = '?';
            }
        }
        $sql = "INSERT INTO transfers (" . implode(', ', $cols) . ") VALUES (" . implode(', ', $placeholders) . ")";
        $stmt = $pdo->prepare($sql);
        $stmt->execute($vals);
        echo json_encode(['ok' => true]);
    } catch (Exception $e) {
        echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
    }
    exit;
}

// Transfer marşrutu redaktə (transfers cədvəli)
if ($entity === 'transfer-route' && $action === 'update') {
    $oldA = isset($input['oldA']) ? trim((string)$input['oldA']) : '';
    $oldB = isset($input['oldB']) ? trim((string)$input['oldB']) : '';
    $oldS = isset($input['oldS']) ? trim((string)$input['oldS']) : '';
    $newA = isset($input['newA']) ? trim((string)$input['newA']) : '';
    $newB = isset($input['newB']) ? trim((string)$input['newB']) : '';
    $newS = isset($input['newS']) ? trim((string)$input['newS']) : '';
    $prices = isset($input['prices']) && is_array($input['prices']) ? $input['prices'] : [];
    if ($oldA === '' || $oldB === '' || $oldS === '' || $newA === '' || $newB === '' || $newS === '') {
        echo json_encode(['ok' => false, 'error' => 'oldA, oldB, oldS, newA, newB, newS required']);
        exit;
    }
    require_once __DIR__ . '/tour_config_functions.php';
    $colMap = getTransferVehicleColumnsFromTable($pdo);
    try {
        $stmt = $pdo->prepare("UPDATE transfers SET a = ?, b = ?, service = ? WHERE a = ? AND b = ? AND service = ?");
        $stmt->execute([$newA, $newB, $newS, $oldA, $oldB, $oldS]);
        foreach (array_keys($colMap) as $col) {
            if (isset($prices[$col]) && is_numeric($prices[$col]) && (float)$prices[$col] >= 0) {
                $up = $pdo->prepare("UPDATE transfers SET `" . str_replace('`', '``', $col) . "` = ? WHERE a = ? AND b = ? AND service = ?");
                $up->execute([(float)$prices[$col], $newA, $newB, $newS]);
            }
        }
        echo json_encode(['ok' => true]);
    } catch (Exception $e) {
        echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
    }
    exit;
}

echo json_encode(['ok' => false, 'error' => 'Unknown entity']);
