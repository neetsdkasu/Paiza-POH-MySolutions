p=process.stdin;
p.resume();
p.setEncoding('utf8');
p.on('data',function(chunk){
    w=chunk.toString().split('\n').sort();
    n=w[1];c=s=e='';
    for(i=0;i<n;i++){
        z=w[i+2];
        r=z.split(e).reverse().join(e);
        if(z==r)c+=z;else if(w.indexOf(r)>0&&z<r)s+=z;
    }
    console.log(s+c+s.split(e).reverse().join(e));
});
