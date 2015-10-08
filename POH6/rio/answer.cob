       *>
       *> 結果 https://paiza.jp/poh/joshibato/rio/result/6957daab
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
                     05 n          PIC 9(2).  *> 05 である必要はなく 02 n PIC 9(2). でもよいらしい
                     05 i          PIC 9(2).
                     05 w          PIC 9(4)V9(20) VALUE 0.0. *> 9(4)V9(20)は計算用 9(4).9(20)だと文字出力用？
                     05 c          PIC 9(4)V9(20) VALUE 0.0.
                     05 wc         PIC 9(4)V9(20).
                     05 ans        PIC 9(4)V9(20).
                     05 x1         PIC 9(4)V9(20).
                     05 x2         PIC 9(4)V9(20).
                     05 dsp        PIC Z(4).        *> Zは表示用,9での上位桁の0をスペースに置き換える
                     05 tas.
                            10 t   PIC 9(2). *> tが1桁と分かっているので文字数決め打ち分割
                            10 s   PIC 9(3). *> sは3桁までなので
       PROCEDURE DIVISION.
       MainRoutine SECTION.
       000-Main.
              ACCEPT n.
              PERFORM WITH TEST AFTER VARYING i FROM 1 BY 1 UNTIL i = n
                     ACCEPT tas
                     IF NUMVAL(t) = 1 THEN
                            ADD NUMVAL(s) TO w
                     END-IF
                     IF NUMVAL(t) = 2 THEN *> 流石にELSEネストはキツイ
                            ADD NUMVAL(s) TO c
                     END-IF
                     IF NUMVAL(t) = 3 THEN
                        MOVE w TO wc
                        ADD c TO wc
                        
                        MOVE w TO x1
                        MULTIPLY wc BY x1
                        MOVE NUMVAL(s) TO x2
                        MULTIPLY w BY x2
                        ADD x2 TO x1
                        DIVIDE wc INTO x1
                        MOVE x1 TO w

                        MOVE c TO x1
                        MULTIPLY wc BY x1
                        MOVE NUMVAL(s) TO x2
                        MULTIPLY c BY x2
                        ADD x2 TO x1
                        DIVIDE wc INTO x1
                        MOVE x1 TO c
                        
                     END-IF
              END-PERFORM.
              
              MOVE w TO wc.
              ADD c TO wc.
              
              MOVE 100 TO ans.
              MULTIPLY c BY ans.
              DIVIDE wc INTO ans.
              
              MOVE ans TO dsp.
              DISPLAY TRIM(dsp).
       END PROGRAM Answer.
