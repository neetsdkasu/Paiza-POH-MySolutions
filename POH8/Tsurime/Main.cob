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
              05 INT-P   PIC 9(5).
              05 INT-S   PIC Z(4)9.
       PROCEDURE DIVISION.
       MAIN-ROUTINE SECTION.
       000-MAIN.
              
              ACCEPT INT-P.
              
              DIVIDE INT-P BY 100 GIVING INT-P.
              
              IF INT-P >= 10 THEN
                     ADD 10 TO INT-P.
              
              MOVE INT-P TO INT-S
              
              DISPLAY TRIM(INT-S).
              
       END PROGRAM MAIN.
