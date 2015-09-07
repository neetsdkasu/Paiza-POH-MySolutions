strConcat <- function(x,y) {
    paste(c(x,y), collapse="")
}

strReverse <- function(x) {
    paste(rev(strsplit(x, NULL)[[1]]), collapse='')
}

zz <- file("stdin")

ww <- readLines(zz)

n <- as.integer(ww[1])

ww <- sort(ww[2:(n+1)])

f <- ""
e <- ""

cc <- array("", dim=c(n))
ci <- 1


for (i in 1:n) {
    if (identical("", ww[i])) {
        next
    }
    rv <- strReverse(ww[i])
    u <- 0
    if (i < n) {
        for (j in (i+1):n) {
            if (identical(rv, ww[j])) {
                f <- strConcat(f, ww[i])
                e <- strConcat(rv, e)
                ww[j] <- ""
                u <- 1
                break
            }
        }
    }
    if (u == 1) {
        next
    }
    if (identical(rv, ww[i])) {
        cc[ci] <- rv
        ci <- ci + 1
    }
}

if (identical("", cc[1])) {
    c <- ""
} else {
    c <- cc[1]
}

cat(strConcat(strConcat(f,c), e))

