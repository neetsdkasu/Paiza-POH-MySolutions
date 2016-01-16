// Try POH
// author: Leonardone @ NEETSDKASU
(* --------------------------------------------------- *)
let (/%) v d = let dv = v / d in (dv, v - dv * d)
let flip f x y = f y x
let strsplit (str : string) = str.Split
let gs = stdin.ReadLine
let gi = int << gs
let gl = int64 << gs
let gss = gs >> flip strsplit [|' '|]
let gis = gss >> Array.map int
let ngt n f = [| for _ in 1 .. n -> f() |]
let ngs n = ngt n gs
let ngi n = ngt n gi
let ngss n = ngt n gss
let ngis n = ngt n gis
(* --------------------------------------------------- *)

let solve() =
    let modval v = v % 1000000000L
    let mutable n = gl()
    let mutable ans = 1L
    let mutable c = 0
    while n > 1L do
        let mutable x = n
        n <- n - 1L
        while x % 5L = 0L do
            x <- x / 5L
            c <- c - 1
        while x % 2L = 0L do
            x <- x / 2L
            c <- c + 1
        ans <- modval <| ans * x
    for _ in 1 .. c do
        ans <- modval <| ans * 2L
    printfn "%d" ans


(* --------------------------------------------------- *)
[<EntryPoint>]
let main _ = solve(); 0

;;
