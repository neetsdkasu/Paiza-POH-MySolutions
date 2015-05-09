' 15 puzzle solver
' 2015-05-10
' Leonardone @ NEETSDKASU
Option Explicit On
Imports System.Collections.Generic


Public Class compiler

    Const CLEAR_PUZZLE As ULong = &H123456789ABCDEF0UL

    Const DEFAULT_DEPTH As Integer = 10
    Const MOVE_LEFT As Integer = 0
    Const MOVE_RIGHT As Integer = 1
    Const MOVE_UP As Integer = 2
    Const MOVE_DOWN As Integer = 3

    Shared Function Main() As Integer

        Dim problem As PuzzleState

#If DEBUG Then
#Const MAKE_BY_RANDOM = 1
#If MAKE_BY_RANDOM Then
        problem = PuzzleState.NewPuzzleState().Shuffle(500)
#Else
        problem = PuzzleState.NewPuzzleState({{1, 2, 3, 0}, {5, 6, 7, 4}, {9, 10, 11, 8}, {13, 14, 15, 12}})
#End If
        problem.Print()
#Else
        problem = InputPuzzle()
#End If

        Dim nextsFromStart As New List(Of PuzzleState)(1000000)
        Dim nextsFromGoal As New List(Of PuzzleState)(1000000)
        Dim allRootsFromStart As AllRoots = New AllRoots
        Dim allRootsFromGoal As AllRoots = New AllSymmetryRoots

        nextsFromStart.Add(problem)
        allRootsFromStart.Add(0UL, problem)

        nextsFromGoal.Add(New PuzzleState(CLEAR_PUZZLE))
        allRootsFromGoal.Add(0UL, New PuzzleState(CLEAR_PUZZLE))

        Dim nextsSwap As List(Of PuzzleState)
        Dim nextsTemp As New List(Of PuzzleState)

        Dim result As ULong = 0UL

        Do
            For i As Integer = 1 To 100
#If DEBUG Then
                Console.WriteLine("i={0:D}", i)
#End If

                nextsTemp.Clear()
                For j As Integer = 0 To nextsFromGoal.Count - 1
                    Dim puzzle As PuzzleState = nextsFromGoal.Item(j)
                    For k As Integer = 0 To 3
                        Dim tempPuzzle As PuzzleState = puzzle.Move(k)
                        If tempPuzzle.data <> puzzle.data Then
                            If allRootsFromGoal.Add(puzzle.data, tempPuzzle) Then
                                nextsTemp.Add(tempPuzzle)
                                If allRootsFromStart.roots.ContainsKey(tempPuzzle.data) Then
                                    result = tempPuzzle.data
                                    Exit Do
                                End If
                                If allRootsFromStart.roots.ContainsKey(tempPuzzle.rv_data) Then
                                    result = tempPuzzle.rv_data
                                    Exit Do
                                End If
                            End If
                        End If
                    Next k
                Next j
                nextsSwap = nextsFromGoal
                nextsFromGoal = nextsTemp
                nextsTemp = nextsSwap

                nextsTemp.Clear()
                For j As Integer = 0 To nextsFromStart.Count - 1
                    Dim puzzle As PuzzleState = nextsFromStart.Item(j)
                    For k As Integer = 0 To 3
                        Dim tempPuzzle As PuzzleState = puzzle.Move(k)
                        If tempPuzzle.data <> puzzle.data Then
                            If allRootsFromStart.Add(puzzle.data, tempPuzzle) Then
                                nextsTemp.Add(tempPuzzle)
                                If allRootsFromGoal.Contains(tempPuzzle) Then
                                    result = tempPuzzle.data
                                    Exit Do
                                End If
                            End If
                        End If
                    Next k
                Next j
                nextsSwap = nextsFromStart
                nextsFromStart = nextsTemp
                nextsTemp = nextsSwap

                If nextsFromStart.Count = 0 Or nextsFromGoal.Count = 0 Then
                    Exit Do
                End If
            Next i
            Exit Do
        Loop

        If result = 0 Then
#If DEBUG Then
            Console.WriteLine("failure {0:D} {1:D} {2:D} {3:D}", allRootsFromStart.roots.Count, nextsFromStart.Count, allRootsFromGoal.roots.Count, nextsFromGoal.Count)
            Stop
#End If
            Return 0
        End If

        Dim root As List(Of Integer) = MakeRoot(result, allRootsFromStart, allRootsFromGoal)

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
        Dim numbers(15) As Integer
        Dim n As Integer = 0
        For i As Integer = 0 To 3
            Dim strLine As String = Console.ReadLine()
            Dim strLines() As String = strLine.Split(" ")
            For j As Integer = 0 To 3
                Dim v As Integer
                If Integer.TryParse(strLines(j), v) Then
                    numbers(n) = v
                Else
                    numbers(n) = 0
                End If
                n += 1
            Next j
        Next i
        Return PuzzleState.NewPuzzleState(numbers)
    End Function

    Shared Function MakeRoot(value As ULong, allRoots1 As AllRoots, allRoots2 As AllRoots) As List(Of Integer)
        Dim root As New List(Of Integer)

        Dim stk As New Stack(Of Integer)
        Dim t1 As ULong = value
        Dim t2 As ULong = allRoots1.roots.Item(t1)
        Do While t2 <> 0UL
            stk.Push(PuzzleState.GetDifferenceOneNumber(t1, t2))
            t1 = t2
            t2 = allRoots1.roots.Item(t1)
        Loop
        Do While stk.Count > 0
            root.Add(stk.Pop())
        Loop
        If allRoots2.roots.ContainsKey(value) Then
            t1 = value
            t2 = allRoots2.roots.Item(t1)
            Do While t2 <> 0UL
                root.Add(PuzzleState.GetDifferenceOneNumber(t1, t2))
                t1 = t2
                t2 = allRoots2.roots.Item(t1)
            Loop
        Else
            t1 = PuzzleState.ToSymmetry(value)
            t2 = allRoots2.roots.Item(t1)
            Do While t2 <> 0UL
                root.Add(PuzzleState.ToSymmetryNumber(PuzzleState.GetDifferenceOneNumber(t1, t2)))
                t1 = t2
                t2 = allRoots2.roots.Item(t1)
            Loop
        End If
        Return root
    End Function

    Class AllRoots
        Public roots As New Dictionary(Of ULong, ULong)(100000000)
        Public Overridable Function Add(fromData As ULong, toPuzzle As PuzzleState) As Boolean
            If roots.ContainsKey(toPuzzle.data) Then
                Return False
            Else
                roots.Item(toPuzzle.data) = fromData
                Return True
            End If
        End Function
        Public Overridable Function Contains(puzzle As PuzzleState) As Boolean
            Return roots.ContainsKey(puzzle.data)
        End Function
    End Class

    Class AllSymmetryRoots
        Inherits AllRoots
        Public Overrides Function Add(fromData As ULong, toPuzzle As PuzzleState) As Boolean
            If roots.ContainsKey(toPuzzle.rv_data) Then
                Return False
            Else
                Return MyBase.Add(fromData, toPuzzle)
            End If
        End Function
        Public Overrides Function Contains(puzzle As PuzzleState) As Boolean
            Return roots.ContainsKey(puzzle.rv_data) Or MyBase.Contains(puzzle)
        End Function
    End Class

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

        Public Shared Function GetNumber(data As ULong, index As Integer) As Integer
            Return (data >> (60 - ((index And &HF%) << 2))) And &HFUL
        End Function

        Public Shared Function GetNumber(data As ULong, x As Integer, y As Integer) As Integer
            Return GetNumber(data, ((y And &H3%) << 2) Or (x And &H3%))
        End Function

        Public Shared Function NewPuzzleState(array() As Integer) As PuzzleState
            Return New PuzzleState(array)
        End Function

        Public Shared Function NewPuzzleState(array(,) As Integer) As PuzzleState
            Return New PuzzleState(array)
        End Function

        Public Shared Function NewPuzzleState(Optional data As ULong = CLEAR_PUZZLE) As PuzzleState
            Return New PuzzleState(data)
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

        Public Function IndexOf(number As ULong) As Integer
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
