#! ruby

#
# 結果 https://paiza.jp/poh/joshibato/tsubame/result/137c4ad4
#

n = gets.chomp.to_i

n1 = n % 10
n10 = (n - n1) / 10

r = n + n1 + n10

puts r
