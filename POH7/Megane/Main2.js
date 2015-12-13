// Try POH
// author: Leonardone @ NEETSDKASU
process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data',function(c){main(c)});

function main(chunk) {
    var i;
    var s = chunk.toString().trim().split('\n');
    var n = parseInt(s[0]);
    var q = "", p = '';
    for (i = 0; i < n; i++) {
        q += s[i + 1] + 'xx';
    }
    var m = parseInt(s[n + 1]);
    for (i = 0; i < m; i++) {
        if (i > 0) {
            p += '.{' + ((n - m + 1) * 2) + '}';
        }
        p += s[(n + 2) + i];
    }
    var r = q.search(p);
    var y = Math.floor(r / (n * 2 + 1));
    var x = Math.floor((r % (n * 2 + 1)) / 2);
    console.log(y + ' ' + x);
}
