/*
 * 結果 https://paiza.jp/poh/joshibato/tsubame/result/ec08af86
 */
process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', function (chunk) {
    var n_str = chunk.toString();
    
    var n = parseInt(n_str);
    var n1 = parseInt(n_str.substring(1,2)); // pos - pos
    var n10 = parseInt(n_str.substr(0,1)); // pos - len
    
    var r = n + n1 + n10;
    
    console.log(r);
});
