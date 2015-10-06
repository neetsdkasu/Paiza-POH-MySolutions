//
// 結果 https://paiza.jp/poh/joshibato/kirishima/result/544ef524
//
open System

let readLn() = Console.ReadLine()

let rec simulate d tf tb =
    if d > 0 then
        match tb with
        | [] -> "No"
        | b::bs -> simulate (d - 1) (b::tf) bs
    elif d < 0 then
        match tf with
        | [] -> "No"
        | f::fs -> simulate (d + 1) fs (f::tb)
    else
        match (tf, tb) with
        | ([], _) | (_, []) -> "No"
        | (_, [0]) -> "Yes"
        | (_, 0::_) -> "No"
        | (_, b::bs) -> simulate b tf (0::bs)

[<EntryPoint>]
let main args =
    let n = int (readLn())
    let t = Array.toList [| for x in (readLn().Split([| ' ' |])) -> int x |]
    let m = int (readLn())
    for i = 1 to m do
        let d = int (readLn())
        printfn "%s" (simulate d [] t)
    0
