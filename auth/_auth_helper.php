<?php
/**
 * Auth helper – session, giriş yoxlaması, admin yoxlaması
 */
if (!defined('DB_HOST')) {
    require_once __DIR__ . '/../config.php';
}

function auth_start_session() {
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
}

function auth_user_logged_in() {
    auth_start_session();
    return isset($_SESSION['user_id']) && !empty($_SESSION['user_id']);
}

function auth_is_admin() {
    auth_start_session();
    return isset($_SESSION['admin_status']) && (int)$_SESSION['admin_status'] === 1;
}

/**
 * Admin assistant rolu: yalnız məhdud admin icazələri (Orders, Invoices & Debts, Users).
 * admin_status = 2 kimi istifadə edirik.
 */
function auth_is_admin_assistant() {
    auth_start_session();
    return isset($_SESSION['admin_status']) && (int)$_SESSION['admin_status'] === 2;
}

/**
 * Hem tam admin (1), həm də admin assistant (2) üçün ümumi yoxlama.
 */
function auth_is_admin_or_assistant() {
    auth_start_session();
    if (!isset($_SESSION['admin_status'])) return false;
    $st = (int)$_SESSION['admin_status'];
    return $st === 1 || $st === 2;
}

function auth_get_user() {
    auth_start_session();
    if (!auth_user_logged_in()) return null;
    return [
        'id' => $_SESSION['user_id'] ?? null,
        'email' => $_SESSION['user_email'] ?? null,
        'name' => $_SESSION['user_name'] ?? null,
        'admin_status' => isset($_SESSION['admin_status']) ? (int)$_SESSION['admin_status'] : 0,
    ];
}

function auth_require_login($redirect_to = null) {
    if (!auth_user_logged_in()) {
        $url = $redirect_to ?: ('/bb/auth/login.php?redirect=' . urlencode($_SERVER['REQUEST_URI'] ?? ''));
        header('Location: ' . $url);
        exit;
    }
}

function auth_require_login_api() {
    auth_start_session();
    if (!auth_user_logged_in()) {
        http_response_code(401);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode(['ok' => false, 'error' => 'Giriş tələb olunur']);
        exit;
    }
}

function auth_require_admin($redirect_to = null) {
    auth_require_login($redirect_to ?: '/bb/auth/login.php');
    if (!auth_is_admin()) {
        header('Location: ' . ($redirect_to ?: '/bb/tour-builder.php'));
        exit;
    }
}

/**
 * Admin və ya admin assistant üçün (panelə giriş, oxuma icazələri və müəyyən məhdud əməliyyatlar üçün).
 */
function auth_require_admin_or_assistant($redirect_to = null) {
    auth_require_login($redirect_to ?: '/bb/auth/login.php');
    if (!auth_is_admin_or_assistant()) {
        header('Location: ' . ($redirect_to ?: '/bb/tour-builder.php'));
        exit;
    }
}

function auth_require_admin_api() {
    auth_start_session();
    if (!auth_user_logged_in()) {
        http_response_code(401);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode(['ok' => false, 'error' => 'Giriş tələb olunur']);
        exit;
    }
    if (!auth_is_admin()) {
        http_response_code(403);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode(['ok' => false, 'error' => 'Admin icazəsi tələb olunur']);
        exit;
    }
}

/**
 * Admin və ya admin assistant üçün API yoxlaması.
 * Tam konfiqurasiya dəyişiklikləri üçün yenə də auth_require_admin_api istifadə olunmalıdır.
 */
function auth_require_admin_or_assistant_api() {
    auth_start_session();
    if (!auth_user_logged_in()) {
        http_response_code(401);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode(['ok' => false, 'error' => 'Giriş tələb olunur']);
        exit;
    }
    if (!auth_is_admin_or_assistant()) {
        http_response_code(403);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode(['ok' => false, 'error' => 'Admin və ya admin assistant icazəsi tələb olunur']);
        exit;
    }
}
