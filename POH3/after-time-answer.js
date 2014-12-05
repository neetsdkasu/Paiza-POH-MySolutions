// paiza POH! Lite
// result:
//
// author: Leonardone @ NEETSDKASU
process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', function (chunk) {
    var lines = chunk.toString().split('\n');
    var m = lines[0] ^ 0;
    var n = lines[1] ^ 0;
    var w = -m;
    var p = 0;
    var i,j,line,x,y,u,v;
    for(i=n+1; i>1; i--) {
        line = lines[i] = lines[i].split(" ");
        w += line[0] ^= 0;
        p += line[1] ^= 0;
    }
    var a = new Array(w+1);
    var b = new Array(w+1);
    var c = a;
    for(j=0; j<=w; j++) {
        a[j] = 0;
    }
    for(i=0; i<n; i++) {
        line=lines[i+2];
        u=line[0];
        v=line[1];
        if (u <= w) {
            for(j=0; j<u; j++) {
                b[j] = a[j];
            }
            for(; j<=w; j++) {
                x = a[j];
                y = a[j-u] + v;
                b[j] = (x > y) ? x : y;
            }
        } else {
            for(j=0; j<=w; j++) {
                b[j] = a[j];
            }
        }
        c = a;
        a = b;
        b = c;
    }
    console.log(p - a[w]);
});
