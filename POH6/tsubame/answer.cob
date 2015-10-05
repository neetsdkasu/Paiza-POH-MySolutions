       *>
       *> 結果 https://paiza.jp/poh/joshibato/tsubame/result/cbf8cf08
       *>
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Answer.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
              FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
              01 Answer-Values.
                     05 x    PIC X(10).
                     05 n    PIC 9(10).
                     05 n1   PIC 9(10).
                     05 n10  PIC 9(10).
                     05 r    PIC 9(10) VALUE Is 0.
                     05 r2   PIC 9(2).
                     05 r3   PIC 9(3).
       PROCEDURE DIVISION.
       MainRoutine SECTION.
       000-Main.
              ACCEPT x.
              MOVE x TO n.
              MOVE n TO n10.
              DIVIDE 10 INTO n10.
              MULTIPLY 10 BY n10.
              MOVE n TO n1.
              SUBTRACT n10 FROM n1.
              DIVIDE 10 INTO n10.
              ADD n n1 n10 TO r.
              IF NUMVAL(r) < 100 THEN
                     MOVE NUMVAL(r) TO r2
                     DISPLAY r2
              ELSE
                     MOVE NUMVAL(r) TO r3
                     DISPLAY r3
              END-IF.
       END PROGRAM Answer.
