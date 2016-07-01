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
              05 INT-N   BINARY-LONG.
              05 INT-M   PIC 999.
              05 INT-T   BINARY-LONG.
              05 INT-I   PIC 999.
              05 INT-C   PIC 999 VALUE IS 0.
              05 INT-Z   PIC Z9.
       PROCEDURE DIVISION.
       MAIN-ROUTINE SECTION.
       000-MAIN.
              
              ACCEPT INT-N.
              ACCEPT INT-M.
              
              MULTIPLY 60 BY INT-N.
              
              PERFORM WITH TEST AFTER
              VARYING INT-I FROM 1 BY 1 UNTIL INT-I >= INT-M
                     ACCEPT INT-T
                     IF INT-N >= INT-T THEN
                            MOVE INT-I TO INT-C
                     END-IF
                     SUBTRACT INT-T FROM INT-N
              END-PERFORM.
              
              IF INT-C = INT-M THEN
                     DISPLAY "OK"
              ELSE
                     MOVE INT-C TO INT-Z
                     DISPLAY TRIM(INT-Z)
              END-IF.
              
       END PROGRAM MAIN.
