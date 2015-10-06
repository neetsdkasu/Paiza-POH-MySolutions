/*
 * 結果 https://paiza.jp/poh/joshibato/rio/result/f92458a2
 */
process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', function (chunk) {
    var lines = chunk.toString().trim().split('\n');
    var n = parseInt(lines[0]);
    var i, wc;
    var w = 0.0;
    var c = 0.0;
    for (i = 1; i <= n; i++) {
        var tas = lines[i].trim().split(' ');
        var s = parseFloat(tas[1]);
        switch (tas[0]) {
            case "1":
                w += s;
                break;
            case "2":
                c += s;
                break;
            default:
                wc = w + c;
                w = (w * wc - s * w) / wc;
                c = (c * wc - s * c) / wc;
                break;
        }
    }
    var ans = 100.0 * c / (w + c);
    console.log(Math.floor(ans));
});
