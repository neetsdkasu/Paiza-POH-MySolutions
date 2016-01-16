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

main = do
    n <- gi
    p <- ngis n
    m <- gi
    q <- ngis m
    putStrLn . unwords . fmap show $ solve n p m q

solve n p m q = ans where
    i = length $ takeWhile (/= q) [ fmap (take m . drop j) $ take m $ drop i p | i <- [0..n-m], j <- [0..n-m] ]
    (y, x) = divMod i (n - m + 1)
    ans = [y, x]
