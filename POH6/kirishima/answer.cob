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
                     05 n      PIC 9(3).
                     05 m      PIC 9(3).
                     05 d      PIC 9(3).
                     05 i      PIC 9(3).
       PROCEDURE DIVISION.
       AnswerMain SECTION.
       000-Start.
              ACCEPT n.
              DISPLAY n.
       END PROGRAM Answer.
