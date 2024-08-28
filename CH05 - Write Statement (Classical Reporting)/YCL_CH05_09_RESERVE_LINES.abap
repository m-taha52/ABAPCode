REPORT YCL_CH05_09_RESERVE_LINES LINE-COUNT 55 LINE-SIZE 50
NO STANDARD PAGE HEADING.

***************************************************************
* Part Of Output Not Splitting Between Pages - RESERVE LINES **
***************************************************************

TABLES: YCL_CH05_KNAT5T.

****************************************************************
* Page Header Section
****************************************************************
TOP-OF-PAGE.
WRITE:/40 'Page:', (5) SY-PAGNO. " Print the page number in the header

****************************************************************
* Data Selection and Output
****************************************************************
START-OF-SELECTION.

  SELECT * FROM YCL_CH05_KNAT5T UP TO 1000 ROWS.

    " Reserve 6 lines on the current page
    RESERVE 6 LINES. 
    " If 6 lines are available on the current page, print the data.
    " Otherwise, the system will automatically handle page breaks.

    WRITE /5: YCL_CH05_KNAT5T-KUNNR USING NO EDIT MASK,
               YCL_CH05_KNAT5T-NAME1,
               YCL_CH05_KNAT5T-STRAS,
               YCL_CH05_KNAT5T-ORT01,
               YCL_CH05_KNAT5T-PSTLZ,
               YCL_CH05_KNAT5T-LANDX.
    SKIP 1. " Skip one line after each record

  ENDSELECT.
