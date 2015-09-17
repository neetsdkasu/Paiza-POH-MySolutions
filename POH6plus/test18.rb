s=""
gets
ARGF.read.split.group_by{|x|[x,x.reverse].min}.sort.map{|k,x|
eval [0,'$><<k if k==k.reverse','$><<k;s=x.max+s',3,4,5,6,'s=k*7'][x.size]
# case x.size
# when 2
#   $><<k; s=x.max+s
# when 7
#   s=k*7
# else
#   $><<k if k==k.reverse
# end
}
$><<s
