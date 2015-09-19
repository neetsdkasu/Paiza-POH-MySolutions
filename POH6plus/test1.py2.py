n=int(raw_input());w=[raw_input()for i in range(n)];s=c=""
while len(w)>0:
 m=min(w);w.remove(m);r=m[::-1]
 if r in w:s+=m;w.remove(r)
 elif m==r:c=m
print s+c+s[::-1]
