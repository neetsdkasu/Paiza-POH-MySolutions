// Try POH
// author: Leonardone @ NEETSDKASU
process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', function(c){main(c);});

function main(chunk) {
    var n = parseInt(chunk.toString().trim());
    var r = 1, b = 0, i, x;
    for (i = 1; i <= n; i++) {
        x = i;
        while (x % 2 === 0) {
            x /= 2;
            b++;
        }
        while (x % 5 === 0) {
            x /= 5;
            b--;
        }
        r = (r * x) % 1000000000;
    }
    for (i = 0; i < b; i++) {
        r = (r * 2) % 1000000000;
    }
    console.log(r);
}
