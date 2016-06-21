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
              05 INT-Z   PIC ZZ9.
              05 STR-MN  PIC X(10).
       PROCEDURE DIVISION.
       MAIN-ROUTINE SECTION.
       000-MAIN.
              
              ACCEPT STR-MN.
              
              UNSTRING STR-MN DELIMITED BY " " INTO INT-M INT-N.
              
              IF INT-M > INT-N THEN
                     SUBTRACT INT-N FROM INT-M
                     MOVE INT-M TO INT-Z
                     DISPLAY TRIM(INT-Z)
              ELSE
                     DISPLAY "0"
              END-IF.
              
       END PROGRAM MAIN.
