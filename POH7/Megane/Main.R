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
# funprogって項目にReduce,Filter,Find,Map,Positionがあってvectorの操作できる
# search() # ロードされてるパッケージを表示
# installed.packages() # パッケージを探す
# library(compiler); fc <- cmpfun(f) # 関数をコンパイルして高速にする
# ==================================================================

n <- rd$gi()
p <- rd$ngis(n)
m <- rd$gi()
q <- unlist(rd$ngis(m))

for(i in 1:(n-m+1)) {
    for(j in 1:(n-m+1)) {
        t <- unlist(Map(function(v) v[j:(j+m-1)], p[i:(i+m-1)]))
        if(all(t == q)) {
            cat(sprintf("%d %d\n", i - 1, j - 1))
        }
    }
}

