<?php
require __DIR__ . '/config.php';
require __DIR__ . '/api/tour_config_functions.php';

$pdo = dbConnect();
$p = fetchTransferVehiclePricesFromTransfers($pdo);
$k1 = 'Airport|Hotel|1 way Transfer';
$k2 = 'Airport|Hotel|Day Trip';
echo $k1 . ' sprinter=' . ($p[$k1]['Sprinter 18'] ?? 'NONE') . PHP_EOL;
echo $k2 . ' sprinter=' . ($p[$k2]['Sprinter 18'] ?? 'NONE') . PHP_EOL;

$leaks = 0;
foreach ($p as $k => $v) {
    $parts = explode('|', $k, 3);
    $svc = $parts[2] ?? '';
    if (stripos($svc, 'Day Trip') === false && stripos($svc, 'Day trip') === false) {
        continue;
    }
    if (stripos($k, 'Airport') !== false && stripos($k, 'Hotel') !== false) {
        echo 'KEY ' . $k . ' = ' . ($v['Sprinter 18'] ?? 'n/a') . PHP_EOL;
        $leaks++;
    }
}
echo 'airport+hotel+daytrip keys=' . $leaks . PHP_EOL;
