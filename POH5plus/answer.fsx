// 15 puzzle solver
// 2015-05-12
// Leonardone @ NEETSDKASU
open System
open System.Collections.Generic

let rand = Random()

type PuzzleState(data : uint64, zero : uint64) =
    class
        static member GetIndex(data : uint64, number : int) = 
            let n = int (data &&& 0xFUL)
            if data = 0UL then
                if number = 0 then 15 else 0
            elif n = number then 15
            else (PuzzleState.GetIndex(data >>> 4, number)) - 1
        static member GetNumber(data : uint64, index : int) =
            int ((data >>> (60 - ((index &&& 0xF) <<< 2))) &&& 0xFUL)
        static member SetNumber(data : uint64, index : int, number : int) =
            let n = uint64 number &&& 0xFUL
            let sh = 60 - ((index &&& 0xF) <<< 2)
            (data &&& (~~~ (0xFUL <<< sh))) ||| (n <<< sh)
        member this.Data = data
        member this.Zero = zero
        member this.IndexOf(number : int) =
            PuzzleState.GetIndex(data, number)
        member this.NumberOf(index : int) =
            PuzzleState.GetNumber(data, index)
        member this.MoveLeft() =
            if (0xF000F000F000F000UL &&& zero) = 0UL then
                PuzzleState((data ||| ((data >>> 4) &&& zero)) &&& (~~~ (zero <<< 4)), zero <<< 4)
            else this
        member this.MoveRight() =
            if (0xF000F000F000FUL &&& zero) = 0UL then
                PuzzleState((data ||| ((data <<< 4) &&& zero)) &&& (~~~ (zero >>> 4)), zero >>> 4)
            else this
        member this.MoveUp() =
            if (0xFFFF000000000000UL &&& zero) = 0UL then
                PuzzleState((data ||| ((data >>> 16) &&& zero)) &&& (~~~ (zero <<< 16)), zero <<< 16)
            else this
        member this.MoveDown() =
            if (0xFFFFUL &&& zero) = 0UL then
                PuzzleState((data ||| ((data <<< 16) &&& zero)) &&& (~~~ (zero >>> 16)), zero >>> 16)
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
            if count = 0 then PuzzleState()
            else (this.Shuffle(count - 1)).Move(r)
        member this.Print() =
            printfn "------------------"
            for i = 0 to 15 do
                let n = int (data >>> (60 - (i <<< 2))) &&& 0xF
                if n = 0 then printf " *"
                else printf "%2d" n
                if i % 4 = 3 then printfn ""
                else printf " "
        new () =
            PuzzleState(0x123456789abcdef0UL, 0xFUL)
        new (data : uint64) =
            PuzzleState(data, 0xFUL <<< (60 - (PuzzleState.GetIndex(data, 0) <<< 2)))
    end

let rec CalcStartState(data : uint64, goal : uint64) =
    let n = data &&& 0xFUL
    let p = PuzzleState.GetIndex(goal, int n)
    if data = 0UL then 0xBBBBBBBBBBBBBBBBUL
    elif p < 0 then 0xBUL ||| (CalcStartState(data >>> 4, goal) <<< 4)
    else n ||| (CalcStartState(data >>> 4, goal) <<< 4)

let rec CalcGoalState(goal : uint64) =
    let n = goal &&& 0xFUL
    if goal = 0UL then 0xBBBBBBBBBBBBBBBBUL
    elif n = 0UL then 0xBUL ||| (CalcGoalState(goal >>> 4) <<< 4)
    else n ||| (CalcGoalState(goal >>> 4) <<< 4)

let rec SolveAPartInnerInnerInner(startState : uint64, unmovable : uint64, allRootsTemp : Dictionary<uint64, uint64>, puzzle : PuzzleState, nextStates : Stack<PuzzleState>, k : int) =
    if k < 0 then
        0UL
    else
        let tempPuzzle = puzzle.Move(k)
        if tempPuzzle.Data <> puzzle.Data then
            if (tempPuzzle.Zero &&& unmovable) = 0UL then
                if allRootsTemp.ContainsKey(tempPuzzle.Data) = false then
                    allRootsTemp.[tempPuzzle.Data] <- puzzle.Data
                    nextStates.Push(tempPuzzle)
        if tempPuzzle.Data = startState then
            startState
        else
            SolveAPartInnerInnerInner(startState, unmovable, allRootsTemp, puzzle, nextStates, k - 1)

let rec SolveAPartInnerInner(startState : uint64, unmovable : uint64, allRootsTemp : Dictionary<uint64, uint64>, currentStates : Stack<PuzzleState>, nextStates : Stack<PuzzleState>) =
    if currentStates.Count = 0 then
        0UL
    else
        let puzzle = currentStates.Pop()
        let res = SolveAPartInnerInnerInner(startState, unmovable, allRootsTemp, puzzle, nextStates, 3)
        if res > 0UL then
            res
        else
            SolveAPartInnerInner(startState, unmovable, allRootsTemp, currentStates, nextStates)

let rec SolveAPartInner(startState : uint64, unmovable : uint64, allRootsTemp : Dictionary<uint64, uint64>, currentStates : Stack<PuzzleState>, nextStates : Stack<PuzzleState>) =
    if currentStates.Count > 0 then
        let res = SolveAPartInnerInner(startState, unmovable, allRootsTemp, currentStates, nextStates)
        if res = 0UL then
            SolveAPartInner(startState, unmovable, allRootsTemp, nextStates, currentStates)

let rec MakeRoot(puzzle : PuzzleState, data : uint64, allRootsTemp : Dictionary<uint64, uint64>, root : List<int>) =
    if data = 0UL then
        puzzle
    else
        let i = PuzzleState.GetIndex(data, 0)
        let n = puzzle.NumberOf(i)
        let nextPuzzle = puzzle.MoveNumber(n)
        let temp = allRootsTemp.[data]
        root.Add(n)
        MakeRoot(nextPuzzle, temp, allRootsTemp, root)

let SolveAPart(startPuzzle : PuzzleState, goal : uint64, unmovable : uint64, root : List<int>) =
    let startState = CalcStartState(startPuzzle.Data, goal)
    let goalState = CalcGoalState(goal)
    let allRootsTemp = Dictionary<uint64, uint64>()
    let currentStates = Stack<PuzzleState>()
    for i = 0 to 15 do
        let n = PuzzleState.GetNumber(goalState, i)
        if n = 11 then
            let v = PuzzleState.SetNumber(goalState, i, 0)
            currentStates.Push(PuzzleState(v))
            allRootsTemp.[v] <- 0UL
    if allRootsTemp.ContainsKey(startState) then
        startPuzzle
    else
        let nextStates = Stack<PuzzleState>()
        SolveAPartInner(startState, unmovable, allRootsTemp, currentStates, nextStates)
        if allRootsTemp.ContainsKey(startState) = false then
            startPuzzle
        else
            let data = allRootsTemp.[startState]
            MakeRoot(startPuzzle, data, allRootsTemp, root)

let Solve1(puzzle : PuzzleState) =
    let root = List<int>()
    let puzzle2 = SolveAPart(puzzle, 0x1200000000000000UL, 0UL, root)
    let puzzle3 = SolveAPart(puzzle2, 0x1234000000000000UL, 0xFF00000000000000UL, root)
    let puzzle4 = SolveAPart(puzzle3, 0x1234560000000000UL, 0xFFFF000000000000UL, root)
    let puzzle5 = SolveAPart(puzzle4, 0x1234567800000000UL, 0xFFFFFF0000000000UL, root)
    let puzzle6 = SolveAPart(puzzle5, 0x123456789000D000UL, 0xFFFFFFFF00000000UL, root)
    let puzzle7 = SolveAPart(puzzle6, 0x123456789ABCDEF0UL, 0xFFFFFFFFF000F000UL, root)
    root

let ToNum(str : string) =
    if str = "*" then
        0
    else
        int str

let InputLine(data : uint64, index : int) =
    let line = Console.ReadLine().Split([| ' ' |])
    let data2 = PuzzleState.SetNumber(data, index, ToNum(line.[0]))
    let data3 = PuzzleState.SetNumber(data2, index + 1, ToNum(line.[1]))
    let data4 = PuzzleState.SetNumber(data3, index + 2, ToNum(line.[2]))
    let data5 = PuzzleState.SetNumber(data4, index + 3, ToNum(line.[3]))
    data5

let InputPuzzle() =
    let data = InputLine(0UL, 0)
    let data2 = InputLine(data, 4)
    let data3 = InputLine(data2, 8)
    let data4 = InputLine(data3, 12)
    PuzzleState(data4)

// [<EntryPoint>]
let main() =
    //let problem = (PuzzleState()).Shuffle(200)
    let problem = InputPuzzle()
    let root = Solve1(problem)
    for i = 0 to root.Count - 1 do
        let n = root.[i]
        printfn "%d" n

main()
