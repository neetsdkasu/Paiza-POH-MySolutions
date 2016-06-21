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
              05 STR-SN  PIC X(10).
              05 INT-S   PIC 999.
              05 INT-N   PIC 999.
       PROCEDURE DIVISION.
       MAIN-ROUTINE SECTION.
       000-MAIN.
              
              ACCEPT STR-SN.
              
              UNSTRING STR-SN DELIMITED BY " " INTO INT-S INT-N.
              
              IF INT-S < INT-N THEN
                    DISPLAY "NG"
              ELSE
                    DISPLAY "OK"
              END-IF.
              
       END PROGRAM MAIN.
