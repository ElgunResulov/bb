<?php
require 'config.php';
$pdo = dbConnect();
if (!$pdo) {
    die("Connection failed\n");
}
$stmt = $pdo->query('SHOW TABLES');
if ($stmt) {
    print_r($stmt->fetchAll(PDO::FETCH_COLUMN));
} else {
    echo "Query failed\n";
}
