#! ruby
# Try POH
# author: Leonardone @ NEETSDKASU

require 'matrix'

n = gets.to_i
q = []
n.times do
    q << gets.chomp.split.map(&:to_i)
end
m = gets.to_i
p = []
m.times do 
    p << gets.chomp.split.map(&:to_i)
end

qm = Matrix.rows(q,false)
pm = Matrix.rows(p,false)

(0..n-m).each do |i|
    (0..n-m).each do |j|
        puts "%d %d" % [i,j] if qm.minor(i,m,j,m) == pm
    end
end
