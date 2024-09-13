REPORT YCL_CH08_10_OUTER_JOIN NO STANDARD PAGE HEADING
       LINE-SIZE 100 LINE-COUNT 60.

**********************************************************
* OUTER JOIN With Customer Primary Data & Billing Docs. *
**********************************************************

**************************************
* Declare TYPES and DATA.            *
* Input customer code via PARAMETERS. *
* Include heading for output.        *
* Use SELECT statement with OUTER JOIN *
* to retrieve data into internal table. *
* Filter customers based on input.    *
* Sort internal table by customer code. *
* Output results from internal table. *
**************************************

* Define the structure for customer and billing data
TYPES: BEGIN OF CUST_BILLS_TYPE,
         KUNNR TYPE KNA1-KUNNR,          " Customer Number
         NAME1 TYPE KNA1-NAME1,          " Customer Name
         LANDX TYPE T005T-LANDX,          " Country
         VBELN TYPE VBRK-VBELN,          " Billing Document Number
         FKDAT TYPE VBRK-FKDAT,          " Billing Date
       END OF CUST_BILLS_TYPE.

* Declare an internal table and a header line for the data
DATA: CUST_BILLS TYPE STANDARD TABLE OF CUST_BILLS_TYPE
              WITH HEADER LINE.

* Define input parameter for customer code
PARAMETERS: CUST_CD TYPE VBRK-KUNAG VALUE CHECK
            DEFAULT '0000001000'.  " Default customer code

*************************************************
* Include heading for the report output
INCLUDE YCL_CH08_08_HEADER_JOINS.

START-OF-SELECTION.

  * Select data using LEFT OUTER JOIN between customer and billing tables
  SELECT VW~KUNNR, VW~NAME1, VW~LANDX, 
         TB~VBELN, TB~FKDAT
    INTO CORRESPONDING FIELDS OF TABLE CUST_BILLS
    FROM ( YCL_CH05_KNAT5T AS VW
    LEFT OUTER JOIN VBRK AS TB ON VW~MANDT = TB~MANDT
                                AND VW~KUNNR = TB~KUNAG )
    WHERE VW~KUNNR <= CUST_CD.

  * Sorting the internal table by customer number is optional here
  * SORT CUST_BILLS BY KUNNR.

  * Output the data from the internal table
  LOOP AT CUST_BILLS.
    WRITE:/5(5) SY-TABIX,              " Line number in the loop
           CUST_BILLS-KUNNR USING NO EDIT MASK,  " Customer Number without leading zeros
           CUST_BILLS-NAME1,           " Customer Name
           CUST_BILLS-LANDX,           " Country
           CUST_BILLS-VBELN,           " Billing Document Number
           CUST_BILLS-FKDAT.           " Billing Date
  ENDLOOP.
