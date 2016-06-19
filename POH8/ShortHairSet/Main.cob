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
              05 INT-N   PIC 9(3).
              05 STR-S   PIC X(20).
              05 INT-I   PIC 9(3).
       PROCEDURE DIVISION.
       MAIN-ROUTINE SECTION.
       000-MAIN.
              
              ACCEPT INT-N.
              ACCEPT STR-S.
              
              PERFORM WITH TEST AFTER
              VARYING INT-I FROM 1 BY 1 UNTIL INT-I = INT-N
                     DISPLAY TRIM(STR-S)
              END-PERFORM.
              
       END PROGRAM MAIN.
