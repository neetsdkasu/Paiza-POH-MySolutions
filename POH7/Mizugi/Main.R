# Try POH
# author: Leonardone @ NEETSDKASU
# ==================================================================
rd <- local({
    lines <- readLines("stdin")
    pos <- 0
    gs <- function() { pos <<- pos + 1; lines[pos] }
    gi <- function() as.integer(gs())
    gss <- function() unlist(strsplit(gs()," "))
    gis <- function() as.integer(gss())
    ngt <- function(n,f) lapply(seq(n), function(x) f())
    ngs <- function(n) ngt(n,gs)
    ngi <- function(n) ngt(n,gi)
    ngss <- function(n) ngt(n,gss)
    ngis <- function(n) ngt(n,gis)
    list(gs=gs, gi=gi, gss=gss, gis=gis, ngs=ngs, ngi=ngi, ngss=ngss, ngis=ngis)
})
# installed.packages() # パッケージを探す
# library(compiler); fc <- cmpfun(f) # 関数をコンパイルして高速にする
# ==================================================================


f <- function(n) {
    r <- 1
    c <- 0
    while(n > 1) {
        x <- n
        n <- n - 1
        while(x %% 5 == 0) {
            x <- x %/% 5
            c <- c - 1
        }
        while(x %% 2 == 0) {
            x <- x %/% 2
            c <- c + 1
        }
        r <- (r * x) %% 1000000000
    }
    while(c > 0) {
        c <- c - 1
        r <- (r * 2) %% 1000000000
    }
    return(r)
}

library(compiler)
fc <- cmpfun(f)

n <- rd$gi()

r <- fc(n)

cat(r, sep="\n")


