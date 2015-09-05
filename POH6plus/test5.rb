f=Hash.new 0;s=c=""
gets.to_i.times{
    f[[x=gets.chop,y=x.reverse].min]+=1
    x==y&&c=x
}
f.sort.map{|k,v|
s+=k.*v/2
}
$><<s+c+s.reverse
