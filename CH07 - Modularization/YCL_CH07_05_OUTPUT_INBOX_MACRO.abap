REPORT YCL_CH07_05_OUTPUT_INBOX_MACRO NO STANDARD PAGE HEADING
LINE-COUNT 60 LINE-SIZE 75.

********************************************************************
* SAP Icon List - Use Macro To Impart Color & Enclose Output In Box *
* Use Subroutine to Output Report Header Instead of TOP-OF-PAGE     *
* Event                                                             *
********************************************************************

TABLES: ICON.

DATA: COL    TYPE SY-COLNO,     " Current column number
      LIN    TYPE SY-LINNO,     " Current line number
      LENGTH TYPE I,            " Length of horizontal line
      PG     TYPE SY-PAGNO,     " Page number
      CNTR   TYPE I,            " Line counter
      CNT(6) TYPE C.            " Counter to suppress thousand separator

********************************************************************
* Macro: WRITE_GRID                                                *
* - Outputs a field enclosed in a box with specified formatting    *
* - The macro takes 5 parameters: field, width, inverse, intensified*
*   color                                                          *
********************************************************************

DEFINE WRITE_GRID.
  COL = SY-COLNO. LIN = SY-LINNO. " Save current column & line/row no.
  FORMAT INVERSE &3 INTENSIFIED &4 COLOR &5.
  WRITE: '|' NO-GAP, (&2) &1 NO-GAP, '|'. " Output field with left & right SY-VLINE
  LENGTH = SY-COLNO - COL. " Derive length of horizontal line

  LIN = LIN - 1. SKIP TO LINE LIN. POSITION COL.
  ULINE AT COL(LENGTH). " Top horizontal line
  LIN = LIN + 2. SKIP TO LINE LIN. POSITION COL.
  ULINE AT COL(LENGTH). " Bottom horizontal line
  LIN = LIN - 1. COL = SY-COLNO - 2.
  SKIP TO LINE LIN. " Set line & column no for next output
  POSITION COL.
END-OF-DEFINITION.

********************************************************************
* START-OF-SELECTION Event                                          *
* - Select data from ICON table and output it using the macro       *
********************************************************************

START-OF-SELECTION.

  SELECT * FROM ICON ORDER BY NAME.

    " Check if new page heading is needed
    IF CNTR >= 58 OR CNT IS INITIAL.
      PERFORM PHEAD.
    ENDIF.

    CNT = SY-DBCNT. " Set CNT to the current row number without commas
    WRITE_GRID CNT 6 ON OFF COL_TOTAL. " Output CNT (width 6) with specified format
    WRITE_GRID ICON-NAME 35 ON OFF COL_KEY. " Output ICON-NAME (width 35)
    WRITE_GRID ICON-ID 7 ON OFF COL_POSITIVE. " Output ICON-ID (width 7)
    WRITE_GRID ICON+1(2) 4 ON OFF COL_HEADING. " Output ICON+1(2) (width 4)

    SKIP 2. " Skip two lines after output
    POSITION 5. " Set the column position to 5 for the next row
    CNTR = CNTR + 2. " Increase line count by 2

  ENDSELECT.

********************************************************************
* FORM PHEAD - Report Header                                        *
* - Output report header using the macro                            *
* - This subroutine is called when CNT is INITIAL or CNTR >= 58     *
********************************************************************

FORM PHEAD.

  NEW-PAGE NO-HEADING. " Start a new page without standard page heading
  PG = PG + 1. " Increment the page number
  WRITE 59(3) PG. " Output the page number at column 59

  SKIP 2. " Skip two lines for top horizontal line
  POSITION 5. " Start output from column 5

  WRITE_GRID TEXT-001 6 ON OFF COL_TOTAL. " Output column heading with width 6
  WRITE_GRID TEXT-002 35 ON OFF COL_KEY. " Output column heading with width 35
  WRITE_GRID TEXT-003 7 ON OFF COL_POSITIVE. " Output column heading with width 7
  WRITE_GRID TEXT-004 4 ON OFF COL_HEADING. " Output column heading with width 4

  SKIP 2. " Skip two lines after output
  POSITION 5. " Set column position to 5 for the next row
  CNTR = 4. " Reset line count to 4

ENDFORM.


" Explanation:
" WRITE_GRID Macro:

" This macro outputs a field enclosed in a box with left and right vertical lines (|), and top and bottom horizontal lines (ULINE).
" It formats the output based on the parameters for inverse display, intensified display, and color.
" After outputting a field, it adjusts the column and line numbers for the next output.
" START-OF-SELECTION:

" The main logic of the program is executed here.
" It retrieves data from the ICON table, checks if a new page header is needed, and then uses the WRITE_GRID macro to output the fields (CNT, ICON-NAME, ICON-ID, and ICON+1(2)) enclosed in boxes.
" PHEAD Subroutine:

" This subroutine generates the report header, including the page number and column headings.
" It uses the NEW-PAGE NO-HEADING statement to start a new page and the WRITE_GRID macro to format the headings.
" General Notes:

" The code uses SY-COLNO and SY-LINNO to manage the current column and line positions.
" The PG variable is used to keep track of the current page number.
" The CNTR variable tracks the current line count, ensuring proper spacing and triggering a new page header when needed.