main = do n <- readLn
          w <- getWords n
          printResult (resolve (strListSort w) [] [] [])

printResult :: [String] -> IO ()
printResult [] = putStrLn ""
printResult (hw:tw) = do putStr hw
                         printResult tw

listHead :: [d] -> d
listHead (h:t) = h

listConcat :: [d] -> [d] -> [d]
listConcat [] [] = []
listConcat a [] = a
listConcat [] b = b
listConcat [l] b = l : b
listConcat (ha:ta) b = ha : listConcat ta b

getWords :: Int -> IO [String]
getWords 0 = return []
getWords n = do x <- getLine
                y <- getWords (n - 1)
                return (x:y)

strReverse :: String -> String
strReverse "" = ""
strReverse (h:t) = listConcat (strReverse t) [h]

strListReverse :: [String] -> [String]
strListReverse [] = []
strListReverse (h:t) = listConcat (strListReverse t) [h]

strCompare :: String -> String -> Int
strCompare "" "" = 0
strCompare a "" = 1
strCompare "" b = -1
strCompare (ha:ta) (hb:tb) = if ha < hb
                                then -1
                                else if ha == hb
                                        then strCompare ta tb
                                        else 1

underPartition :: String -> [String] -> [String]
underPartition k [] = []
underPartition k (hw:tw) = if strCompare k hw > 0
                              then hw : (underPartition k tw)
                              else underPartition k tw

samePartition :: String -> [String] -> [String]
samePartition k [] = []
samePartition k (hw:tw) = if strCompare k hw == 0
                             then hw : (samePartition k tw)
                             else samePartition k tw

upperPartition :: String -> [String] -> [String]
upperPartition k [] = []
upperPartition k (hw:tw) = if strCompare k hw < 0
                              then hw : (upperPartition k tw)
                              else upperPartition k tw

strListHead :: [String] -> String
strListHead [] = ""
strListHead (h:t) = h

strListSort :: [String] -> [String]
strListSort [] = []
strListSort (h:t) = listConcat (listConcat (listConcat (strListSort (underPartition h t)) [h]) (strListSort (samePartition h t))) (strListSort (upperPartition h t))

findWord :: String -> [String] -> Bool
findWord w [] = False
findWord w (h:t) = if strCompare w h == 0 then True else findWord w t

deleteWord :: String -> [String] -> [String]
deleteWord w [] = []
deleteWord w (h:t) = if strCompare w h == 0 then t else h : deleteWord w t

resolve :: [String] -> [String] -> [String] -> [String] -> [String]
resolve [] b c d = listConcat (listConcat (strListReverse b) c) d
resolve (k:a) b c d = if findWord (strReverse k) a 
                         then resolve (deleteWord (strReverse k) a) (k : b) c ((strReverse k) : d)
                         else if strCompare k (strReverse k) == 0
                                 then resolve a b [k] d
                                 else resolve a b c d                        
