h={};c="";$<.read(()).gsub(/[a-z]+/){|x|(x==y=x.reverse)?c+=x : h[x] ?h[x]=[x,y].min: h[y]=""};s=h.values.sort*"";$><<s+c+s.reverse
