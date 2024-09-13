REPORT YCL_CH08_02_PSIZE_INTO_TAB NO STANDARD PAGE HEADING
       LINE-SIZE 95 LINE-COUNT 60.

*********************************************************
* Fetch Data From Database Table in Batches into Table **
*********************************************************

******************************************************
* When dealing with a large number of rows, fetching data
* in smaller batches helps manage RAM usage effectively.
* In this example, data is fetched in batches of 1000 rows.
* The batch size can be specified using the PACKAGE SIZE
* phrase followed by a literal or variable.
*
* Each time a batch of rows is fetched, the existing data
* in the internal table is overwritten. Thus, only one
* batch of data is present in the internal table at any
* given time.
*
* An INCLUDE program YCL_CH08_01_INCLUDE_HEADING is used
* for displaying a non-standard header. This same INCLUDE
* program is used in YCL_CH08_03_PSIZE_APPEND_TAB.
******************************************************

DATA: CUSTOMER_TAB TYPE STANDARD TABLE OF YCL_CH05_CUST_STRU
      WITH HEADER LINE, " Internal table for customer data
      CNTR TYPE P DECIMALS 0, " Counter for batch rows
      CDATE TYPE STRING. " Date in DD/MM/YYYY format

PARAMETERS: PKSZ TYPE N LENGTH 4 DEFAULT 1000. " Package size

INCLUDE YCL_CH08_01_INCLUDE_HEADING. " Include program for heading

START-OF-SELECTION.

  " Format current date as DD/MM/YYYY
  CONCATENATE SY-DATUM+6(2) SY-DATUM+4(2) SY-DATUM+0(4)
    INTO CDATE SEPARATED BY '/'.

  " Fetch data in batches from the KNA1 table
  SELECT KUNNR NAME1 STRAS ORT01 PSTLZ
    FROM KNA1
    INTO TABLE CUSTOMER_TAB
    PACKAGE SIZE PKSZ.

    " Process each row of the fetched batch
    LOOP AT CUSTOMER_TAB.
      CNTR = CNTR + 1. " Increment counter for each row
      WRITE: /5(5) CNTR, 
             CUSTOMER_TAB-KUNNR USING NO EDIT MASK, " Display customer number without leading zeros
             CUSTOMER_TAB-NAME1, 
             CUSTOMER_TAB-ORT01. " Display customer name and city
    ENDLOOP.

    SKIP 2. " Add a gap between batches of data

  ENDSELECT.
