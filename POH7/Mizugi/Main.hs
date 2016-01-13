-- Try POH
-- author: Leonardone @ NEETSDKASU

main = print . solve . read =<< getLine

modval = 1000000000

reject d v c
    | md == 0   = reject d dv (c + 1)
    | otherwise = (v, c)
    where
        (dv, md) = divMod v d

multiply 1 r c = (r, c)
multiply n r c = res where
    (x, c1) = reject 5 n 0
    (y, c2) = reject 2 x (c - c1)
    z = mod (r * y) modval
    v = multiply (n - 1) z c2
    res = z `seq` c2 `seq` v

doubling (v, 0) = v
doubling (v, c) = res where
    w = mod (v * 2) modval
    res = doubling (w, c - 1)

solve n = res where
    res = doubling $ multiply n 1 0

