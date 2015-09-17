gets;def f(a,s);(a.size<1&&$><<s+$c+s.reverse)||(h=a.shift;r=h.reverse;(h==r&&$c+=h)||a.index(r)&&h<r&&s+=h;f(a,s));end;f(ARGF.read.split.sort,$c="")
