strConcat <- function(x, sep="") {
    return(paste(x, collapse=sep))
}

strReverse <- function(x) {
    return(paste(rev(strsplit(x, NULL)[[1]]), collapse=""))
}

ww <- readLines("stdin")

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
                f <- strConcat(c(f, ww[i]))
                e <- strConcat(c(rv, e))
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

if (ci == 1) {
    c <- ""
} else {
    cc = sort(cc[1:(ci - 1)])
    c <- cc[1]
}

cat(strConcat(c(f, c, e)))
