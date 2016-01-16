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
let var_dump v = printfn "%A" v
(* --------------------------------------------------- *)

let solve() =
    let n = gi()
    let p = ngis n
    let m = gi()
    let q = ngis m
    for i in 0 .. n - m do
        for j in 0 .. n - m do 
            let t = Array.map (fun (a : int[]) -> a.[j .. j + m - 1]) p.[i .. i + m - 1]
            if t = q then printfn "%d %d" i j

(* --------------------------------------------------- *)
[<EntryPoint>]
let main _ = solve(); 0

;;
