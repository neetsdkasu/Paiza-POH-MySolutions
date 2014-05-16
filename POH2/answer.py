# paiza POH! vol.2
# result:
# http://paiza.jp/poh/paizen/result/5921f33c8a94fee3caa44fe179df053f
# author: Leonardone @ NEETSDKASU
h, w = map(int, raw_input().split())
sp = [0 for j in xrange(w)]
tb = [[0 for j in xrange(w + 1)] for i in xrange(h + 1)]
for y in xrange(h) :
	str = raw_input()
	for x in xrange(w) :
		if str[x] == '0' :
			sp[x] = sp[x] + 1
			s = sp[x]
			t = 1
			i = x
			while i >= 0 and sp[i] > 0 :
				if sp[i] < s :
					s = sp[i]
				tb[s][t] = tb[s][t] + 1
				t = t + 1
				i = i - 1
		else :
			sp[x] = 0

for x in xrange(1, w + 1) :
	for y in xrange(h - 1, 0, -1) :
		tb[y][x] = tb[y][x] + tb[y + 1][x]

n = int(raw_input())
for i in xrange(n) :
	s, t = map(int, raw_input().split())
	if s <= h and t <= w :
		print tb[s][t]
	else :
		print "0"
