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
      NXT_PAGE(3) TYPE N,        " To store the next page number
      FLAG(1) TYPE C.           " Flag for conditional footer output

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
  " Footer output is conditional based on the FLAG variable
 
