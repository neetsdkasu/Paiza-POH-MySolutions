import Data.List

main = getContents >>= \x ->
       putStr $ solve "" "" "" $ sort $ tail $ lines x

solve s c t [] = s ++ c ++ t
solve s c t (x:xs)= let r = reverse x
                     in case elemIndex r xs of
                        (Just _) -> solve (s ++ x) c (r ++ t) (delete r xs)
                        Nothing -> solve s (if x == r && (c == "" || x < c) then x else c) t xs
