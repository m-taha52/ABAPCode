REPORT YCL_CH08_14_CUST_LIST_WOUTSTRU LINE-SIZE 140 LINE-COUNT 60 NO STANDARD PAGE HEADING.

*************************************************************
* List Customers - Use Field Symbol To Access Row Directly *
* No Work Area/Header Line                                *
*************************************************************
****************************************************
* The GET RUN TIME statement is used to ascertain *
* the execution time for a program block in micro *
* seconds. The first time it is executed, it      *
* assigns zero to the specified variable. From    *
* the second and subsequent occurrences, it       *
* loads/assigns cumulative elapsed time in micro  *
* seconds. So you can determine the execution     *
* time of a program block by subtracting the      *
* value assigned at the beginning of the program  *
* block from the value assigned at the end of the *
* program block (difference).                     *
****************************************************

DATA: TIME_ELAPSED TYPE I VALUE 100,
      DATE_CHR TYPE C LENGTH 10.

DATA: CUSTOMERS_TAB TYPE STANDARD TABLE OF YCL_CH05_CUST_STRU.

FIELD-SYMBOLS: <FS1> TYPE YCL_CH05_CUST_STRU.

TOP-OF-PAGE.
WRITE:/5 TEXT-001, DATE_CHR, 130 TEXT-002, 137(3) SY-PAGNO.
SKIP 1.
WRITE:/5(135) SY-ULINE.
WRITE:/6 TEXT-003, 12 TEXT-004, 23 TEXT-005, 60 TEXT-006, 96 TEXT-007, 130 TEXT-008.
WRITE:/6 TEXT-009, 13 TEXT-010, 131 TEXT-010.
WRITE:/5(135) SY-ULINE.

START-OF-SELECTION.
  GET RUN TIME FIELD TIME_ELAPSED.
  CONCATENATE SY-DATUM+6(2) SY-DATUM+4(2) SY-DATUM+0(4) INTO DATE_CHR SEPARATED BY '/'.
  
  SELECT KUNNR NAME1 STRAS ORT01 PSTLZ
    INTO TABLE CUSTOMERS_TAB
    FROM KNA1.
  
  SORT CUSTOMERS_TAB BY KUNNR.
  
  LOOP AT CUSTOMERS_TAB ASSIGNING <FS1>.
    WRITE:/5(5) SY-TABIX, <FS1>-KUNNR USING NO EDIT MASK,
           <FS1>-NAME1, <FS1>-STRAS,
           <FS1>-ORT01, <FS1>-PSTLZ.
  ENDLOOP.

  GET RUN TIME FIELD TIME_ELAPSED.
  SKIP 2.
  WRITE:/5 'Time elapsed:', (7) TIME_ELAPSED.
