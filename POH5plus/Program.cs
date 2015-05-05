// 15 puzzle solver
// 2015-05-05
// Leonardone @ NEETSDKASU
using System;
using System.Collections.Generic;

public class compiler {

    static readonly Filter filter0x0 = new Filter(new int[,] {{1, 1, 1, 1}, {1, 1, 1, 1}, {1, 1, 1, 1}, {1, 1, 1, 1}});
    static readonly Filter filter2x2 = new Filter(new int[,]{{1, 1, 1, 1}, {1, 1, 1, 1}, {1, 1, 0, 0}, {1, 1, 0, 0}});
    static readonly Filter filter2x3 = new Filter(new int[,]{{1, 1, 1, 1}, {1, 1, 0, 0}, {1, 1, 0, 0}, {1, 1, 0, 0}});
    static readonly Filter filter2x4 = new Filter(new int[,]{{1, 1, 0, 0}, {1, 1, 0, 0}, {1, 1, 0, 0}, {1, 1, 0, 0}});
    static readonly Filter filter3x2 = new Filter(new int[,]{{1, 1, 1, 1}, {1, 1, 1, 1}, {1, 0, 0, 0}, {1, 0, 0, 0}});
    static readonly Filter filter3x3 = new Filter(new int[,]{{1, 1, 1, 1}, {1, 0, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}});
    static readonly Filter filter3x4 = new Filter(new int[,]{{1, 0, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}});
    static readonly Filter filter4x2 = new Filter(new int[,]{{1, 1, 1, 1}, {1, 1, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}});
    static readonly Filter filter4x3 = new Filter(new int[,]{{1, 1, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}});

    static readonly Filter filter3x3m1LT = new Filter(new int[,]{{1, 1, 1, 1}, {1, 1, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}});
    static readonly Filter filter3x3m1RT = new Filter(new int[,]{{1, 1, 1, 1}, {1, 0, 0, 1}, {1, 0, 0, 0}, {1, 0, 0, 0}});
    static readonly Filter filter3x3m1LB = new Filter(new int[,]{{1, 1, 1, 1}, {1, 0, 0, 0}, {1, 0, 0, 0}, {1, 1, 0, 0}});

    static readonly Filter filter3x4m2LT = new Filter(new int[,]{{1, 1, 0, 0}, {1, 1, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}});
    static readonly Filter filter3x4m2RT = new Filter(new int[,]{{1, 0, 0, 1}, {1, 0, 0, 1}, {1, 0, 0, 0}, {1, 0, 0, 0}});
    static readonly Filter filter3x4m2LB = new Filter(new int[,]{{1, 0, 0, 0}, {1, 0, 0, 0}, {1, 1, 0, 0}, {1, 1, 0, 0}});

    static readonly Filter filter3x4m1LT = new Filter(new int[,]{{1, 1, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}});
    static readonly Filter filter3x4m1RT = new Filter(new int[,]{{1, 0, 0, 1}, {1, 0, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}});
    static readonly Filter filter3x4m1LB = new Filter(new int[,]{{1, 0, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}, {1, 1, 0, 0}});

    static readonly Filter filter4x3m2LT = new Filter(new int[,]{{1, 1, 1, 1}, {1, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}});
    static readonly Filter filter4x3m2RT = new Filter(new int[,]{{1, 1, 1, 1}, {0, 0, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}});
    static readonly Filter filter4x3m2LB = new Filter(new int[,]{{1, 1, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}, {1, 1, 0, 0}});

    static readonly Filter filter4x3m1LT = new Filter(new int[,]{{1, 1, 1, 1}, {1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}});
    static readonly Filter filter4x3m1RT = new Filter(new int[,]{{1, 1, 1, 1}, {0, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}});
    static readonly Filter filter4x3m1LB = new Filter(new int[,]{{1, 1, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}, {1, 0, 0, 0}});

    static readonly Filter filterBxLT = new Filter(new int[,]{{1, 1, 0, 0}, {1, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}});
    static readonly Filter filterBxRT = new Filter(new int[,]{{0, 0, 1, 1}, {0, 0, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}});
    static readonly Filter filterBxLB = new Filter(new int[,]{{0, 0, 0, 0}, {0, 0, 0, 0}, {1, 1, 0, 0}, {1, 1, 0, 0}});

    static readonly Filter filterHzLT = new Filter(new int[,]{{1, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}});
    static readonly Filter filterHzRT = new Filter(new int[,]{{0, 0, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}});
    static readonly Filter filterHzLB = new Filter(new int[,]{{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {1, 1, 0, 0}});

    static readonly Filter filterVtLT = new Filter(new int[,]{{1, 0, 0, 0}, {1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}});
    static readonly Filter filterVtRT = new Filter(new int[,]{{0, 0, 0, 1}, {0, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}});
    static readonly Filter filterVtLB = new Filter(new int[,]{{0, 0, 0, 0}, {0, 0, 0, 0}, {1, 0, 0, 0}, {1, 0, 0, 0}});

    static readonly Filter filter2VtTT = new Filter(new int[,]{{1, 0, 0, 1}, {1, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}});
    static readonly Filter filter2VtBT = new Filter(new int[,]{{0, 0, 0, 1}, {0, 0, 0, 1}, {1, 0, 0, 0}, {1, 0, 0, 0}});

    static readonly Filter filter2HzLL = new Filter(new int[,]{{1, 1, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {1, 1, 0, 0}});
    static readonly Filter filter2HzRL = new Filter(new int[,]{{0, 0, 1, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}, {1, 1, 0, 0}});

    static readonly Filter filter1 = new Filter(new int[,]{{1, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}});
    static readonly Filter filter4 = new Filter(new int[,]{{0, 0, 0, 1}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}});
    static readonly Filter filter13 = new Filter(new int[,]{{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {1, 0, 0, 0}});

    static readonly List<Filter> filters = new List<Filter>(new Filter[] {filter0x0, filter2x2, filter2x3, filter3x2, filter3x3, filter3x4, filter4x3, 
                                                                      filter2x4, filter4x2, filter2HzLL, filter2HzRL, filter2VtBT, filter2VtTT, 
                                                                      filter3x3m1LB, filter3x3m1LT, filter3x3m1RT, filterBxLB, filterBxLT, filterBxRT, 
                                                                      filter3x4m1LB, filter3x4m1LT, filter3x4m1RT, filter3x4m2LB, filter3x4m2LT, filter3x4m2RT, 
                                                                      filter4x3m1LB, filter4x3m1LT, filter4x3m1RT, filter4x3m2LB, filter4x3m2LT, filter4x3m2RT, 
                                                                      filterHzLB, filterHzLT, filterHzRT, filterVtLB, filterVtLT, filterVtRT});


    const int DEFAULT_DEPTH = 12;
    const int MOVE_LEFT =  0;
    const int MOVE_RIGHT  = 1;
    const int MOVE_UP =  2;
    const int MOVE_DOWN = 3;

    public static int Main() {

        PuzzleState problem;

#if DEBUG
#if MAKE_BY_RANDOM 
        problem = new PuzzleState().Shuffle(1000);
#else
        problem = new PuzzleState(new int[,]{{1, 6, 2, 4}, {9, 10, 3, 7}, {12, 15, 14, 11}, {0, 13, 5, 8}});
#endif
        problem.Print();
#else
        problem = InputPuzzle();
#endif

        Dictionary<ulong, List<RootState>> allRoots = new Dictionary<ulong, List<RootState>>();

        Dictionary<ulong, PuzzleState> currentPuzzles = new Dictionary<ulong, PuzzleState>();
        Dictionary<ulong, PuzzleState> nextPuzzles = new Dictionary<ulong, PuzzleState>();
        Dictionary<ulong, PuzzleState> tempSwapPuzzles;

        allRoots[problem.data] = new List<RootState>();
        allRoots[problem.data].Add(new RootState(problem.data, 0UL, null));
        currentPuzzles[problem.data] = problem;


        while (currentPuzzles.Count > 0) {

            nextPuzzles.Clear();

#if DEBUG
            Console.WriteLine("puzzles: {0:D}", currentPuzzles.Count);
#endif

            foreach (PuzzleState puzzle in currentPuzzles.Values) {

                if (filter0x0.Match(puzzle)) {
                    continue;
                }

                MakeAllMovables(puzzle);

                if (CheckAllMovableRoot(puzzle, filter0x0, allRoots, nextPuzzles)) {
                    continue;
                }

                if (CheckAllMovableRoot(puzzle, filter2x2, allRoots, nextPuzzles)) {
                    continue;
                }

                if (filter2x2.Match(puzzle)) {
                    //2x2
                    // 1  2  3  4
                    // 5  6  7  8
                    // 9 10  ?  ?
                    //13 14  ?  ?
                    Console.WriteLine("maybe not come here");
                    continue;
                }

                if (filter2x4.Match(puzzle)) {
                    // 1  2  ?  ?
                    // 5  6  ?  ?
                    // 9 10  ?  ?
                    //13 14  ?  ?
                    if (filter2x3.Match(puzzle)) {
                        // 1  2  3  4
                        // 5  6  ?  ?
                        // 9 10  ?  ?
                        //13 14  ?  ?
                        SearchAll(puzzle, filter2x2, allRoots, nextPuzzles, filter2x3.mask, 16);
                        continue;
                    }
                    if (SearchAll(puzzle, filter2x3, allRoots, nextPuzzles, filter2x4.mask, 14) == false) {
                        // + manual search
                        FitHz(puzzle, allRoots, nextPuzzles, 3, filter2x4.mask);
                    }

                } else if (filter4x2.Match(puzzle)) {
                    // 1  2  3  4
                    // 5  6  7  8
                    // ?  ?  ?  ?
                    // ?  ?  ?  ?
                    if (filter3x2.Match(puzzle)) {
                        // 1  2  3  4
                        // 5  6  7  8
                        // 9  ?  ?  ?
                        //13  ?  ?  ?
                        SearchAll(puzzle, filter2x2, allRoots, nextPuzzles, filter3x2.mask, 16);
                        continue;
                    }
                    if (SearchAll(puzzle, filter2x3, allRoots, nextPuzzles, filter4x2.mask, 14) == false) {
                        // + manual search
                        FitVt(puzzle, allRoots, nextPuzzles, 9, filter4x2.mask);
                    }

                } else if (filter3x3.Match(puzzle)) {
                    // 1  2  3  4
                    // 5  ?  ?  ?
                    // 9  ?  ?  ?
                    //13  ?  ?  ?
                    CheckAllMovableRoot(puzzle, filter2x3, allRoots, nextPuzzles);
                    CheckAllMovableRoot(puzzle, filter3x2, allRoots, nextPuzzles);
                    if (filter3x3m1LT.Match(puzzle)) {
                        // 1  2  3  4
                        // 5  6  ?  ?
                        // 9  ?  ?  ?
                        //13  ?  ?  ?
                        // + manual search
                        FitHz(puzzle, allRoots, nextPuzzles, 7, filter3x3m1LT.mask);
                        FitVt(puzzle, allRoots, nextPuzzles, 10, filter3x3m1LT.mask);
                        continue;
                    }
                    if (filter3x3m1RT.Match(puzzle)) {
                        // 1  2  3  4
                        // 5  ?  ?  8
                        // 9  ?  ?  ?
                        //13  ?  ?  ?
                        // + manual search
                        FitHz(puzzle, allRoots, nextPuzzles, 6, filter3x3m1RT.mask);
                        continue;
                    }
                    if (filter3x3m1LB.Match(puzzle)) {
                        // 1  2  3  4
                        // 5  ?  ?  ?
                        // 9  ?  ?  ?
                        //13 14  ?  ?
                        // + manual search
                        FitVt(puzzle, allRoots, nextPuzzles, 6, filter3x3m1LB.mask);
                        continue;
                    }
                    // + manual search
                    FitHz(puzzle, allRoots, nextPuzzles, 7, filter3x3.mask);
                    FitVt(puzzle, allRoots, nextPuzzles, 10, filter3x3.mask);
                    FitHz(puzzle, allRoots, nextPuzzles, 6, filter3x3.mask);
                    FitVt(puzzle, allRoots, nextPuzzles, 6, filter3x3.mask);

                }else if (filter3x4.Match(puzzle)) {
                    // 1  ?  ?  ?
                    // 5  ?  ?  ?
                    // 9  ?  ?  ?
                    //13  ?  ?  ?
                    if (filter3x4m2LT.Match(puzzle)) {
                        // 1  2  ?  ?
                        // 5  6  ?  ?
                        // 9  ?  ?  ?
                        //13  ?  ?  ?
                        if (CheckAllMovableRoot(puzzle, filter3x3m1LT, allRoots, nextPuzzles) == false) {
                            FitHz(puzzle, allRoots, nextPuzzles, 3, filter3x4m2LT.mask);
                        }
                        if (CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) == false) {
                            FitVt(puzzle, allRoots, nextPuzzles, 10, filter3x4m2LT.mask);
                        }
                        continue;
                    }
                    if (filter3x4m2LB.Match(puzzle)) {
                        // 1  ?  ?  ?
                        // 5  ?  ?  ?
                        // 9 10  ?  ?
                        //13 14  ?  ?
                        if (CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) == false) {
                            FitVt(puzzle, allRoots, nextPuzzles, 2, filter3x4m2LB.mask);
                        }
                        continue;
                    }
                    if (filter3x4m2RT.Match(puzzle)) {
                        // 1  ?  ?  4
                        // 5  ?  ?  8
                        // 9  ?  ?  ?
                        //13  ?  ?  ?
                        CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles);
                        if (CheckAllMovableRoot(puzzle, filter3x3m1RT, allRoots, nextPuzzles) == false) {
                            FitHz(puzzle, allRoots, nextPuzzles, 2, filter3x4m2RT.mask);
                        }
                        continue;
                    }
                    if (filter3x4m1LT.Match(puzzle)) {
                        // 1  2  ?  ?
                        // 5  ?  ?  ?
                        // 9  ?  ?  ?
                        //13  ?  ?  ?
                        if (CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles) == false) {
                            FitHz(puzzle, allRoots, nextPuzzles, 3, filter3x4m1LT.mask);
                        }
                        if (CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) == false) {
                            CheckAllMovableRoot(puzzle, filter3x4m2LT, allRoots, nextPuzzles);
                            CheckAllMovableRoot(puzzle, filter3x4m2LB, allRoots, nextPuzzles);
                        }
                        FitVt(puzzle, allRoots, nextPuzzles, 2, filter3x4.mask);
                        FitVt(puzzle, allRoots, nextPuzzles, 10, filter3x4.mask);
                        continue;
                    }
                    if (filter3x4m1RT.Match(puzzle)) {
                        // 1  ?  ?  4
                        // 5  ?  ?  ?
                        // 9  ?  ?  ?
                        //13  ?  ?  ?
                        if (CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles) == false) {
                            FitHz(puzzle, allRoots, nextPuzzles, 2, filter3x4m1RT.mask);
                        }
                        if (CheckAllMovableRoot(puzzle, filter3x4m2LT, allRoots, nextPuzzles) == false) {
                            FitVt(puzzle, allRoots, nextPuzzles, 2, filter3x4.mask);
                        }
                        if (CheckAllMovableRoot(puzzle, filter3x4m2RT, allRoots, nextPuzzles) == false) {
                            FitVt(puzzle, allRoots, nextPuzzles, 10, filter3x4.mask);
                        }
                        FitHz(puzzle, allRoots, nextPuzzles, 2, filter3x4.mask);
                        continue;
                    }
                    if (filter3x4m1LB.Match(puzzle)) {
                        // 1  ?  ?  ?
                        // 5  ?  ?  ?
                        // 9  ?  ?  ?
                        //13 14  ?  ?
                        if (CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) == false) {
                            if (CheckAllMovableRoot(puzzle, filter3x4m2LB, allRoots, nextPuzzles) == false) {
                                FitVt(puzzle, allRoots, nextPuzzles, 2, filter3x4.mask);
                            }
                            if ( CheckAllMovableRoot(puzzle, filter3x4m2LT, allRoots, nextPuzzles) == false) {
                                FitVt(puzzle, allRoots, nextPuzzles, 10, filter3x4.mask);
                            }
                        }
                        continue;
                    }
                    CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles);
                    if (CheckAllMovableRoot(puzzle, filter3x4m2RT, allRoots, nextPuzzles) == false) {
                        FitVtRv(puzzle, allRoots, nextPuzzles, 4, filter3x4.mask);
                    }
                    if (CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) == false) {
                        if (CheckAllMovableRoot(puzzle, filter3x4m2LT, allRoots, nextPuzzles) == false) {
                            FitVt(puzzle, allRoots, nextPuzzles, 2, filter3x4.mask);
                        }
                        if (CheckAllMovableRoot(puzzle, filter3x4m2LB, allRoots, nextPuzzles) == false) {
                            FitVt(puzzle, allRoots, nextPuzzles, 10, filter3x4.mask);
                        }
                    }

                }else if (filter4x3.Match(puzzle) ){
                    // 1  2  3  4
                    // ?  ?  ?  ?
                    // ?  ?  ?  ?
                    // ?  ?  ?  ?
                    if( filter4x3m2LT.Match(puzzle) ){
                        // 1  2  3  4
                        // 5  6  ?  ?
                        // ?  ?  ?  ?
                        // ?  ?  ?  ?
                        if (CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) == false) {
                            FitHz(puzzle, allRoots, nextPuzzles, 7, filter4x3m2LT.mask);
                        }
                        if (CheckAllMovableRoot(puzzle, filter3x3m1LT, allRoots, nextPuzzles) == false) {
                            if( CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles) == false) {
                                FitVt(puzzle, allRoots, nextPuzzles, 9, filter4x3m2LT.mask);
                            }
                        }
                        continue;
                    }
                    if (filter4x3m2RT.Match(puzzle)) {
                        // 1  2  3  4
                        // ?  ?  7  8
                        // ?  ?  ?  ?
                        // ?  ?  ?  ?
                        if( CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) == false) {
                            FitHz(puzzle, allRoots, nextPuzzles, 5, filter4x3m2RT.mask);
                        }
                        continue;
                    }
                    if (filter4x3m2LB.Match(puzzle)) {
                        // 1  2  3  4
                        // ?  ?  ?  ? 
                        // ?  ?  ?  ?
                        //13 14  ?  ?
                        if( CheckAllMovableRoot(puzzle, filter2x3, allRoots, nextPuzzles) == false) {
                            if( CheckAllMovableRoot(puzzle, filter3x3m1LB, allRoots, nextPuzzles) == false) {
                                if( CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles) == false){
                                    FitVt(puzzle, allRoots, nextPuzzles, 5, filter4x3m2LB.mask);
                                }
                            }
                        }
                        continue;
                    }
                    if( filter4x3m1LT.Match(puzzle) ){
                        // 1  2  3  4
                        // 5  ?  ?  ?
                        // ?  ?  ?  ?
                        // ?  ?  ?  ?
                        if( CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) == false){
                            CheckAllMovableRoot(puzzle, filter4x3m2LT, allRoots, nextPuzzles);
                        }
                        CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles);
                        FitVt(puzzle, allRoots, nextPuzzles, 9, filter4x3m1LT.mask);
                        continue;
                    }
                    if( filter4x3m1RT.Match(puzzle) ){
                        // 1  2  3  4
                        // ?  ?  ?  8
                        // ?  ?  ?  ?
                        // ?  ?  ?  ?
                        if( CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) == false){
                            CheckAllMovableRoot(puzzle, filter4x3m2LT, allRoots, nextPuzzles);
                            CheckAllMovableRoot(puzzle, filter4x3m2RT, allRoots, nextPuzzles);
                        }
                        FitHz(puzzle, allRoots, nextPuzzles, 5, filter4x3.mask);
                        FitHz(puzzle, allRoots, nextPuzzles, 7, filter4x3.mask);
                        continue;
                    }
                    if( filter4x3m1LB.Match(puzzle) ){
                        // 1  2  3  4
                        // ?  ?  ?  ?
                        // ?  ?  ?  ?
                        //13  ?  ?  ?
                        CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles);
                        FitVt(puzzle, allRoots, nextPuzzles, 5, filter4x3m1LB.mask);
                        continue;
                    }
                    if( CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) == false){
                        CheckAllMovableRoot(puzzle, filter4x3m2LT, allRoots, nextPuzzles);
                        CheckAllMovableRoot(puzzle, filter4x3m2RT, allRoots, nextPuzzles);
                    }
                    CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles);
                    //+ manual search
                    FitHz(puzzle, allRoots, nextPuzzles, 5, filter4x3.mask);
                    FitHz(puzzle, allRoots, nextPuzzles, 7, filter4x3.mask);
                    FitHzRv(puzzle, allRoots, nextPuzzles, 13, filter4x3.mask);

                }else if (filterBxLT.Match(puzzle)) {
                    // 1  2  ?  ?
                    // 5  6  ?  ?
                    // ?  ?  ?  ?
                    // ?  ?  ?  ?
                    if (CheckAllMovableRoot(puzzle, filter3x3m1LT, allRoots, nextPuzzles) == false) {
                        CheckAllMovableRoot(puzzle, filter3x3, allRoots, nextPuzzles);
                    }
                    if( CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) == false) {
                        if( CheckAllMovableRoot(puzzle, filter3x4m2LT, allRoots, nextPuzzles) == false) {
                            if( CheckAllMovableRoot(puzzle, filter3x4m1LT, allRoots, nextPuzzles) == false) {
                                CheckAllMovableRoot(puzzle, filter3x4, allRoots, nextPuzzles);
                            }
                        }
                    }
                    if( CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) == false) {
                        if( CheckAllMovableRoot(puzzle, filter4x3m2LT, allRoots, nextPuzzles) ){
                            if (CheckAllMovableRoot(puzzle, filter4x3m1LT, allRoots, nextPuzzles) == false) {
                                CheckAllMovableRoot(puzzle, filter4x3, allRoots, nextPuzzles);
                            }
                        }
                    }
                    FitHz(puzzle, allRoots, nextPuzzles, 3, filterBxLT.mask);
                    FitVt(puzzle, allRoots, nextPuzzles, 9, filterBxLT.mask);

                }else if( filterBxRT.Match(puzzle) ){
                    // ?  ?  3  4
                    // ?  ?  7  8
                    // ?  ?  ?  ?
                    // ?  ?  ?  ?
                    if( CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) == false) {
                        if( CheckAllMovableRoot(puzzle, filter4x3m2RT, allRoots, nextPuzzles) == false) {
                            if( CheckAllMovableRoot(puzzle, filter4x3m1RT, allRoots, nextPuzzles) == false) {
                                CheckAllMovableRoot(puzzle, filter4x3, allRoots, nextPuzzles);
                            }
                        }
                    }
                    FitHz(puzzle, allRoots, nextPuzzles, 1, filterBxRT.mask);

                }else if( filterBxLB.Match(puzzle) ){
                    // ?  ?  ?  ?
                    // ?  ?  ?  ?
                    // 9 10  ?  ?
                    //13 14  ?  ?
                    if (CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) == false) {
                        if( CheckAllMovableRoot(puzzle, filter3x4m2LB, allRoots, nextPuzzles) == false) {
                            if( CheckAllMovableRoot(puzzle, filter3x4m1LB, allRoots, nextPuzzles) == false) {
                                CheckAllMovableRoot(puzzle, filter3x4, allRoots, nextPuzzles);
                            }
                        }
                    }
                    FitVt(puzzle, allRoots, nextPuzzles, 1, filterBxLB.mask);

                }else if( filter2VtTT.Match(puzzle) ){
                    // 1  ?  ?  4
                    // 5  ?  ?  8
                    // ?  ?  ?  ?
                    // ?  ?  ?  ?
                    if (CheckAllMovableRoot(puzzle, filter4x2, allRoots, nextPuzzles) == false) {
                        if( CheckAllMovableRoot(puzzle, filter4x3m2LT, allRoots, nextPuzzles) == false) {
                            CheckAllMovableRoot(puzzle, filter4x3m1LT, allRoots, nextPuzzles);
                        }
                        if (CheckAllMovableRoot(puzzle, filter4x3m2RT, allRoots, nextPuzzles) == false) {
                            CheckAllMovableRoot(puzzle, filter4x3m1RT, allRoots, nextPuzzles);
                        }
                        FitHz(puzzle, allRoots, nextPuzzles, 2, filter2VtTT.mask);
                    }
                    if ( CheckAllMovableRoot(puzzle, filter3x4, allRoots, nextPuzzles) == false) {
                        FitVt(puzzle, allRoots, nextPuzzles, 9, filterVtLT.mask);
                    }

                }else if( filter2VtBT.Match(puzzle)) {
                    // ?  ?  ?  4
                    // ?  ?  ?  8
                    // 9  ?  ?  ?
                    //13  ?  ?  ?
                    if( CheckAllMovableRoot(puzzle, filter3x4, allRoots, nextPuzzles) == false) {
                        FitVt(puzzle, allRoots, nextPuzzles, 1, filterVtLB.mask);
                    }
                    if (CheckAllMovableRoot(puzzle, filterBxLB, allRoots, nextPuzzles) == false) {
                        FitVt(puzzle, allRoots, nextPuzzles, 10, filterVtLB.mask);
                    }
                    if (CheckAllMovableRoot(puzzle, filterBxRT, allRoots, nextPuzzles) == false) {
                        FitVtRv(puzzle, allRoots, nextPuzzles, 3, filterVtRT.mask);
                    }

                }else if( filter2HzRL.Match(puzzle) ){
                    // ?  ?  3  4
                    // ?  ?  ?  ?
                    // ?  ?  ?  ?
                    //13 14  ?  ?
                    if (CheckAllMovableRoot(puzzle, filter4x3, allRoots, nextPuzzles) == false) {
                        FitHz(puzzle, allRoots, nextPuzzles, 1, filterHzRT.mask);
                    }
                    if (CheckAllMovableRoot(puzzle, filterBxLB, allRoots, nextPuzzles) == false) {
                        FitHzRv(puzzle, allRoots, nextPuzzles, 9, filterHzLB.mask);
                    }
                    if (CheckAllMovableRoot(puzzle, filterBxRT, allRoots, nextPuzzles) == false) {
                        FitHz(puzzle, allRoots, nextPuzzles, 7, filterHzRT.mask);
                    }

                }else if (filter2HzLL.Match(puzzle) ){
                    // 1  2  ?  ?
                    // ?  ?  ?  ?
                    // ?  ?  ?  ?
                    //13 14  ?  ?
                    if( CheckAllMovableRoot(puzzle, filter2x4, allRoots, nextPuzzles) == false) {
                        CheckAllMovableRoot(puzzle, filter3x4m1LT, allRoots, nextPuzzles);
                        CheckAllMovableRoot(puzzle, filter3x4m1LB, allRoots, nextPuzzles);
                        if (CheckAllMovableRoot(puzzle, filter3x4, allRoots, nextPuzzles) == false) {
                            FitVt(puzzle, allRoots, nextPuzzles, 5, filter2HzLL.mask);
                            FitHz(puzzle, allRoots, nextPuzzles, 3, filter2HzLL.mask);
                        }
                    }
                    CheckAllMovableRoot(puzzle, filterBxLT, allRoots, nextPuzzles);
                    CheckAllMovableRoot(puzzle, filterBxLB, allRoots, nextPuzzles);

                }else{

                    if (filter1.Match(puzzle)) {
                        if (filterVtLT.Match(puzzle)) {
                            // 1  ?  ?  ?
                            // 5  ?  ?  ?
                            // ?  ?  ?  ?
                            // ?  ?  ?  ?
                            if( CheckAllMovableRoot(puzzle, filterBxLT, allRoots, nextPuzzles) == false) {
                                FitVt(puzzle, allRoots, nextPuzzles, 2, filterVtLT.mask);
                            }
                            if (CheckAllMovableRoot(puzzle, filter3x4, allRoots, nextPuzzles) == false) {
                                FitVt(puzzle, allRoots, nextPuzzles, 9, filterVtLT.mask);
                            }
                            if (CheckAllMovableRoot(puzzle, filter2VtTT, allRoots, nextPuzzles) == false) {
                                FitVtRv(puzzle, allRoots, nextPuzzles, 4, filterVtLT.mask);
                            }
                            continue;
                        }

                        if (filterHzLT.Match(puzzle)) {
                            // 1  2  ?  ?
                            // ?  ?  ?  ?
                            // ?  ?  ?  ?
                            // ?  ?  ?  ?
                            if( CheckAllMovableRoot(puzzle, filterBxLT, allRoots, nextPuzzles) == false) {
                                FitHz(puzzle, allRoots, nextPuzzles, 5, filterHzLT.mask);
                            }
                            if( CheckAllMovableRoot(puzzle, filter4x3, allRoots, nextPuzzles) == false) {
                                FitHz(puzzle, allRoots, nextPuzzles, 3, filterHzLT.mask);
                            }
                            if( CheckAllMovableRoot(puzzle, filter2HzLL, allRoots, nextPuzzles) == false) {
                                FitHzRv(puzzle, allRoots, nextPuzzles, 13, filterHzLT.mask);
                            }
                            continue;
                        }

                    }

                    if (filter4.Match(puzzle) ){

                        if (filterVtRT.Match(puzzle) ){
                            // ?  ?  ?  4 
                            // ?  ?  ?  8
                            // ?  ?  ?  ?
                            // ?  ?  ?  ?
                            if( CheckAllMovableRoot(puzzle, filterBxRT, allRoots, nextPuzzles) == false) {
                                FitVtRv(puzzle, allRoots, nextPuzzles, 3, filterVtRT.mask);
                            }
                            if (CheckAllMovableRoot(puzzle, filter2VtBT, allRoots, nextPuzzles) == false) {
                                FitVt(puzzle, allRoots, nextPuzzles, 9, filterVtRT.mask);
                            }
                            if (CheckAllMovableRoot(puzzle, filter2VtTT, allRoots, nextPuzzles) == false) {
                                FitVt(puzzle, allRoots, nextPuzzles, 1, filterVtRT.mask);
                            }
                            continue;
                        }

                        if( filterHzRT.Match(puzzle) ){
                            // ?  ?  3  4
                            // ?  ?  ?  ?
                            // ?  ?  ?  ?
                            // ?  ?  ?  ?
                            if( CheckAllMovableRoot(puzzle, filterBxRT, allRoots, nextPuzzles) == false) {
                                FitHz(puzzle, allRoots, nextPuzzles, 7, filterHzRT.mask);
                            }
                            if( CheckAllMovableRoot(puzzle, filter4x3, allRoots, nextPuzzles) == false) {
                                FitHz(puzzle, allRoots, nextPuzzles, 1, filterHzRT.mask);
                            }
                            if (CheckAllMovableRoot(puzzle, filter2HzRL, allRoots, nextPuzzles) == false) {
                                FitHzRv(puzzle, allRoots, nextPuzzles, 13, filterHzRT.mask);
                            }
                            continue;
                        }
                    }

                    if( filter13.Match(puzzle) ){

                        if( filterHzLB.Match(puzzle) ){
                            // ?  ?  ?  ?
                            // ?  ?  ?  ?
                            // ?  ?  ?  ?
                            //13 14  ?  ?
                            if( CheckAllMovableRoot(puzzle, filterBxLB, allRoots, nextPuzzles) == false) {
                                FitHzRv(puzzle, allRoots, nextPuzzles, 9, filterHzLB.mask);
                            }
                            if (CheckAllMovableRoot(puzzle, filter2HzLL, allRoots, nextPuzzles) == false) {
                                FitHz(puzzle, allRoots, nextPuzzles, 1, filterHzLB.mask);
                            }
                            if (CheckAllMovableRoot(puzzle, filter2HzRL, allRoots, nextPuzzles) == false) {
                                FitHz(puzzle, allRoots, nextPuzzles, 3, filterHzLB.mask);
                            }
                            continue;
                        }

                        if( filterVtLB.Match(puzzle) ){
                            // ?  ?  ?  ?
                            // ?  ?  ?  ?
                            // 9  ?  ?  ?
                            //13  ?  ?  ?
                            if( CheckAllMovableRoot(puzzle, filterBxLB, allRoots, nextPuzzles) == false) {
                                FitVt(puzzle, allRoots, nextPuzzles, 10, filterVtLB.mask);
                            }
                            if (CheckAllMovableRoot(puzzle, filter3x4, allRoots, nextPuzzles) == false) {
                                FitVt(puzzle, allRoots, nextPuzzles, 1, filterVtLB.mask);
                            }
                            if (CheckAllMovableRoot(puzzle, filter2VtBT, allRoots, nextPuzzles) == false) {
                                FitVtRv(puzzle, allRoots, nextPuzzles, 4, filterVtLB.mask);
                            }
                            continue;
                        }
                    }

                    if( CheckAllMovableRoot(puzzle, filterHzLT, allRoots, nextPuzzles) == false) {
                        FitHz(puzzle, allRoots, nextPuzzles, 1);
                    }

                    if (CheckAllMovableRoot(puzzle, filterVtLT, allRoots, nextPuzzles) == false) {
                        FitVt(puzzle, allRoots, nextPuzzles, 1);
                    }

                    if (CheckAllMovableRoot(puzzle, filterHzRT, allRoots, nextPuzzles) == false) {
                        FitHz(puzzle, allRoots, nextPuzzles, 3);
                    }

                    if (CheckAllMovableRoot(puzzle, filterHzLB, allRoots, nextPuzzles) == false) {
                        FitHzRv(puzzle, allRoots, nextPuzzles, 13);
                    }

                    if (CheckAllMovableRoot(puzzle, filterVtRT, allRoots, nextPuzzles) == false) {
                        FitVtRv(puzzle, allRoots, nextPuzzles, 4);
                    }

                    if (CheckAllMovableRoot(puzzle, filterVtLB, allRoots, nextPuzzles) == false) {
                        FitVt(puzzle, allRoots, nextPuzzles, 9);
                    }

                }

            }

            tempSwapPuzzles = currentPuzzles;
            currentPuzzles = nextPuzzles;
            nextPuzzles = tempSwapPuzzles;

        }

        Dictionary<ulong, List<int>> currentRoots = new Dictionary<ulong, List<int>>();
        Dictionary<ulong, List<int>> nextRoots = new Dictionary<ulong, List<int>>();
        Dictionary<ulong, List<int>> tempSwapRoots ;
        List<int> minRoot = null;

        currentRoots[filter0x0.value] = new List<int>();

        while (currentRoots.Count > 0) {
            nextRoots.Clear();

            foreach (ulong data in currentRoots.Keys) {
                if ( allRoots.ContainsKey(data) == false) {
                    Console.WriteLine("what?");
                    continue;
                }
                List<RootState> tempRoots = allRoots[data];
                foreach (RootState state in tempRoots) {
                    List<int> tempList;
                    if (state.parent == 0UL) {
                        tempList = currentRoots[data];
#if DEBUG
                        Console.WriteLine("Root: {0:D}", tempList.Count);
#endif
                        if (minRoot == null) {
                            minRoot = tempList;
                        }else if (tempList.Count < minRoot.Count) {
                            minRoot = tempList;
                        }
                    }else{
                        tempList = new List<int>(state.root);
                        tempList.AddRange(currentRoots[data]);
                        if (nextRoots.ContainsKey(state.parent)) {
                            if (tempList.Count < nextRoots[state.parent].Count) {
                                nextRoots[state.parent] = tempList;
                            }
                        }else{
                            nextRoots.Add(state.parent, tempList);
                        }
                    }
                }
            }

            tempSwapRoots = currentRoots;
            currentRoots = nextRoots;
            nextRoots = tempSwapRoots;
        }

#if DEBUG
        PuzzleState checker = problem;
#endif

        if (minRoot != null) {
            foreach (int j in minRoot) {
                Console.WriteLine(j);
#if DEBUG
                checker = checker.MoveNumber((ulong)j);
                //checker.Print();
#endif
            }
        }else{
            Console.WriteLine("Error");
        }

#if DEBUG
        if (minRoot != null) {
            Console.WriteLine("Step {0:D}", minRoot.Count);
        }
        if (filter0x0.Match(checker)) {
            Console.WriteLine("SUCCESS");
        }else{
            Console.WriteLine("FAILURE");
            checker.Print();
        }
#endif
        return 0;

    }

    class Filter {
        public readonly  ulong value, mask;

        public Filter(ulong mask) {
            this.mask = mask;
            value = mask & 0x123456789ABCDEF0UL;
        }

        public Filter(int[,] masks) {
            int sh = 60;
            mask = 0UL;
            for (int i = 0; i<= 3; i++) {
                for( int j  =0;j<=  3;j++) {
                    if (masks[i, j] != 0) {
                        mask = mask | (0xFUL << sh);
                    }
                    sh -= 4;
                } 
            } 
            value = mask & 0x123456789ABCDEF0UL;
        }

        public bool Match(ulong data ) {
            return (data & mask) == value;
        }

        public bool Match(PuzzleState puzzle) {
            return Match(puzzle.data);
        }

        public void Print() {
            for (int i =  0; i<= 3; i++) {
                for (int j = 0; j<= 3; j++) {
                    Console.Write("{0:X} ", PuzzleState.GetNumber(mask, j, i));
                }
                Console.WriteLine();
            }
        }

    } 

    static PuzzleState InputPuzzle() {
        int[] numbers = new int[16];
        int n =  0;
        for (int i = 0; i <= 3; i++) {
            string strLine = Console.ReadLine();
            string[] strLines = strLine.Split(new char[]{' '});
            for (int j = 0; j <= 3; j++) {
                if ("*" != strLines[j]) {
                    numbers[n] = Convert.ToInt32(strLines[j]);
                }else{
                    numbers[n] = 0;
                }
                n += 1;
            }
        }
        return new PuzzleState(numbers);
    }

    static bool CheckAllMovableRoot(PuzzleState startPuzzle, Filter goalFilter , Dictionary<ulong, List<RootState>> allRoots, Dictionary<ulong, PuzzleState> nextPuzzles) {

        if (amv_allMovable.ContainsKey(goalFilter.value) == false) {
            return false;
        }

        PuzzleState puzzle = new PuzzleState(amv_allMovable[goalFilter.value]);

        Stack<int> stackRootNumbers = new Stack<int>();
        ulong tempData = puzzle.data;
        ulong tempData2 = amv_rootData[tempData];
        List<int> root = new List<int>();
        while (tempData2 != 0UL) {
            stackRootNumbers.Push((int)PuzzleState.GetDifferenceOneNumber(tempData, tempData2));
            tempData = tempData2;
            tempData2 = amv_rootData[tempData];
        }
        while (stackRootNumbers.Count > 0) {
            root.Add(stackRootNumbers.Pop());
        }
        if (allRoots.ContainsKey(puzzle.data) == false) {
            allRoots[puzzle.data] = new List<RootState>();
        }
        allRoots[puzzle.data].Add(new RootState(puzzle.data, startPuzzle.data, root));
        nextPuzzles[puzzle.data] = puzzle;

        return true;
    }

    static Dictionary<ulong,PuzzleState> amv_currentStates = new Dictionary<ulong, PuzzleState>();
    static Dictionary<ulong,PuzzleState> amv_nextStates = new Dictionary<ulong, PuzzleState>();
    static Dictionary<ulong,PuzzleState> amv_tempSwapStates ;
    static List<Filter> amv_tempFilters = new List<Filter>();
    static Dictionary<ulong, ulong> amv_rootData = new Dictionary<ulong, ulong>();
    static Dictionary<ulong, ulong> amv_allMovable = new Dictionary<ulong, ulong>();

    static bool MakeAllMovables(PuzzleState startPuzzle,int depth = DEFAULT_DEPTH) {

        amv_currentStates.Clear();
        amv_nextStates.Clear();
        amv_tempSwapStates = null;
        amv_tempFilters.Clear();
        amv_tempFilters.AddRange(filters);

        amv_allMovable.Clear();
        amv_rootData.Clear();
        amv_rootData[startPuzzle.data] = 0UL;
        amv_currentStates[startPuzzle.data] = startPuzzle;

        for (int i = 1; i<= depth; i++) {

            amv_nextStates.Clear();

            foreach (PuzzleState puzzle  in amv_currentStates.Values) {

                for (int k =amv_tempFilters.Count - 1; k >= 0; k--) {
                    Filter fi  = amv_tempFilters[k];
                    if (fi.Match(puzzle)) {
                        amv_allMovable.Add(fi.value, puzzle.data);
                        amv_tempFilters.Remove(fi);
                    }
                }
                if (amv_tempFilters.Count == 0) {
                    break;
                }

                for (int j = 0; j <= 3; j++) {
                    PuzzleState tempPuzzle = puzzle.Move(j);
                    if (tempPuzzle.data != puzzle.data) {
                        if (amv_rootData.ContainsKey(tempPuzzle.data) == false) {
                            amv_rootData[tempPuzzle.data] = puzzle.data;
                            amv_nextStates[tempPuzzle.data] = tempPuzzle;
                        }
                    }
                }
            }

            if (amv_nextStates.Count == 0) {
                break;
            }

            amv_tempSwapStates = amv_currentStates;
            amv_currentStates = amv_nextStates;
            amv_nextStates = amv_tempSwapStates;

        }

        return amv_allMovable.Count > 0;
    }

    static bool SearchAll(PuzzleState startPuzzle ,Filter goalFilter, Dictionary< ulong, List<RootState>> allRoots, Dictionary<ulong, PuzzleState> nextPuzzles, ulong keepOutMask = 0UL, int depth  = DEFAULT_DEPTH) {
        Dictionary<ulong, PuzzleState> currentStates = new Dictionary<ulong, PuzzleState>();
        Dictionary<ulong, PuzzleState> nextStates = new Dictionary< ulong, PuzzleState>();
        Dictionary<ulong, PuzzleState> tempSwapStates;
        Dictionary<ulong, ulong> rootData = new Dictionary< ulong, ulong>();
        bool flag = false;

        rootData[startPuzzle.data] = 0UL;
        currentStates[startPuzzle.data] = startPuzzle;

        for (int i = 1; i <= depth;i++) {
            nextStates.Clear();

            foreach (PuzzleState puzzle in currentStates.Values) {

                if (goalFilter.Match(puzzle)) {
                    Stack<int> stackRootNumbers = new Stack<int>();
                    ulong tempData  = puzzle.data;
                    ulong tempData2= rootData[tempData];
                    List<int> root = new List<int>();
                    while (tempData2 != 0UL) {
                        stackRootNumbers.Push((int)PuzzleState.GetDifferenceOneNumber(tempData, tempData2));
                        tempData = tempData2;
                        tempData2 = rootData[tempData];
                    }
                    while (stackRootNumbers.Count > 0) {
                        root.Add(stackRootNumbers.Pop());
                    }
                    if (allRoots.ContainsKey(puzzle.data) == false) {
                        allRoots[puzzle.data] = new List<RootState>();
                    }
                    allRoots[puzzle.data].Add(new RootState(puzzle.data, startPuzzle.data, root));
                    nextPuzzles[puzzle.data] = puzzle;
                    flag = true;
                }

                if (flag == false) {
                    for (int j = 0;  j <= 3; j++) {
                        PuzzleState tempPuzzle = puzzle.Move(j);
                        if (tempPuzzle.data != puzzle.data && (tempPuzzle.zero & keepOutMask) == 0UL) {
                            if (rootData.ContainsKey(tempPuzzle.data) == false) {
                                rootData[tempPuzzle.data] = puzzle.data;
                                nextStates[tempPuzzle.data] = tempPuzzle;
                            }
                        }
                    } 
                }

            } 

            if (flag) {
                return true;
            }

            if (nextStates.Count == 0) {
                return false;
            }

            tempSwapStates = currentStates;
            currentStates = nextStates;
            nextStates = tempSwapStates;

        }

        return false;
    }

    static bool[] InitKeepOutMap(ulong keepOutMask ) {
        bool[] keepOutMap = new bool[16];
        for (int i = 0; i < 16; i++) {
            if (PuzzleState.GetNumber(keepOutMask, i) != 0) {
                keepOutMap[i] = true;
            }else{
                keepOutMap[i] = false;
            }
        }
        return keepOutMap;
    }

    static bool MakeRoot(int[] rootMap, bool[] keepOutMap,int fromIndex ,int toIndex ) {
        for (int i = 0; i<= 15;i++) {
            if (keepOutMap[i]) {
                rootMap[i] = -1;
            }else{
                rootMap[i] = 0;
            }
        }
        if (keepOutMap[fromIndex] || keepOutMap[toIndex]) {
            return false;
        }
        int c = 1;
        rootMap[toIndex] = c;
        while (rootMap[fromIndex] == 0) {
            bool flag = true;
            for (int i = 0; i <= 15; i++) {
                if (rootMap[i] != c) {
                    continue;
                }
                if (i > 3) {
                    if (rootMap[i - 4] == 0) {
                        rootMap[i - 4] = c + 1;
                        flag = false;
                    }
                }
                if (i < 12) {
                    if (rootMap[i + 4] == 0) {
                        rootMap[i + 4] = c + 1;
                        flag = false;
                    }
                }
                if ((i & 3) > 0 ){
                    if (rootMap[i - 1] == 0) {
                        rootMap[i - 1] = c + 1;
                        flag = false;
                    }
                }
                if ((i & 3) < 3) {
                    if (rootMap[i + 1] == 0) {
                        rootMap[i + 1] = c + 1;
                        flag = false;
                    }
                }
            }
            c += 1;
            if (flag) {
                return false;
            }
        }
        return true;
    }

    static PuzzleState MoveSpace(PuzzleState startPuzzle , int  toIndex , bool[] keepOutMap , List<int> root ) {
        int[] rootMap =new int[16];
        int fromIndex = startPuzzle.IndexOf(0);

        if (MakeRoot(rootMap, keepOutMap, fromIndex, toIndex) == false) {
#if DEBUG
            Console.WriteLine("No Root Space {0:D} to {1:D}", fromIndex, toIndex);
            PuzzleState f1 = new PuzzleState(rootMap);
            f1.Print();
#endif
            return null;
        }

        PuzzleState tempPuzzle = startPuzzle;
        int c = rootMap[fromIndex] - 1;

        while (c > 0) {
            int mv = -1;
            int nextIndex = fromIndex;
            if ((fromIndex & 3) > 0) {
                if (rootMap[fromIndex - 1] == c) {
                    mv = MOVE_LEFT; // space move
                    nextIndex = fromIndex - 1; // space index
                }
            }
            if ((fromIndex & 3) < 3) {
                if (rootMap[fromIndex + 1] == c) {
                    mv = MOVE_RIGHT;
                    nextIndex = fromIndex + 1;
                }
            }
            if (fromIndex > 3) {
                if (rootMap[fromIndex - 4] == c) {
                    mv = MOVE_UP;
                    nextIndex = fromIndex - 4;
                }
            }
            if (fromIndex < 12) {
                if (rootMap[fromIndex + 4] == c) {
                    mv = MOVE_DOWN;
                    nextIndex = fromIndex + 4;
                }
            }

            tempPuzzle = tempPuzzle.Move(mv);
            root.Add(tempPuzzle.NumberOf(fromIndex));
            fromIndex = nextIndex;
            c -= 1;
        }

        return tempPuzzle;
    }

    static PuzzleState MoveNumber(PuzzleState startPuzzle ,bool[] keepOutMap,int number ,int toIndex , List<int> root ) {
        int[] rootMap = new int[16];
        int fromIndex = startPuzzle.IndexOf(number);

        if (MakeRoot(rootMap, keepOutMap, fromIndex, toIndex) == false) {
#if DEBUG 
            Console.WriteLine("No Root {0:D} from {1:D} to {2:D}", number, fromIndex, toIndex);
#endif
            return null;
        }

        PuzzleState tempPuzzle = startPuzzle;
        int c = rootMap[fromIndex] - 1;

        while (c > 0) {
            int mv  = -1;
            int nextIndex = fromIndex;

            //Console.WriteLine("} head of MN num={0:D} fromIndex={1:D}", number, fromIndex);
            //tempPuzzle.Print();

            if ((fromIndex & 3) > 0) {
                if (rootMap[fromIndex - 1] == c) {
                    mv = MOVE_RIGHT; // number move is reverse space move
                    nextIndex = fromIndex - 1; // number index. not space index.
                }
            }

            if ((fromIndex & 3) < 3) {
                if (rootMap[fromIndex + 1] == c) {
                    mv = MOVE_LEFT;
                    nextIndex = fromIndex + 1;
                }
            }

            if (fromIndex > 3) {
                if (rootMap[fromIndex - 4] == c) {
                    mv = MOVE_DOWN;
                    nextIndex = fromIndex - 4;
                }
            }

            if (fromIndex < 12) {
                if (rootMap[fromIndex + 4] == c) {
                    mv = MOVE_UP;
                    nextIndex = fromIndex + 4;
                }
            }


            keepOutMap[fromIndex] = true;
            tempPuzzle = MoveSpace(tempPuzzle, nextIndex, keepOutMap, root);
            keepOutMap[fromIndex] = false;
            if (tempPuzzle == null) {
#if DEBUG
                Console.WriteLine("cannot move space to {0:D}", nextIndex);
                PuzzleState f2 = new PuzzleState(rootMap);
                f2.Print();
                Console.WriteLine("formIndex={0:D} c={1:D} mv={2:D}", fromIndex, c, mv);
#endif
                return null;
            }

            tempPuzzle = tempPuzzle.Move(mv);
            root.Add(tempPuzzle.NumberOf(nextIndex));
            fromIndex = nextIndex;
            c -= 1;
        }

        return tempPuzzle;
    }

    static bool FitVtRv(PuzzleState startPuzzle, Dictionary<ulong, List<RootState>> allRoots, Dictionary<ulong, PuzzleState> nextPuzzles , int number , ulong  keepOutMask  = 0UL) {
        int i  = number - 1;
        return Fit(startPuzzle, allRoots, nextPuzzles, number + 4, number, i + 4, i, i + 3, i - 1, i + 2, i - 2, keepOutMask);
    }

    static bool FitVt(PuzzleState startPuzzle ,Dictionary<ulong, List<RootState>> allRoots ,Dictionary<ulong, PuzzleState> nextPuzzles , int number , ulong keepOutMask = 0UL ) {
        int i = number - 1;
        return Fit(startPuzzle, allRoots, nextPuzzles, number, number + 4, i, i + 4, i + 1, i + 5, i + 2, i + 6, keepOutMask);
    }

    static bool FitHzRv(PuzzleState startPuzzle ,Dictionary<ulong, List<RootState>> allRoots ,Dictionary<ulong, PuzzleState> nextPuzzles , int number , ulong keepOutMask = 0UL ) {
        int i = number - 1;
        return Fit(startPuzzle, allRoots, nextPuzzles, number + 1, number, i + 1, i, i - 3, i - 4, i - 7, i - 8, keepOutMask);
    }

    static bool FitHz(PuzzleState startPuzzle ,Dictionary<ulong, List<RootState>> allRoots ,Dictionary<ulong, PuzzleState> nextPuzzles , int number , ulong keepOutMask = 0UL ) {
        int i = number - 1;
        return Fit(startPuzzle, allRoots, nextPuzzles, number, number + 1, i, i + 1, i + 4, i + 5, i + 8, i + 9, keepOutMask);
    }

    static bool Fit(PuzzleState startPuzzle ,Dictionary<ulong,List<RootState>> allRoots ,Dictionary<ulong,PuzzleState> nextPuzzles ,int number ,int number2 ,int i1 ,int  i2 ,int i3 ,int i4 ,int i5 ,int i6 , ulong keepOutMask ) {
        bool[] keepOutMap  = InitKeepOutMap(keepOutMask);
        int n1, n2, n3, n4 ;
        List<int> root = new List<int>();
        PuzzleState tempPuzzle = startPuzzle;

        //Console.WriteLine("Call Fit! {0:D},{1:D}", number, number2);
        //startPuzzle.Print();
        //Console.WriteLine("{0:X}", keepOutMask);

        do {
            //Console.WriteLine("} head of fit");
            //tempPuzzle.Print();

            n1 = tempPuzzle.NumberOf(i1);
            n2 = tempPuzzle.NumberOf(i2);
            n3 = tempPuzzle.NumberOf(i3);
            n4 = tempPuzzle.NumberOf(i4);

            if (n1 == number) {
                if (n2 == number2) {
                    //Fin
                    // 1 2
                    // ? ?
                    if (allRoots.ContainsKey(tempPuzzle.data) == false) {
                        allRoots[tempPuzzle.data] = new List<RootState>();
                    }
                    allRoots[tempPuzzle.data].Add(new RootState(tempPuzzle.data, startPuzzle.data, root));
                    nextPuzzles[tempPuzzle.data] = tempPuzzle;
                    return true;
                }else if (n3 == number2) {
                    //NG
                    // 1 ?
                    // 2 ?
                    //number2 to n5
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i5, root);

                }else if (n4 == number2) {
                    if (n2 == 0) {
                        //OK
                        // 1 0
                        // ? 2
                        //number2 to n2
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i2, root);
                    }else{
                        //NG
                        // 1 ?
                        // ? 2
                        //number2 to n6
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i6, root);
                    }
                }else{
                    // 1 ?
                    // ? ?
                    //number to n2
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i2, root);
                }

            }else if (n2 == number) {
                if (n1 == number2) {
                    //NG
                    // 2 1
                    // ? ?
                    //number2 to n5
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i5, root);

                }else if (n3 == number2) {
                    if (n1 == 0) {
                        //NG
                        // 0 1
                        // 2 ?
                        //number2 to n6
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i6, root);
                    }else{
                        //OK
                        // ? 1
                        // 2 ?
                        //number2 to n4
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i4, root);
                    }
                }else if (n4 == number2) {
                    //OK
                    // ? 1
                    // ? 2
                    //lock number2 on n4
                    //number to n1
                    keepOutMap[i4] = true;
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i1, root);
                    keepOutMap[i4] = false;

                }else{
                    // ? 1 x
                    // ? ? y
                    int ix  = i2 + (i2 - i1);
                    int iy  = ix + (i3 - i1);
                    //Console.WriteLine("ix={0:D} iy={1:D}", ix, iy);
                    bool innerFlag = true;
                    if (ix < 16 && (ix & 3) > (i2 & 3)) {
                        if (tempPuzzle.NumberOf(ix) == 0 && iy < 16) {
                            if (tempPuzzle.NumberOf(iy) == number2) {
                                // ? 1 0
                                // ? ? 2
                                tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, ix, root);
                                innerFlag = false;
                            }
                        }else if (tempPuzzle.NumberOf(ix) == number2) {
                            // ? 1 2
                            // ? ?
                            tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i1, root);
                            if ( tempPuzzle != null ){
                                tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i2, root);
                            }
                            innerFlag = false;
                        }
                    }
                    if (innerFlag) {
                        // lock number on n2
                        //number2 to n4
                        keepOutMap[i2] = true;
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i4, root);
                        keepOutMap[i2] = false;
                    }
                }

            }else if (n3 == number) {
                if (n1 == number2) {
                    //OK
                    // 2 ?
                    // 1 ?
                    //lock number on n3
                    //number2 to n2
                    keepOutMap[i3] = true;
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i2, root);
                    keepOutMap[i3] = false;

                }else if( n2 == number2) {
                    if (n1 == 0) {
                        //OK
                        // 0 2
                        // 1 ?
                        //number to n1
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i1, root);
                    }else{
                        //NG
                        // ? 2
                        // 1 ?
                        //number to n5
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i5, root);
                    }
                }else if( n4 == number2) {
                    if (n1 == 0) {
                        //NG
                        // 0 ?
                        // 1 2
                        // number2 to n6
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i6, root);
                    }else if (n2 == 0) {
                        //NG
                        // ? 0
                        // 1 2
                        // number to n5
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i5, root);
                    }else{
                        //OK
                        // ? ?
                        // 1 2
                        // number to n5
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i5, root);
                    }
                }else{
                    // ? ?
                    // 1 ?
                    //number to n2
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i2, root);
                }
            }else if (n4 == number) {
                if (n1 == number2) {
                    if (n2 == 0 ){
                        //NG
                        // 2 0
                        // ? 1
                        //number to n5
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i5, root);
                    }else{
                        //OK
                        // 2 ?
                        // ? 1
                        //number to n3
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i3, root);
                    }
                }else if (n2 == number2) {
                    //NG
                    // ? 2
                    // ? 1
                    //number to n6
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i6, root);

                }else if (n3 == number2) {
                    if( n1 == 0 ){
                        //OK
                        // 0 ?
                        // 2 1
                        //number2 to n1
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i1, root);
                    }else if (n2 == 0) {
                        //OK
                        // ? 0
                        // 2 1
                        //number to n2
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i2, root);
                    }else{
                        //NG
                        // ? ?
                        // 2 1
                        //number2 to n1
                        tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i1, root);
                    }

                }else{
                    // ? ?
                    // ? 1
                    //number to n2
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i2, root);
                }
            }else{
                if( n1 == number2) {
                    // 2 ?
                    // ? ?
                    //lock number2 on n1
                    //number to n3
                    keepOutMap[i1] = true;
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i3, root);
                    keepOutMap[i1] = false;
                }else if( n2 == number2 || n3 == number2 || n4 == number2) {
                    // ? 2
                    // ? ?
                    //number2 to n1
                    // ? ?
                    // 2 ?
                    //number2 to n1
                    // ? ?
                    // ? 2
                    //number2 to n1
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number2, i1, root);
                }else{
                    //near number to each pos
                    tempPuzzle = MoveNumber(tempPuzzle, keepOutMap, number, i2, root);
                }
            }
        } while ( tempPuzzle != null);

#if DEBUG
        Console.WriteLine("unknown error?");
        Filter f1 = new Filter(keepOutMask);
        f1.Print();
        startPuzzle.Print();
#endif
        return false;
    }


    class RootState
    {
        public readonly ulong data, parent;
        public readonly List<int> root;
        public RootState(ulong data, ulong parent, List<int> root)
        {
            this.data = data;
            this.parent = parent;
            this.root = root;
        }
    }


    class PuzzleState
    {
        public static ulong GetDifferenceOneNumber(ulong data1, ulong data2)
        {
            ulong temp = data1 ^ data2;
            for (int i = 0; i <= 15; i++)
            {
                ulong value = (temp >> (60 - (i << 2))) & 0xFUL;
                if (value != 0UL)
                {
                    return value;
                }
            }
            return 0UL;
        }
        public static ulong GetDifferenceOneNumber(PuzzleState puzzle1, PuzzleState puzzle2)
        {
            return GetDifferenceOneNumber(puzzle1.data, puzzle2.data);
        }

        public static int GetNumber(ulong data, int index)
        {
            return (int)((data >> (60 - ((index & 0xF) << 2))) & 0xFUL);
        }

        public static int GetNumber(ulong data, int x, int y)
        {
            return GetNumber(data, ((y & 0x3) << 2) | (x & 0x3));
        }

        public readonly ulong data, zero;

        public PuzzleState(ulong data = 0x123456789ABCDEF0UL)
        {
            this.data = data;
            zero = 0xFUL;
            for (int i = 0; i <= 15; i++)
            {
                if ((data & zero) == 0UL)
                {
                    break;
                }
                zero <<= 4;
            }
        }

        public PuzzleState(int[] array)
        {
            data = 0UL;
            for (int i = 0; i <= 15; i++)
            {
                ulong v = (ulong)array[i] & 0xFul;
                data = data | (v << (60 - (i << 2)));
                if (v == 0UL)
                {
                    zero = 0xFUL << (60 - (i << 2));
                }
            }
        }

        public PuzzleState(int[,] array)
        {
            int sh = 60;
            data = 0UL;
            for (int i = 0; i <= 3; i++)
            {
                for (int j = 0; j <= 3; j++)
                {
                    ulong v = (ulong)array[i, j] & 0xFUL;
                    data = data | (v << sh);
                    if (v == 0UL)
                    {
                        zero = 0xFUL << sh;
                    }
                    sh -= 4;
                }
            }
        }

        private PuzzleState(ulong data, ulong zero)
        {
            this.data = data;
            this.zero = zero;
        }

        public int NumberOf(int index)
        {
            return GetNumber(data, index);
        }

        public int NumberOf(int x, int y)
        {
            return GetNumber(data, x, y);
        }

        public int IndexOf(int number)
        {
            for (int i = 0; i <= 15; i++)
            {
                if (NumberOf(i) == number)
                {
                    return i;
                }
            }
            return -1;
        }

        public PuzzleState MoveLeft()
        {
            if ((zero & 0xF000F000F000F000UL) == 0UL)
            {
                return new PuzzleState((data | ((data >> 4) & zero)) & (~(zero << 4)), zero << 4);
            }
            else
            {
                return this;
            }
        }

        public PuzzleState MoveRight()
        {
            if ((zero & 0xF000F000F000FUL) == 0UL)
            {
                return new PuzzleState((data | ((data << 4) & zero)) & (~(zero >> 4)), zero >> 4);
            }
            else
            {
                return this;
            }
        }

        public PuzzleState MoveUp()
        {
            if ((zero & 0xFFFF000000000000UL) == 0UL)
            {
                return new PuzzleState((data | ((data >> 16) & zero)) & (~(zero << 16)), zero << 16);
            }
            else
            {
                return this;
            }
        }

        public PuzzleState MoveDown()
        {
            if ((zero & 0xFFFFUL) == 0UL)
            {
                return new PuzzleState((data | ((data << 16) & zero)) & (~(zero >> 16)), zero >> 16);
            }
            else
            {
                return this;
            }
        }

        public PuzzleState Move(int k)
        {
            switch (k & 3)
            {
                case MOVE_LEFT:
                    return MoveLeft();
                case MOVE_RIGHT:
                    return MoveRight();
                case MOVE_UP:
                    return MoveUp();
                case MOVE_DOWN:
                    return MoveDown();
                default:
                    return this;
            }
        }

        public PuzzleState MoveNumber(ulong num)
        {
            PuzzleState tempPuzzle;

            tempPuzzle = MoveLeft();
            if (GetDifferenceOneNumber(this, tempPuzzle) == num)
            {
                return tempPuzzle;
            }

            tempPuzzle = MoveRight();
            if (GetDifferenceOneNumber(this, tempPuzzle) == num)
            {
                return tempPuzzle;
            }

            tempPuzzle = MoveUp();
            if (GetDifferenceOneNumber(this, tempPuzzle) == num)
            {
                return tempPuzzle;
            }

            tempPuzzle = MoveDown();
            if (GetDifferenceOneNumber(this, tempPuzzle) == num)
            {
                return tempPuzzle;
            }

            return this;
        }

        public PuzzleState Shuffle(int count = 10, bool show = false)
        {
            Random rand = new Random();
            PuzzleState temp = this;
            int k = 0;
            for (int i = 1; i <= count; i++)
            {
                PuzzleState temp2;
                if (k == 0)
                {
                    temp2 = temp.Move(rand.Next(2));
                }
                else
                {
                    temp2 = temp.Move(rand.Next(2) + 2);
                }
                if (temp.data != temp2.data)
                {
                    if (show)
                    {
                        Console.WriteLine(GetDifferenceOneNumber(temp2.data, temp.data));
                    }
                    temp = temp2;
                    k = 1 - k;
                }
            }
            return temp;
        }

        public void Print()
        {
            Console.WriteLine("---------------------------");
            for (int i = 0; i <= 15; i++)
            {
                ulong n = (data >> (60 - (i << 2))) & 0xFUL;
                if (n == 0)
                {
                    Console.Write(" *");
                }
                else
                {
                    Console.Write("{0,2:D}", n);
                }
                if (i % 4 == 3)
                {
                    Console.WriteLine();
                }
                else
                {
                    Console.Write(" ");
                }
            }
        }
      } 
} 
