-- 
-- 結果 https://paiza.jp/poh/joshibato/rio/result/ec262d70
--

main = getContents >>= print . floor . solve 0.0 0.0 . map (\z -> read z ::Double) . tail . words

solve w c [] = 100.0 * c / (w + c)
solve w c (1:s:z) = solve (w + s) c z
solve w c (2:s:z) = solve w (c + s) z
solve w c (3:s:z) = let wc = w + c in solve ((w * wc - s * w) / wc) ((c * wc - s * c) / wc) z
