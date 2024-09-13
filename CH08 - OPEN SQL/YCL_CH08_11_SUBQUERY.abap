REPORT YCL_CH08_11_SUBQUERY NO STANDARD PAGE HEADING
       LINE-SIZE 90 LINE-COUNT 60.

****************************************************
* SELECT statement with Sub-query in WHERE condition *
****************************************************

************************************
* Declare data structures and parameters *
* Code heading for output          *
* **                                *
* Load internal table from table VBRK *
* using a sub-query in the SELECT statement. *
* **                                *
* Sort internal table by VBELN     *
* Output data from internal table  *
************************************

* Define the structure for billing data
DATA: BEGIN OF BILL_STRU,
         VBELN TYPE VBRK-VBELN,          " Billing Document Number
         FKDAT TYPE VBRK-FKDAT,          " Billing Date
         KUNAG TYPE VBRK-KUNAG,          " Customer Number
         WAERK TYPE VBRK-WAERK,          " Currency Key
         NETWR TYPE VBRK-NETWR,          " Net Value
       END OF BILL_STRU,
       BILL_TAB TYPE STANDARD TABLE OF BILL_STRU
                WITH HEADER LINE.

* Define input parameter for city (ORT01)
PARAMETERS: ORT01 TYPE ORT01_GP LOWER CASE DEFAULT 'Berlin'.  " Reference to data element

****************************************************************
* Note: Test with other city names like Frankfurt, Hamburg, etc. *
* Case sensitivity of field ORT01 is important here.             *
****************************************************************

* Output heading
TOP-OF-PAGE.
WRITE: /5 TEXT-001, ORT01, 66(3) SY-PAGNO.
SKIP.
WRITE:/5(63) SY-ULINE.
WRITE:/5 TEXT-002, 11 TEXT-003, 22 TEXT-004, 33 TEXT-005,
       56 TEXT-006, 64 TEXT-007.
WRITE:/6 TEXT-008, 34 TEXT-009.
WRITE:/5(63) SY-ULINE.

START-OF-SELECTION.

  * Load data into internal table using a sub-query
  SELECT VBELN, FKDAT, KUNAG, WAERK, NETWR
    INTO TABLE BILL_TAB
    FROM VBRK
    WHERE KUNAG IN ( SELECT KUNNR 
                       FROM KNA1 
                       WHERE ORT01 = @ORT01 ).

  * Sort the internal table by billing document number
  SORT BILL_TAB BY VBELN.

  * Output the data from the internal table
  LOOP AT BILL_TAB INTO BILL_STRU.
    WRITE:/5(4) SY-TABIX,              " Line number in the loop
           BILL_STRU-VBELN,           " Billing Document Number
           BILL_STRU-FKDAT,           " Billing Date
           BILL_STRU-KUNAG USING NO EDIT MASK, " Customer Number without leading zeros
           BILL_STRU-NETWR,           " Net Value
           BILL_STRU-WAERK.           " Currency Key
  ENDLOOP.
