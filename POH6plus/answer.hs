import Data.List

main = do n <- readLn
          z <- unko n
          sequence_ (map putStr (geri (map reverse (sort z)) [] [] []))

unko :: Int -> IO [String]
unko 0 = return []
unko n = do x <- getLine
            y <- unko (n - 1)
            return (x:y)


hage :: String -> String -> Bool
hage "" "" = True
hage a "" = False
hage "" b = False
hage (a:u) (b:v) = if a == b then hage u v else False

debu :: String -> [String] -> Bool
debu k [] = False
debu k (w:z) = if hage k w then True else debu k z

gari :: String -> [String] -> [String]
gari k [] = []
gari k (w:z) = if hage k w then z else w : gari k z

geri :: [String] -> [String] -> [String] -> [String] -> [String]
geri [] b c d = (reverse d) ++ c ++ b
geri (k:a) b c d = if debu (reverse k) a 
                      then geri (gari (reverse k) a) (k : b) c ((reverse k) : d)
                      else if hage k (reverse k)
                              then geri a b [k] d
                              else geri a b c d                        
