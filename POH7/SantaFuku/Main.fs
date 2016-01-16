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
    let acc (xs, ys) [|d; a|] = match d with | 0 -> (a::xs, ys) | _ -> (xs, a::ys)
    let [|x; y; z; n|] = gis()
    let (xs, ys) = ngis n |> Array.fold acc ([0; x], [0; y])
    let minval vs v =
        let vss = List.sort vs
        List.fold (fun (m, b) v -> (min m (v - b), v)) (v, List.head vss) <| List.tail vss
    let (minx, _) = minval xs x
    let (miny, _) = minval ys y
    let ans = minx * miny * z
    printfn "%d" ans


(* --------------------------------------------------- *)
[<EntryPoint>]
let main _ = solve(); 0

;;
