gets;$a=ARGF.read.split.sort;$s=$c="";def f;($a.size<1&&$><<$s+$c+$s.reverse)||(h=$a.shift;r=h.reverse;(h==r&&$c+=h)||$a.index(r)&&h<r&&$s+=h;f);end;f
