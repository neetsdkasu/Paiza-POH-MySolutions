       *> Try POH
       *> author: Leonardone @ NEETSDKASU
       *> ↓ 1行あたりの字数の目安
       *>==============================================================$
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAIN.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
              FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 ANSWER-VALUES.
              05 INT-N   BINARY-LONG.
              05 INT-M   BINARY-LONG.
              05 STR-NM  PIC X(30).
              05 STR-S   PIC A(200000).
              05 STR-T   PIC A(200000).
              05 INT-I   BINARY-LONG.
              05 INT-CH  BINARY-SHORT.
              05 ARR OCCURS 300 TIMES.
                     07 INT-TBL BINARY-LONG VALUE IS 0.
              05 INT-A   BINARY-LONG VALUE IS 0.
              05 INT-Z   PIC Z(6)9.
       PROCEDURE DIVISION.
       MAIN-ROUTINE SECTION.
       000-MAIN.
              
              ACCEPT STR-NM.
              ACCEPT STR-S.
              ACCEPT STR-T.
              
              UNSTRING STR-NM DELIMITED BY " " INTO INT-N INT-M.
              
              PERFORM WITH TEST AFTER
              VARYING INT-I FROM 1 BY 1 UNTIL INT-I >= INT-N
                    MOVE ORD(STR-S(INT-I:1)) TO INT-CH
                    ADD 1 TO INT-TBL(INT-CH)
              END-PERFORM.
              
              PERFORM WITH TEST AFTER
              VARYING INT-I FROM 1 BY 1 UNTIL INT-I >= INT-M
                    MOVE ORD(STR-T(INT-I:1)) TO INT-CH
                    SUBTRACT 1 FROM INT-TBL(INT-CH)
              END-PERFORM.
              
              PERFORM WITH TEST AFTER
              VARYING INT-I FROM ORD("a") BY 1 UNTIL INT-I >= ORD("z")
                    IF INT-TBL(INT-I) < 0 THEN
                           SUBTRACT INT-TBL(INT-I) FROM INT-A
                    END-IF
              END-PERFORM.
              
              MOVE INT-A TO INT-Z.
              DISPLAY TRIM(INT-Z).
              
       END PROGRAM MAIN.
