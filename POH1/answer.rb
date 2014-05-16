# paiza POH! Vol.1
# result:
# http://paiza.jp/poh/ec-campaign/result/dcb4fefe9a664bb385df949cf057122e
# author: Leonardone @ NEETSDKASU

def foo(p, f, e, m)
	df = e - f
	if df < 5 then
		f
	else
		ci = f + (df >> 1)
		if m > p[ci] then
			foo(p, ci, e, m)
		else
			foo(p, f, ci, m)
		end
	end
end

def bar(p, f, e, m) 
	df = e - f
	if df < 5 then
		e
	else
		ci = f + (df >> 1)
		if m < p[ci] then
			bar(p, f, ci, m)
		else
			bar(p, ci, e, m)
		end
	end
end
	

s = gets.split(' ')
n = s[0].to_i
d = s[1].to_i
p = []
n.times do |i|
	p[i] = gets.to_i
end
p = p.sort

d.times do
	m = gets.to_i
	tmp = 0
	j = bar(p, 0, n - 1, m)
	while (j >= 0) && (p[j] >= m) do
		j = j - 1
	end
	if j >=0 then
		df = m - p[j]
		if df <= p[j] then
			i = foo(p, 0, j, df)
			while df <= p[j] do
				while (df > p[i]) do
					i = i + 1
				end
				if (df < p[i]) || (i == j) then
					if i > 0 then
						i = i - 1
					end
				end
				sum = p[i] + p[j]
				if (sum > tmp) && (sum <= m) then
					tmp = sum
					if tmp == m then
						break
					end
				end
				j = j - 1
				df = m - p[j]
			end
		end
	end
	puts tmp
end
