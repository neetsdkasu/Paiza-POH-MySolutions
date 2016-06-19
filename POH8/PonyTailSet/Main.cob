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
              05 STR-DE   PIC X(3).
              05 INT-I    PIC 9.
              05 INT-C    PIC 9 VALUE IS 0.
       PROCEDURE DIVISION.
       MAIN-ROUTINE SECTION.
       000-MAIN.
              
              PERFORM WITH TEST AFTER VARYING INT-I FROM 1 BY 1 UNTIL INT-I >= 5
                     ACCEPT STR-DE
                     IF STR-DE(1:1) = STR-DE(3:1) THEN
                            ADD 1 TO INT-C
                     END-IF
              END-PERFORM.
              
              IF INT-C > 2 THEN
                     DISPLAY "OK"
              ELSE
                     DISPLAY "NG"
              END-IF.
              
       END PROGRAM MAIN.
