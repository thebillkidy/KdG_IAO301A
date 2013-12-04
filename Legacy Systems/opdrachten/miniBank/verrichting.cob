      ************************************************************
      * VERRICHTING
      *
      * REGISTREERT EEN VERRICHTING EN LOGT DEZE IN HET BESTAND
      * "BESTANDEN/VERRICHTINGEN".
      *
      ************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. VERRICHTING.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OPTIONAL VERRICHTINGEN
                  ASSIGN TO "BESTANDEN/DAGVERRICHTINGEN".

       DATA DIVISION.
       FILE SECTION.
       FD VERRICHTINGEN BLOCK CONTAINS 10 RECORDS.
       01  VERRICHTING.
           02 SOORT PIC 9.
               88 OVERSCHRIJVING VALUE 1.
               88 STORTING       VALUE 2.
               88 AFHALING       VALUE 3.
           02 VAN.
               03 DEEL1 PIC 9(3).
               03 DEEL2 PIC 9(7).
               03 DEEL3 PIC 9(2).
           02 NAAR.
               03 DEEL1 PIC 9(3).
               03 DEEL2 PIC 9(7).
               03 DEEL3 PIC 9(2).
           02 BEDRAG.
               03 GEHEEL PIC 9(7).
               03 DECIMAAL PIC 9(2).
           02 DATUM  PIC 9(8).
           02 MEDEDELING PIC X(50).

       WORKING-STORAGE SECTION.
       77  MENUWAARDE PIC 9 VALUE 0.
           88 MENUWAARDE-GELDIG VALUES 0 THRU 3.
           88 MENU-OVERSCHR VALUE 1.
           88 MENU-STORTING VALUE 2.
           88 MENU-AFHALING VALUE 3.
           88 MENU-EINDE    VALUE 0.
       77  FOUTMELDING PIC X(79).

       SCREEN SECTION.
       01  HOOFDMENU.
           02 BLANK SCREEN.
           02 LINE  6 COL 23 VALUE "KIES EEN VAN VOLGENDE OPTIES:".
           02 LINE  8 COL 25 VALUE "1. OVERSCHRIJVING".
           02 LINE  9 COL 25 VALUE "2. STORTING".
           02 LINE 10 COL 25 VALUE "3. AFHALING".
           02 LINE 12 COL 25 VALUE "0. EINDE".
           02 LINE 20 COL  1 VALUE "UW SELECTIE:".
           02 LINE 20 COL 15 PIC Z USING MENUWAARDE.
           02 LINE 24 COL  1 PIC X(79) FROM FOUTMELDING.
       01  OVERSCHRIJVINGSCHERM.
           02 BLANK SCREEN.
           02 LINE  4 COL 13 VALUE "*** OVERSCHRIJVING ***".
           02 LINE  6 COL 9 VALUE "GEEF HIER DE GEGEVENS IN:".
           02 LINE  8 COL 9 VALUE "REKNR. OPDRACHTGEVER:    .       .".
           02 LINE  9 COL 9 VALUE "REKNR. BEGUNSTIGDE:    .       .".
           02 LINE 10 COL 9 VALUE "BEDRAG:        ,  ".
           02 LINE 11 COL 9 VALUE "MEDEDELING:".
           02 LINE  8 COL 31 PIC 9(3) USING DEEL1 IN VAN.
           02 LINE  8 COL 35 PIC 9(7) USING DEEL2 IN VAN.
           02 LINE  8 COL 43 PIC 9(2) USING DEEL3 IN VAN.
           02 LINE  9 COL 29 PIC 9(3) USING DEEL1 IN NAAR.
           02 LINE  9 COL 33 PIC 9(7) USING DEEL2 IN NAAR.
           02 LINE  9 COL 41 PIC 9(2) USING DEEL3 IN NAAR.
           02 LINE 10 COL 17 PIC 9(7) USING GEHEEL IN BEDRAG.
           02 LINE 10 COL 25 PIC 9(2) USING DECIMAAL IN BEDRAG.
           02 LINE 11 COL 21 PIC X(50) USING MEDEDELING.
       01 STORTINGSCHERM.
           02 BLANK SCREEN.
           02 LINE  4 COL 16 VALUE "*** STORTING ***".
           02 LINE  6 COL  9 VALUE "GEEF HIER DE GEGEVENS IN:".
           02 LINE  8 COL  9 VALUE "REKENINGNUMMER:    .       .".
           02 LINE  9 COL  9 VALUE "BEDRAG:        ,  ".
           02 LINE  8 COL 25 PIC 9(3) USING DEEL1 IN NAAR.
           02 LINE  8 COL 29 PIC 9(7) USING DEEL2 IN NAAR.
           02 LINE  8 COL 37 PIC 9(2) USING DEEL3 IN NAAR.
           02 LINE  9 COL 17 PIC 9(7) USING GEHEEL IN BEDRAG.
           02 LINE  9 COL 25 PIC 9(2) USING DECIMAAL IN BEDRAG.
       01 AFHALINGSCHERM.
           02 BLANK SCREEN.
           02 LINE  4 COL 16 VALUE "*** AFHALING ***".
           02 LINE  6 COL  9 VALUE "GEEF HIER DE GEGEVENS IN:".
           02 LINE  8 COL  9 VALUE "REKENINGNUMMER:    .       .".
           02 LINE  9 COL  9 VALUE "BEDRAG:        ,  ".
           02 LINE  8 COL 25 PIC 9(3) USING DEEL1 IN VAN.
           02 LINE  8 COL 29 PIC 9(7) USING DEEL2 IN VAN.
           02 LINE  8 COL 37 PIC 9(2) USING DEEL3 IN VAN.
           02 LINE  9 COL 17 PIC 9(7) USING GEHEEL IN BEDRAG.
           02 LINE  9 COL 25 PIC 9(2) USING DECIMAAL IN BEDRAG.

       PROCEDURE DIVISION.

       MAIN.
           PERFORM INITIALISEER
           PERFORM DOETAAK WITH TEST AFTER UNTIL MENU-EINDE
           PERFORM SLUIT-BESTAND
           STOP RUN.

       INITIALISEER.
           OPEN EXTEND VERRICHTINGEN.

       DOETAAK.
           MOVE SPACES TO FOUTMELDING
           PERFORM HAALINPUT
           PERFORM TOONFOUT THRU HAALINPUT UNTIL MENUWAARDE-GELDIG
           MOVE ALL "_" TO VERRICHTING
           IF MENU-OVERSCHR
               PERFORM DOE-OVERSCHRIJVING
           ELSE IF MENU-STORTING
               PERFORM DOE-STORTING
           ELSE IF MENU-AFHALING
               PERFORM DOE-AFHALING
           ELSE
               PERFORM DOE-EINDE
           END-IF.

       TOONFOUT.
           MOVE "KIES EEN WAARDE TUSSEN 0 EN 3!" TO FOUTMELDING.

       HAALINPUT.
           DISPLAY HOOFDMENU
           ACCEPT HOOFDMENU.

       DOE-OVERSCHRIJVING.
           DISPLAY OVERSCHRIJVINGSCHERM
           ACCEPT OVERSCHRIJVINGSCHERM
           SET OVERSCHRIJVING TO TRUE
           PERFORM SCHRIJF-WEG.

       DOE-STORTING.
           DISPLAY STORTINGSCHERM
           ACCEPT STORTINGSCHERM
           SET STORTING TO TRUE
           PERFORM SCHRIJF-WEG.

       DOE-AFHALING.
           DISPLAY AFHALINGSCHERM
           ACCEPT AFHALINGSCHERM
           SET AFHALING TO TRUE
           PERFORM SCHRIJF-WEG.

       DOE-EINDE.
           EXIT.

       SCHRIJF-WEG.
           ACCEPT DATUM FROM DATE
      * JAAR 2000 PROBLEEM OPLOSSEN!
           ADD 20000000 TO DATUM
           WRITE VERRICHTING.

       SLUIT-BESTAND.
           CLOSE VERRICHTINGEN.
