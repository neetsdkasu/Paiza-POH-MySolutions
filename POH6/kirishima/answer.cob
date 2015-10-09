       *>
       *> 結果 https://paiza.jp/poh/joshibato/kirishima/result/bb55c60c
       *>
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Answer.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
              FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
              01 Answer-Values.
                     05 n      BINARY-CHAR UNSIGNED.  *> PIC 9(4) とかより便利そうなのあるじゃん
                     05 m      BINARY-CHAR UNSIGNED.
                     05 d      BINARY-SHORT.
                     05 x      BINARY-SHORT.
                     05 i      BINARY-SHORT UNSIGNED.
                     05 j      BINARY-SHORT UNSIGNED.
                     05 t_str  PIC X(1000).
                     05 t_cnt  BINARY-SHORT UNSIGNED.
                     05 tbl    OCCURS 100 TIMES.
                            10 t       BINARY-SHORT.
                            10 f       BINARY-CHAR UNSIGNED.
       PROCEDURE DIVISION.
       AnswerMain SECTION.
       000-Start.
       
              ACCEPT n.
              ACCEPT t_str.
              
              *> 文字列の分割でけた
              PERFORM WITH TEST AFTER VARYING i FROM 1 BY 1 UNTIL i = n
                     UNSTRING t_str DELIMITED BY ALL SPACES INTO t(i) COUNT IN t_cnt
                     ADD 2 TO t_cnt
                     MOVE t_str(t_cnt:100) TO t_str
              END-PERFORM.
              
              ACCEPT m.
              
              PERFORM WITH TEST AFTER VARYING i FROM 1 BY 1 UNTIL i = m
                     ACCEPT d
                     PERFORM WITH TEST AFTER VARYING j FROM 1 BY 1 UNTIL j = n
                            MOVE 0 TO f(j)
                     END-PERFORM
                     PERFORM WITH TEST AFTER VARYING j FROM 1 BY 1 UNTIL j > n
                            IF d < 1 OR d >= n THEN
                                   DISPLAY "No"
                                   ExIT PERFORM
                            END-IF
                            IF d = n - 1 THEN
                                   DISPLAY "Yes"
                                   EXIT PERFORM
                            END-IF
                            COMPUTE x = d + 1
                            IF t(x) = 0 THEN
                                   DISPLAY "No"
                                   EXIT PERFORM
                            END-IF
                            IF f(x) = 1 THEN
                                   DISPLAY "No"
                                   EXIT PERFORM
                            END-IF
                            MOVE 1 TO f(x)
                            ADD t(x) TO d
                     END-PERFORM
              END-PERFORM.
              
       END PROGRAM Answer.
