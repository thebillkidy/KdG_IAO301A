      ********************************************
      * KLANTENBEHEER
      *
      * DIT PROGRAMMA LAAT TOE OM:
      * - EEN KLANT TOE TE VOEGEN
      * - EEN KLANT TE WISSEN
      * - KLANTGEGEVENS TE WIJZIGEN
      *
      * ER WORDT GEBRUIK GEMAAKT VAN FULL SCREEN IO
      *
      ********************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. KLANTENBEHEER.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OPTIONAL KLANTEN ASSIGN TO "BESTANDEN/KLANTEN"
                  ACCESS MODE IS RANDOM
                  ORGANIZATION IS INDEXED
                  RECORD KEY IS NR.

       DATA DIVISION.
       FILE SECTION.
       FD  KLANTEN BLOCK CONTAINS 10 RECORDS.
       01  KLANT.
           02 NR       PIC 9(7).
           02 NAAM     PIC X(20).
           02 STRAAT   PIC X(30).
           02 POSTCODE PIC X(8).
           02 GEMEENTE PIC X(20).
           02 TEL      PIC X(13).

       WORKING-STORAGE SECTION.
       77  MENUWAARDE PIC 9 VALUE 0.
           88 MENU-WAARDE-GELDIG VALUES 0 THRU 3.
           88 M-VOEGTOE   VALUE 1.
           88 M-VERWIJDER VALUE 2.
           88 M-WIJZIG    VALUE 3.
           88 M-EINDE     VALUE 0.
       77  FOUTMELDING PIC X(79).
       77  INVOERSTATUS PIC X.
           88 INVOER-OK VALUE "J".
           88 INVOER-NOK VALUE "N".

       SCREEN SECTION.
       01  HOOFDMENU.
           02 BLANK SCREEN.
           02 LINE 6 COL 23  VALUE "KIES EEN VAN VOLGENDE OPTIES:".
           02 LINE 8 COL 25  VALUE "1. VOEG KLANT TOE".
           02 LINE 9 COL 25  VALUE "2. VERWIJDER KLANT".
           02 LINE 10 COL 25 VALUE "3. WIJZIG KLANTGEGEVENS".
           02 LINE 12 COL 25 VALUE "0. EINDE".
           02 LINE 20 COL 1  VALUE "UW SELECTIE:".
           02 LINE 20 COL 15 PIC Z USING MENUWAARDE.
           02 LINE 24 COL 1  PIC X(79) FROM FOUTMELDING.
       01 VOEGTOESCHERM.
           02 BLANK SCREEN.
           02 LINE 6  COL 23 VALUE "VUL HIER DE GEGEVENS IN:".
       01 KLANTNRSCHERM.
           02 LINE 8  COL 23 VALUE "KLANTNUMMER:".
           02 LINE 8  COL 41 PIC 9(7) USING NR.
       01 GEGEVENSSCHERM.
           02 LINE 9  COL 23 VALUE "NAAM:".
           02 LINE 10 COL 23 VALUE "STRAAT EN NUMMER:".
           02 LINE 11 COL 23 VALUE "POSTCODE:".
           02 LINE 12 COL 23 VALUE "GEMEENTE:".
           02 LINE 13 COL 23 VALUE "TELEFOONNR.:".
           02 LINE 9  COL 41 PIC X(20) USING NAAM.
           02 LINE 10 COL 41 PIC X(30) USING STRAAT.
           02 LINE 11 COL 41 PIC X(8) USING POSTCODE.
           02 LINE 12 COL 41 PIC X(20) USING GEMEENTE.
           02 LINE 13 COL 41 PIC X(13) USING TEL.
           02 LINE 24 COL 1 PIC X(79) FROM FOUTMELDING.
       01 WIJZIGSCHERM.
           02 BLANK SCREEN.
           02 LINE 6  COL 23 VALUE "WIJZIG DE KLANTGEGEVENS:".
       01 VERWIJDERSCHERM.
           02 BLANK SCREEN.
           02 LINE 6 COL 23 VALUE "KLANT VERWIJDEREN".
       01 KLANTNUMMERSCHERM.
           02 BLANK SCREEN.
           02 LINE 8 COL 23 VALUE "GEEF HET KLANTNUMMER:".
           02 LINE 8 COL 45 PIC 9(7) USING NR.
           02 LINE 24 COL 1 PIC X(79) FROM FOUTMELDING.

       PROCEDURE DIVISION.

       MAIN.
           PERFORM INITIALISEER
           PERFORM DOETAAK WITH TEST AFTER UNTIL M-EINDE
           PERFORM SLUITBESTAND
           STOP RUN.

       INITIALISEER.
           OPEN I-O KLANTEN.

       DOETAAK.
           MOVE SPACES TO FOUTMELDING
           PERFORM HAALINPUT
           PERFORM TOONFOUT THRU HAALINPUT UNTIL MENU-WAARDE-GELDIG
           IF M-VOEGTOE
               PERFORM VOEGTOEPROC
           ELSE IF M-VERWIJDER
               PERFORM VERWIJDERPROC
           ELSE IF M-WIJZIG
               PERFORM WIJZIGPROC
           ELSE
               PERFORM EINDEPROC
           END-IF.

       TOONFOUT.
           MOVE "KIES EEN WAARDE TUSSEN 0 EN 3!" TO FOUTMELDING.

       HAALINPUT.
           DISPLAY HOOFDMENU
           ACCEPT HOOFDMENU.

       VOEGTOEPROC.
           MOVE ALL "_" TO KLANT
           PERFORM WITH TEST AFTER UNTIL INVOER-OK
               SET INVOER-OK TO TRUE
               DISPLAY VOEGTOESCHERM
               DISPLAY KLANTNRSCHERM
               DISPLAY GEGEVENSSCHERM
               ACCEPT KLANTNRSCHERM
               ACCEPT GEGEVENSSCHERM
               PERFORM CLEANUPKLANT
               WRITE KLANT INVALID KEY PERFORM FOUTTOEVOEGEN
               END-WRITE
           END-PERFORM.

       CLEANUPKLANT.
           INSPECT KLANT REPLACING ALL "_" BY " "
      * DIT IS OM EEN BUG IN DE COMPILER TE OMZEILEN
           INSPECT NR REPLACING ALL X"00" BY SPACE
           INSPECT NAAM REPLACING ALL X"00" BY SPACE
           INSPECT STRAAT REPLACING ALL X"00" BY SPACE
           INSPECT POSTCODE REPLACING ALL X"00" BY SPACE
           INSPECT GEMEENTE REPLACING ALL X"00" BY SPACE
           INSPECT TEL REPLACING ALL X"00" BY SPACE.

       VERWIJDERPROC.
           MOVE ALL "_" TO NR
           PERFORM WITH TEST AFTER UNTIL INVOER-OK
               SET INVOER-OK TO TRUE
               DISPLAY VERWIJDERSCHERM
               DISPLAY KLANTNUMMERSCHERM
               ACCEPT KLANTNUMMERSCHERM
               PERFORM CLEANUPKLANT
               DELETE KLANTEN INVALID KEY PERFORM FOUTVERWIJDEREN
               END-DELETE
           END-PERFORM.

       WIJZIGPROC.
           MOVE ALL "_" TO NR
           PERFORM WITH TEST AFTER UNTIL INVOER-OK
               SET INVOER-OK TO TRUE
               DISPLAY KLANTNUMMERSCHERM
               ACCEPT KLANTNUMMERSCHERM
               PERFORM CLEANUPKLANT
               IF NOT NR=0
                   READ KLANTEN INVALID KEY PERFORM FOUTZOEKEN
                   END-READ
               END-IF
           END-PERFORM
           IF NOT NR=0
               PERFORM WITH TEST AFTER UNTIL INVOER-OK
                   SET INVOER-OK TO TRUE
                   DISPLAY WIJZIGSCHERM
                   DISPLAY GEGEVENSSCHERM
                   ACCEPT GEGEVENSSCHERM
                   PERFORM CLEANUPKLANT
                   REWRITE KLANT INVALID KEY PERFORM FOUTWIJZIGEN
                   END-REWRITE
               END-PERFORM
           END-IF.

       EINDEPROC.
           EXIT.

       SLUITBESTAND.
           CLOSE KLANTEN.

       FOUTTOEVOEGEN.
           MOVE "NUMMER BESTAAT REEDS!" TO FOUTMELDING
           SET INVOER-NOK TO TRUE.

       FOUTZOEKEN.
       FOUTWIJZIGEN.
       FOUTVERWIJDEREN.
           MOVE "NUMMER BESTAAT NIET!" TO FOUTMELDING
           SET INVOER-NOK TO TRUE.


