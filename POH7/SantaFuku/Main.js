// Try POH
// author: Leonardone @ NEETSDKASU
process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', function(c){main(c);});

function main(chunk) {
    var i, d, a;
    var s = chunk.toString().trim().split(/\s/).map(function(c,i,a){return parseInt(c);});
    var x = s[0], y = s[1], z = s[2], n = s[3];
    var xs = [], ys = [], xm = x, ym = y;
    var f = function (es, em, e, b) {
        var i;
        em = Math.min(em, e, b - e);
        for (i in es) {
            em = Math.min(em, Math.abs(es[i] - e));
        }
        es.push(e);
        return em;
    };
    for (i = 0; i < n; i++) {
        d = s[i * 2 + 4];
        a = s[i * 2 + 5];
        if (d === 0) {
            xm = f(xs, xm, a, x);
        } else {
            ym = f(ys, ym, a, y);
        }
    }
    console.log(z * xm * ym);
}
