s=c=""
gets
ARGF.read.split.group_by{|x|(x==y=x.reverse)&&c=x;[x,y].min}.sort.map{|k,x|
(0<z=x.size/2)&&($><<k*z;s=x.max*z+s)
}
$><<c+s
