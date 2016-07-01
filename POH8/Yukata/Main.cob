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
              05 STR-TS  PIC X(20).
              05 INT-T   PIC 999.
              05 STR-S   PIC XXX.
              05 INT-H   PIC 999 VALUE IS 0.
              05 INT-X   PIC 999 VALUE IS 0.
              05 INT-Y   PIC 999.
              05 INT-P   PIC 999 VALUE IS 24.
              05 INT-I   PIC 999.
              05 INT-Z   PIC ZZ9.
       PROCEDURE DIVISION.
       MAIN-ROUTINE SECTION.
       000-MAIN.
              
              ACCEPT INT-N.
              
              PERFORM WITH TEST BEFORE
              VARYING INT-I FROM 1 BY 1 UNTIL INT-I > INT-N
                     ACCEPT STR-TS
                     UNSTRING STR-TS DELIMITED BY " " INTO INT-T STR-S
                     IF INT-X > 0 THEN
                            MOVE INT-T TO INT-Y
                            SUBTRACT INT-H FROM INT-Y
                            IF INT-Y >= INT-X THEN
                                   ADD INT-X TO INT-P
                                   MOVE 0 TO INT-X
                            ELSE
                                   ADD INT-Y TO INT-P
                                   SUBTRACT INT-Y FROM INT-X
                            END-IF
                     END-IF
                     MOVE INT-T TO INT-H
                     IF STR-S = "out" THEN
                            ADD 3 TO INT-X
                     ELSE
                            ADD 5 TO INT-X
                     END-IF
              END-PERFORM.
              
              IF INT-X > 0 THEN
                     MOVE 24 TO INT-Y
                     SUBTRACT INT-H FROM INT-Y
                     IF INT-Y >= INT-X THEN
                            ADD INT-X TO INT-P
                     ELSE
                            ADD INT-Y TO INT-P
                     END-IF
              END-IF.
              
              MOVE INT-P TO INT-Z.
              DISPLAY TRIM(INT-Z).
              
       END PROGRAM MAIN.
