        IDENTIFICATION DIVISION.
        PROGRAM-ID. hello.
        ENVIRONMENT DIVISION.
        CONFIGURATION SECTION.
        REPOSITORY.
            FUNCTION ALL INTRINSIC.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
            01 EQUALITY IS GLOBAL PIC 9(4) VALUE 0.
            01 SMALL IS GLOBAL PIC 9(4) VALUE 1.
            01 LARGE IS GLOBAL PIC 9(4) VALUE 2.
            01 Hello-Values IS GLOBAL.
                05 Number-Of-Words PIC 9(4).
                05 Word PIC A(10) OCCURS 1000 TIMES.
                05 Word-Length PIC 9(2).
                05 Index1 PIC 9(4).
                05 Index2 PIC 9(4).
            01 Compare-Values IS GLOBAL.
                05 IndexC1 PIC 9(4).
                05 String1 PIC A(10).
                05 String2 PIC A(10).
                05 Ord1 PIC 9(4).
                05 Ord2 PIC 9(4).
                05 Result PIC 9(4).
            01 Seek-Values IS GLOBAL.
                05 IndexF1 PIC 9(4).
                05 IndexF2 PIC 9(4).
                05 Reversed-Word PIC A(10).
                05 Left-Side PIC A(5000) VALUE SPACE.
                05 Center-Word PIC A(10) VALUE SPACE.
                05 For-Copy PIC A(5000) VALUE SPACE.
        PROCEDURE DIVISION.
        Hello-Main SECTION.
        Main-Dayo.
                ACCEPT Number-Of-Words
                    FROM SYSIN
                END-ACCEPT.
        Init-Read-Words.
                MOVE 1 TO Index1.
        Read-Words.
                IF Index1 <= Number-Of-Words THEN
                    ACCEPT Word(Index1)
                        FROM SYSIN
                    END-ACCEPT
                    ADD 1 TO Index1
                    GO TO Read-Words
                END-IF
                MOVE STORED-CHAR-LENGTH(Word(1)) TO Word-Length.
                IF Number-Of-Words > 1 THEN
                    CALL "Sort-Words".
                
        Init-Make-Palindome.
                MOVE 1 TO Index1.
        Make-Palindome.
                If Index1 <= Number-Of-Words THEN
                    MOVE Index1 TO IndexF1
                    CALL "Seek-Reverse-Word"
                    ADD 1 TO Index1
                    GO TO Make-Palindome
                END-IF.
        Show-Result.
                IF STORED-CHAR-LENGTH(Left-Side) > 0 THEN
                    DISPLAY TRIM(Left-Side) WITH NO ADVANCING.
                IF STORED-CHAR-LENGTH(Center-Word) = Word-Length THEN
                    DISPLAY TRIM(Center-Word) WITH NO ADVANCING
                END-IF
                IF STORED-CHAR-LENGTH(Left-Side) > 0 THEN
                    DISPLAY REVERSE(TRIM(Left-Side)) WITH NO ADVANCING.
                STOP RUN.
        PROGRAM-ID. Sort-Words.
        DATA DIVISION.
        WORKING-STORAGE SECTION.
            01 IndexS1 PIC 9(4).
            01 IndexS2 PIC 9(4).
            01 IndexS3 PIC 9(4).
            01 TempWord PIC A(10).
        PROCEDURE DIVISION.
        Sort-Main SECTION.
        Init-Sort.
                MOVE 1 TO IndexS1.
        Main-Loop.
                IF IndexS1 = Number-Of-Words THEN
                    GOBACK
                END-IF
                MOVE IndexS1 TO IndexS2 IndexS3.
        Sub-Loop.
                ADD 1 TO IndexS2.
                IF IndexS2 > Number-Of-Words THEN
                    IF NOT IndexS1 = IndexS3 THEN
                        MOVE Word(IndexS1) TO TempWord
                        MOVE Word(IndexS3) TO Word(IndexS1)
                        MOVE TempWord TO Word(IndexS3)
                    END-IF
                    ADD 1 TO IndexS1
                    GO TO Main-Loop
                ELSE
                    MOVE Word(IndexS3) TO String1 OF Compare-Values
                    MOVE Word(IndexS2) TO String2 OF Compare-Values
                    CALL "Compare-Strings"
                    IF SMALL = Result OF Compare-Values THEN
                        MOVE IndexS2 TO IndexS3
                    END-IF
                    GO TO Sub-Loop
                END-IF.
        END PROGRAM Sort-Words.
        PROGRAM-ID. Compare-Strings.
        PROCEDURE DIVISION.
        Compare-Main SECTION.
        Init-Compare.
                MOVE 1 TO IndexC1.
        Main-Loop.
                IF IndexC1 > Word-Length THEN
                    MOVE EQUALITY TO Result OF Compare-Values
                ELSE
                    MOVE ORD(String1(IndexC1:1)) TO Ord1
                    MOVE ORD(String2(IndexC1:1)) TO Ord2
                    IF Ord1 < Ord2 THEN
                        MOVE LARGE TO Result OF Compare-Values
                    ELSE
                        IF Ord1 > Ord2 THEN
                            MOVE SMALL TO Result OF Compare-Values
                        ELSE
                            ADD 1 TO IndexC1
                            GO TO Main-Loop
                        END-IF
                    END-IF
                END-IF.
        END PROGRAM Compare-Strings.
        PROGRAM-ID. Seek-Reverse-Word.
        PROCEDURE DIVISION.
        Seek-Main SECTION.
        Init-Seek.
            MOVE Word(IndexF1) TO String1 OF Compare-Values.
            MOVE "-" TO String2 OF Compare-Values.
            CALL "Compare-Strings".
            IF EQUALITY = Result OF Compare-Values THEN
                GOBACK
            END-IF
            MOVE REVERSE(TRIM(Word(IndexF1))) TO Reversed-Word String1.
            MOVE IndexF1 TO IndexF2.
        Main-Loop.
            ADD 1 TO IndexF2.
            IF IndexF2 > Number-Of-Words THEN
                MOVE Word(IndexF1) TO String2 OF Compare-Values
                CALL "Compare-Strings"
                IF EQUALITY = Result OF Compare-Values THEN
                    IF STORED-CHAR-LENGTH(Center-Word) = 0 THEN
                        MOVE Reversed-Word TO Center-Word
                    ELSE
                        MOVE Center-Word TO String2
                        CALL "Compare-Strings"
                        IF LARGE = Result OF Compare-Values THEN
                            MOVE Reversed-Word TO Center-Word
                        END-IF
                    END-IF
                END-IF
                GOBACK
            ELSE
                MOVE Word(IndexF2) TO String2 OF Compare-Values
                CALL "Compare-Strings"
                IF EQUALITY = Result OF Compare-Values THEN
                    MOVE CONCATENATE(TRIM(Left-Side), TRIM(WORD(IndexF1))) TO For-Copy
                    MOVE For-Copy TO Left-Side
                    MOVE "-" TO Word(IndexF2)
                    GOBACK
                ELSE
                    GO TO Main-Loop
                END-IF
            END-IF.
        END PROGRAM Seek-Reverse-Word.
        END PROGRAM hello.
