       *>
       *> 結果 https://paiza.jp/poh/joshibato/rio/result/2506c7df
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
                     05 w          PIC 9(11)V9(24) VALUE 0.0. *> 9(11)V9(24)は計算用 9(11).9(24)だと文字出力用？
                     05 c          PIC 9(11)V9(24) VALUE 0.0. *> 最大36文字までらしい
                     05 wc         PIC 9(11)V9(24).
                     05 ans        PIC 9(11)V9(24).
                     05 dsp        PIC Z(10)9.        *> Zは表示用,9での上位桁の0をスペースに置き換える
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
                            COMPUTE wc = w + c  *> 面倒なのでCOMPUTEで処理ｗ
                            COMPUTE w = (w * wc - NUMVAL(s) * w) / wc
                            COMPUTE c = (c * wc - NUMVAL(s) * c) / wc
                     END-IF
              END-PERFORM.
              COMPUTE wc = w + c.
              COMPUTE ans = 100 * c / wc.
              MOVE ans TO dsp.
              DISPLAY TRIM(dsp).
       END PROGRAM Answer.
