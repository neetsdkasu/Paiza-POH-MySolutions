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
              05 INT-N   PIC 9(5).
              05 INT-P   PIC 9(10).
              05 INT-M   PIC 9(5).
              05 INT-Q   PIC 9(10).
              05 INT-D   PIC 9(5).
              05 INT-Z   PIC Z(9)9.
              05 STR-NP  PIC X(20).
              05 STR-MQ  PIC X(20).
       PROCEDURE DIVISION.
       MAIN-ROUTINE SECTION.
       000-MAIN.
              
              ACCEPT STR-NP.
              ACCEPT STR-MQ.
              
              UNSTRING STR-NP DELIMITED BY " " INTO INT-N INT-P.
              UNSTRING STR-MQ DELIMITED BY " " INTO INT-M INT-Q.
              
              MULTIPLY INT-N BY INT-P.
              
              MOVE MOD(INT-N, INT-M) TO INT-D.
              DIVIDE INT-M INTO INT-N.
              IF INT-D > 0 THEN
                     ADD 1 TO INT-N
              END-IF.
              MULTIPLY INT-N BY INT-Q.
              
              ADD INT-Q TO INT-P.
              MOVE INT-P TO INT-Z.
              
              DISPLAY TRIM(INT-Z).
              
       END PROGRAM MAIN.
