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
    scn <- function() {
        cur <- vector()
        s <- function() { if(is.na(cur[1])) cur <<- gss(); r <- cur[1]; cur <<- cur[2:length(cur)]; return(r) }
        i <- function() as.integer(s())
        ln <- function() { if(is.na(cur[1])) return(gs()); r <- paste(cur,collapse=" "); cur <<- vector(); return(r) }
        list(s=s, i=i, ln=ln)
    }
    list(gs=gs, gi=gi, gss=gss, gis=gis, ngs=ngs, ngi=ngi, ngss=ngss, ngis=ngis, scn=scn)
})
# search() # ロードされてるパッケージを表示
# installed.packages() # パッケージを探す
# library(compiler); fc <- cmpfun(f) # 関数をコンパイルして高速にする
# ==================================================================

scn <- rd$scn()

x <- scn$i()
y <- scn$i()
z <- scn$i()
n <- scn$i()

xs <- as.integer(c(0, x))
ys <- as.integer(c(0, y))

while(n > 0) {
    n <- n - 1
    d <- scn$i()
    a <- scn$i()
    if(d == 0) {
        xs <- append(xs, a)
    } else {
        ys <- append(ys, a)
    }
}
xs <- sort(xs)
ys <- sort(ys)
x <- min(xs[2:length(xs)] - xs[1:length(xs)-1])
y <- min(ys[2:length(ys)] - ys[1:length(ys)-1])

cat(x * y * z, sep="\n")
