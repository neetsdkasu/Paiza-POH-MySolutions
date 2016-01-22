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
                     05 str_val   PIC X(100).
                     05 val       BINARY-DOUBLE VALUE 0.
                     05 j         BINARY-SHORT.
                     05 tbl       OCCURS 101 TIMES.
                            07 xs        BINARY-DOUBLE.
                            07 ys        BINARY-DOUBLE.
                     05 xc        BINARY-SHORT VALUE 0.
                     05 yc        BINARY-SHORT VALUE 0.
                     05 xmin      BINARY-DOUBLE.
                     05 ymin      BINARY-DOUBLE.
                     05 tmp       BINARY-DOUBLE.
                     05 x         BINARY-DOUBLE.
                     05 y         BINARY-DOUBLE.
                     05 z         BINARY-DOUBLE.
                     05 d         BINARY-SHORT.
                     05 a         BINARY-DOUBLE.
                     05 n         BINARY-SHORT.
                     05 ans       BINARY-DOUBLE.
                     05 show      PIC Z(15).
       PROCEDURE DIVISION.
       MainRoutine SECTION.
       000-Main.
              ACCEPT str_val.
              UNSTRING str_val DELIMITED BY " " INTO x y z n
              *> DISPLAY x y z n
              MOVE x TO xmin.
              MOVE y TO ymin.
              
       001-Check-Next.
              IF n > 0 THEN
                     SUBTRACT 1 FROM n
                     ACCEPT str_val
                     UNSTRING str_val DELIMITED BY " " INTO d a
                     *> DISPLAY d a
                     IF d = 0 THEN
                            GO TO 002-Calc-Xmin
                     ELSE
                            GO TO 003-Calc-Ymin
                     END-IF
              ELSE
                     GO TO 004-Answer
              END-IF.
              
       002-Calc-Xmin.
              MOVE x TO tmp.
              SUBTRACT a FROM tmp.
              MOVE MIN(xmin, a, tmp) TO xmin
              PERFORM WITH TEST BEFORE VARYING j FROM 1 BY 1 UNTIL j > xc
                     MOVE xs(j) TO tmp
                     SUBTRACT a FROM tmp
                     MOVE MIN(xmin, ABS(tmp)) TO xmin
              END-PERFORM.
              ADD 1 TO xc.
              MOVE a TO xs(xc).
              GO TO 001-Check-Next.
       
       003-Calc-Ymin.
              MOVE y TO tmp.
              SUBTRACT a FROM tmp.
              MOVE MIN(ymin, a, tmp) TO ymin
              PERFORM WITH TEST BEFORE VARYING j FROM 1 BY 1 UNTIL j > yc
                     MOVE ys(j) TO tmp
                     SUBTRACT a FROM tmp
                     MOVE MIN(ymin, ABS(tmp)) TO ymin
              END-PERFORM.
              ADD 1 TO yc.
              MOVE a TO ys(yc).
              GO TO 001-Check-Next.
       
       004-Answer.
              MOVE xmin TO ans.
              MULTIPLY ymin BY ans.
              MULTIPLY z BY ans.
              MOVE ans TO show.
              DISPLAY TRIM(show).
              
       END PROGRAM Main.
