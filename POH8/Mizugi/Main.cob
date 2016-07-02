       *> Try POH
       *> author: Leonardone @ NEETSDKASU
       *> ↓ 1行あたりの字数の目安
       *>==============================================================$
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Main.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
           FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 LF PIC X VALUE X"0A".
       01 Solver-Variables.
           05 INT-I   PIC 9(4).
           05 INT-N   PIC 9(10).
           05 INT-M   PIC 9(10).
           05 STR-Z   PIC Z(9)9.
           05 INT-F   PIC 9 VALUE IS 0.
           05 STR-C   PIC X.
           05 INT-O   PIC 999.
           05 ANSWER  BINARY-LONG.
           05 ARR OCCURS 26 TIMES.
               07 INT-T    BINARY-LONG.
       01 File-Variables.
           05 Access-Mode PIC X USAGE COMP-X VALUE 1.
           05 File-Handle PIC X(4) USAGE COMP-X.
           05 File-Offset PIC X(8) USAGE COMP-X VALUE 0.
           05 Read-Length PIC X(4) USAGE COMP-X VALUE 1000.
           05 Read-Buffer PIC X(1000).
       PROCEDURE DIVISION.
       000-Main SECTION.
              
           CALL "CBL_OPEN_FILE"
               USING "/dev/stdin" Access-Mode 0 0 File-Handle.
           
           PERFORM WITH TEST AFTER UNTIL INT-F >= 4
               
               CALL "CBL_READ_FILE"
                   USING File-Handle File-Offset
                         Read-Length 0 Read-Buffer
               
               PERFORM WITH TEST AFTER
               VARYING INT-I FROM 1 BY 1 UNTIL INT-I >= Read-Length
                   MOVE Read-Buffer(INT-I:1) TO STR-C
                   EVALUATE INT-F
                       WHEN 0
                           IF STR-C = SPACE THEN
                               MOVE STR-Z TO INT-N
                               MOVE 0 TO STR-Z
                               ADD 1 TO INT-F
                           ELSE
                               MOVE CONCATENATE(TRIM(STR-Z),STR-C)
                                   TO STR-Z
                           END-IF
                       WHEN 1
                           IF STR-C = LF THEN
                               MOVE STR-Z TO INT-M
                               ADD 1 TO INT-F
                           ELSE
                               MOVE CONCATENATE(TRIM(STR-Z),STR-C)
                                   TO STR-Z
                           END-IF
                       WHEN 2
                           IF STR-C = LF THEN
                               ADD 1 TO INT-F
                           ELSE
                               MOVE ORD(STR-C) TO INT-O
                               SUBTRACT 97 FROM INT-O
                               ADD 1 TO INT-T(INT-O)
                           END-IF
                       WHEN OTHER
                           IF STR-C = LF THEN
                               ADD 1 TO INT-F
                               EXIT PERFORM
                           ELSE
                               MOVE ORD(STR-C) TO INT-O
                               SUBTRACT 97 FROM INT-O
                               SUBTRACT 1 FROM INT-T(INT-O)
                           END-IF
                   END-EVALUATE
               END-PERFORM
               
               ADD Read-Length TO File-Offset
               
           END-PERFORM.
           
           CALL "CBL_CLOSE_FILE" USING File-Handle.      

           PERFORM WITH TEST AFTER
           VARYING INT-I FROM 1 BY 1 UNTIL INT-I >= 26
               IF INT-T(INT-I) < 0 THEN
                   SUBTRACT INT-T(INT-I) FROM ANSWER
               END-IF
           END-PERFORM.
           
           MOVE ANSWER TO STR-Z.
           DISPLAY TRIM(STR-Z).
              
       END PROGRAM Main.
