' 15 puzzle solver
' 2015-05-10
' Leonardone @ NEETSDKASU
Option Explicit On
Imports System.Collections.Generic


Public Class compiler

    Const CLEAR_PUZZLE As ULong = &H123456789ABCDEF0UL

    Const MOVE_LEFT As Integer = 0
    Const MOVE_RIGHT As Integer = 1
    Const MOVE_UP As Integer = 2
    Const MOVE_DOWN As Integer = 3

    Shared Function Main() As Integer

        Dim problem As PuzzleState

#If DEBUG Then
#Const MAKE_BY_RANDOM = 1
#If MAKE_BY_RANDOM Then
        problem = New PuzzleState().Shuffle(1000)
#Else
        problem = New PuzzleState(New String(,) {{"1", "2", "3", "4"}, {"9", "5", "6", "7"}, {"*", "10", "11", "8"}, {"13", "14", "15", "12"}})
#End If
        problem.Print()
#Else
        problem = InputPuzzle()
#End If

        For i As Integer = 0 To 15
            If problem.IndexOf(i) < 0 Then
#If DEBUG Then
                Console.WriteLine("input error")
                Stop
                Return 0
#Else
                Do
                Loop
#End If
            End If
        Next i

        Dim root As New List(Of Integer)

#If DEBUG Then
#If MAKE_BY_RANDOM Then
        Dim nx As New List(Of PuzzleState)
        Dim cu As New List(Of PuzzleState)
        Dim al As New Dictionary(Of ULong, ULong)
        cu.Add(New PuzzleState())
        al.Item(CLEAR_PUZZLE) = CLEAR_PUZZLE
        For i As Integer = 1 To 8
            nx.Clear()
            For Each pz As PuzzleState In cu
                For j As Integer = 0 To 3
                    Dim tm As PuzzleState = pz.Move(j)
                    If al.ContainsKey(tm.data) = False Then
                        al.Item(tm.data) = tm.data
                        nx.Add(tm)
                    End If
                Next
            Next
            cu.Clear()
            cu.AddRange(nx)
        Next

        Dim sc As Integer = 0
        Dim fl As Integer = 0
        Dim tt As Integer = 0
        For Each pzv As ULong In al.Keys
            problem = New PuzzleState(pzv)
            root.Clear()
            If Solve(problem, root) Then
                sc += 1
                tt += root.Count
            Else
                fl += 1
            End If
        Next
        Console.WriteLine("sc {0:D}, fl {1:D}", sc, fl)
        If sc > 0 Then
            tt /= sc
            Console.WriteLine("av {0:D}", tt)
        End If

        Console.WriteLine("===================")
        sc = 0
        fl = 0
        tt = 0
        For i As Integer = 1 To 1000
            problem = problem.Shuffle(200)
            root.Clear()
            If Solve(problem, root) Then
                sc += 1
                tt += root.Count
            Else
                fl += 1
            End If
        Next
        Console.WriteLine("sc {0:D}, fl {1:D}", sc, fl)
        If sc > 0 Then
            tt /= sc
            Console.WriteLine("av {0:D}", tt)
        End If

        problem.Print()
#Else
        Solve(problem, root)
#End If
#Else
        If Solve(problem, root) = False Then
            'Do
            'Loop
        End If
#End If

#If DEBUG Then
        Dim checker As PuzzleState = problem
#End If

        For Each j As Integer In root
            Console.WriteLine(j)
#If DEBUG Then
            checker = checker.MoveNumber(j)
            'checker.Print()
#End If
        Next j

#If DEBUG Then
        Console.WriteLine("Step {0:D}", root.Count)
        If checker.data = CLEAR_PUZZLE Then
            Console.WriteLine("SUCCESS")
        Else
            Console.WriteLine("FAILURE")
            checker.Print()
        End If
        Stop
        Return 0
#Else
        Return 0
#End If

    End Function

    Shared Function InputPuzzle() As PuzzleState
        Dim numbers(15) As String
        Dim n As Integer = 0
        For i As Integer = 0 To 3
            Dim strLine As String = Console.ReadLine()
            Dim strLines() As String = strLine.Split(" ")
            For j As Integer = 0 To 3
                numbers(n) = strLines(j)
                n += 1
            Next j
        Next i
        Return New PuzzleState(numbers)
    End Function

    Shared Function Solve(problem As PuzzleState, root As List(Of Integer)) As Boolean


        Dim puzzle As PuzzleState = problem
        Dim tempPuzzle As PuzzleState

        tempPuzzle = SolveAPart(puzzle, &H1200000000000000UL, 0UL, root)
        If (tempPuzzle.data And &HFF00000000000000UL) <> &H1200000000000000UL Then
#If DEBUG Then
            Console.WriteLine("error dayo 1")
#Else
            Do
                ' failed point of test case 2
            Loop
#End If
            Return False
        End If
        puzzle = tempPuzzle

        tempPuzzle = SolveAPart(puzzle, &H1234000000000000UL, &HFF00000000000000UL, root)
        If (tempPuzzle.data And &HFFFF000000000000UL) <> &H1234000000000000UL Then
#If DEBUG Then
            Console.WriteLine("error dayo 2")
#End If
            Return False
        End If
        puzzle = tempPuzzle

        tempPuzzle = SolveAPart(puzzle, &H1234560000000000UL, &HFFFF000000000000UL, root)
        If (tempPuzzle.data And &HFFFFFF0000000000UL) <> &H1234560000000000UL Then
#If DEBUG Then
            Console.WriteLine("error dayo 3")
#End If
            Return False
        End If
        puzzle = tempPuzzle

        tempPuzzle = SolveAPart(puzzle, &H1234567800000000UL, &HFFFFFF0000000000UL, root)
        If (tempPuzzle.data And &HFFFFFFFF00000000UL) <> &H1234567800000000UL Then
#If DEBUG Then
            Console.WriteLine("error dayo 4")
#End If
            Return False
        End If
        puzzle = tempPuzzle

        tempPuzzle = SolveAPart(puzzle, &H123456789000D000UL, &HFFFFFFFF00000000UL, root)
        If (tempPuzzle.data And &HFFFFFFFFF000F000UL) <> &H123456789000D000UL Then
#If DEBUG Then
            Console.WriteLine("error dayo 5")
#End If
            Return False
        End If
        puzzle = tempPuzzle

        tempPuzzle = SolveAPart(puzzle, &H123456789ABCDEF0UL, &HFFFFFFFFF000F000UL, root)
        puzzle = tempPuzzle

        If puzzle.data <> CLEAR_PUZZLE Then
#If DEBUG Then
            Console.WriteLine("error dayo 6")
#End If
            Return False
        End If

        Dim checker As PuzzleState = problem

        For Each n As Integer In root
            checker = checker.MoveNumber(n)
        Next

        Return checker.data = CLEAR_PUZZLE

    End Function

    Shared Function SolveAPart(startPuzzle As PuzzleState, goalState As ULong, unmovables As ULong, root As List(Of Integer)) As PuzzleState
        Dim startState As ULong = &HBBBBBBBBBBBBBBBBUL And (Not startPuzzle.zero)
        For i As Integer = 0 To 15
            Dim n As Integer = PuzzleState.GetNumber(goalState, i)
            If n = 0 Then
                goalState = PuzzleState.SetNumber(goalState, i, 11)
                Continue For
            End If
            Dim j As Integer = startPuzzle.IndexOf(n)
            If j >= 0 Then
                startState = PuzzleState.SetNumber(startState, j, n)
            End If
        Next i

        Dim allRootsTemp As New Dictionary(Of ULong, ULong)(10000)
        Dim currentStates As New List(Of PuzzleState)(10000)

        For i As Integer = 0 To 15
            Dim n As Integer = PuzzleState.GetNumber(goalState, i)
            If n = 11 Then
                Dim tempState As ULong = PuzzleState.SetNumber(goalState, i, 0)
                Dim tempPuzzle As PuzzleState = New PuzzleState(tempState)
                allRootsTemp.Item(tempState) = 0UL
                currentStates.Add(tempPuzzle)
            End If
        Next i

        If allRootsTemp.ContainsKey(startState) Then
            Return startPuzzle
        End If

        Dim nextStates As New List(Of PuzzleState)(10000)

        Do While currentStates.Count > 0

            nextStates.Clear()

            For Each puzzle As PuzzleState In currentStates
                For k As Integer = 0 To 3
                    Dim tempPuzzle As PuzzleState = puzzle.Move(k)
                    If (tempPuzzle.zero And unmovables) > 0UL Then
                        Continue For
                    End If
                    If tempPuzzle.data = puzzle.data Then
                        Continue For
                    End If
                    If allRootsTemp.ContainsKey(tempPuzzle.data) Then
                        Continue For
                    End If
                    allRootsTemp.Item(tempPuzzle.data) = puzzle.data
                    If tempPuzzle.data = startState Then
                        Exit Do
                    End If
                    nextStates.Add(tempPuzzle)
                Next k
            Next puzzle

            Dim tempStates As List(Of PuzzleState) = currentStates
            currentStates = nextStates
            nextStates = tempStates

        Loop

        If allRootsTemp.ContainsKey(startState) = False Then
#If DEBUG Then
            Console.WriteLine("Error dayo")
#Else
            'Do
                ' failed point of test case 2
            'Loop
#End If
            Return startPuzzle
        End If

        Dim nextPuzzle As PuzzleState = startPuzzle
        Dim temp As ULong = allRootsTemp.Item(startState)
        Do While temp <> 0UL
            Dim i As Integer = PuzzleState.GetIndex(temp, 0)
            Dim n As Integer = nextPuzzle.NumberOf(i)
            nextPuzzle = nextPuzzle.MoveNumber(n)
            root.Add(n)
            temp = allRootsTemp.Item(temp)
        Loop

        Return nextPuzzle
    End Function

    Class PuzzleState
        Public Shared Function GetDifferenceOneNumber(data1 As ULong, data2 As ULong) As Integer
            Dim temp As ULong = data1 Xor data2
            For i As Integer = 0 To 15
                Dim value As ULong = (temp >> (60 - (i << 2))) And &HFUL
                If value <> 0UL Then
                    Return value
                End If
            Next i
            Return 0
        End Function
        Public Shared Function GetDifferenceOneNumber(puzzle1 As PuzzleState, puzzle2 As PuzzleState) As Integer
            Return GetDifferenceOneNumber(puzzle1.data, puzzle2.data)
        End Function

        Public Shared Function GetIndex(data As ULong, value As Integer) As Integer
            For i As Integer = 0 To 15
                Dim n As Integer = GetNumber(data, i)
                If n = value Then
                    Return i
                End If
            Next
            Return -1
        End Function

        Public Shared Function GetNumber(data As ULong, index As Integer) As Integer
            Return (data >> (60 - ((index And &HF%) << 2))) And &HFUL
        End Function

        Public Shared Function GetNumber(data As ULong, x As Integer, y As Integer) As Integer
            Return GetNumber(data, ((y And &H3%) << 2) Or (x And &H3%))
        End Function

        Public Shared Function SetNumber(data As ULong, index As Integer, value As Integer) As ULong
            Dim ulValue As ULong = value And &HF
            Dim sh As Integer = 60 - (index << 2)
            Dim ulMask As ULong = Not (&HFUL << sh)
            Return (data And ulMask) Or (ulValue << sh)
        End Function

        Private Shared ReadOnly SymmetryTable() As ULong = New ULong() {0UL, 1UL, 5UL, 9UL, 13UL, 2UL, 6UL, 10UL, 14UL, 3UL, 7UL, 11UL, 15UL, 4UL, 8UL, 12UL}
        Private Shared ReadOnly SymmetryShift() As Integer = New Integer() {60, 44, 28, 12, 56, 40, 24, 8, 52, 36, 20, 4, 48, 32, 16, 0}

        Public Shared Function ToSymmetry(data As ULong) As ULong
            Dim p As ULong = 0UL
            Dim sh As Integer = 60
            For i As Integer = 0 To 15
                p = p Or (SymmetryTable((data >> sh) And &HFUL) << SymmetryShift(i))
                sh -= 4
            Next
            Return p
        End Function

        Public Shared Function ToSymmetryNumber(value As Integer) As Integer
            Return SymmetryTable(value)
        End Function

        Public Shared Function ToSymmetryPosition(data As ULong) As ULong
            Return (data And &HF0000F0000F0000FUL) _
                Or ((data And &HF0000F0000F0000UL) >> 12) _
                Or ((data And &HF0000F00000000UL) >> 24) _
                Or ((data And &HF000000000000UL) >> 36) _
                Or ((data And &HF0000F0000F0UL) << 12) _
                Or ((data And &HF0000F00UL) << 24) _
                Or ((data And &HF000UL) << 36)
        End Function

        Public ReadOnly data, zero, rv_data, rv_zero As ULong


        Sub New(Optional data As ULong = CLEAR_PUZZLE)
            Me.data = data
            zero = &HFUL
            For i As Integer = 0 To 15
                If (data And zero) = 0UL Then
                    Exit For
                End If
                zero <<= 4
            Next i
            rv_data = ToSymmetry(data)
            rv_zero = ToSymmetryPosition(zero)
        End Sub

        Sub New(array() As Integer)
            data = 0UL
            For i As Integer = 0 To 15
                Dim v As ULong = array(i) And &HF%
                v <<= 60 - (i << 2)
                data = data Or v
                If v = 0UL Then
                    zero = &HFUL << (60 - (i << 2))
                End If
            Next i
            rv_data = ToSymmetry(data)
            rv_zero = ToSymmetryPosition(zero)
        End Sub

        Sub New(array() As String)
            data = 0UL
            For i As Integer = 0 To 15
                Dim x As Integer
                Dim v As ULong
                If Integer.TryParse(array(i), x) Then
                    v = x And &HF
                Else
                    v = 0UL
                End If
                v <<= 60 - (i << 2)
                data = data Or v
                If v = 0UL Then
                    zero = &HFUL << (60 - (i << 2))
                End If
            Next i
            rv_data = ToSymmetry(data)
            rv_zero = ToSymmetryPosition(zero)
        End Sub

        Sub New(array(,) As Integer)
            Dim sh As Integer = 60
            data = 0UL
            For i As Integer = 0 To 3
                For j As Integer = 0 To 3
                    Dim v As ULong = array(i, j) And &HF%
                    v <<= sh
                    data = data Or v
                    If v = 0UL Then
                        zero = &HFUL << sh
                    End If
                    sh -= 4
                Next j
            Next i
            rv_data = ToSymmetry(data)
            rv_zero = ToSymmetryPosition(zero)
        End Sub

        Sub New(array(,) As String)
            Dim sh As Integer = 60
            data = 0UL
            For i As Integer = 0 To 3
                For j As Integer = 0 To 3
                    Dim x As Integer
                    Dim v As ULong
                    If Integer.TryParse(array(i, j), x) Then
                        v = x And &HF
                    Else
                        v = 0UL
                    End If
                    v <<= sh
                    data = data Or v
                    If v = 0UL Then
                        zero = &HFUL << sh
                    End If
                    sh -= 4
                Next j
            Next i
            rv_data = ToSymmetry(data)
            rv_zero = ToSymmetryPosition(zero)
        End Sub

        Private Sub New(data As ULong, zero As ULong, rv_data As ULong, rv_zero As ULong)
            Me.data = data
            Me.zero = zero
            Me.rv_data = rv_data
            Me.rv_zero = rv_zero
        End Sub

        Public Function NumberOf(index As Integer) As Integer
            Return GetNumber(data, index)
        End Function

        Public Function NumberOf(x As Integer, y As Integer) As Integer
            Return GetNumber(data, x, y)
        End Function

        Public Function IndexOf(number As Integer) As Integer
            For i As Integer = 0 To 15
                If NumberOf(i) = number Then
                    Return i
                End If
            Next i
            Return -1
        End Function

        Public Function MoveLeft() As PuzzleState
            If (zero And &HF000F000F000F000UL) = 0UL Then
                Return New PuzzleState((data Or ((data >> 4) And zero)) And (Not (zero << 4)), zero << 4, (rv_data Or ((rv_data >> 16) And rv_zero)) And (Not (rv_zero << 16)), rv_zero << 16)
            Else
                Return Me
            End If
        End Function

        Public Function MoveRight() As PuzzleState
            If (zero And &HF000F000F000FUL) = 0UL Then
                Return New PuzzleState((data Or ((data << 4) And zero)) And (Not (zero >> 4)), zero >> 4, (rv_data Or ((rv_data << 16) And rv_zero)) And (Not (rv_zero >> 16)), rv_zero >> 16)
            Else
                Return Me
            End If
        End Function

        Public Function MoveUp() As PuzzleState
            If (zero And &HFFFF000000000000UL) = 0UL Then
                Return New PuzzleState((data Or ((data >> 16) And zero)) And (Not (zero << 16)), zero << 16, (rv_data Or ((rv_data >> 4) And rv_zero)) And (Not (rv_zero << 4)), rv_zero << 4)
            Else
                Return Me
            End If
        End Function

        Public Function MoveDown() As PuzzleState
            If (zero And &HFFFFUL) = 0UL Then
                Return New PuzzleState((data Or ((data << 16) And zero)) And (Not (zero >> 16)), zero >> 16, (rv_data Or ((rv_data << 4) And rv_zero)) And (Not (rv_zero >> 4)), rv_zero >> 4)
            Else
                Return Me
            End If
        End Function

        Public Function Move(k As Integer) As PuzzleState
            Select Case k And 3
                Case MOVE_LEFT
                    Return MoveLeft()
                Case MOVE_RIGHT
                    Return MoveRight()
                Case MOVE_UP
                    Return MoveUp()
                Case MOVE_DOWN
                    Return MoveDown()
                Case Else
                    Return Me
            End Select
        End Function

        Public Function MoveNumber(num As Integer) As PuzzleState
            Dim tempPuzzle As PuzzleState

            tempPuzzle = MoveLeft()
            If GetDifferenceOneNumber(Me, tempPuzzle) = num Then
                Return tempPuzzle
            End If

            tempPuzzle = MoveRight()
            If GetDifferenceOneNumber(Me, tempPuzzle) = num Then
                Return tempPuzzle
            End If

            tempPuzzle = MoveUp()
            If GetDifferenceOneNumber(Me, tempPuzzle) = num Then
                Return tempPuzzle
            End If

            tempPuzzle = MoveDown()
            If GetDifferenceOneNumber(Me, tempPuzzle) = num Then
                Return tempPuzzle
            End If

            Return Me
        End Function

        Public Function Shuffle(Optional count As Integer = 10) As PuzzleState
            Dim rand As New Random
            Dim temp As PuzzleState = Me
            Dim k As Integer = 0
            For i As Integer = 1 To count
                Dim temp2 As PuzzleState
                If k = 0 Then
                    temp2 = temp.Move(rand.Next(2))
                Else
                    temp2 = temp.Move(rand.Next(2) + 2)
                End If
                If temp.data <> temp2.data Then
                    temp = temp2
                    k = 1 - k
                End If
            Next i
            Return temp
        End Function

        Public Sub Print()
            Console.WriteLine("---------------------------")
            For i As Integer = 0 To 15
                Dim n As ULong = (data >> (60 - (i << 2))) And &HFUL
                If n = 0 Then
                    Console.Write(" *")
                Else
                    Console.Write("{0,2:D}", n)
                End If
                If i Mod 4 = 3 Then
                    Console.WriteLine()
                Else
                    Console.Write(" ")
                End If
            Next i
        End Sub

    End Class

End Class
