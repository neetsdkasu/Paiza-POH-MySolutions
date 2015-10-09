       *>
       *> 結果 https://paiza.jp/poh/joshibato/kirishima/result/9a0ae8c7
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
                     05 t_cnt  BINARY-SHORT.
                     05 t_len  BINARY-SHORT.
                     05 t_c    PIC X.
                     05 tbl    OCCURS 100 TIMES.
                            10 t       BINARY-SHORT.
                            10 f       BINARY-CHAR UNSIGNED.
       PROCEDURE DIVISION.
       AnswerMain SECTION.
       000-Start.
       
              ACCEPT n.
              ACCEPT t_str.
              
              MOVE 1 TO t_cnt.
              *> 文字列の分割でけた
              PERFORM WITH TEST AFTER VARYING i FROM 1 BY 1 UNTIL i = n
                     PERFORM WITH TEST AFTER VARYING j FROM t_cnt BY 1 UNTIL j = 1000
                            MOVE t_str(j:1) TO t_c
                            IF t_c = SPACE THEN
                                   EXIT PERFORM
                            END-IF
                     END-PERFORM
                     COMPUTE t_len = j - t_cnt
                     MOVE NUMVAL(t_str(t_cnt:t_len)) TO t(i)
                     COMPUTE t_cnt = j + 1
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
