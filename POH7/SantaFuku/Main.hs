-- Try POH
-- author: Leonardone @ NEETSDKASU

import qualified Data.List as List (sort)

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

main = do
    (x:y:z:n:_) <- gis
    da <- ngis n
    print $ solve x y z n da

solve x y z n da = ans where
    append (d:a:_) (xs, ys)
        | d == 0    = (a:xs, ys)
        | otherwise = (xs, a:ys)
    (xs, ys) = foldr append ([0,x],[0,y]) da
    addval (a, b) = b - a
    valmin vs = let vss = List.sort vs in minimum . map addval $ zip vss $ tail vss
    xmin = valmin xs
    ymin = valmin ys
    ans = xmin * ymin * z
