process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', function (chunk) {
    function strrev(s) { return s.split("").reverse().join(""); }
    var w = chunk.toString().trim().split('\n');
    var n = parseInt(w[0]);
    var c = "";
    for (var i = 1; i <= n; i++) {
        if (w[i] === "") {
            continue;
        }
        var r = strrev(w[i]);
        var j = w.indexOf(r, i + 1);
        if (j > 0 && j != i) {
            process.stdout.write(w[i]);
            w[j] = "";
        } else {
            if (w[i] === r && (c === "" || c > r)) {
                c = r;
            }
            w[i] = "";
        }
    }
    process.stdout.write(c);
    for (var k = n; k > 0; k--) {
        if (w[k] === "") {
            continue;
        }
        process.stdout.write(strrev(w[k]));
    }
});
