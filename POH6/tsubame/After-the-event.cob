       *> Try POH
       *> author: Leonardone @ NEETSDKASU
       *>
       *> 結果: https://paiza.jp/poh/joshibato/tsubame/result/b873ea35
       *>
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Main.
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
       01 For-Inputing-Values.
              05 file-access PIC X USAGE COMP-X VALUE IS 1.
              05 file-handle PIC X(4) USAGE COMP-X.
              05 file-offset PIC X(8) USAGE COMP-X VALUE IS 0.
              05 file-nbytes PIC X(4) USAGE COMP-X VALUE IS 2.
              05 file-buffer PIC X(10).
       PROCEDURE DIVISION.
       MainRoutine SECTION.
       000-Main.
              *> ACCEPT n.
              CALL "CBL_OPEN_FILE" USING "/dev/stdin" file-access 0 0 file-handle.
              CALL "CBL_READ_FILE" USING file-handle file-offset file-nbytes 0 file-buffer.
              CALL "CBL_CLOSE_FILE" USING file-handle.      
              MOVE INTEGER(TRIM(file-buffer)) TO n.
              
              MOVE n TO n10.
              DIVIDE 10 INTO n10.
              MULTIPLY 10 BY n10.
              MOVE n TO n1.
              SUBTRACT n10 FROM n1.
              DIVIDE 10 INTO n10.
              ADD n n1 n10 TO r.
              MOVE r TO d.
              DISPLAY TRIM(d).
       END PROGRAM Main.
