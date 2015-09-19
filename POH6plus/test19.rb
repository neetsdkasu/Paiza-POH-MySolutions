gets;w=ARGF.read.split.sort;a=[];w.map{|x|((x==y=x.reverse)&&a+=[y])||(x<y&&w.index(y)&&a=[y]+a+[x])};$><<a.rotate(a.size/2)*""
