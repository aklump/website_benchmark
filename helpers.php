<?php

/**
 * @file
 * Process the raw statistics and return the results as JSON.s
 */

$data = json_decode($argv[1], TRUE);
$data['date'] = date('r');

$data['average_all'] = [];
foreach ($data['results'] as $path => $result) {
  if (count($result) > 2) {
    // When we have at least three values then we can throw out the min/max for
    // better statistics.
    sort($result);
    array_shift($result);
    array_pop($result);
  }
  $data['averages'][$path] = count($result) ? array_sum($result) / count($result) : 0;
  $data['average_all'][] = $data['averages'][$path];
}
$data['average_all'] = count($data['average_all']) ? array_sum($data['average_all']) / count($data['average_all']) : 0;

print json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES);
