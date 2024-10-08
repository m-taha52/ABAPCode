REPORT YCL_CH05_07_CUST_LIST06 LINE-SIZE 145 LINE-COUNT 60
NO STANDARD PAGE HEADING.

****************************************************
* Simple Customer List - Fields Enclosed in Boxes *
****************************************************

DATA: BEGIN OF CUST_STRU,
        KUNNR TYPE KNA1-KUNNR,     " Customer Number
        NAME1 TYPE KNA1-NAME1,     " Customer Name
        STRAS TYPE KNA1-STRAS,     " Street Address
        ORT01 TYPE KNA1-ORT01,     " City
        PSTLZ TYPE KNA1-PSTLZ,     " Postal Code
      END OF CUST_STRU.

*************************************************
* Page Header Section
*************************************************
TOP-OF-PAGE.
WRITE :/5 TEXT-001, SY-TVAR9, 132 TEXT-002, 139(3) SY-PAGNO.
SKIP.
WRITE :/5(137) SY-ULINE. " Horizontal line for header
WRITE :/5 SY-VLINE NO-GAP, TEXT-003 NO-GAP, 11 SY-VLINE NO-GAP,
        TEXT-004 NO-GAP, 22 SY-VLINE NO-GAP, TEXT-005 NO-GAP, 58
        SY-VLINE NO-GAP, TEXT-006 NO-GAP, 94 SY-VLINE NO-GAP, TEXT-007
        NO-GAP, 130 SY-VLINE NO-GAP, TEXT-008 NO-GAP, 141 SY-VLINE NO-GAP.
WRITE :/5 SY-VLINE NO-GAP, TEXT-009 NO-GAP, 11 SY-VLINE NO-GAP,
        TEXT-010 NO-GAP, 22 SY-VLINE NO-GAP, 58 SY-VLINE NO-GAP, 94
        SY-VLINE NO-GAP, 130 SY-VLINE NO-GAP, TEXT-010 NO-GAP, 141
        SY-VLINE NO-GAP.
WRITE :/5(137) SY-ULINE. " Horizontal line after header

******************************************************
* Data Selection and Output
******************************************************
START-OF-SELECTION.
  " Format the current date in DD-MM-YYYY
  CONCATENATE SY-DATUM+6(2) SY-DATUM+4(2) SY-DATUM+0(4) INTO SY-TVAR9
    SEPARATED BY '-'.

  " Select customer data from KNA1 table
  SELECT KUNNR NAME1 STRAS ORT01 PSTLZ FROM KNA1 INTO CUST_STRU.
    " Output customer data enclosed in vertical lines
    WRITE :/5 SY-VLINE NO-GAP, (5) SY-DBCNT NO-GAP, 11 SY-VLINE NO-GAP,
             CUST_STRU-KUNNR USING NO EDIT MASK NO-GAP, 22 SY-VLINE NO-GAP,
             CUST_STRU-NAME1 NO-GAP, 58 SY-VLINE NO-GAP, CUST_STRU-STRAS
             NO-GAP, 94 SY-VLINE NO-GAP, CUST_STRU-ORT01 NO-GAP, 130 SY-VLINE
             NO-GAP, CUST_STRU-PSTLZ, 141 SY-VLINE NO-GAP.
    WRITE :/5(137) SY-ULINE. " Horizontal line after data row
  ENDSELECT.
