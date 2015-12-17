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

$n = gi();
$q = ngs($n);
$m = gi();
$p = ngs($m);

for2p(range(0,$n-$m),range(0,$n-$m), function ($i,$j) use ($q,$m,$p) {
    $x = array_reduce(range(0,$m-1), function ($c, $e) use ($i,$j,$q,$m,$p) {
        return $c && $p[$e] === substr($q[$i+$e],$j*2,$m*2-1);
    }, TRUE);
    if ($x) {
        echo "$i $j", PHP_EOL;
    }
});
