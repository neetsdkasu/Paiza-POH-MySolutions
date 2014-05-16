# paiza POH! vol.2
# result:
# http://paiza.jp/poh/paizen/result/0a6719efee92cade010971bc36de29c7
# author: Leonardone @ NEETSDKASU
hw = gets.split(' ')
h = hw[0].to_i
w = hw[1].to_i
sp = Array.new(w, 0)
tb = Array.new(h + 1).map{ Array.new(w + 1, 0) }
h.times do |y|
	line = gets.split('')
	w.times do |x|
		if line[x] == '0' then
			sp[x] = sp[x] + 1
			s = sp[x]
			t = 1
			i = x
			while i >= 0 && sp[i] > 0 do
				if sp[i] < s then
					s = sp[i]
				end
				tb[s][t] = tb[s][t] + 1
				t = t + 1
				i = i - 1
			end
		else
			sp[x] = 0
		end
	end
end

hh = h - 1
w.times do |x|
	xx = x + 1
	hh.times do |y|
		yy = hh - y
		tb[yy][xx] = tb[yy][xx] + tb[yy + 1][xx]
	end
end

n = gets.to_i

n.times do
	st = gets.split(' ')
	s = st[0].to_i
	t = st[1].to_i
	if s <= h && t <= w then
		puts tb[s][t]
	else
		puts "0"
	end
end
