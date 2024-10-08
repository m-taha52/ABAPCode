REPORT YCL_CH05_03_CUST_LIST02 LINE-SIZE 140 LINE-COUNT 60.
***************************************************
* WRITE - Simple Customer List With List Headings**
* (STANDARD HEADER) **
***************************************************

DATA: 

BEGIN OF CUST_STRU,
KUNNR LIKE KNA1-KUNNR, "referring to customer code
NAME1 LIKE KNA1-NAME1, "referring to Customer Name
STRAS LIKE KNA1-STRAS, "Referring to Customer Street
ORT01 LIKE KNA1-ORT01, "Referring to Customer Country
PSTLZ LIKE KNA1-PSTLZ, "Referring to Customer Post Code
END OF CUST_STRU.

***********************************************************
CONCATENATE SY-DATUM+6(2) SY-DATUM+4(2) SY-DATUM+0(4)
INTO SY-TVAR1 SEPARATED BY '/'. "Wriitng the date

SELECT KUNNR NAME1 STRAS ORT01 PSTLZ FROM KNA1 INTO CUST_STRU.

WRITE:/5(5) SY-DBCNT, CUST_STRU-KUNNR USING NO EDIT MASK,
CUST_STRU-NAME1, CUST_STRU-STRAS, CUST_STRU-ORT01, CUST_STRU-PSTLZ.
ENDSELECT.