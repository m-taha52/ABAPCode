REPORT YCL_CH08_04_SELECT_DISTINCT LINE-SIZE 95 LINE-COUNT 60
       NO STANDARD PAGE HEADING.

********************************************
* SELECT DISTINCT - List Billed Customers *
* of a Specified Company Code *
********************************************

********************************************************
* The SELECT DISTINCT statement is used to fetch rows
* with unique or distinct field values from the database.
*
* In this example, the goal is to generate a list of customers
* who have billing documents, similar to the output in program
* YCL_CH06_ITAB10. Unlike that approach, which used internal
* table operations to remove duplicates, this approach uses
* the SELECT DISTINCT SQL statement directly on the database
* view to achieve the same result.
*
* The source data comes from a database view that joins tables
* KNA1 and VBRK. The output will list each customer only once
* even if they have multiple billing documents.
********************************************************

* Define the structure and data types for storing customer data
TYPES: BEGIN OF CUSTOMERS_STRU_TYPE,
         KUNNR TYPE KNA1-KUNNR,      " Customer Number
         NAME1 TYPE KNA1-NAME1,      " Customer Name
         ORT01 TYPE KNA1-ORT01,      " City
       END OF CUSTOMERS_STRU_TYPE.

DATA: CUSTOMERS_TAB TYPE STANDARD TABLE OF CUSTOMERS_STRU_TYPE, " Internal table for customer data
      CUSTOMERS_STRU TYPE CUSTOMERS_STRU_TYPE,                " Work area for customer data
      BUTXT TYPE T001-BUTXT.                                  " Company Code Name

PARAMETERS: CCODE TYPE VBRK-BUKRS DEFAULT 3000 VALUE CHECK.  " Company Code

****************************************************************
* Output header information
TOP-OF-PAGE.
  WRITE: /5 TEXT-001 NO-GAP, CCODE NO-GAP, '/' NO-GAP, BUTXT, 92(2) SY-PAGNO.
  WRITE: /5(88) SY-ULINE.
  WRITE: /5 TEXT-002, 11 TEXT-003, 22 TEXT-004, 58 TEXT-005.
  WRITE: /6 TEXT-006, 13 TEXT-007.
  WRITE: /5(88) SY-ULINE.
******************************************************************

START-OF-SELECTION.

  " Fetch company code name
  SELECT SINGLE BUTXT FROM T001 INTO (BUTXT) WHERE BUKRS = CCODE.

  " Fetch distinct customer records with billing documents
  SELECT DISTINCT KUNNR NAME1 ORT01
    FROM YCL_CH05_VBRKKNA
    INTO TABLE CUSTOMERS_TAB
    WHERE BUKRS = CCODE.

  " Sort the internal table by customer number
  SORT CUSTOMERS_TAB BY KUNNR.

  " Output the list of customers
  LOOP AT CUSTOMERS_TAB INTO CUSTOMERS_STRU.
    WRITE: /5(4) SY-TABIX,                      " Row number in the list
           CUSTOMERS_STRU-KUNNR USING NO EDIT MASK, " Customer Number without leading zeros
           CUSTOMERS_STRU-NAME1,              " Customer Name
           CUSTOMERS_STRU-ORT01.             " City
  ENDLOOP.
