REPORT YCL_CH07_03_ITAB_AS_PARM 
       LINE-SIZE 95 
       LINE-COUNT 60 
       NO STANDARD PAGE HEADING.

************************************************
* Subroutine with Internal Table as Parameter  *
* Simple Customer List                         *
************************************************

************************************************************************
* Data Declaration                                                     *
* - CUSTOMER_TAB: Internal table to store customer data                *
* - DAT: A string to hold the formatted date                           *
************************************************************************
DATA: 
  CUSTOMER_TAB TYPE SORTED TABLE OF YCL_CH05_CUST_STRU
                WITH UNIQUE KEY KUNNR, " Sorted internal table with unique key KUNNR
  DAT(10) TYPE C.                            " Character field to store the formatted date

***********************************************************
* TOP-OF-PAGE Event                                        *
* This event triggers the page heading when a new page is  *
* started during the report execution.                     *
***********************************************************

TOP-OF-PAGE.
  WRITE: /5  TEXT-001, DAT,                  " 'List of Customers as on' followed by the formatted date
          81 TEXT-002,                       " 'Page' followed by the page number
          (3) SY-PAGNO.
  WRITE: /5(83) SY-ULINE.                    " Draw a horizontal line
  WRITE: /5  TEXT-003, 12 TEXT-004,          " 'Srl.', 'Customer'
          24 TEXT-005, 60 TEXT-006.          " 'Name', 'City'
  WRITE: /6  TEXT-007, 14 TEXT-008.          " 'No.', 'Code'
  WRITE: /5(83) SY-ULINE.                    " Draw another horizontal line

***********************************************************
* START-OF-SELECTION Event                                *
* Main processing block that runs when the program starts *
***********************************************************

START-OF-SELECTION.
  " Concatenate the current date in DD/MM/YYYY format into DAT
  CONCATENATE SY-DATUM+6(2) SY-DATUM+4(2) SY-DATUM+0(4) INTO DAT 
              SEPARATED BY '/'.

  " Select customer data from the KNA1 table into the internal table CUSTOMER_TAB
  SELECT KUNNR NAME1 STRAS ORT01 PSTLZ 
    FROM KNA1 
    INTO TABLE CUSTOMER_TAB.

  " Call the subroutine OUTPUT_LIST to display the customer list
  PERFORM OUTPUT_LIST USING CUSTOMER_TAB.

***********************************************************
* Subroutine: OUTPUT_LIST                                 *
* This subroutine processes and outputs the customer data *
* passed as an internal table.                            *
***********************************************************

FORM OUTPUT_LIST USING CUST_TAB TYPE ANY TABLE.
  " Local structure to hold individual customer records
  DATA CUST_STRU LIKE YCL_CH05_CUST_STRU.

  " Loop through each record in the internal table
  LOOP AT CUST_TAB INTO CUST_STRU.
    " Write the customer details
    WRITE: /5(5) SY-TABIX,                " Current row number in the internal table
           CUST_STRU-KUNNR USING NO EDIT MASK,  " Customer number without formatting
           CUST_STRU-NAME1,               " Customer name
           CUST_STRU-ORT01.               " City
  ENDLOOP.

ENDFORM.
