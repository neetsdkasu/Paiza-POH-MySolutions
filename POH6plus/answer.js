process.stdin.resume();process.stdin.setEncoding('utf8');function strrev(s){return s.split("").reverse().join("");}process.stdin.on('data',function(chunk){var j0=0;var j1=chunk.indexOf("\n");var n=parseInt(chunk.substring(j0,j1));j0=j1+1;j1=chunk.indexOf("\n",j0);var l=j1-j0;j1=chunk.indexOf("\n",j1+1);var q=j1-j0-l;var i,s0,s1,r,c="",smin,smax,st;var u=0;smin=chunk.substring(j0,j0+q);smax=smin;for(i=0;i<n;i++){j1=j0+i*q;s1=chunk.substring(j1,j1+l);if(s1<smin){smin=s1;}if(s1>smax){smax=s1;}}s0=smin;for(;;) {r=strrev(s0);if(s0<=r){u=0;for(i=0;i<n;i++){j1=j0+i*q;s1=chunk.substring(j1,j1+l);if(s1===r){u++;}}if(u>0){if(s0===r){if(u%2==1){if(c===""||c>r){c=r;}u--;}u/=2;}for(i=0;i<u;i++){process.stdout.write(s0);}}}if(s0===smax){break;}st=s0;s0=smax;for(i=0;i<n;i++){j1=j0+i*q;s1=chunk.substring(j1,j1+l);if(s1>st&&s1<s0){s0=s1;}}}process.stdout.write(c);s0=smax;for(;;){r=strrev(s0);if(s0<=r){u=0;for(i=0;i<n;i++){j1=j0+i*q;s1=chunk.substring(j1,j1+l);if(s1===r){u++;}}if(u>0){if(s0===r){if(u%2==1){u--;}u/=2;}for(i=0;i<u;i++){process.stdout.write(r);}}}if(s0===smin){break;}st=s0;s0=smin;for(i=0;i<n;i++){j1=j0+i*q;s1=chunk.substring(j1,j1+l);if(s1<st&&s1>s0){s0=s1;}}}});
