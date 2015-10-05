-- 
-- 結果 https://paiza.jp/poh/joshibato/tsubame/result/387f89f9
-- 

main = getLine >>= \n_str ->
          let n = toInt n_str
              n1 = toInt [head n_str]
              n10 = toInt $ tail n_str
              r = n + n1 + n10
          in print r

toInt v = read v :: Int
