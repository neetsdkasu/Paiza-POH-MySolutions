process.stdin.resume();process.stdin.setEncoding('utf8');process.stdin.on('data',function(a){p=s=c='';function k(b){return b.split(p).reverse().join(p)}w=a.toString().trim().split('\n');n=w[0]-0;w.sort();for(i=1;i<=n;i++){if(w[i]===p)continue;r=k(w[i]);j=w.indexOf(r,i+1);if(j>0&&j!=i){s+=w[i];w[j]=r=p}if(w[i]===r&&(c===p||c>r))c=r}console.log(s+c+k(s))});
