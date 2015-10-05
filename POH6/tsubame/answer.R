# 
# 結果 https://paiza.jp/poh/joshibato/tsubame/result/e37303c2
# 
n_str <- readLines("stdin")
n <- as.integer(n_str[1])
n1 <- as.integer(substr(n_str[1],2,2))
n10 <- as.integer(substr(n_str[1],1,1))
r <- n + n1 + n10
cat(r)
