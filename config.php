<?php
/**
 * Veritabanı konfiqurasiyası - B2B Tour Builder
 * XAMPP üçün: root, boş parol
 * Email: php.ini-də SMTP/sendmail_path təyin edin və ya xarici SMTP istifadə edin
 */
// Environment detection (cPanel vs XAMPP)
$is_localhost = ($_SERVER['SERVER_NAME'] === 'localhost' || $_SERVER['SERVER_NAME'] === '127.0.0.1');

if ($is_localhost) {
    // Local XAMPP credentials
    define('DB_HOST', 'localhost');
    define('DB_NAME', 'b2b_tour_builder'); // CHANGE THIS
    define('DB_USER', 'root');
    define('DB_PASS', '');
} else {
    // Live cPanel credentials
    define('DB_HOST', 'localhost'); // Usually localhost on cPanel
    define('DB_NAME', 'b2b_tour_builder'); // CHANGE THIS
    define('DB_USER', 'root'); // CHANGE THIS
    define('DB_PASS', ''); // CHANGE THIS
}
define('DB_CHARSET', 'utf8mb4');

/**
 * Excel import üçün Python.exe tam yolu (Apache PATH-də python olmaya bilər).
 * Boş buraxsanız lib/excel_import.php avtomatik tapmağa çalışır.
 * Nümunə: 'C:\\Users\\user\\AppData\\Local\\Python\\pythoncore-3.14-64\\python.exe'
 */
define('PYTHON_BIN', 'C:\\Users\\user\\AppData\\Local\\Python\\pythoncore-3.14-64\\python.exe');

/**
 * Excel import: cPanel-də avtomatik PHP istifadə olunur (exec bağlıdır).
 * Məcburi PHP: define('EXCEL_IMPORT_ENGINE', 'php');
 */
// define('EXCEL_IMPORT_ENGINE', 'php');

function dbConnect() {
    $dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=' . DB_CHARSET;
    try {
        $pdo = new PDO($dsn, DB_USER, DB_PASS, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ]);
        return $pdo;
    } catch (PDOException $e) {
        error_log("Database connection failed: " . $e->getMessage());
        return null; // Return null so we can check it
    }
}
