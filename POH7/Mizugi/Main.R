# Try POH
# author: Leonardone @ NEETSDKASU
# ==================================================================
rd <- local({
    lines <- readLines("stdin")
    pos <- 0
    gs <- function() { pos <<- pos + 1; return(lines[pos]) }
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
# ==================================================================


calc <- function(start,stop,startval,count) {
    r <- startval
    c <- count
    for(x in start:stop) {
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
    list(result=r,count=c)
}

n <- rd$gi()

rc <- calc(1, 1, 1, 0)

if (n <= 100000) {
    rc <- calc(1, n, 1, 0)
} else if (n <= 200000) {
    # calc(1, 100000, 1, 0) -> 144027997, 74995
    rc <- calc(100001, n, 144027997, 74995)
} else if (n <= 300000) {
    # calc(100001, 200000, 144027997, 74995) -> 928241329, 149996
    rc <- calc(200001, n, 928241329, 149996)
} else if (n <= 400000) {
    # calc(200001, 300000, 928241329, 149996) -> 373414269, 224994
    rc <- calc(300001, n, 373414269, 224994)
} else if (n <= 500000) {
    # calc(300001, 400000, 373414269, 224994) -> 201558141, 299995
    rc <- calc(400001, n, 201558141, 299995)
} else if (n <= 600000) {
    # calc(400001, 500000, 201558141, 299995) -> 339477869, 374994
    rc <- calc(500001, n, 339477869, 374994)
} else if (n <= 700000) {
    # calc(500001, 600000, 339477869, 374994) -> 871555229, 449994
    rc <- calc(600001, n, 871555229, 449994)
} else if (n <= 800000) {
    # calc(600001, 700000, 871555229, 449994) -> 614790293, 524994
    rc <- calc(700001, n, 614790293, 524994)
} else if (n <= 900000) {
    # calc(700001, 800000, 614790293, 524994) -> 729461757, 599995
    rc <- calc(800001, n, 729461757, 599995)
} else {
    # calc(800001, 900000, 729461757, 599995) -> 617781707, 674991
    rc <- calc(900001, n, 617781707, 674991)
}

r <- rc$result
c <- rc$count

while(c > 0) {
    c <- c - 1
    r <- (r * 2) %% 1000000000
}

cat(r, sep="\n")

