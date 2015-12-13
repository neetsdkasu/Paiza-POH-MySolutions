// Try POH
// author: Leonardone @ NEETSDKASU
process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data',function(c){main(c)});

function main(chunk) {
    var i, j, k, x;
    var s = chunk.toString().trim().split('\n');
    var n = parseInt(s[0]);
    var q = [];
    for (i = 0; i < n; i++) {
        q[i] = s[i + 1];
    }
    var m = parseInt(s[n + 1]);
    var t = {}, p = "";
    for (i = 0; i < m; i++) {
        p = s[(n + 2) + i];
        for (j = 0; j <= n - m; j++) {
            for (k = 0; (k = q[i + j].indexOf(p, k)) >= 0; k++) {
                x = j.toString() + ' ' + Math.floor(k / 2).toString();
                if (t[x] === undefined) {
                    t[x] = 0;
                }
                t[x]++;
            }
        }
    }
    for (x in t) {
        if (t[x] == m) {
            console.log(x);
        }
    }
}
