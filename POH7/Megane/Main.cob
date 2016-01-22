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
                     05 n       BINARY-SHORT.
                     05 m       BINARY-SHORT.
                     05 pq      OCCURS 200 TIMES.
                           07 p       PIC X(200).
                           07 q       PIC X(200).
                     05 x       PIC ZZZ9.
                     05 y       PIC ZZZ9.
                     05 i       BINARY-SHORT.
                     05 j       BINARY-SHORT.
                     05 t       PIC X(200).
                     05 f       BINARY-SHORT.
                     05 k       BINARY-SHORT.
                     05 mlen    BINARY-SHORT.
                     05 j2      BINARY-SHORT.
                     05 ii      BINARY-SHORT.

       PROCEDURE DIVISION.
       MainRoutine SECTION.
       000-Main.
              ACCEPT n.
              PERFORM WITH TEST AFTER VARYING i FROM 1 BY 1 UNTIL i = n
                    ACCEPT p(i)
              END-PERFORM.
              ACCEPT m.
              PERFORM WITH TEST AFTER VARYING i FROM 1 BY 1 UNTIL i = n
                    ACCEPT q(i)
              END-PERFORM.
              MOVE m TO mlen.
              MULTIPLY 2 BY mlen.
              SUBTRACT 1 FROM mlen.
              PERFORM WITH TEST AFTER VARYING i FROM 0 BY 1 UNTIL i = n - m
                    PERFORM WITH TEST AFTER VARYING j FROM 0 BY 1 UNTIL j = n - m
                          MOVE 0 TO f
                          MOVE j TO j2
                          MULTIPLY 2 BY j2
                          ADD 1 TO j2
                          PERFORM WITH TEST AFTER VARYING k FROM 1 BY 1 UNTIL k = m
                                 MOVE i TO ii
                                 ADD k TO ii
                                 MOVE p(ii) TO t
                                 MOVE t(j2:mlen) TO t
                                 IF TRIM(q(k)) = TRIM(t) THEN
                                       ADD 1 TO f
                                 END-IF
                          END-PERFORM
                          IF f = m THEN
                              MOVE i TO y
                              MOVE j TO x
                              DISPLAY TRIM(y) " " TRIM(x)
                          END-IF
                    END-PERFORM
              END-PERFORM.
              
       END PROGRAM Main.
