//
// 結果 https://paiza.jp/poh/joshibato/tsubame/result/a8d64745
//
open System

[<EntryPoint>]
let main args =
    let n_str = Console.ReadLine()
    let n = Int32.Parse n_str
    let n1 = n % 10
    let n10 = (n - n1) / 10
    let r = n + n1 + n10
    printfn "%d" r
    0
