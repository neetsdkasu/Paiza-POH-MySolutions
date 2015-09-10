       IDENTIFICATION DIVISION.
       PROGRAM-ID. Hello.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
              FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
              01 Hello-Values.
                     05 n PIC 9(4).
                     05 i PIC 9(4).
                     05 j PIC 9(4).
                     05 k PIC 9(4).
                     05 t PIC A(10).
                     05 c PIC A(10).
                     05 r PIC A(10).
                     05 p PIC A(5000).
                     05 a OCCURS 1000 TIMES.
                            10 w PIC A(10).
       PROCEDURE DIVISION.
       MainRoutine SECTION.
       000-Main.
              ACCEPT n.
              PERFORM WITH TEST AFTER VARYING i FROM 1 BY 1 UNTIL i = n
                     ACCEPT w(i)
              END-PERFORM
              IF n = 1 THEN
                     GO TO 002-Make-Palindome.
       001-Sort.
              PERFORM WITH TEST AFTER VARYING i FROM 1 BY 1 UNTIL i = n - 1
                     MOVE i TO k
                     PERFORM WITH TEST AFTER VARYING j FROM i BY 1 UNTIL j + 1 = n
                            IF w(j + 1) < w(k) THEN
                                   COMPUTE k = j + 1
                            END-IF
                     END-PERFORM
                     IF k NOT = i THEN
                            MOVE w(k) TO t
                            MOVE w(i) TO w(k)
                            MOVE t TO w(i)
                     END-IF
              END-PERFORM
              .
       002-Make-Palindome.
              PERFORM WITH TEST AFTER VARYING i FROM 1 BY 1 UNTIL i = n
                     IF W(i) NOT = SPACES THEN
                            MOVE REVERSE(TRIM(w(i))) TO r
                            PERFORM WITH TEST AFTER VARYING j FROM i BY 1 UNTIL j >= n - 1
                                   IF w(j + 1) = r THEN
                                         MOVE CONCATENATE(TRIM(p), TRIM(w(i))) TO p
                                         MOVE SPACES TO w(j + 1)
                                         EXIT PERFORM
                                   END-IF
                            END-PERFORM
                            IF j >= n - 1 AND w(i) = r THEN
                                   IF c = SPACES OR r < c THEN
                                          MOVE r TO c
                                   END-IF
                            END-IF
                     END-IF
              END-PERFORM
              .
       003-Show-Palindome.
              IF p NOT = SPACES THEN
                     DISPLAY TRIM(p) WITH NO ADVANCING.
              IF c NOT = SPACES THEN
                     DISPLAY TRIM(c) WITH NO ADVANCING.
              IF p NOT = SPACES THEN
                     DISPLAY REVERSE(TRIM(p)) WITH NO ADVANCING.
       END PROGRAM Hello.
