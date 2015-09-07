f=Hash.new 0;g={};c="";a=[];b=[];ARGF.read.split[1..-1].map{|x|f[[x,y=x.reverse].min]+=1;g[x]=y;x==y&&c=y};f.keys.sort.each{|k|v=f[k]>>1;a+=[k].*v;b=([g[k]].*v)+b};$><<(a+[c]+b).join
