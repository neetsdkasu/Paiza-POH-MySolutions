-- Try POH
-- author: Leonardone @ NEETSDKASU


main = print . solve . read =<< getLine

modval = 1000000000

reject d v c
    | md == 0   = reject d dv (c + 1)
    | otherwise = (v, c)
    where
        (dv, md) = divMod v d

multiply a b | a == b = res where
    (x, c1) = reject 5 a 0
    res = reject 2 x (-c1)
multiply a b = res where
    h = div (b + a) 2
    (aa, c1) = multiply a h
    (bb, c2) = multiply (h + 1) b
    aam = mod aa modval
    bbm = mod bb modval
    mul = aam * bbm
    res = (mod mul modval, c1 + c2)

doubling v 0 = v
doubling v c = res where
    w = mod (v * 2) modval
    res = doubling w (c - 1)

solve n = res where
    (x, c) = multiply 1 n
    res = doubling x c

