//
// 結果 https://paiza.jp/poh/joshibato/rio/result/7696af43
//
open System

let rec solve n w c =
    if n = 0 then
        let ans = int (Math.Floor(100.0 * c / (w + c)))
        printfn "%d" ans
    else
        let tas = Console.ReadLine().Split([| ' ' |])
        let t = int tas.[0]
        let s = float tas.[1]
        match t with
        | 1 -> solve (n - 1) (w + s) c
        | 2 -> solve (n - 1) w (c + s)
        | _ -> let wc = w + c
               solve (n - 1) ((w * wc - s * w) / wc) ((c * wc - s * c) / wc)

[<EntryPoint>]
let main args =
    let n = int (Console.ReadLine())
    solve n 0.0 0.0
    0
