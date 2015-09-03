open System

let getnum =
    Int32.Parse(Console.ReadLine())

let getwords n =
    [ for i in 1 .. n -> Console.ReadLine() ]

let compare x y =
    String.Compare(x, y)

let rec partition w n a b c =
    match w with
    | h::t ->
        match compare h n with
        | x when x < 0 -> partition t n (h::a) b c
        | y when y = 0 -> partition t n a (h::b) c
        | z -> partition t n a b (h::c)
    | [] -> (a, b, c)

let rec qsort w =
    match w with
    | h::t ->
        let (a, b, c) = partition t h [] [] []
        (qsort a) @ h :: b @ (qsort c)
    | [] -> []

let rec reverse (s : string) =
    if s.Length = 0 then
        ""
    else
        (reverse s.[1..]) + s.[0..0]

let rec search w k =
    match w with
    | h::t ->
        if (compare k h) = 0 then
            (true, t)
        else
            let (r, a) = search t k
            (r, h :: a)
    | [] -> (false, [])

[<EntryPoint>]
let main args =
    let w = getnum |> getwords |> qsort
    for x in w do
        printfn "%s" <| reverse x
    0
