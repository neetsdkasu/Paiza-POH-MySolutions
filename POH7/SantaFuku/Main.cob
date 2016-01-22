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
                     05 char_val  PIC X.
                     05 digit     PIC 9.
                     05 val       BINARY-DOUBLE VALUE 0.
                     05 i         BINARY-SHORT.
                     05 j         BINARY-SHORT.
                     05 t         BINARY-SHORT VALUE 0.
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
                     05 n         BINARY-SHORT.
                     05 ans       BINARY-DOUBLE.
                     05 show      PIC Z(15).
       PROCEDURE DIVISION.
       MainRoutine SECTION.
       000-Main.
              ACCEPT str_val.
              MOVE 1 TO i.
        
       001-Split.
              MOVE 0 TO val.
              PERFORM WITH TEST AFTER UNTIL i > 100
                     MOVE str_val(i:1) TO char_val
                     ADD 1 TO i
                     IF char_val = SPACE THEN
                            *> DISPLAY val
                            EXIT PERFORM
                     END-IF
                     MOVE char_val TO digit
                     MULTIPLY 10 BY val
                     ADD digit TO val
              END-PERFORM.
              
       002-Bind.
              ADD 1 TO t.
              EVALUATE t ALSO MOD(t, 2)
                     WHEN 1 ALSO ANY
                            MOVE val TO x xmin
                            GO TO 001-Split
                     WHEN 2 ALSO ANY
                            MOVE val TO y ymin
                            GO TO 001-Split
                     WHEN 3 ALSO ANY
                            MOVE val TO z
                            GO TO 001-Split
                     WHEN 4 ALSO ANY
                            MOVE val TO n
                            IF n > 0 THEN
                                   GO TO 000-Main
                            ELSE
                                   GO TO 006-Answer
                            END-IF
                     WHEN ANY ALSO 1
                            MOVE val TO d
                            GO TO 001-Split
                     WHEN OTHER
                            IF d = 0 THEN
                                   GO TO 004-Calc-Xmin
                            ELSE
                                   GO TO 005-Calc-Ymin
                            END-IF
              END-EVALUATE.
              
       003-Check-Next.
              SUBTRACT 1 FROM n.
              IF n > 0 THEN
                     GO TO 000-Main
              ELSE
                     GO TO 006-Answer
              END-IF.
              
       004-Calc-Xmin.
              MOVE x TO tmp.
              SUBTRACT val FROM tmp.
              MOVE MIN(xmin, val, tmp) TO xmin
              PERFORM WITH TEST BEFORE VARYING j FROM 1 BY 1 UNTIL j > xc
                     MOVE xs(j) TO tmp
                     SUBTRACT val FROM tmp
                     MOVE MIN(xmin, ABS(tmp)) TO xmin
              END-PERFORM.
              ADD 1 TO xc.
              MOVE val TO xs(xc).
              GO TO 003-Check-Next.
       
       005-Calc-Ymin.
              MOVE y TO tmp.
              SUBTRACT val FROM tmp.
              MOVE MIN(ymin, val, tmp) TO ymin
              PERFORM WITH TEST BEFORE VARYING j FROM 1 BY 1 UNTIL j > yc
                     MOVE ys(j) TO tmp
                     SUBTRACT val FROM tmp
                     MOVE MIN(ymin, ABS(tmp)) TO ymin
              END-PERFORM.
              ADD 1 TO yc.
              MOVE val TO ys(yc).
              GO TO 003-Check-Next.
       
       006-Answer.
              MOVE xmin TO ans.
              MULTIPLY ymin BY ans.
              MULTIPLY z BY ans.
              MOVE ans TO show.
              DISPLAY TRIM(show).
              
       END PROGRAM Main.
