       *> Try POH
       *> author: Leonardone @ NEETSDKASU
       *> ↓ 1行あたりの字数の目安
       *>==============================================================$
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAIN.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
              FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 ANSWER-VALUES.
              05 INT-N   PIC 999.
              05 INT-M   PIC 999.
              05 STR-NM  PIC X(10).
       PROCEDURE DIVISION.
       MAIN-ROUTINE SECTION.
       000-MAIN.
              
              ACCEPT STR-NM.
              
              UNSTRING STR-NM DELIMITED BY " " INTO INT-N INT-M.
              
              IF MOD(INT-M,INT-N) > 0 THEN
                     DISPLAY "ng"
              ELSE
                     DISPLAY "ok"
              END-IF.
              
       END PROGRAM MAIN.
