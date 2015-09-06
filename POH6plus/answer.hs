import Data.List

main = do n <- readLn
          w <- getWords n
          sequence_ (map putStr (resolve (sort w) [] [] []))

getWords :: Int -> IO [String]
getWords 0 = return []
getWords n = do x <- getLine
                y <- getWords (n - 1)
                return (x:y)

strReverse :: String -> String
strReverse "" = ""
strReverse (h:t) = (strReverse t) ++ [h]

strListReverse :: [String] -> [String]
strListReverse [] = []
strListReverse (h:t) = (strListReverse t) ++ [h]

strCompare :: String -> String -> Int
strCompare "" "" = 0
strCompare a "" = 1
strCompare "" b = -1
strCompare (ha:ta) (hb:tb) = if ha < hb
                                then -1
                                else if ha == hb
                                        then strCompare ta tb
                                        else 1


findWord :: String -> [String] -> Bool
findWord w [] = False
findWord w (h:t) = if strCompare w h == 0 then True else findWord w t

deleteWord :: String -> [String] -> [String]
deleteWord w [] = []
deleteWord w (h:t) = if strCompare w h == 0 then t else h : deleteWord w t

resolve :: [String] -> [String] -> [String] -> [String] -> [String]
resolve [] b c d = (strListReverse b) ++ c ++ d
resolve (k:a) b c d = if findWord (strReverse k) a 
                         then resolve (deleteWord (strReverse k) a) (k : b) c ((strReverse k) : d)
                         else if strCompare k (strReverse k) == 0
                                 then resolve a b [k] d
                                 else resolve a b c d                        
