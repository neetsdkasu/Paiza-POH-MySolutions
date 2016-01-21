       *> Try POH
       *> author: Leonardone @ NEETSDKASU
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Main.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
              FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
              01 Variables.
                     05 n     BINARY-DOUBLE.
                     05 i     BINARY-DOUBLE.
                     05 x     BINARY-DOUBLE.
                     05 c     BINARY-DOUBLE VALUE 0.
                     05 r     BINARY-DOUBLE VALUE 1.
                     05 z     PIC Z(9).
       PROCEDURE DIVISION.
       MainRoutine SECTION.
       000-Main.
              ACCEPT n.
              DIVIDE n BY 5 GIVING x.
              MOVE INTEGER(x) TO x.
              PERFORM WITH TEST BEFORE UNTIL x < 1
                    ADD x TO c
                    DIVIDE x BY 5 GIVING x
                    MOVE INTEGER(x) TO x
              END-PERFORM.
              PERFORM WITH TEST AFTER VARYING i FROM 1 BY 1 UNTIL i = n
                     MOVE i TO x
                     PERFORM WITH TEST BEFORE UNTIL MOD(x, 5) <> 0
                            DIVIDE x BY 5 GIVING x 
                            MOVE INTEGER(x) TO x
                     END-PERFORM
                     IF c > 0 THEN
                            PERFORM WITH TEST BEFORE UNTIL MOD(x, 2) <> 0
                                   DIVIDE x BY 2 GIVING x 
                                   MOVE INTEGER(x) TO x
                                   SUBTRACT 1 FROM c
                                   IF c < 1 THEN EXIT PERFORM
                            END-PERFORM
                     END-IF
                     MULTIPLY x BY r
                     MOVE MOD(r, 1000000000) TO r
              END-PERFORM.
              MOVE r TO z.
              DISPLAY TRIM(z).
       END PROGRAM Main.
