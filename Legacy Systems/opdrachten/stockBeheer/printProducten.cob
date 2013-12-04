       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRINT-PRODUCTEN.
       AUTHOR. XAVIER.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT Stock ASSIGN TO "BESTANDEN/STOCK.DAT"
                  ACCESS MODE IS SEQUENTIAL
                  ORGANIZATION IS INDEXED
                  RECORD KEY IS NR.

       DATA DIVISION.
       FILE SECTION.
       FD  Stock BLOCK CONTAINS 10 RECORDS.
       01  PRODUCT.
           02 NR       PIC X(6).
           02 NAAM     PIC X(40).
           02 INSTOCK  PIC 9(4).
       WORKING-STORAGE SECTION.
       77  NRKOP      PIC X(6) VALUE "  NR  ".
       77  NAAMKOP    PIC X(40) VALUE "                  NAAM         ".
       77  INSTOCKKOP PIC X(4) VALUE "STOC".
       77  GEDAAN     PIC X(1).
           88 STOPLEZEN VALUE "J".

       PROCEDURE DIVISION.

       MAIN.
           PERFORM INITIALISEER
           PERFORM PRINTSTOCK
           PERFORM SLUITBESTAND
           STOP RUN.

       INITIALISEER.
           MOVE ZEROS TO PRODUCT
           MOVE "N" TO GEDAAN
           OPEN INPUT Stock.

       PRINTSTOCK.
           PERFORM PRINTHEADLINES
           DISPLAY "|" NRKOP "|" NAAMKOP WITH NO ADVANCING
           DISPLAY "|" INSTOCKKOP "|"
           PERFORM PRINTHEADLINES
           PERFORM PRINTPRODUCT UNTIL STOPLEZEN
           PERFORM PRINTHEADLINES.

       PRINTHEADLINES.
           DISPLAY "+------+" WITH NO ADVANCING
           PERFORM PRINTMIN 40 TIMES
           DISPLAY "+" WITH NO ADVANCING
           PERFORM PRINTMIN 4 TIMES
           DISPLAY "+".

       PRINTMIN.
           DISPLAY "-" WITH NO ADVANCING.

       PRINTPRODUCT.
           READ Stock AT END MOVE "J" TO GEDAAN
           END-READ
           IF NOT STOPLEZEN
               DISPLAY "|" NR "|" NAAM "|" WITH NO ADVANCING
               DISPLAY INSTOCK "|"
           END-IF.

       SLUITBESTAND.
           CLOSE Stock.