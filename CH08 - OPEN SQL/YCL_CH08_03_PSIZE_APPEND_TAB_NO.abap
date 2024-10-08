REPORT YCL_CH08_03_PSIZE_APPEND_TAB NO STANDARD PAGE HEADING
LINE-SIZE 95 LINE-COUNT 60.
**************************************************************
* Fetch Data From Database Table In Batches APPENDING TABLE **
**************************************************************
******************************************************************
* if no of rows/data is very large putting pressure on network, **
* then in this scenario data can be fetched in batches of **
* smaller size & appended to the internal table. in the present **
* scenario,you are fetching data in batches of 1000 rows at a **
* time. this batch size can be specified with the phrase PACKAGE**
* SIZE & a literal/variable. every time batch of rows is **
* fetched, existing data in the internal table is appended to. **
* at the end of SELECT...ENDSELECT loop, internal table **
* contains all the fetched rows of all the batches. **
******************************************************************
******************************************************
* declare data. input PACKAGE SIZE thru PARAMETERS **
* INCLUDE program for heading **
* **
* retrieve a batch of rows with SELECT...PACKAGE **
* SIZE...etc. append to existing data ENDSELECT. **
* **
* output retrieved batch LOOP AT...WRITE...ENDLOOP **
******************************************************
DATA: CUSTOMER_TAB TYPE STANDARD TABLE OF YCL_CH05_CUST_STRU
WITH HEADER LINE,
CNTR(3) TYPE P DECIMALS 0,
CDATE TYPE STRING.
PARAMETERS: PKSZ(4) TYPE N DEFAULT 1000.
********************************************
INCLUDE YCL_CH08_01_INCLUDE_HEADING. " heading
START-OF-SELECTION.
CONCATENATE SY-DATUM+6(2) SY-DATUM+4(2) SY-DATUM+0(4)
INTO CDATE SEPARATED BY '/'.
SELECT KUNNR NAME1 STRAS ORT01 PSTLZ FROM KNA1 APPENDING
TABLE CUSTOMER_TAB PACKAGE SIZE PKSZ.
LOOP AT CUSTOMER_TAB.
WRITE:/5(5) SY-TABIX, CUSTOMER_TAB-KUNNR USING NO EDIT MASK,
CUSTOMER_TAB-NAME1, CUSTOMER_TAB-ORT01.
CNTR = SY-TABIX MOD PKSZ.
IF CNTR = 0.
SKIP 2. " gap between batches
ENDIF.
ENDLOOP.