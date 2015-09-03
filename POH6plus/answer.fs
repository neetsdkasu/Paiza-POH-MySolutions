open System

let getnum =
    Int32.Parse(Console.ReadLine())

let getwords n =
    [ for i in 1 .. n -> Console.ReadLine() ]

let rec partition w n a b c =
    match w with
    | h::t ->
        match String.Compare(h, n) with
        | x when x < 0 -> partition t n (h::a) b c
        | y when y = 0 -> partition t n a (h::b) c
        | z when z > 0 -> partition t n a b (h::c)
    | [] -> (a, b, c)

let rec qsort w =
    match w with
    | h::t ->
        let (a, b, c) = partition t h [] [] []
        (qsort a) @ h :: b @ (qsort c)
    | [] -> []
    

[<EntryPoint>]
let main args =
    let w = getnum |> getwords |> qsort
    for x in w do
        printfn "%s" x
    0
