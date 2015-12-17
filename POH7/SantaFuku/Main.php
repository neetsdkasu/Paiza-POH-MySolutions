<?php
// Try POH
// author: Leonardone @ NEETSDKASU

function gs()  { return trim(fgets(STDIN)); }
function gi()  { return intval(gs()); }
function gss() { return explode(' ', fgets(STDIN)); }
function gis() { return array_map('intval', gss()); }
function nmapf($n, $f) { return array_map($f, range(0, $n - 1)); }
function ngs($n) { return nmapf($n, 'gs'); }
function ngi($n) { return nmapf($n, 'gi'); }
function ngss($n){ return nmapf($n, 'gss'); }
function ngis($n){ return nmapf($n, 'gis'); }
function for2p($hr,$wr,$pr) { foreach ($hr as $i) { foreach ($wr as $j) { call_user_func($pr, $i, $j); } } }

list($x, $y, $z, $n) = gis();
$das = ngis($n);

$rx = $x;
$ry = $y;

while (list($i, list($d, $a)) = each($das)) {
    $r = $a;
    while (++$i < $n) {
        if ($das[$i][0] === $d) {
            $r = min(abs($das[$i][1] - $a), $r);
        }
    }
    if ($d === 0) {
        $rx = min($rx, $r, $x - $a);
    } else {
        $ry = min($ry, $r, $y - $a);
    }
}

echo ($z * $rx * $ry), PHP_EOL;
