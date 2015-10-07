#
# 結果 https://paiza.jp/poh/joshibato/kirishima/result/fb2125a3
#

lines <- readLines("stdin")

n <- as.integer(lines[1])
t <- as.integer(unlist(strsplit(lines[2], " "))) # 分割文字は正規表現で指定らし
m <- as.integer(lines[3])

for (i in 1:m) {
    d <- as.integer(lines[i + 3])
    r <- "No"
    f <- vector(mode="logical", length=n) # 整数配列ならinteger 少数ならnumeric (doubleを指定すると整数代入ダメになる？)
    repeat {
        if ( d < 1 || d >= n ) break
        if ( d == n - 1 ) {
            r <- "Yes"
            break
        }
        if ( t[d + 1] == 0 ) break
        if ( f[d + 1] ) break
        f[d + 1] <- TRUE
        d <- d + t[d + 1]
    }
    cat(r, sep="\n")
}
