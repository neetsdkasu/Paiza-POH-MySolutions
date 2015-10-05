       *>
       *> 結果 https://paiza.jp/poh/joshibato/tsubame/result/b4aa954c
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
                     05 n    PIC 9(3).
                     05 n1   PIC 9(3).
                     05 n10  PIC 9(3).
                     05 r    PIC 9(3) VALUE Is 0.
                     05 d    PIC Z(3).
       PROCEDURE DIVISION.
       MainRoutine SECTION.
       000-Main.
              ACCEPT n.
              MOVE n TO n10.
              DIVIDE 10 INTO n10.
              MULTIPLY 10 BY n10.
              MOVE n TO n1.
              SUBTRACT n10 FROM n1.
              DIVIDE 10 INTO n10.
              ADD n n1 n10 TO r.
              MOVE r TO d.
              DISPLAY TRIM(d).
       END PROGRAM Answer.
