REPORT YCL_CH07_03_ITAB_AS_PARM 
       LINE-SIZE 95 
       LINE-COUNT 60 
       NO STANDARD PAGE HEADING.

************************************************
* Subroutine With Structure As Parameter       *
* Simple Customer List                         *
************************************************

************************************************************************
* Data Declaration                                                     *
* - CUSTOMER_TAB: Internal table to store customer data                *
* - DAT: A string to hold the formatted date                           *
************************************************************************
DATA: 
  CUSTOMER_TAB TYPE SORTED TABLE OF YCL_CH05_CUST_STRU
                WITH UNIQUE KEY KUNNR 
                WITH HEADER LINE,        " Internal table with a header line
  DAT(10) TYPE C.                        " Character field to store the formatted date

***********************************************************
* TOP-OF-PAGE Event                                        *
* This event triggers the page heading when a new page is  *
* started during the report execution.                     *
***********************************************************

TOP-OF-PAGE.
  WRITE: /5  TEXT-001, DAT,                 " 'List of Customers as on' followed by the formatted date
          81 TEXT-002,                      " 'Page' followed by the page number
          (3) SY-PAGNO.
  WRITE: /5(83) SY-ULINE.                   " Draw a horizontal line
  WRITE: /5  TEXT-003, 12 TEXT-004,         " 'Srl.', 'Customer'
          24 TEXT-005, 60 TEXT-006.         " 'Name', 'City'
  WRITE: /6  TEXT-007, 14 TEXT-008.         " 'No.', 'Code'
  WRITE: /5(83) SY-ULINE.                   " Draw another horizontal line

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

  " Loop through each record in the internal table and call the WRITER subroutine
  LOOP AT CUSTOMER_TAB INTO CUSTOMER_TAB.
    PERFORM WRITER USING CUSTOMER_TAB.
  ENDLOOP.

***********************************************************
* Subroutine: WRITER                                      *
* This subroutine processes and outputs the customer data *
* passed as a structure parameter.                        *
***********************************************************

FORM WRITER USING CUST_STRU STRUCTURE YCL_CH05_CUST_STRU.
  " Write the customer details to the output
  WRITE: /5(5) SY-TABIX,                " Current row number in the internal table
           CUST_STRU-KUNNR USING NO EDIT MASK,  " Customer number without formatting
           CUST_STRU-NAME1,               " Customer name
           CUST_STRU-ORT01.               " City
ENDFORM.


 
" TOP-OF-PAGE: Displays a header with the list of customers, the current date, page number, and column titles (e.g., Serial Number, Customer, Name, City).
" START-OF-SELECTION: The program begins by formatting the date and then selecting customer data from the KNA1 table into the CUSTOMER_TAB internal table.
" LOOP AT...PERFORM WRITER...ENDLOOP: Iterates through each record in the internal table and calls the WRITER subroutine.
" FORM WRITER: This subroutine takes a structure parameter (CUST_STRU), which represents each record in the internal table. It then writes the relevant details (Customer Number, Name, City) to the output.
" This structure ensures that the report is well-organized, with meaningful comments explaining each part of the code. The text symbols you've provided make the report output more readable and user-friendly.
