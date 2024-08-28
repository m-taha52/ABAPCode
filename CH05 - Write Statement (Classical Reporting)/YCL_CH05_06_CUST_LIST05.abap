REPORT YCL_CH05_06_CUST_LIST05 LINE-SIZE 140 LINE-COUNT 60
NO STANDARD PAGE HEADING.

******************************************
* Simple Customer List - Usage of COLOR *
******************************************
****************************************************************
* (1) Color can be specified with the FORMAT statement. All WRITE *
* statements will be output as per the color specified in the *
* FORMAT statement. *
* (2) However, if color is specified for fields in the WRITE *
* statement, this will override the FORMAT statement. *
* (3) FORMAT RESET will restore default colors. *
* (4) Only 8 colors are supported. *
* (5) Either the foreground (INVERSE ON) or the background *
* color (INVERSE OFF) can be controlled at a time, not both. *
* By default, INVERSE is OFF. *
* (6) Background color can be sharp (INTENSIFIED ON) or faint *
* (INTENSIFIED OFF). By default, INTENSIFIED is ON. *
* (7) Colors can be specified by color code 0,1,2,3,4,5,6,7 *
* or by name. See the color table. *
****************************************************************

DATA: BEGIN OF CUST_STRU,
        KUNNR LIKE KNA1-KUNNR,   " Customer Number
        NAME1 LIKE KNA1-NAME1,   " Customer Name
        STRAS LIKE KNA1-STRAS,   " Street Address
        ORT01 LIKE KNA1-ORT01,   " City
        PSTLZ LIKE KNA1-PSTLZ,   " Postal Code
      END OF CUST_STRU,
      DATE_CHR(10) TYPE C.       " Date in character format

******************************************************************
* Page Header Section
******************************************************************
TOP-OF-PAGE.
FORMAT RESET. " Reset to default colors for header
WRITE:/5 TEXT-001, DATE_CHR, 130 TEXT-002, 137(3) SY-PAGNO.
SKIP 1.
WRITE:/5(135) SY-ULINE. " Horizontal line for separation
WRITE:/6 TEXT-003, 12 TEXT-004, 23 TEXT-005, 60 TEXT-006, 
       96 TEXT-007, 130 TEXT-008.
WRITE:/6 TEXT-009, 13 TEXT-010, 131 TEXT-010.
WRITE:/5(135) SY-ULINE. " Another horizontal line for separation

**********************************************************************
* Data Selection and Output
**********************************************************************
START-OF-SELECTION.
  " Format the current date in DD/MM/YYYY
  CONCATENATE SY-DATUM+6(2) '/' SY-DATUM+4(2) '/' SY-DATUM+0(4) INTO DATE_CHR.

  " Set the color format for the data
  FORMAT INVERSE ON COLOR COL_POSITIVE. " Foreground color green
  
  " Select customer data from KNA1 table
  SELECT KUNNR NAME1 STRAS ORT01 PSTLZ FROM KNA1 INTO CUST_STRU.
    " Output customer data with specific color formatting
    WRITE:/5(5) SY-DBCNT INVERSE OFF COLOR = 4, " Page row number with color code 4
             CUST_STRU-KUNNR USING NO EDIT MASK, " Customer Number
             CUST_STRU-NAME1 INVERSE ON COLOR COL_GROUP, " Customer Name with color COL_GROUP
             CUST_STRU-STRAS, " Street Address
             CUST_STRU-ORT01, " City
             CUST_STRU-PSTLZ. " Postal Code
  ENDSELECT.
