n=gets.to_i;w=ARGF.read.split.sort;w=w.reject{|x|!w.index(y=x.reverse)||x>y};$><<w.join+(n!=7&&(n<9?w[0..-2]:w).join.reverse||"")
