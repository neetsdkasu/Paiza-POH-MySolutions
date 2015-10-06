/*
 * 結果 https://paiza.jp/poh/joshibato/kirishima/result/dbb4f923
 */
process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', function (chunk) {
    var lines = chunk.toString().trim().split('\n');
    var n = parseInt(lines[0]);
    var t = lines[1].split(' ').map(function(x){return parseInt(x);});
    var m = parseInt(lines[2]);
    var i, d, f, r;
    for (i = 0; i < m; i++) {
        d = parseInt(lines[i + 3]);
        f = (new Array(n)).fill(false);
        r = 'No';
        for (;;) {
            if (d < 1 || d >= n) break;
            if (d == n - 1) {
                r = 'Yes';
                break;
            }
            if (t[d] == 0) break;
            if (f[d] == true) break;
            f[d] = true;
            d += t[d] - 0;
        }
        console.log(r);
    }
});
