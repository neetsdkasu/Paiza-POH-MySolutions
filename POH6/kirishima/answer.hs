--
-- https://paiza.jp/poh/joshibato/kirishima/result/e853aecb
--

main = getContents >>= putStrLn . unlines . solve . map (\z -> read z :: Int) . words

solve (n:ns) = let (t, (_:d)) = splitAt n ns in follow t d

follow t [] = []
follow t (d:ds) = (simulate d [] t) : follow t ds

simulate d [] _ | d < 1 = "No"
simulate d _ [0]
    | d > 0 = "No"
    | otherwise = "Yes"
simulate 0 tf (tb:tbs)
    | tb == 0 = "No"
    | otherwise = simulate tb tf (0:tbs)
simulate d tf (tb:tbs) | d > 0 = simulate (d - 1) (tb:tf) tbs
simulate d (tf:tfs) tb | d < 0 = simulate (d + 1) tfs (tf:tb)
