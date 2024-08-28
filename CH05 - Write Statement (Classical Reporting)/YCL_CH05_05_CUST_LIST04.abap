REPORT YCL_CH05_05_CUST_LIST04 LINE-SIZE 140 LINE-COUNT 60(3) NO STANDARD PAGE HEADING.

*************************************************************
* Simple Customer List - NON STANDARD PAGE HEADER & FOOTER *
*************************************************************

* Define a structure to hold customer data
DATA: BEGIN OF CUST_STRU,
        KUNNR LIKE KNA1-KUNNR,   " Customer Number
        NAME1 LIKE KNA1-NAME1,   " Name of the Customer
        STRAS LIKE KNA1-STRAS,   " Street Address
        ORT01 LIKE KNA1-ORT01,   " City
        PSTLZ LIKE KNA1-PSTLZ,   " Postal Code
      END OF CUST_STRU,
      DATE_CHR(10) TYPE C,       " Date in character format
      NXT_PAGE(3) TYPE N.        " To store the next page number

***********************************************************************
* Page header section
***********************************************************************
TOP-OF-PAGE.
  " Print the page header including the date and page number
  WRITE:/5 TEXT-001, DATE_CHR, 130 TEXT-002, 137(3) SY-PAGNO. " Header text and page number
  SKIP 1. " Skip a line for spacing
  WRITE:/5(135) SY-ULINE. " Print a horizontal line for separation
  " Print column headers
  WRITE:/6 TEXT-003, 12 TEXT-004, 23 TEXT-005, 60 TEXT-006,
       96 TEXT-007, 130 TEXT-008.
  WRITE:/6 TEXT-009, 13 TEXT-010, 131 TEXT-010.
  WRITE:/5(135) SY-ULINE. " Print another horizontal line for separation

***********************************************************************
* Page footer section
***********************************************************************
END-OF-PAGE.
  " Prepare the next page number and print footer
  NXT_PAGE = SY-PAGNO + 1. " Increment the page number
  SKIP 1. " Skip a line for spacing
  WRITE:/60 TEXT-011, (3) NXT_PAGE. " Print footer with the next page number

***********************************************************************
* Start of selection event - main processing logic
***********************************************************************
START-OF-SELECTION.

  " Format the current date in DD/MM/YYYY
  CONCATENATE SY-DATUM+6(2) '/' SY-DATUM+4(2) '/' SY-DATUM+0(4)
              INTO DATE_CHR.

  " Select customer data from KNA1 table
  SELECT KUNNR NAME1 STRAS ORT01 PSTLZ FROM KNA1 INTO CUST_STRU UP TO 51 ROWS.
    " Output the customer data
    WRITE:/5(5) SY-DBCNT,               " Row number
             CUST_STRU-KUNNR USING NO EDIT MASK,  " Customer Number
             CUST_STRU-NAME1,           " Customer Name
             CUST_STRU-STRAS,           " Street Address
             CUST_STRU-ORT01,           " City
             CUST_STRU-PSTLZ.           " Postal Code
  ENDSELECT.
