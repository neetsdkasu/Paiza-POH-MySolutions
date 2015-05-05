' 15 puzzle solver
' 2015-05-05
' Leonardone @ NEETSDKASU
Option Explicit On
Imports System.Collections.Generic


Public Class compiler

    Shared ReadOnly filter0x0 As New Filter(New Integer(,){{1, 1, 1, 1}, {1, 1, 1, 1}, {1, 1, 1, 1}, {1, 1, 1, 1}})
    Shared ReadOnly filter2x2 As New Filter(New Integer(,){{1, 1, 1, 1}, {1, 1, 1, 1}, {1, 1, 0, 0}, {1, 1, 0, 0}})
    Shared ReadOnly filter2x3 As New Filter(New Integer(,){{1, 1, 1, 1}, {1, 1, 0, 0}, {1, 1, 0, 0}, {1, 1, 0, 0}})
    Shared ReadOnly filter2x4 As New Filter(New Integer(,){{1, 1, 0, 0}, {1, 1, 0, 0}, {1, 1, 0, 0}, {1, 1, 0, 0}})
    Shared ReadOnly filter3x2 As New Filter(New Integer(,){{1, 1, 1, 1}, {1, 1, 1, 1}, {1, 0, 0, 0}, {1, 0, 0, 0}})
    Shared ReadOnly filter3x3 As New Filter(New Integer(,){{1, 1, 1, 1}, {1, 0, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}})
    Shared ReadOnly filter3x4 As New Filter(New Integer(,){{1, 0, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}})
    Shared ReadOnly filter4x2 As New Filter(New Integer(,){{1, 1, 1, 1}, {1, 1, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}})
    Shared ReadOnly filter4x3 As New Filter(New Integer(,){{1, 1, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}})

    Shared ReadOnly filter3x3m1LT As New Filter(New Integer(,){{1, 1, 1, 1}, {1, 1, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}})
    Shared ReadOnly filter3x3m1RT As New Filter(New Integer(,){{1, 1, 1, 1}, {1, 0, 0, 1}, {1, 0, 0, 0}, {1, 0, 0, 0}})
    Shared ReadOnly filter3x3m1LB As New Filter(New Integer(,){{1, 1, 1, 1}, {1, 0, 0, 0}, {1, 0, 0, 0}, {1, 1, 0, 0}})

    Shared ReadOnly filter3x4m2LT As New Filter(New Integer(,){{1, 1, 0, 0}, {1, 1, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}})
    Shared ReadOnly filter3x4m2RT As New Filter(New Integer(,){{1, 0, 0, 1}, {1, 0, 0, 1}, {1, 0, 0, 0}, {1, 0, 0, 0}})
    Shared ReadOnly filter3x4m2LB As New Filter(New Integer(,){{1, 0, 0, 0}, {1, 0, 0, 0}, {1, 1, 0, 0}, {1, 1, 0, 0}})

    Shared ReadOnly filter3x4m1LT As New Filter(New Integer(,){{1, 1, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}})
    Shared ReadOnly filter3x4m1RT As New Filter(New Integer(,){{1, 0, 0, 1}, {1, 0, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}})
    Shared ReadOnly filter3x4m1LB As New Filter(New Integer(,){{1, 0, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}, {1, 1, 0, 0}})

    Shared ReadOnly filter4x3m2LT As New Filter(New Integer(,){{1, 1, 1, 1}, {1, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}})
    Shared ReadOnly filter4x3m2RT As New Filter(New Integer(,){{1, 1, 1, 1}, {0, 0, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}})
    Shared ReadOnly filter4x3m2LB As New Filter(New Integer(,){{1, 1, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}, {1, 1, 0, 0}})

    Shared ReadOnly filter4x3m1LT As New Filter(New Integer(,){{1, 1, 1, 1}, {1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}})
    Shared ReadOnly filter4x3m1RT As New Filter(New Integer(,){{1, 1, 1, 1}, {0, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}})
    Shared ReadOnly filter4x3m1LB As New Filter(New Integer(,){{1, 1, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}, {1, 0, 0, 0}})

    Shared ReadOnly filterBxLT As New Filter(New Integer(,){{1, 1, 0, 0}, {1, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}})
    Shared ReadOnly filterBxRT As New Filter(New Integer(,){{0, 0, 1, 1}, {0, 0, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}})
    Shared ReadOnly filterBxLB As New Filter(New Integer(,){{0, 0, 0, 0}, {0, 0, 0, 0}, {1, 1, 0, 0}, {1, 1, 0, 0}})

    Shared ReadOnly filterHzLT As New Filter(New Integer(,){{1, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}})
    Shared ReadOnly filterHzRT As New Filter(New Integer(,){{0, 0, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}})
    Shared ReadOnly filterHzLB As New Filter(New Integer(,){{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {1, 1, 0, 0}})

    Shared ReadOnly filterVtLT As New Filter(New Integer(,){{1, 0, 0, 0}, {1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}})
    Shared ReadOnly filterVtRT As New Filter(New Integer(,){{0, 0, 0, 1}, {0, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}})
    Shared ReadOnly filterVtLB As New Filter(New Integer(,){{0, 0, 0, 0}, {0, 0, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}})

    Shared ReadOnly filter2VtTT As New Filter(New Integer(,){{1, 0, 0, 1}, {1, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}})
    Shared ReadOnly filter2VtBT As New Filter(New Integer(,){{0, 0, 0, 1}, {0, 0, 0, 1}, {1, 0, 0, 0}, {1, 0, 0, 0}})

    Shared ReadOnly filter2HzLL As New Filter(New Integer(,){{1, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {1, 1, 0, 0}})
    Shared ReadOnly filter2HzRL As New Filter(New Integer(,){{0, 0, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}, {1, 1, 0, 0}})

    Shared ReadOnly filter1 As New Filter(New Integer(,){{1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}})
    Shared ReadOnly filter4 As New Filter(New Integer(,){{0, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}})
    Shared ReadOnly filter13 As New Filter(New Integer(,){{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {1, 0, 0, 0}})

    Shared ReadOnly filters As New List(Of Filter)(New Filter(){filter0x0, filter2x2, filter2x3, filter3x2, filter3x3, filter3x4, filter4x3, _
                                                                      filter2x4, filter4x2, filter2HzLL, filter2HzRL, filter2VtBT, filter2VtTT, _
                                                                      filter3x3m1LB, filter3x3m1LT, filter3x3m1RT, filterBxLB, filterBxLT, filterBxRT, _
                                                                      filter3x4m1LB, filter3x4m1LT, filter3x4m1RT, filter3x4m2LB, filter3x4m2LT, filter3x4m2RT, _
                                                                      filter4x3m1LB, filter4x3m1LT, filter4x3m1RT, filter4x3m2LB, filter4x3m2LT, filter4x3m2RT, _
                                                                      filterHzLB, filterHzLT, filterHzRT, filterVtLB, filterVtLT, filterVtRT})


    Const DEFAULT_DEPTH As Integer = 10
    Const MOVE_LEFT As Integer = 0
    Const MOVE_RIGHT As Integer = 1
    Const MOVE_UP As Integer = 2
    Const MOVE_DOWN As Integer = 3

    Shared Function Main() As Integer

        Dim problem As PuzzleState

#If DEBUG Then
#Const MAKE_BY_RANDOM = -1
#If MAKE_BY_RANDOM Then
        problem = New PuzzleState().Shuffle(1000)
#Else
        problem = New PuzzleState({{1, 6, 2, 4}, {9, 10, 3, 7}, {12, 15, 14, 11}, {0, 13, 5, 8}})
#End If
        problem.Print()
#Else
        problem = InputPuzzle()
#End If

        Dim allRoots As New Dictionary(Of ULong, List(Of RootState))

        Dim currentPuzzles As New Dictionary(Of ULong, PuzzleState)
        Dim nextPuzzles As New Dictionary(Of ULong, PuzzleState)
        Dim tempSwapPuzzles As Dictionary(Of ULong, PuzzleState)

        allRoots.Item(problem.data) = New List(Of RootState)
        allRoots.Item(problem.data).Add(New RootState(problem.data, 0UL, Nothing))
        currentPuzzles.Item(problem.data) = problem


        Do While currentPuzzles.Count > 0

            nextPuzzles.Clear()

#If DEBUG Then
            Console.WriteLine("puzzles: {0:D}", currentPuzzles.Count)
#End If

            For Each puzzle As PuzzleState In currentPuzzles.Values

                If filter0x0.Match(puzzle) Then
                    Continue For
                End If

                MakeAllMovables(puzzle)

                If CheckAllMovableRoot(puzzle, filter0x0, allRoots, nextPuzzles) Then
                    Continue For
                End If

                If CheckAllMovableRoot(puzzle, filter2x2, allRoots, nextPuzzles) Then
                    Continue For
                End If

                If filter2x2.Match(puzzle) Then
                    '2x2
                    ' 1  2  3  4
                    ' 5  6  7  8
                    ' 9 10  ?  ?
                    '13 14  ?  ?
                    Console.WriteLine("maybe not come here")
                    Continue For
                End If

                If filter2x4.Match(puzzle) Then
                    ' 1  2  ?  ?
                    ' 5  6  ?  ?
                    ' 9 10  ?  ?
                    '13 14  ?  ?
                    If filter2x3.Match(puzzle) Then
                        ' 1  2  3  4
                        ' 5  6  ?  ?
                        ' 9 10  ?  ?
                        '13 14  ?  ?
                        SearchAll(puzzle, filter2x2, allRoots, nextPuzzles, filter2x3.mask, 16)
                        Continue For
                    End If
                    If SearchAll(puzzle, filter2x3, allRoots, nextPuzzles, filter2x4.mask, 14) = False Then
                        ' + manual search
                        FitHz(puzzle, allRoots, nextPuzzles, 3, filter2x4.mask)
                    End If

                ElseIf filter4x2.Match(puzzle) Then
                    ' 1  2  3  4
                    ' 5  6  7  8
                    ' ?  ?  ?  ?
                    ' ?  ?  ?  ?
                    If filter3x2.Match(puzzle) Then
                        ' 1  2  3  4
                        ' 5  6  7  8
                        ' 9  ?  ?  ?
                        '13  ?  ?  ?
                        SearchAll(puzzle, filter2x2, allRoots, nextPuzzles, filter3x2.mask, 16)
                        Continue For
                    End If
                    If SearchAll(puzzle, filter2x3, allRoots, nextPuzzles, filter4x2.mask, 14) = False Then
                        ' + manual search
                        FitVt(puzzle, allRoots, nextPuzzles, 9, filter4x2.mask)
                    End If

                ElseIf filter3x3.Match(puzzle) Then
                    ' 1  2  3  4
                    ' 5  ?  ?  ?
                    ' 9  ?  ?  ?
                    '13  ?  ?  ?
                    CheckAllMovableRoot(puzzle, filter2x3, allRoots, nextPuzzles)
                    CheckAllMovableRoot(puzzle, filter3x2, allRoots, nextPuzzles)
                    If filter3x3m1LT.Match(puzzle) Then
                        ' 1  2  3  4
                        ' 5  6  ?  ?
                        ' 9  ?  ?  ?
                        '13  ?  ?  ?
                        ' + manual search
                        FitHz(puzzle, allRoots, nextPuzzles, 7, filter3x3m1LT.mask)
                        FitVt(puzzle, allRoots, nextPuzzles, 10, filter3x3m1LT.mask)
                        Continue For
                    End If
                    If filter3x3m1RT.Match(puzzle) Then
                        ' 1  2  3  4
                        ' 5  ?  ?  8
                        ' 9  ?  ?  ?
                        '13  ?  ?  ?
                        ' + manual search
                        FitHz(puzzle, allRoots, nextPuzzles, 6, filter3x3m1RT.mask)
                        Continue For
                    End If
                    If filter3x3m1LB.Match(puzzle) Then
                        ' 1  2  3  4
                        ' 5  ?  ?  ?
                        ' 9  ?  ?  ?
                        '13 14  ?  ?
                        ' + manual search
                        FitVt(puzzle, allRoots, nextPuzzles, 6, filter3x3m1LB.mask)
                        Continue For
                    End If
                    ' + manual search
                    FitHz(puzzle, allRoots, nextPuzzles, 7, filter3x3.mask)
                    FitVt(puzzle, allRoots, nextPuzzles, 10, filter3x3.mask)
                    FitHz(puzzle, allRoots, nextPuzzles, 6, filter3x3.mask)
                    FitVt(puzzle, allRoots, nextPuzzles, 6, filter3x3.mask)

                ElseIf filter3x4.Match(puzzle) Then
                    ' 1  ?  ?  ?
                    ' 5  ?  ?  ?
                    ' 9  ?  ?  ?
                    '13  ?  ?  ?
                    If filter3x4m2LT.Match(puzzle) Then
                        ' 1  2  ?  ?
                        ' 5  6  ?  ?
                        ' 9  ?  ?  ?
                        '13  ?  ?  ?
                        If CheckAllMovableRoot(puzzle, filter3x3m1LT, allRoots, nextPuzzles) = False Then
                            FitHz(puzzle, allRoots, nextPuzzles, 3, filter3x4m2LT.mask)
                        End If
                        If CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) = False Then
                            FitVt(puzzle, allRoots, nextPuzzles, 10, filter3x4m2LT.mask)
                        End If
                        Continue For
                    End If
                    If filter3x4m2LB.Match(puzzle) Then
                        ' 1  ?  ?  ?
                        ' 5  ?  ?  ?
                        ' 9 10  ?  ?
                        '13 14  ?  ?
                        If CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) = False Then
                            FitVt(puzzle, allRoots, nextPuzzles, 2, filter3x4m2LB.mask)
                        End If
                        Continue For
                    End If
                    If filter3x4m2RT.Match(puzzle) Then
                        ' 1  ?  ?  4
                        ' 5  ?  ?  8
                        ' 9  ?  ?  ?
                        '13  ?  ?  ?
                        CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles)
                        If CheckAllMovableRoot(puzzle, filter3x3m1RT, allRoots, nextPuzzles) = False Then
                            FitHz(puzzle, allRoots, nextPuzzles, 2, filter3x4m2RT.mask)
                        End If
                        Continue For
                    End If
                    If filter3x4m1LT.Match(puzzle) Then
                        ' 1  2  ?  ?
                        ' 5  ?  ?  ?
                        ' 9  ?  ?  ?
                        '13  ?  ?  ?
                        If CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles) = False Then
                            FitHz(puzzle, allRoots, nextPuzzles, 3, filter3x4m1LT.mask)
                        End If
                        If CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) = False Then
                            CheckAllMovableRoot(puzzle, filter3x4m2LT, allRoots, nextPuzzles)
                            CheckAllMovableRoot(puzzle, filter3x4m2LB, allRoots, nextPuzzles)
                        End If
                        FitVt(puzzle, allRoots, nextPuzzles, 2, filter3x4.mask)
                        FitVt(puzzle, allRoots, nextPuzzles, 10, filter3x4.mask)
                        Continue For
                    End If
                    If filter3x4m1RT.Match(puzzle) Then
                        ' 1  ?  ?  4
                        ' 5  ?  ?  ?
                        ' 9  ?  ?  ?
                        '13  ?  ?  ?
                        If CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles) = False Then
                            FitHz(puzzle, allRoots, nextPuzzles, 2, filter3x4m1RT.mask)
                        End If
                        If CheckAllMovableRoot(puzzle, filter3x4m2LT, allRoots, nextPuzzles) = False Then
                            FitVt(puzzle, allRoots, nextPuzzles, 2, filter3x4.mask)
                        End If
                        If CheckAllMovableRoot(puzzle, filter3x4m2RT, allRoots, nextPuzzles) = False Then
                            FitVt(puzzle, allRoots, nextPuzzles, 10, filter3x4.mask)
                        End If
                        FitHz(puzzle, allRoots, nextPuzzles, 2, filter3x4.mask)
                        Continue For
                    End If
                    If filter3x4m1LB.Match(puzzle) Then
                        ' 1  ?  ?  ?
                        ' 5  ?  ?  ?
                        ' 9  ?  ?  ?
                        '13 14  ?  ?
                        If CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) = False Then
                            If CheckAllMovableRoot(puzzle, filter3x4m2LB, allRoots, nextPuzzles) = False Then
                                FitVt(puzzle, allRoots, nextPuzzles, 2, filter3x4.mask)
                            End If
                            If CheckAllMovableRoot(puzzle, filter3x4m2LT, allRoots, nextPuzzles) = False Then
                                FitVt(puzzle, allRoots, nextPuzzles, 10, filter3x4.mask)
                            End If
                        End If
                        Continue For
                    End If
                    CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles)
                    If CheckAllMovableRoot(puzzle, filter3x4m2RT, allRoots, nextPuzzles) = False Then
                        FitVtRv(puzzle, allRoots, nextPuzzles, 4, filter3x4.mask)
                    End If
                    If CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) = False Then
                        If CheckAllMovableRoot(puzzle, filter3x4m2LT, allRoots, nextPuzzles) = False Then
                            FitVt(puzzle, allRoots, nextPuzzles, 2, filter3x4.mask)
                        End If
                        If CheckAllMovableRoot(puzzle, filter3x4m2LB, allRoots, nextPuzzles) = False Then
                            FitVt(puzzle, allRoots, nextPuzzles, 10, filter3x4.mask)
                        End If
                    End If

                ElseIf filter4x3.Match(puzzle) Then
                    ' 1  2  3  4
                    ' ?  ?  ?  ?
                    ' ?  ?  ?  ?
                    ' ?  ?  ?  ?
                    If filter4x3m2LT.Match(puzzle) Then
                        ' 1  2  3  4
                        ' 5  6  ?  ?
                        ' ?  ?  ?  ?
                        ' ?  ?  ?  ?
                        If CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) = False Then
                            FitHz(puzzle, allRoots, nextPuzzles, 7, filter4x3m2LT.mask)
                        End If
                        If CheckAllMovableRoot(puzzle, filter3x3m1LT, allRoots, nextPuzzles) = False Then
                            If CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles) = False Then
                                FitVt(puzzle, allRoots, nextPuzzles, 9, filter4x3m2LT.mask)
                            End If
                        End If
                        Continue For
                    End If
                    If filter4x3m2RT.Match(puzzle) Then
                        ' 1  2  3  4
                        ' ?  ?  7  8
                        ' ?  ?  ?  ?
                        ' ?  ?  ?  ?
                        If CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) = False Then
                            FitHz(puzzle, allRoots, nextPuzzles, 5, filter4x3m2RT.mask)
                        End If
                        Continue For
                    End If
                    If filter4x3m2LB.Match(puzzle) Then
                        ' 1  2  3  4
                        ' ?  ?  ?  ? 
                        ' ?  ?  ?  ?
                        '13 14  ?  ?
                        If CheckAllMovableRoot(puzzle, filter2x3, allRoots, nextPuzzles) = False Then
                            If CheckAllMovableRoot(puzzle, filter3x3m1LB, allRoots, nextPuzzles) = False Then
                                If CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles) = False Then
                                    FitVt(puzzle, allRoots, nextPuzzles, 5, filter4x3m2LB.mask)
                                End If
                            End If
                        End If
                        Continue For
                    End If
                    If filter4x3m1LT.Match(puzzle) Then
                        ' 1  2  3  4
                        ' 5  ?  ?  ?
                        ' ?  ?  ?  ?
                        ' ?  ?  ?  ?
                        If CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) = False Then
                            CheckAllMovableRoot(puzzle, filter4x3m2LT, allRoots, nextPuzzles)
                        End If
                        CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles)
                        FitVt(puzzle, allRoots, nextPuzzles, 9, filter4x3m1LT.mask)
                        Continue For
                    End If
                    If filter4x3m1RT.Match(puzzle) Then
                        ' 1  2  3  4
                        ' ?  ?  ?  8
                        ' ?  ?  ?  ?
                        ' ?  ?  ?  ?
                        If CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) = False Then
                            CheckAllMovableRoot(puzzle, filter4x3m2LT, allRoots, nextPuzzles)
                            CheckAllMovableRoot(puzzle, filter4x3m2RT, allRoots, nextPuzzles)
                        End If
                        FitHz(puzzle, allRoots, nextPuzzles, 5, filter4x3.mask)
                        FitHz(puzzle, allRoots, nextPuzzles, 7, filter4x3.mask)
                        Continue For
                    End If
                    If filter4x3m1LB.Match(puzzle) Then
                        ' 1  2  3  4
                        ' ?  ?  ?  ?
                        ' ?  ?  ?  ?
                        '13  ?  ?  ?
                        CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles)
                        FitVt(puzzle, allRoots, nextPuzzles, 5, filter4x3m1LB.mask)
                        Continue For
                    End If
                    If CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) = False Then
                        CheckAllMovableRoot(puzzle, filter4x3m2LT, allRoots, nextPuzzles)
                        CheckAllMovableRoot(puzzle, filter4x3m2RT, allRoots, nextPuzzles)
                    End If
                    CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles)
                    '+ manual search
                    FitHz(puzzle, allRoots, nextPuzzles, 5, filter4x3.mask)
                    FitHz(puzzle, allRoots, nextPuzzles, 7, filter4x3.mask)
                    FitHzRv(puzzle, allRoots, nextPuzzles, 13, filter4x3.mask)

                ElseIf filterBxLT.Match(puzzle) Then
                    ' 1  2  ?  ?
                    ' 5  6  ?  ?
                    ' ?  ?  ?  ?
                    ' ?  ?  ?  ?
                    If CheckAllMovableRoot(puzzle, filter3x3m1LT, allRoots, nextPuzzles) = False Then
                        CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles)
                    End If
                    If CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) = False Then
                        If CheckAllMovableRoot(puzzle, filter3x4m2LT, allRoots, nextPuzzles) = False Then
                            If CheckAllMovableRoot(puzzle, filter3x4m1LT, allRoots, nextPuzzles) = False Then
                                CheckAllMovableRoot(puzzle, filter3x4, allRoots, nextPuzzles)
                            End If
                        End If
                    End If
                    If CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) = False Then
                        If CheckAllMovableRoot(puzzle, filter4x3m2LT, allRoots, nextPuzzles) Then
                            If CheckAllMovableRoot(puzzle, filter4x3m1LT, allRoots, nextPuzzles) = False Then
                                CheckAllMovableRoot(puzzle, filter4x3, allRoots, nextPuzzles)
                            End If
                        End If
                    End If
                    FitHz(puzzle, allRoots, nextPuzzles, 3, filterBxLT.mask)
                    FitVt(puzzle, allRoots, nextPuzzles, 9, filterBxLT.mask)

                ElseIf filterBxRT.Match(puzzle) Then
                    ' ?  ?  3  4
                    ' ?  ?  7  8
                    ' ?  ?  ?  ?
                    ' ?  ?  ?  ?
                    If CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) = False Then
                        If CheckAllMovableRoot(puzzle, filter4x3m2RT, allRoots, nextPuzzles) = False Then
                            If CheckAllMovableRoot(puzzle, filter4x3m1RT, allRoots, nextPuzzles) = False Then
                                CheckAllMovableRoot(puzzle, filter4x3, allRoots, nextPuzzles)
                            End If
                        End If
                    End If
                    FitHz(puzzle, allRoots, nextPuzzles, 1, filterBxRT.mask)

                ElseIf filterBxLB.Match(puzzle) Then
                    ' ?  ?  ?  ?
                    ' ?  ?  ?  ?
                    ' 9 10  ?  ?
                    '13 14  ?  ?
                    If CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) = False Then
                        If CheckAllMovableRoot(puzzle, filter3x4m2LB, allRoots, nextPuzzles) = False Then
                            If CheckAllMovableRoot(puzzle, filter3x4m1LB, allRoots, nextPuzzles) = False Then
                                CheckAllMovableRoot(puzzle, filter3x4, allRoots, nextPuzzles)
                            End If
                        End If
                    End If
                    FitVt(puzzle, allRoots, nextPuzzles, 1, filterBxLB.mask)

                ElseIf filter2VtTT.Match(puzzle) Then
                    ' 1  ?  ?  4
                    ' 5  ?  ?  8
                    ' ?  ?  ?  ?
                    ' ?  ?  ?  ?
                    If CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) = False Then
                        If CheckAllMovableRoot(puzzle, filter4x3m2LT, allRoots, nextPuzzles) = False Then
                            CheckAllMovableRoot(puzzle, filter4x3m1LT, allRoots, nextPuzzles)
                        End If
                        If CheckAllMovableRoot(puzzle, filter4x3m2RT, allRoots, nextPuzzles) = False Then
                            CheckAllMovableRoot(puzzle, filter4x3m1RT, allRoots, nextPuzzles)
                        End If
                        FitHz(puzzle, allRoots, nextPuzzles, 2, filter2VtTT.mask)
                    End If
                    If CheckAllMovableRoot(puzzle, filter3x4, allRoots, nextPuzzles) = False Then
                        FitVt(puzzle, allRoots, nextPuzzles, 9, filterVtLT.mask)
                    End If

                ElseIf filter2VtBT.Match(puzzle) Then
                    ' ?  ?  ?  4
                    ' ?  ?  ?  8
                    ' 9  ?  ?  ?
                    '13  ?  ?  ?
                    If CheckAllMovableRoot(puzzle, filter3x4, allRoots, nextPuzzles) = False Then
                        FitVt(puzzle, allRoots, nextPuzzles, 1, filterVtLB.mask)
                    End If
                    If CheckAllMovableRoot(puzzle, filterBxLB, allRoots, nextPuzzles) = False Then
                        FitVt(puzzle, allRoots, nextPuzzles, 10, filterVtLB.mask)
                    End If
                    If CheckAllMovableRoot(puzzle, filterBxRT, allRoots, nextPuzzles) = False Then
                        FitVtRv(puzzle, allRoots, nextPuzzles, 3, filterVtRT.mask)
                    End If

                ElseIf filter2HzRL.Match(puzzle) Then
                    ' ?  ?  3  4
                    ' ?  ?  ?  ?
                    ' ?  ?  ?  ?
                    '13 14  ?  ?
                    If CheckAllMovableRoot(puzzle, filter4x3, allRoots, nextPuzzles) = False Then
                        FitHz(puzzle, allRoots, nextPuzzles, 1, filterHzRT.mask)
                    End If
                    If CheckAllMovableRoot(puzzle, filterBxLB, allRoots, nextPuzzles) = False Then
                        FitHzRv(puzzle, allRoots, nextPuzzles, 9, filterHzLB.mask)
                    End If
                    If CheckAllMovableRoot(puzzle, filterBxRT, allRoots, nextPuzzles) = False Then
                        FitHz(puzzle, allRoots, nextPuzzles, 7, filterHzRT.mask)
                    End If

                ElseIf filter2HzLL.Match(puzzle) Then
                    ' 1  2  ?  ?
                    ' ?  ?  ?  ?
                    ' ?  ?  ?  ?
                    '13 14  ?  ?
                    If CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) = False Then
                        CheckAllMovableRoot(puzzle, filter3x4m1LT, allRoots, nextPuzzles)
                        CheckAllMovableRoot(puzzle, filter3x4m1LB, allRoots, nextPuzzles)
                        If CheckAllMovableRoot(puzzle, filter3x4, allRoots, nextPuzzles) = False Then
                            FitVt(puzzle, allRoots, nextPuzzles, 5, filter2HzLL.mask)
                            FitHz(puzzle, allRoots, nextPuzzles, 3, filter2HzLL.mask)
                        End If
                    End If
                    CheckAllMovableRoot(puzzle, filterBxLT, allRoots, nextPuzzles)
                    CheckAllMovableRoot(puzzle, filterBxLB, allRoots, nextPuzzles)

                Else

                    If filter1.Match(puzzle) Then
                        If filterVtLT.Match(puzzle) Then
                            ' 1  ?  ?  ?
                            ' 5  ?  ?  ?
                            ' ?  ?  ?  ?
                            ' ?  ?  ?  ?
                            If CheckAllMovableRoot(puzzle, filterBxLT, allRoots, nextPuzzles) = False Then
                                FitVt(puzzle, allRoots, nextPuzzles, 2, filterVtLT.mask)
                            End If
                            If CheckAllMovableRoot(puzzle, filter3x4, allRoots, nextPuzzles) = False Then
                                FitVt(puzzle, allRoots, nextPuzzles, 9, filterVtLT.mask)
                            End If
                            If CheckAllMovableRoot(puzzle, filter2VtTT, allRoots, nextPuzzles) = False Then
                                FitVtRv(puzzle, allRoots, nextPuzzles, 4, filterVtLT.mask)
                            End If
                            Continue For
                        End If

                        If filterHzLT.Match(puzzle) Then
                            ' 1  2  ?  ?
                            ' ?  ?  ?  ?
                            ' ?  ?  ?  ?
                            ' ?  ?  ?  ?
                            If CheckAllMovableRoot(puzzle, filterBxLT, allRoots, nextPuzzles) = False Then
                                FitHz(puzzle, allRoots, nextPuzzles, 5, filterHzLT.mask)
                            End If
                            If CheckAllMovableRoot(puzzle, filter4x3, allRoots, nextPuzzles) = False Then
                                FitHz(puzzle, allRoots, nextPuzzles, 3, filterHzLT.mask)
                            End If
                            If CheckAllMovableRoot(puzzle, filter2HzLL, allRoots, nextPuzzles) = False Then
                                FitHzRv(puzzle, allRoots, nextPuzzles, 13, filterHzLT.mask)
                            End If
                            Continue For
                        End If

                    End If

                    If filter4.Match(puzzle) Then

                        If filterVtRT.Match(puzzle) Then
                            ' ?  ?  ?  4 
                            ' ?  ?  ?  8
                            ' ?  ?  ?  ?
                            ' ?  ?  ?  ?
                            If CheckAllMovableRoot(puzzle, filterBxRT, allRoots, nextPuzzles) = False Then
                                FitVtRv(puzzle, allRoots, nextPuzzles, 3, filterVtRT.mask)
                            End If
                            If CheckAllMovableRoot(puzzle, filter2VtBT, allRoots, nextPuzzles) = False Then
                                FitVt(puzzle, allRoots, nextPuzzles, 9, filterVtRT.mask)
                            End If
                            If CheckAllMovableRoot(puzzle, filter2VtTT, allRoots, nextPuzzles) = False Then
                                FitVt(puzzle, allRoots, nextPuzzles, 1, filterVtRT.mask)
                            End If
                            Continue For
                        End If

                        If filterHzRT.Match(puzzle) Then
                            ' ?  ?  3  4
                            ' ?  ?  ?  ?
                            ' ?  ?  ?  ?
                            ' ?  ?  ?  ?
                            If CheckAllMovableRoot(puzzle, filterBxRT, allRoots, nextPuzzles) = False Then
                                FitHz(puzzle, allRoots, nextPuzzles, 7, filterHzRT.mask)
                            End If
                            If CheckAllMovableRoot(puzzle, filter4x3, allRoots, nextPuzzles) = False Then
                                FitHz(puzzle, allRoots, nextPuzzles, 1, filterHzRT.mask)
                            End If
                            If CheckAllMovableRoot(puzzle, filter2HzRL, allRoots, nextPuzzles) = False Then
                                FitHzRv(puzzle, allRoots, nextPuzzles, 13, filterHzRT.mask)
                            End If
                            Continue For
                        End If
                    End If

                    If filter13.Match(puzzle) Then

                        If filterHzLB.Match(puzzle) Then
                            ' ?  ?  ?  ?
                            ' ?  ?  ?  ?
                            ' ?  ?  ?  ?
                            '13 14  ?  ?
                            If CheckAllMovableRoot(puzzle, filterBxLB, allRoots, nextPuzzles) = False Then
                                FitHzRv(puzzle, allRoots, nextPuzzles, 9, filterHzLB.mask)
                            End If
                            If CheckAllMovableRoot(puzzle, filter2HzLL, allRoots, nextPuzzles) = False Then
                                FitHz(puzzle, allRoots, nextPuzzles, 1, filterHzLB.mask)
                            End If
                            If CheckAllMovableRoot(puzzle, filter2HzRL, allRoots, nextPuzzles) = False Then
                                FitHz(puzzle, allRoots, nextPuzzles, 3, filterHzLB.mask)
                            End If
                            Continue For
                        End If

                        If filterVtLB.Match(puzzle) Then
                            ' ?  ?  ?  ?
                            ' ?  ?  ?  ?
                            ' 9  ?  ?  ?
                            '13  ?  ?  ?
                            If CheckAllMovableRoot(puzzle, filterBxLB, allRoots, nextPuzzles) = False Then
                                FitVt(puzzle, allRoots, nextPuzzles, 10, filterVtLB.mask)
                            End If
                            If CheckAllMovableRoot(puzzle, filter3x4, allRoots, nextPuzzles) = False Then
                                FitVt(puzzle, allRoots, nextPuzzles, 1, filterVtLB.mask)
                            End If
                            If CheckAllMovableRoot(puzzle, filter2VtBT, allRoots, nextPuzzles) = False Then
                                FitVtRv(puzzle, allRoots, nextPuzzles, 4, filterVtLB.mask)
                            End If
                            Continue For
                        End If
                    End If

                    If CheckAllMovableRoot(puzzle, filterHzLT, allRoots, nextPuzzles) = False Then
                        FitHz(puzzle, allRoots, nextPuzzles, 1)
                    End If

                    If CheckAllMovableRoot(puzzle, filterVtLT, allRoots, nextPuzzles) = False Then
                        FitVt(puzzle, allRoots, nextPuzzles, 1)
                    End If

                    If CheckAllMovableRoot(puzzle, filterHzRT, allRoots, nextPuzzles) = False Then
                        FitHz(puzzle, allRoots, nextPuzzles, 3)
                    End If

                    If CheckAllMovableRoot(puzzle, filterHzLB, allRoots, nextPuzzles) = False Then
                        FitHzRv(puzzle, allRoots, nextPuzzles, 13)
                    End If

                    If CheckAllMovableRoot(puzzle, filterVtRT, allRoots, nextPuzzles) = False Then
                        FitVtRv(puzzle, allRoots, nextPuzzles, 4)
                    End If

                    If CheckAllMovableRoot(puzzle, filterVtLB, allRoots, nextPuzzles) = False Then
                        FitVt(puzzle, allRoots, nextPuzzles, 9)
                    End If

                End If

            Next puzzle

            tempSwapPuzzles = currentPuzzles
            currentPuzzles = nextPuzzles
            nextPuzzles = tempSwapPuzzles

        Loop

        Dim currentRoots As New Dictionary(Of ULong, List(Of Integer))
        Dim nextRoots As New Dictionary(Of ULong, List(Of Integer))
        Dim tempSwapRoots As Dictionary(Of ULong, List(Of Integer))
        Dim minRoot As List(Of Integer) = Nothing

        currentRoots.Item(filter0x0.value) = New List(Of Integer)

        Do While currentRoots.Count > 0
            nextRoots.Clear()

            For Each data As ULong In currentRoots.Keys
                If allRoots.ContainsKey(data) = False Then
                    Console.WriteLine("what?")
                    Continue For
                End If
                Dim tempRoots As List(Of RootState) = allRoots.Item(data)
                For Each state As RootState In tempRoots
                    Dim tempList As List(Of Integer)
                    If state.parent = 0UL Then
                        tempList = currentRoots.Item(data)
#If DEBUG Then
                        Console.WriteLine("Root: {0:D}", tempList.Count)
#End If
                        If minRoot Is Nothing Then
                            minRoot = tempList
                        ElseIf tempList.Count < minRoot.Count Then
                            minRoot = tempList
                        End If
                    Else
                        tempList = New List(Of Integer)(state.root)
                        tempList.AddRange(currentRoots.Item(data))
                        If nextRoots.ContainsKey(state.parent) Then
                            If tempList.Count < nextRoots.Item(state.parent).Count Then
                                nextRoots.Item(state.parent) = tempList
                            End If
                        Else
                            nextRoots.Add(state.parent, tempList)
                        End If
                    End If
                Next state
            Next data

            tempSwapRoots = currentRoots
            currentRoots = nextRoots
            nextRoots = tempSwapRoots
        Loop

#If DEBUG Then
        Dim checker As PuzzleState = problem
#End If

        If Not minRoot Is Nothing Then
            For Each j As Integer In minRoot
                Console.WriteLine(j)
#If DEBUG Then
                checker = checker.MoveNumber(j)
                'checker.Print()
#End If
            Next j
        Else
            Console.WriteLine("Error")
        End If

#If DEBUG Then
        If Not minRoot Is Nothing Then
            Console.WriteLine("Step {0:D}", minRoot.Count)
        End If
        If filter0x0.Match(checker) Then
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

    Structure Filter
        Public ReadOnly value, mask As ULong

        Public Sub New(mask As ULong)
            Me.mask = mask
            value = mask And &H123456789ABCDEF0UL
        End Sub

        Public Sub New(masks(,) As Integer)
            Dim sh As Integer = 60
            mask = 0UL
            For i As Integer = 0 To 3
                For j As Integer = 0 To 3
                    If masks(i, j) <> 0 Then
                        mask = mask Or (&HFUL << sh)
                    End If
                    sh -= 4
                Next j
            Next i
            value = mask And &H123456789ABCDEF0UL
        End Sub

        Public Function Match(data As ULong) As Boolean
            Return (data And mask) = value
        End Function

        Public Function Match(puzzle As PuzzleState) As Boolean
            Return Match(puzzle.data)
        End Function

        Public Sub Print()
            For i As Integer = 0 To 3
                For j As Integer = 0 To 3
                    Console.Write("{0:X} ", PuzzleState.GetNumber(mask, j, i))
                Next j
                Console.WriteLine()
            Next i
        End Sub

    End Structure

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
        Return New PuzzleState(numbers)
    End Function

    Shared Function CheckAllMovableRoot(startPuzzle As PuzzleState, goalFilter As Filter, allRoots As Dictionary(Of ULong, List(Of RootState)), nextPuzzles As Dictionary(Of ULong, PuzzleState)) As Boolean

        If amv_allMovable.ContainsKey(goalFilter.value) = False Then
            Return False
        End If

        Dim puzzle As New PuzzleState(amv_allMovable(goalFilter.value))

        Dim stackRootNumbers As New Stack(Of Integer)
        Dim tempData As ULong = puzzle.data
        Dim tempData2 As ULong = amv_rootData.Item(tempData)
        Dim root As New List(Of Integer)
        Do While tempData2 <> 0UL
            stackRootNumbers.Push(PuzzleState.GetDifferenceOneNumber(tempData, tempData2))
            tempData = tempData2
            tempData2 = amv_rootData.Item(tempData)
        Loop
        Do While stackRootNumbers.Count > 0
            root.Add(stackRootNumbers.Pop())
        Loop
        If allRoots.ContainsKey(puzzle.data) = False Then
            allRoots.Item(puzzle.data) = New List(Of RootState)
        End If
        allRoots.Item(puzzle.data).Add(New RootState(puzzle.data, startPuzzle.data, root))
        nextPuzzles.Item(puzzle.data) = puzzle

        Return True
    End Function

    Shared amv_currentStates As New Dictionary(Of ULong, PuzzleState)
    Shared amv_nextStates As New Dictionary(Of ULong, PuzzleState)
    Shared amv_tempSwapStates As Dictionary(Of ULong, PuzzleState)
    Shared amv_tempFilters As New List(Of Filter)
    Shared amv_rootData As New Dictionary(Of ULong, ULong)
    Shared amv_allMovable As New Dictionary(Of ULong, ULong)

    Shared Function MakeAllMovables(startPuzzle As PuzzleState, Optional depth As Integer = DEFAULT_DEPTH) As Boolean

        amv_currentStates.Clear()
        amv_nextStates.Clear()
        amv_tempSwapStates = Nothing
        amv_tempFilters.Clear()
        amv_tempFilters.AddRange(filters)

        amv_allMovable.Clear()
        amv_rootData.Clear()
        amv_rootData.Item(startPuzzle.data) = 0UL
        amv_currentStates.Item(startPuzzle.data) = startPuzzle

        For i As Integer = 1 To depth

            amv_nextStates.Clear()

            For Each puzzle As PuzzleState In amv_currentStates.Values

                For k As Integer = amv_tempFilters.Count - 1 To 0 Step -1
                    Dim fi As Filter = amv_tempFilters(k)
                    If fi.Match(puzzle) Then
                        amv_allMovable.Add(fi.value, puzzle.data)
                        amv_tempFilters.Remove(fi)
                    End If
                Next k
                If amv_tempFilters.Count = 0 Then
                    Exit For
                End If

                For j As Integer = 0 To 3
                    Dim tempPuzzle As PuzzleState = puzzle.Move(j)
                    If tempPuzzle.data <> puzzle.data Then
                        If amv_rootData.ContainsKey(tempPuzzle.data) = False Then
                            amv_rootData.Item(tempPuzzle.data) = puzzle.data
                            amv_nextStates.Item(tempPuzzle.data) = tempPuzzle
                        End If
                    End If
                Next j
            Next puzzle

            If amv_nextStates.Count = 0 Then
                Exit For
            End If

            amv_tempSwapStates = amv_currentStates
            amv_currentStates = amv_nextStates
            amv_nextStates = amv_tempSwapStates

        Next i

        Return amv_allMovable.Count > 0
    End Function

    Shared Function SearchAll(startPuzzle As PuzzleState, goalFilter As Filter, allRoots As Dictionary(Of ULong, List(Of RootState)), nextPuzzles As Dictionary(Of ULong, PuzzleState), Optional keepOutMask As ULong = 0UL, Optional depth As Integer = DEFAULT_DEPTH) As Boolean
        Dim currentStates As New Dictionary(Of ULong, PuzzleState)
        Dim nextStates As New Dictionary(Of ULong, PuzzleState)
        Dim tempSwapStates As Dictionary(Of ULong, PuzzleState)
        Dim rootData As New Dictionary(Of ULong, ULong)
        Dim flag As Boolean = False

        rootData.Item(startPuzzle.data) = 0UL
        currentStates.Item(startPuzzle.data) = startPuzzle

        For i As Integer = 1 To depth
            nextStates.Clear()

            For Each puzzle As PuzzleState In currentStates.Values

                If goalFilter.Match(puzzle) Then
                    Dim stackRootNumbers As New Stack(Of Integer)
                    Dim tempData As ULong = puzzle.data
                    Dim tempData2 As ULong = rootData.Item(tempData)
                    Dim root As New List(Of Integer)
                    Do While tempData2 <> 0UL
                        stackRootNumbers.Push(PuzzleState.GetDifferenceOneNumber(tempData, tempData2))
                        tempData = tempData2
                        tempData2 = rootData.Item(tempData)
                    Loop
                    Do While stackRootNumbers.Count > 0
                        root.Add(stackRootNumbers.Pop())
                    Loop
                    If allRoots.ContainsKey(puzzle.data) = False Then
                        allRoots.Item(puzzle.data) = New List(Of RootState)
                    End If
                    allRoots.Item(puzzle.data).Add(New RootState(puzzle.data, startPuzzle.data, root))
                    nextPuzzles.Item(puzzle.data) = puzzle
                    flag = True
                End If

                If flag = False Then
                    For j As Integer = 0 To 3
                        Dim tempPuzzle As PuzzleState = puzzle.Move(j)
                        If tempPuzzle.data <> puzzle.data And (tempPuzzle.zero And keepOutMask) = 0UL Then
                            If rootData.ContainsKey(tempPuzzle.data) = False Then
                                rootData.Item(tempPuzzle.data) = puzzle.data
                                nextStates.Item(tempPuzzle.data) = tempPuzzle
                            End If
                        End If
                    Next j
                End If

            Next puzzle

            If flag Then
                Return True
            End If

            If nextStates.Count = 0 Then
                Return False
            End If

            tempSwapStates = currentStates
            currentStates = nextStates
            nextStates = tempSwapStates

        Next i

        Return False
    End Function

    Shared Function InitKeepOutMap(keepOutMask As ULong) As Boolean()
        Dim keepOutMap(15) As Boolean
        For i As Integer = 0 To 15
            If PuzzleState.GetNumber(keepOutMask, i) <> 0 Then
                keepOutMap(i) = True
            Else
                keepOutMap(i) = False
            End If
        Next i
        Return keepOutMap
    End Function

    Shared Function MakeRoot(rootMap() As Integer, keepOutMap() As Boolean, fromIndex As Integer, toIndex As Integer) As Boolean
        For i As Integer = 0 To 15
            If keepOutMap(i) Then
                rootMap(i) = -1
            Else
                rootMap(i) = 0
            End If
        Next i
        If keepOutMap(fromIndex) Or keepOutMap(toIndex) Then
            Return False
        End If
        Dim c As Integer = 1
        rootMap(toIndex) = c
        Do While rootMap(fromIndex) = 0
            Dim flag As Boolean = True
            For i As Integer = 0 To 15
                If rootMap(i) <> c Then
                    Continue For
                End If
                If i > 3 Then
                    If rootMap(i - 4) = 0 Then
                        rootMap(i - 4) = c + 1
                        flag = False
                    End If
                End If
                If i < 12 Then
                    If rootMap(i + 4) = 0 Then
                        rootMap(i + 4) = c + 1
                        flag = False
                    End If
                End If
                If (i And 3) > 0 Then
                    If rootMap(i - 1) = 0 Then
                        rootMap(i - 1) = c + 1
                        flag = False
                    End If
                End If
                If (i And 3) < 3 Then
                    If rootMap(i + 1) = 0 Then
                        rootMap(i + 1) = c + 1
                        flag = False
                    End If
                End If
            Next i
            c += 1
            If flag Then
                Return False
            End If
        Loop
        Return True
    End Function

    Shared Function MoveSpace(startPuzzle As PuzzleState, toIndex As Integer, keepOutMap() As Boolean, root As List(Of Integer)) As PuzzleState
        Dim rootMap(15) As Integer
        Dim fromIndex As Integer = startPuzzle.IndexOf(0UL)

        If MakeRoot(rootMap, keepOutMap, fromIndex, toIndex) = False Then
#If DEBUG Then
            Console.WriteLine("No Root Space {0:D} to {1:D}", fromIndex, toIndex)
            Dim f1 As New PuzzleState(rootMap)
            f1.Print()
#End If
            Return Nothing
        End If

        Dim tempPuzzle As PuzzleState = startPuzzle
        Dim c As Integer = rootMap(fromIndex) - 1

        Do While c > 0
            Dim mv As Integer = -1
            Dim nextIndex As Integer = fromIndex
            If (fromIndex And 3) > 0 Then
                If rootMap(fromIndex - 1) = c Then
                    mv = MOVE_LEFT ' space move
                    nextIndex = fromIndex - 1 ' space index
                End If
            End If
            If (fromIndex And 3) < 3 Then
                If rootMap(fromIndex + 1) = c Then
                    mv = MOVE_RIGHT
                    nextIndex = fromIndex + 1
                End If
            End If
            If fromIndex > 3 Then
                If rootMap(fromIndex - 4) = c Then
                    mv = MOVE_UP
                    nextIndex = fromIndex - 4
                End If
            End If
            If fromIndex < 12 Then
                If rootMap(fromIndex + 4) = c Then
                    mv = MOVE_DOWN
                    nextIndex = fromIndex + 4
                End If
            End If

            tempPuzzle = tempPuzzle.Move(mv)
            root.Add(tempPuzzle.NumberOf(fromIndex))
            fromIndex = nextIndex
            c -= 1
        Loop

        Return tempPuzzle
    End Function

    Shared Function MoveNumber(startPuzzle As PuzzleState, keepOutMap() As Boolean, number As Integer, toIndex As Integer, root As List(Of Integer)) As PuzzleState
        Dim rootMap(15) As Integer
        Dim fromIndex As Integer = startPuzzle.IndexOf(number)

        If MakeRoot(rootMap, keepOutMap, fromIndex, toIndex) = False Then
#If DEBUG Then
            Console.WriteLine("No Root {0:D} from {1:D} to {2:D}", number, fromIndex, toIndex)
#End If
            Return Nothing
        End If

        Dim tempPuzzle As PuzzleState = startPuzzle
        Dim c As Integer = rootMap(fromIndex) - 1

        Do While c > 0
            Dim mv As Integer = -1
            Dim nextIndex As Integer = fromIndex

            'Console.WriteLine("loop head of MN num={0:D} fromIndex={1:D}", number, fromIndex)
            'tempPuzzle.Print()

            If (fromIndex And 3) > 0 Then
                If rootMap(fromIndex - 1) = c Then
                    mv = MOVE_RIGHT ' number move is reverse space move
                    nextIndex = fromIndex - 1 ' number index. not space index.
                End If
            End If

            If (fromIndex And 3) < 3 Then
                If rootMap(fromIndex + 1) = c Then
                    mv = MOVE_LEFT
                    nextIndex = fromIndex + 1
                End If
            End If

            If fromIndex > 3 Then
                If rootMap(fromIndex - 4) = c Then
                    mv = MOVE_DOWN
                    nextIndex = fromIndex - 4
                End If
            End If

            If fromIndex < 12 Then
                If rootMap(fromIndex + 4) = c Then
                    mv = MOVE_UP
                    nextIndex = fromIndex + 4
                End If
            End If


            keepOutMap(fromIndex) = True
            tempPuzzle = MoveSpace(tempPuzzle, nextIndex, keepOutMap, root)
            keepOutMap(fromIndex) = False
            If tempPuzzle Is Nothing Then
#If DEBUG Then
                Console.WriteLine("cannot move space to {0:D}", nextIndex)
                Dim f2 As New PuzzleState(rootMap)
                f2.Print()
                Console.WriteLine("formIndex={0:D} c={1:D} mv={2:D}", fromIndex, c, mv)
#End If
                Return Nothing
            End If

            tempPuzzle = tempPuzzle.Move(mv)
            root.Add(tempPuzzle.NumberOf(nextIndex))
            fromIndex = nextIndex
            c -= 1
        Loop

        Return tempPuzzle
    End Function

    Shared Function FitVtRv(startPuzzle As PuzzleState, allRoots As Dictionary(Of ULong, List(Of RootState)), nextPuzzles As Dictionary(Of ULong, PuzzleState), number As Integer, Optional keepOutMask As ULong = 0UL) As Boolean
        Dim i As Integer = number - 1
        Return Fit(startPuzzle, allRoots, nextPuzzles, number + 4, number, i + 4, i, i + 3, i - 1, i + 2, i - 2, keepOutMask)
    End Function

    Shared Function FitVt(startPuzzle As PuzzleState, allRoots As Dictionary(Of ULong, List(Of RootState)), nextPuzzles As Dictionary(Of ULong, PuzzleState), number As Integer, Optional keepOutMask As ULong = 0UL) As Boolean
        Dim i As Integer = number - 1
        Return Fit(startPuzzle, allRoots, nextPuzzles, number, number + 4, i, i + 4, i + 1, i + 5, i + 2, i + 6, keepOutMask)
    End Function

    Shared Function FitHzRv(startPuzzle As PuzzleState, allRoots As Dictionary(Of ULong, List(Of RootState)), nextPuzzles As Dictionary(Of ULong, PuzzleState), number As Integer, Optional keepOutMask As ULong = 0UL) As Boolean
        Dim i As Integer = number - 1
        Return Fit(startPuzzle, allRoots, nextPuzzles, number + 1, number, i + 1, i, i - 3, i - 4, i - 7, i - 8, keepOutMask)
    End Function

    Shared Function FitHz(startPuzzle As PuzzleState, allRoots As Dictionary(Of ULong, List(Of RootState)), nextPuzzles As Dictionary(Of ULong, PuzzleState), number As Integer, Optional keepOutMask As ULong = 0UL) As Boolean
        Dim i As Integer = number - 1
        Return Fit(startPuzzle, allRoots, nextPuzzles, number, number + 1, i, i + 1, i + 4, i + 5, i + 8, i + 9, keepOutMask)
    End Function

    Shared Function Fit(startPuzzle As PuzzleState, allRoots As Dictionary(Of ULong, List(Of RootState)), nextPuzzles As Dictionary(Of ULong, PuzzleState), number As Integer, number2 As Integer, i1 As Integer, i2 As Integer, i3 As Integer, i4 As Integer, i5 As Integer, i6 As Integer, keepOutMask As ULong) As Boolean
        Dim keepOutMap() As Boolean = InitKeepOutMap(keepOutMask)
        Dim n1, n2, n3, n4 As Integer
        Dim root As New List(Of Integer)
        Dim tempPuzzle As PuzzleState = startPuzzle

        'Console.WriteLine("Call Fit! {0:D},{1:D}", number, number2)
        'startPuzzle.Print()
        'Console.WriteLine("{0:X}", keepOutMask)

        Do
            'Console.WriteLine("loop head of fit")
            'tempPuzzle.Print()

            n1 = tempPuzzle.NumberOf(i1)
            n2 = tempPuzzle.NumberOf(i2)
            n3 = tempPuzzle.NumberOf(i3)
            n4 = tempPuzzle.NumberOf(i4)

            If n1 = number Then
                If n2 = number2 Then
                    'Fin
                    ' 1 2
                    ' ? ?
                    If allRoots.ContainsKey(tempPuzzle.data) = False Then
                        allRoots.Item(tempPuzzle.data) = New List(Of RootState)
                    End If
                    allRoots.Item(tempPuzzle.data).Add(New RootState(tempPuzzle.data, startPuzzle.data, root))
                    nextPuzzles.Item(tempPuzzle.data) = tempPuzzle
                    Return True
                ElseIf n3 = number2 Then
                    'NG
                    ' 1 ?
                    ' 2 ?
                    'number2 to n5
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i5, root)

                ElseIf n4 = number2 Then
                    If n2 = 0 Then
                        'OK
                        ' 1 0
                        ' ? 2
                        'number2 to n2
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i2, root)
                    Else
                        'NG
                        ' 1 ?
                        ' ? 2
                        'number2 to n6
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i6, root)
                    End If
                Else
                    ' 1 ?
                    ' ? ?
                    'number to n2
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i2, root)
                End If

            ElseIf n2 = number Then
                If n1 = number2 Then
                    'NG
                    ' 2 1
                    ' ? ?
                    'number2 to n5
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i5, root)

                ElseIf n3 = number2 Then
                    If n1 = 0 Then
                        'NG
                        ' 0 1
                        ' 2 ?
                        'number2 to n6
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i6, root)
                    Else
                        'OK
                        ' ? 1
                        ' 2 ?
                        'number2 to n4
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i4, root)
                    End If
                ElseIf n4 = number2 Then
                    'OK
                    ' ? 1
                    ' ? 2
                    'lock number2 on n4
                    'number to n1
                    keepOutMap(i4) = True
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i1, root)
                    keepOutMap(i4) = False

                Else
                    ' ? 1 x
                    ' ? ? y
                    Dim ix As Integer = i2 + (i2 - i1)
                    Dim iy As Integer = ix + (i3 - i1)
                    'Console.WriteLine("ix={0:D} iy={1:D}", ix, iy)
                    Dim innerFlag As Boolean = True
                    If ix < 16 And (ix And 3) > (i2 And 3) Then
                        If tempPuzzle.NumberOf(ix) = 0 And iy < 16 Then
                            If tempPuzzle.NumberOf(iy) = number2 Then
                                ' ? 1 0
                                ' ? ? 2
                                tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, ix, root)
                                innerFlag = False
                            End If
                        ElseIf tempPuzzle.NumberOf(ix) = number2 Then
                            ' ? 1 2
                            ' ? ?
                            tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i1, root)
                            If Not tempPuzzle Is Nothing Then
                                tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i2, root)
                            End If
                            innerFlag = False
                        End If
                    End If
                    If innerFlag Then
                        ' lock number on n2
                        'number2 to n4
                        keepOutMap(i2) = True
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i4, root)
                        keepOutMap(i2) = False
                    End If
                End If

            ElseIf n3 = number Then
                If n1 = number2 Then
                    'OK
                    ' 2 ?
                    ' 1 ?
                    'lock number on n3
                    'number2 to n2
                    keepOutMap(i3) = True
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i2, root)
                    keepOutMap(i3) = False

                ElseIf n2 = number2 Then
                    If n1 = 0 Then
                        'OK
                        ' 0 2
                        ' 1 ?
                        'number to n1
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i1, root)
                    Else
                        'NG
                        ' ? 2
                        ' 1 ?
                        'number to n5
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i5, root)
                    End If
                ElseIf n4 = number2 Then
                    If n1 = 0 Then
                        'NG
                        ' 0 ?
                        ' 1 2
                        ' number2 to n6
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i6, root)
                    ElseIf n2 = 0 Then
                        'NG
                        ' ? 0
                        ' 1 2
                        ' number to n5
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i5, root)
                    Else
                        'OK
                        ' ? ?
                        ' 1 2
                        ' number to n5
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i5, root)
                    End If
                Else
                    ' ? ?
                    ' 1 ?
                    'number to n2
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i2, root)
                End If
            ElseIf n4 = number Then
                If n1 = number2 Then
                    If n2 = 0 Then
                        'NG
                        ' 2 0
                        ' ? 1
                        'number to n5
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i5, root)
                    Else
                        'OK
                        ' 2 ?
                        ' ? 1
                        'number to n3
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i3, root)
                    End If
                ElseIf n2 = number2 Then
                    'NG
                    ' ? 2
                    ' ? 1
                    'number to n6
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i6, root)

                ElseIf n3 = number2 Then
                    If n1 = 0 Then
                        'OK
                        ' 0 ?
                        ' 2 1
                        'number2 to n1
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i1, root)
                    ElseIf n2 = 0 Then
                        'OK
                        ' ? 0
                        ' 2 1
                        'number to n2
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i2, root)
                    Else
                        'NG
                        ' ? ?
                        ' 2 1
                        'number2 to n1
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i1, root)
                    End If

                Else
                    ' ? ?
                    ' ? 1
                    'number to n2
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i2, root)
                End If
            Else
                If n1 = number2 Then
                    ' 2 ?
                    ' ? ?
                    'lock number2 on n1
                    'number to n3
                    keepOutMap(i1) = True
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i3, root)
                    keepOutMap(i1) = False
                ElseIf n2 = number2 Or n3 = number2 Or n4 = number2 Then
                    ' ? 2
                    ' ? ?
                    'number2 to n1
                    ' ? ?
                    ' 2 ?
                    'number2 to n1
                    ' ? ?
                    ' ? 2
                    'number2 to n1
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i1, root)
                Else
                    'near number to each pos
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i2, root)
                End If
            End If
        Loop While Not tempPuzzle Is Nothing

#If DEBUG Then
        Console.WriteLine("unknown error?")
        Dim f1 As New Filter(keepOutMask)
        f1.Print()
        startPuzzle.Print()
#End If
        Return False
    End Function

    Class RootState
        Public ReadOnly data, parent As ULong, root As List(Of Integer)
        Sub New(data As ULong, parent As ULong, root As List(Of Integer))
            Me.data = data
            Me.parent = parent
            Me.root = root
        End Sub
    End Class

    Class PuzzleState
        Public Shared Function GetDifferenceOneNumber(data1 As ULong, data2 As ULong) As ULong
            Dim temp As ULong = data1 Xor data2
            For i As Integer = 0 To 15
                Dim value As ULong = (temp >> (60 - (i << 2))) And &HFUL
                If value <> 0UL Then
                    Return value
                End If
            Next i
            Return 0UL
        End Function
        Public Shared Function GetDifferenceOneNumber(puzzle1 As PuzzleState, puzzle2 As PuzzleState) As ULong
            Return GetDifferenceOneNumber(puzzle1.data, puzzle2.data)
        End Function

        Public Shared Function GetNumber(data As ULong, index As Integer) As Integer
            Return (data >> (60 - ((index And &HF%) << 2))) And &HFUL
        End Function

        Public Shared Function GetNumber(data As ULong, x As Integer, y As Integer) As Integer
            Return GetNumber(data, ((y And &H3%) << 2) Or (x And &H3%))
        End Function

        Public ReadOnly data, zero As ULong

        Sub New(Optional data As ULong = &H123456789ABCDEF0UL)
            Me.data = data
            zero = &HFUL
            For i As Integer = 0 To 15
                If (data And zero) = 0UL Then
                    Exit For
                End If
                zero <<= 4
            Next i
        End Sub

        Sub New(array() As Integer)
            data = 0UL
            For i As Integer = 0 To 15
                Dim v As ULong = array(i) And &HF%
                data = data Or (v << (60 - (i << 2)))
                If v = 0UL Then
                    zero = &HFUL << (60 - (i << 2))
                End If
            Next i
        End Sub

        Sub New(array(,) As Integer)
            Dim sh As Integer = 60
            data = 0UL
            For i As Integer = 0 To 3
                For j As Integer = 0 To 3
                    Dim v As ULong = array(i, j) And &HF%
                    data = data Or (v << sh)
                    If v = 0UL Then
                        zero = &HFUL << sh
                    End If
                    sh -= 4
                Next j
            Next i
        End Sub

        Private Sub New(data As ULong, zero As ULong)
            Me.data = data
            Me.zero = zero
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
                Return New PuzzleState((data Or ((data >> 4) And zero)) And (Not (zero << 4)), zero << 4)
            Else
                Return Me
            End If
        End Function

        Public Function MoveRight() As PuzzleState
            If (zero And &HF000F000F000FUL) = 0UL Then
                Return New PuzzleState((data Or ((data << 4) And zero)) And (Not (zero >> 4)), zero >> 4)
            Else
                Return Me
            End If
        End Function

        Public Function MoveUp() As PuzzleState
            If (zero And &HFFFF000000000000UL) = 0UL Then
                Return New PuzzleState((data Or ((data >> 16) And zero)) And (Not (zero << 16)), zero << 16)
            Else
                Return Me
            End If
        End Function

        Public Function MoveDown() As PuzzleState
            If (zero And &HFFFFUL) = 0UL Then
                Return New PuzzleState((data Or ((data << 16) And zero)) And (Not (zero >> 16)), zero >> 16)
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

        Public Function MoveNumber(num As ULong) As PuzzleState
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

        Public Function Shuffle(Optional count As Integer = 10, Optional show As Boolean = False) As PuzzleState
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
                    If show Then
                        Console.WriteLine(GetDifferenceOneNumber(temp2.data, temp.data))
                    End If
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
