#! ruby
# Try POH
# author: Leonardone @ NEETSDKASU
############################################################
def gs() gets.chomp end
def gi() gets.to_i end
def gss() gs.split end
def gis() gss.map(&:to_i) end
def nmapf(n,f) n.times.map{ __send__ f } end
def ngs(n) nmapf n,:gs end
def ngi(n) nmapf n,:gi end
def ngss(n) nmapf n,:gss end
def ngis(n) nmapf n,:gis end
def arr2d(h,w,v=0) h.times.map{[v] * w} end
def for2p(hr,wr,&pr) hr.each{|i|wr.each{|j| yield(i,j)}} end
def nsum(n) n * (n + 1) / 2 end
def vcount(d,r=Hash.new(0)) d.inject(r){|r,e| r[e]+=1;r} end
############################################################

n = gi
m1 = gi
x = gis
m2 = gi
y = gis

z = y - x
if z.empty?
    puts :None
else
    puts z.uniq.sort*" "
end


