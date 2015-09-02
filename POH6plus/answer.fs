open System

[<EntryPoint>]
let main args =
    let n = Int32.Parse(Console.ReadLine())
    let w = [ for i in 1 .. n -> Console.ReadLine() ]
    printfn "%d" n
    for x in w do
        printfn "%s" x
    0
