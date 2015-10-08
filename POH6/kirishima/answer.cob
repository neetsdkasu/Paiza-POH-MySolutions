       *>
       *>
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
                     05 n      BINARY-CHAR.  *> PIC 9(4) とかより便利そうなのあるじゃん
                     05 m      BINARY-CHAR.
                     05 d      BINARY-SHORT.
                     05 i      BINARY-SHORT.
                     05 j      BINARY-SHORT.
                     05 t_str  PIC X(1000).
                     05 t_cnt  BINARY-SHORT.
                     05 t_idx  BINARY-SHORT.
                     05 t_table OCCURS 100 TIMES.
                            10 t       BINARY-SHORT.
       PROCEDURE DIVISION.
       AnswerMain SECTION.
       000-Start.
       
              ACCEPT n.
              ACCEPT t_str.
              
              *> 文字列の分割でけた
              PERFORM WITH TEST AFTER VARYING i FROM 1 BY 1 UNTIL i = n
                     UNSTRING t_str DELIMITED BY ALL SPACES INTO t(i) COUNT IN t_cnt
                     DISPLAY t(i)
                     ADD 2 TO t_cnt
                     MOVE t_str(t_cnt:100) TO t_str
              END-PERFORM.
              
              
       END PROGRAM Answer.
