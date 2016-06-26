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
              05 STR-CARDS PIC X(200).
              05 ARR OCCURS 52 TIMES.
                     07 STR-C  PIC XX.
                     07 INT-R  PIC 99.
              05 INT-I   PIC 999.
              05 INT-J   PIC 99 VALUE IS 1.
              05 STR-X   PIC X.
              05 STR-T   PIC XX.
              05 INT-P   PIC 999.
              05 INT-K   PIC 99.
              05 INT-E   PIC 99.
              05 INT-Z   PIC Z9.
       PROCEDURE DIVISION.
       MAIN-ROUTINE SECTION.
       000-MAIN.
              
              ACCEPT STR-CARDS.
              
              PERFORM WITH TEST AFTER
              VARYING INT-I FROM 1 BY 1 UNTIL INT-I >= 108
                    MOVE STR-CARDS(INT-I:1) TO STR-X
                    IF STR-X = SPACE THEN
                           MOVE STR-T TO STR-C(INT-J)
                           MOVE SPACE TO STR-T
                           ADD 1 TO INT-J
                    ELSE
                           MOVE CONCATENATE(TRIM(STR-T),TRIM(STR-X))
                                  TO STR-T
                    END-IF
              END-PERFORM.
              
              MOVE 1 TO INT-J.
              
              PERFORM WITH TEST AFTER UNTIL INT-J >= 53
                     PERFORM WITH TEST AFTER
                     VARYING INT-I FROM 1 BY 1 UNTIL INT-I >= 52
                            IF INT-I = INT-P THEN
                                 MOVE 0 TO INT-P
                                 MOVE 0 TO INT-E
                            END-IF
                            IF INT-R(INT-I) = 0 THEN
                                   MOVE STR-C(INT-I) TO STR-T
                                   EVALUATE TRIM(STR-T)
                                          WHEN "J"
                                                 MOVE 11 TO INT-K
                                          WHEN "Q"
                                                 MOVE 12 TO INT-K
                                          WHEN "K"
                                                 MOVE 13 TO INT-K
                                          WHEN "A"
                                                 MOVE 14 TO INT-K
                                          WHEN "2"
                                                 MOVE 15 TO INT-K
                                          WHEN OTHER
                                                 MOVE STR-T TO INT-K
                                   END-EVALUATE
                                   IF INT-K > INT-E THEN
                                          MOVE INT-J TO INT-R(INT-I)
                                          ADD 1 TO INT-J
                                          MOVE INT-I TO INT-P
                                          MOVE INT-K TO INT-E
                                   END-IF
                            END-IF
                     END-PERFORM
              END-PERFORM.
              
              PERFORM WITH TEST AFTER
              VARYING INT-I FROM 1 BY 1 UNTIL INT-I >= 52
                     MOVE INT-R(INT-I) TO INT-Z
                     DISPLAY TRIM(INT-Z)
              END-PERFORM.
              
       END PROGRAM MAIN.
