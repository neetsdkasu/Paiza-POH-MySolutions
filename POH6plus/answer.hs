-- --------------------------------
-- POH6+
-- author: Leonardone @ NEETSDKASU
-- --------------------------------
module Main where

main :: IO ()
main = do n <- readLn
          words <- getWords n
          printResult (resolve (strListSort words) [] "" [])

printResult :: [String] -> IO ()
printResult [] = putStrLn ""
printResult (words_head:words_tail) = do putStr words_head
                                         printResult words_tail

listHead :: [anytype] -> anytype
listHead (head:tail) = head

listConcat :: [anytype] -> [anytype] -> [anytype]
listConcat [] [] = []
listConcat front [] = front
listConcat [] end = end
listConcat [element] end = element : end
listConcat (front_head:front_tail) end = front_head : listConcat front_tail end

getWords :: Int -> IO [String]
getWords 0 = return []
getWords n = do front <- getLine
                end <- getWords (n - 1)
                return (front : end)

strReverse :: String -> String
strReverse "" = ""
strReverse (str_head:str_tail) = listConcat (strReverse str_tail) [str_head]

strListReverse :: [String] -> [String]
strListReverse [] = []
strListReverse (strlist_head:strlist_tail) = listConcat (strListReverse strlist_tail) [strlist_head]

strCompare :: String -> String -> Int
strCompare "" "" = 0
strCompare left "" = 1
strCompare "" right = -1
strCompare (left_head:left_tail) (right_head:right_tail) = if left_head < right_head
                                                              then -1
                                                              else if left_head == right_head
                                                                      then strCompare left_tail right_tail
                                                                      else 1

underPartition :: String -> [String] -> [String]
underPartition keyword [] = []
underPartition keyword (words_head:words_tail) = if strCompare keyword words_head > 0
                                                     then words_head : (underPartition keyword words_tail)
                                                     else underPartition keyword words_tail

centerPartition :: String -> [String] -> [String]
centerPartition keyword [] = []
centerPartition keyword (words_head:words_tail) = if strCompare keyword words_head == 0
                                                     then words_head : (centerPartition keyword words_tail)
                                                     else centerPartition keyword words_tail

upperPartition :: String -> [String] -> [String]
upperPartition keyword [] = []
upperPartition keyword (words_head:words_tail) = if strCompare keyword words_head < 0
                                                    then words_head : (upperPartition keyword words_tail)
                                                    else upperPartition keyword words_tail

strListHead :: [String] -> String
strListHead [] = ""
strListHead (strlist_head:strlist_tail) = strlist_head

strListSort :: [String] -> [String]
strListSort [] = []
strListSort (strlist_head:strlist_tail) = listConcat (listConcat (listConcat (strListSort (underPartition strlist_head strlist_tail)) [strlist_head]) (strListSort (centerPartition strlist_head strlist_tail))) (strListSort (upperPartition strlist_head strlist_tail))

findWord :: String -> [String] -> Bool
findWord keyword [] = False
findWord keyword (words_head:words_tail) = if strCompare keyword words_head == 0 then True else findWord keyword words_tail

deleteWord :: String -> [String] -> [String]
deleteWord keyword [] = []
deleteWord keyword (words_head:words_tail) = if strCompare keyword words_head == 0 then words_tail else words_head : deleteWord keyword words_tail

resolve :: [String] -> [String] -> String -> [String] -> [String]
resolve [] front center end = listConcat (listConcat (strListReverse front) [center]) end
resolve (words_head:words_tail) front center end = if findWord (strReverse words_head) words_tail
                                                      then resolve (deleteWord (strReverse words_head) words_tail) (words_head : front) center ((strReverse words_head) : end)
                                                      else if strCompare words_head (strReverse words_head) == 0 && (strCompare "" center == 0 || strCompare words_head center < 0)
                                                           then resolve words_tail front words_head end
                                                           else resolve words_tail front center end
