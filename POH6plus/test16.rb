gets;w=ARGF.read.split.sort;v=w-(w-w.map{|x|x.reverse});u=v.select{|x|x<x.reverse};s=u*"";$><<s+v.select{|x|x==x.reverse}*""+s.reverse
