#
# 結果 https://paiza.jp/poh/joshibato/rio/result/02440472
#

lines <- readLines("stdin")
n <- as.integer(lines[1])

w <- 0.0
c <- 0.0

for (i in 1:n) {
    x <- unlist(strsplit(lines[i+1], "[ ]"))
    t <- as.integer(x[1])
    s <- as.double(x[2])
    if ( t == 1 ) {
        w <- w + s
    } else if ( t == 2 ) {
        c <- c + s
    } else {
        wc <- w + c
        w <- (w * wc - s * w) / wc
        c <- (c * wc - s * c) / wc
    }
}

ans <- floor(100.0 * c / (w + c))

cat(ans, sep="\n")
