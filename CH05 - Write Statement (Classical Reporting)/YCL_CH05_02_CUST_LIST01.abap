REPORT YCL_CH05_02_CUST_LIST01 LINE-SIZE 140.
*********************************
* WRITE - Simple Customer List **
*********************************
***********************************************
* KUNNR LIKE KNA1-KUNNR - the field KUNNR of **
* our declared structure CUST_STRU has same **
* attributes as the field KUNNR of DDIC table**
* definition KNA1. here either the key word **
* LIKE or TYPE can be used. difference **
* LIKE & TYPE will be discussed subsequently **
* **
* like wise for NAME1, STRAS, ORT01, PSTLZ **
***********************************************

DATA: 
BEGIN OF CUST_STRU,
KUNNR LIKE KNA1-KUNNR, "referring to a DDIC table field
NAME1 LIKE KNA1-NAME1,
STRAS LIKE KNA1-STRAS,
ORT01 LIKE KNA1-ORT01,
PSTLZ LIKE KNA1-PSTLZ,
END OF CUST_STRU.

*****************************************
SELECT KUNNR NAME1 STRAS ORT01 PSTLZ FROM KNA1 INTO CUST_STRU.
WRITE:/5(5) SY-DBCNT, CUST_STRU-KUNNR USING NO EDIT MASK,
CUST_STRU-NAME1, CUST_STRU-STRAS, CUST_STRU-ORT01, CUST_STRU-PSTLZ.
ENDSELECT.