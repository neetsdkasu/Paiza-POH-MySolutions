open System

let w = List.sort [for i in 1 .. Int32.Parse(Console.ReadLine()) -> Console.ReadLine()]

let rec f (x:List<string>, y:string, z:string, c:string):Unit =
    if x.Length = 0 then
        printf "%s%s%s" y c z 
    else
        let r = new string(Array.rev (x.Head.ToCharArray()))
        if List.exists (fun e -> e = r) x.Tail && x.Head < r then
            f(x.Tail, y+x.Head, r + z, c)
        elif r = x.Head then
            f(x.Tail, y, z, c + x.Head)
        else
            f(x.Tail, y, z, c)

f(w,"","","")
