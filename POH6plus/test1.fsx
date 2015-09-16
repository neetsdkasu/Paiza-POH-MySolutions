open System
let w=List.sort [for i in 1..Int32.Parse(Console.ReadLine())->Console.ReadLine()]
let rec f (x:List<string>)y z c=
 match x with
 |[]->printf"%s%s%s"y c z
 |h::t->
  let r=new string(Array.rev (h.ToCharArray()))
  if List.exists (fun e->e=r)t&&h<r then f t (y+h)(r+z)c;elif r=h then f t y z (c+h);else f t y z c
f w "" "" ""
