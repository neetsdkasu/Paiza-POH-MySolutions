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
              05 INT-S    PIC 9(3).
              05 INT-T    PIC 9(3).
              05 INT-I    PIC 9(3).
              05 STR-R    PIC X(100).
       PROCEDURE DIVISION.
       MAIN-ROUTINE SECTION.
       000-MAIN.
              
              ACCEPT INT-S.
              ACCEPT INT-T.
              
              PERFORM WITH TEST AFTER VARYING INT-I FROM 1 BY 1 UNTIL INT-I >= INT-S
                     MOVE "-" TO STR-R(INT-I:1)
              END-PERFORM.
              
              MOVE "+" TO STR-R(INT-T:1).
              
              DISPLAY TRIM(STR-R).
              
       END PROGRAM MAIN.
