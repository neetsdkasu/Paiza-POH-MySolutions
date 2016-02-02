-- Try POH
-- author: Leonardone @ NEETSDKASU
{- **************************************** -}
ti s = read s ::Int
gs = getLine
gi = fmap ti gs
gss = fmap words gs
gis = fmap (map ti) gss
ngt n f = sequence [f | _ <- [1..n]]
ngs n = ngt n gs
ngi n = ngt n gi
ngss n = ngt n gss
ngis n = ngt n gis
{- **************************************** -}

main = print . solve =<< readLn 

solve n = calc n (count5 n 0) 1

calc 1 _ r = r
calc n c r = let (p, k) = reject2 n c in calc (n - 1) k $ modval $ r * (reject5 p)

modval x = mod x 1000000000

count5 0 c = c
count5 n c = let d = div n 5 in count5 d d + c

reject5 x | m == 0 = reject5 d where (d, m) = divMod x 5
reject5 x = x

reject2 x 0 = (x, 0)
reject2 x c | m == 0 = reject2 d (c - 1) where (d, m) = divMod x 2
reject2 x c = (x, c)
