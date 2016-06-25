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
              05 INT-N   PIC 99.
              05 INT-M   PIC 99.
              05 INT-D   PIC 99.
              05 INT-Z   PIC Z9.
       PROCEDURE DIVISION.
       MAIN-ROUTINE SECTION.
       000-MAIN.
              
              ACCEPT INT-N.
              ACCEPT INT-M.
              
              MULTIPLY 2 BY INT-N.
              MOVE MOD(INT-M, INT-N) TO INT-D.
              DIVIDE INT-N INTO INT-M.
              IF INT-D > 0 THEN
                     ADD 1 TO INT-M
              END-IF.
              MOVE INT-M TO INT-Z.
              DISPLAY TRIM(INT-Z).
              
       END PROGRAM MAIN.
