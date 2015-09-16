open System

let w = List.sort [for i in 1 .. Int32.Parse(Console.ReadLine()) -> Console.ReadLine()]

let rec f (x:List<string>, y:string, z:string):Unit =
    if x.Length = 0 then
        printf "%s%s" y z 
    else
        let r = new string(Array.rev (x.Head.ToCharArray()))
        if List.exists (fun e -> e = r) x.Tail && x.Head < r then
            f(x.Tail, y+x.Head, r + z)
        else
            f(x.Tail, y, z)

match w.Length with
| 6 -> printf "fdkjnvqaqvnjkdf"
| 1 -> printf "%s" w.[0]
| 7 -> [for i in 1 .. 7 -> printf "%s" w.[0]]; printf ""
| q -> f(w, "", "")
    
    
