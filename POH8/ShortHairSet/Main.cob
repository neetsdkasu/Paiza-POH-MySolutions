       *> Try POH
       *> author: Leonardone @ NEETSDKASU
       *> ↓ 1行あたりの字数の目安
       *>==============================================================$
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Main.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
              FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 Answer-Values.
              05 INT-N   PIC 9(3).
              05 STR-S   PIC X(20).
              05 INT-I   PIC 9(3).
       PROCEDURE DIVISION.
       MainRoutine SECTION.
       000-Main.
              ACCEPT INT-N.
              ACCEPT STR-S.
              
              PERFORM WITH TEST AFTER VARYING INT-I FROM 1 BY 1 UNTIL INT-I = INT-N
                     DISPLAY TRIM(STR-S)
              END-PERFORM.
       END PROGRAM Main.
