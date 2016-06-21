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
              05 STR-AS  PIC X(5000).
              05 INT-ARR OCCURS 100 TIMES.
                     07 INT-A PIC 999.
              05 STR-C PIC X.
              05 INT-X PIC 999 VALUE IS 0.
              05 INT-I PIC 999.
              05 INT-J PIC 999 VALUE IS 1.
              05 INT-K PIC 999.
              05 INT-Z PIC ZZ9.
              05 INT-LEN PIC 99999.
       PROCEDURE DIVISION.
       MAIN-ROUTINE SECTION.
       000-MAIN.
              
              ACCEPT INT-N.
              ACCEPT STR-AS.
              
              MOVE STORED-CHAR-LENGTH(STR-AS) TO INT-LEN.
              
              PERFORM WITH TEST AFTER
              VARYING INT-I FROM 1 BY 1
              UNTIL INT-I >= INT-LEN
                     MOVE STR-AS(INT-I:1) TO STR-C
                     IF STR-C = SPACE THEN
                            MOVE INT-X TO INT-A(INT-J)
                            ADD 1 TO INT-J
                            MOVE 0 TO INT-X
                     ELSE
                            MULTIPLY 10 BY INT-X
                            ADD INTEGER(STR-C) TO INT-X
                     END-IF
              END-PERFORM.
              MOVE INT-X TO INT-A(INT-J).
              
              PERFORM WITH TEST AFTER
              VARYING INT-I FROM 1 BY 1
              UNTIL INT-I >= INT-N
                     MOVE INT-I TO INT-K
                     PERFORM WITH TEST BEFORE
                     VARYING INT-J FROM INT-N BY -1
                     UNTIL INT-J <= INT-I
                         IF INT-A(INT-K) > INT-A(INT-J) THEN
                                MOVE INT-J TO INT-K
                         END-IF
                     END-PERFORM
                     MOVE INT-A(INT-K) TO INT-X
                     MOVE INT-A(INT-I) TO INT-A(INT-K)
                     MOVE INT-X TO INT-A(INT-I)
              END-PERFORM.
              
              ADD 1 TO INT-N.
              DIVIDE INT-N BY 2 GIVING INT-N.
              MOVE INT-A(INT-N) TO INT-Z.
              
              DISPLAY TRIM(INT-Z).
              
       END PROGRAM MAIN.
