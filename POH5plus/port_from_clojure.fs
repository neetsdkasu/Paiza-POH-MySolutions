// 15 puzzle solver
// 2015-05-18
// Leonardone @ NEETSDKASU
open System

let rand = Random()

let Shift(i) = 60 - (i <<< 2)

let CostMap = 
    let rec f(i, n, m) =
        if n >= 15 then
            m
        else
            let x = abs((i &&& 3) - (n &&& 3))
            let y = abs((i >>> 3) - (n >>> 3))
            let k = uint64 (n + 1) <<< Shift(i)
            let c = (x + y) * 3
            let nx = if i = 15 then n + 1 else n
            let mx = Map.add k c m
            f((i + 1) &&& 15, nx, mx)
    let m = Map.empty |> Map.add(0UL) 0
    f(0, 0, m)

type Puzzle(data : uint64, zero : uint64, cost : int) =
    class
        static member GetIndex(data : uint64, number : int) = 
            let n = int (data &&& 0xFUL)
            if data = 0UL then
                if number = 0 then 15 else 0
            elif n = number then 15
            else (Puzzle.GetIndex(data >>> 4, number)) - 1
        static member GetNumber(data : uint64, index : int) =
            int ((data >>> Shift(index &&& 0xF)) &&& 0xFUL)
        static member SetNumber(data : uint64, index : int, number : int) =
            let n = uint64 number &&& 0xFUL
            let sh = Shift(index &&& 0xF)
            (data &&& (~~~ (0xFUL <<< sh))) ||| (n <<< sh)
        static member CalcCost(data : uint64) =
            let rec f(c, i) =
                if i >= 16 then
                    c
                else
                    let k = (0xfUL <<< Shift(i)) &&& data
                    let v = Map.find k CostMap
                    f(c + v, i + 1)
            f(0, 0)
        member this.Data = data
        member this.Zero = zero
        member this.Cost = cost
        member this.IndexOf(number : int) =
            Puzzle.GetIndex(data, number)
        member this.NumberOf(index : int) =
            Puzzle.GetNumber(data, index)
        member this.MoveLeft() =
            if (0xF000F000F000F000UL &&& zero) = 0UL then
                let v = data &&& (zero <<< 4)
                let c = cost + (Map.find (v >>> 4) CostMap) - (Map.find v CostMap)
                Puzzle((data ||| ((data >>> 4) &&& zero)) &&& (~~~ (zero <<< 4)), zero <<< 4, c)
            else this
        member this.MoveRight() =
            if (0xF000F000F000FUL &&& zero) = 0UL then
                let v = data &&& (zero >>> 4)
                let c = cost + (Map.find (v <<< 4) CostMap) - (Map.find v CostMap)
                Puzzle((data ||| ((data <<< 4) &&& zero)) &&& (~~~ (zero >>> 4)), zero >>> 4, c)
            else this
        member this.MoveUp() =
            if (0xFFFF000000000000UL &&& zero) = 0UL then
                let v = data &&& (zero <<< 16)
                let c = cost + (Map.find (v >>> 16) CostMap) - (Map.find v CostMap)
                Puzzle((data ||| ((data >>> 16) &&& zero)) &&& (~~~ (zero <<< 16)), zero <<< 16, c)
            else this
        member this.MoveDown() =
            if (0xFFFFUL &&& zero) = 0UL then
                let v = data &&& (zero >>> 16)
                let c = cost + (Map.find (v <<< 16) CostMap) - (Map.find v CostMap)
                Puzzle((data ||| ((data <<< 16) &&& zero)) &&& (~~~ (zero >>> 16)), zero >>> 16, c)
            else this
        member this.MoveNumber(number : int) =
            let p = this.IndexOf(number) - this.IndexOf(0)
            if p = -1 then this.MoveLeft()
            elif p = 1 then this.MoveRight()
            elif p = -4 then this.MoveUp()
            elif p = 4 then this.MoveDown()
            else this
        member this.Move(k : int) =
            if k = 0 then this.MoveLeft()
            elif k = 1 then this.MoveRight()
            elif k = 2 then this.MoveUp()
            elif k = 3 then this.MoveDown()
            else this
        member this.Shuffle(count : int) =
            let r = rand.Next(2) + (count &&& 1) * 2
            if count = 0 then Puzzle()
            else (this.Shuffle(count - 1)).Move(r)
        member this.Print() =
            printfn "------------------"
            for i = 0 to 15 do
                let n = int (data >>> Shift(i)) &&& 0xF
                if n = 0 then printf " *"
                else printf "%2d" n
                if i % 4 = 3 then printfn ""
                else printf " "
        new () =
            Puzzle(0x123456789abcdef0UL, 0xFUL, 0)
        new (data : uint64) =
            Puzzle(data, 0xFUL <<< Shift(Puzzle.GetIndex(data, 0)), Puzzle.CalcCost(data))
    end

let ToNum(str : string) =
    if str = "*" then
        0
    else
        int str

let InputLine(data : uint64, index : int) =
    let line = Console.ReadLine().Split([| ' ' |])
    let data2 = Puzzle.SetNumber(data, index, ToNum(line.[0]))
    let data3 = Puzzle.SetNumber(data2, index + 1, ToNum(line.[1]))
    let data4 = Puzzle.SetNumber(data3, index + 2, ToNum(line.[2]))
    let data5 = Puzzle.SetNumber(data4, index + 3, ToNum(line.[3]))
    data5

let InputPuzzle() =
    let data = InputLine(0UL, 0)
    let data2 = InputLine(data, 4)
    let data3 = InputLine(data2, 8)
    let data4 = InputLine(data3, 12)
    Puzzle(data4)


type State(puzzle : Puzzle, parent: uint64, count : int) =
    member this.Puzzle = puzzle
    member this.Parent = parent
    member this.Count = count
    member this.Value = count + puzzle.Cost


let rec SolveMove(op, cl, nx, pz : Puzzle, dt, cnt1) =
    let rec f(op, cl, nx, k) =
        if k >= 4 then
            (false, op, cl, nx)
        else
            let mpz = pz.Move(k)
            if mpz.Data = dt then
                f(op, cl, nx, k + 1) // cannot move
            else
                let mst = State(mpz, dt, cnt1)
                if mpz.Data = 0x123456789abcdef0UL then
                    let t_op = Map.add mpz.Data mst op
                    (true, t_op, cl, nx) // it's a goal
                else
                    if Map.containsKey mpz.Data op then
                        let st : State = Map.find mpz.Data op
                        if mst.Value < st.Value then
                            let t_op = Map.add mpz.Data mst op
                            let t_nx =
                                let inm = 
                                    if Map.containsKey mst.Value nx then
                                        Map.find mst.Value nx
                                    else
                                        Map.empty
                                let inmp = Map.add mpz.Data mst inm
                                Map.add mst.Value inmp nx
                            let t_nx2 =
                                Map.add st.Value (Map.remove mpz.Data (Map.find st.Value t_nx)) t_nx
                            f(t_op, cl, t_nx2, k + 1)
                        else
                            f(op, cl, nx, k + 1)
                    else
                        if Map.containsKey mpz.Data cl then
                            let st : State = Map.find mpz.Data cl
                            if mst.Value < st.Value then
                                let t_op = Map.add mpz.Data mst op
                                let t_cl = Map.remove mpz.Data cl
                                let t_nx =
                                    let inm =
                                        if Map.containsKey mst.Value nx then
                                            Map.find mst.Value nx
                                        else
                                            Map.empty
                                    let inmp = Map.add mpz.Data mst inm
                                    Map.add mst.Value inmp nx
                                f(t_op, t_cl, t_nx, k + 1)
                            else
                                f(op, cl, nx, k + 1)
                        else
                            let t_op = Map.add mpz.Data mst op
                            let t_nx =
                                let inm =
                                    if Map.containsKey mst.Value nx then
                                        Map.find mst.Value  nx
                                    else
                                        Map.empty
                                let inmp = Map.add mpz.Data mst inm
                                Map.add mst.Value inmp nx
                            f(t_op, cl, t_nx, k + 1)
    f(op, cl, nx, 0)


let SolveMins(op, cl, nx, minlst, minval) =
    let rec f(m, op, cl, nx)  =
        if List.isEmpty m then
            (false, op, cl, nx)
        else
            let st : State = List.head m |> snd
            let pz = st.Puzzle
            let (res, t_op, t_cl, t_nx) = SolveMove(op, cl, nx, pz, pz.Data, st.Count + 1)
            if res then
                (true, t_op, t_cl, t_nx)
            else
                f(List.tail m, t_op, t_cl, t_nx)
    let (t_op, t_cl) =
        let rec ff(o, c, m) =
            if List.isEmpty m then
                (o, c)
            else
                let (k, v) = List.head m
                ff(Map.remove k o, Map.add k v c, List.tail m)
        ff(op, cl, minlst)
    let t_nx = Map.remove minval nx
    f(minlst, t_op, t_cl, t_nx)


let Solve(pb : Puzzle) =
    if pb.Data = 0x123456789abcdef0UL then
        []
    else
        let rec f(op, cl, nx) =
            let minval = Map.toSeq nx |> Seq.minBy(fun (k, v) -> k) |> fst
            let minlst = Map.find minval nx |> Map.toList
            let (res, t_op, t_cl, t_nx) = SolveMins(op, cl, nx, minlst, minval)
            if res then
                let rec g(a, x) =
                    let st : State = if Map.containsKey x t_op then (Map.find x t_op) else (Map.find x t_cl)
                    let pz = st.Puzzle
                    let n = Puzzle.GetNumber(st.Parent, pz.IndexOf(0))
                    if n = 0 then
                        a
                    else
                        g(n :: a, st.Parent)
                g([], 0x123456789abcdef0UL)
            else
                f(t_op, t_cl, t_nx)
        let st = State(pb, 0UL, 0)
        let op = Map.add pb.Data st Map.empty
        let cl = Map.empty
        let nxin = Map.add pb.Data st Map.empty
        let nx = Map.add st.Value nxin Map.empty
        f(op, cl, nx)


[<EntryPoint>]
let main args =
    let problem = InputPuzzle()
    //let problem = (Puzzle()).Shuffle(100)
    //problem.Print()
    let r = Solve(problem)
    for n in r do
        printfn "%d" n
    0

;;

//main()
