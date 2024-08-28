REPORT YCL_CH05_08_BILL_DOCS_LIST LINE-SIZE 135 LINE-COUNT 60
NO STANDARD PAGE HEADING.

*********************************************************************
* List of Billing Documents of a Specified Company Code with Total **
*********************************************************************
* Billing Documents of XXXX/XXXXXXXXXXXXXXXXXXXXXXXXX Curr: XXXXX *
* ------------------------------------------------------------------ *
* Doc No. Doc Date Customer N a m e C i t y Amount                *
* Code                                                             *
* ------------------------------------------------------------------ *
* SY-DBCNT 005 - 009                                                *
* VBELN 011 - 020                                                *
* FKDAT 022 - 031                                                *
* KUNNR 033 - 042                                                *
* NAME1 044 - 078                                                *
* ORT01 080 - 114                                                *
* NETWR 116 - 132                                                *
*********************************************************************
* Database view with tables KNA1 (customer primary)                *
* YCL_CH05_VBRKKNA VBRK (billing docs-header)                       *
*                                                                  *
* VBRK KNA1 MANDT = VBRK MANDT                                    *
* KNA1 KNA1 KUNNR = VBRK KUNAG                                    *
*                                                                  *
* View field Table Field                                           *
*                                                                  *
* MANDT KNA1 MANDT                                                 *
* KUNNR KNA1 KUNNR                                                 *
* VBELN VBRK VBELN                                                 *
* NAME1 KNA1 NAME1                                                 *
* ORT01 KNA1 ORT01                                                 *
* PSTLZ KNA1 PSTLZ                                                 *
* STRAS KNA1 STRAS                                                 *
* FKDAT VBRK FKDAT                                                 *
* KURRF VBRK KURRF                                                 *
* BUKRS VBRK BUKRS                                                 *
* NETWR VBRK NETWR                                                 *
*********************************************************************

TABLES: YCL_CH05_VBRKKNA, " Local structure having all fields of view
        T001.         " Local structure with all fields of T001

DATA: STRNG TYPE STRING,
      TOTAL TYPE VBRK-NETWR VALUE 0. " Initialize total

PARAMETERS: CCODE TYPE VBRK-BUKRS DEFAULT 3000 VALUE CHECK. " Company code parameter

*********************************************************************
* Page Header Section
*********************************************************************
TOP-OF-PAGE.
WRITE :/5 STRNG, 129(3) SY-PAGNO. " Display string and page number
SKIP 1.
WRITE:/5(127) SY-ULINE. " Draw horizontal line
WRITE:/5 TEXT-003,11 TEXT-004, 22 TEXT-005, 33 TEXT-006, 46 TEXT-007,
      83 TEXT-008, 126 TEXT-009.
WRITE:/6 TEXT-010, 35 TEXT-011.
WRITE:/5(127) SY-ULINE. " Draw horizontal line after header

***********************************************************************
* Data Selection and Output
***********************************************************************
START-OF-SELECTION.

  " Fetch company details
  SELECT SINGLE * FROM T001 WHERE BUKRS = CCODE.
  CONCATENATE TEXT-001 CCODE '/' T001-BUTXT TEXT-002 T001-WAERS INTO STRNG.

  " Select billing documents for specified company code
  SELECT * FROM YCL_CH05_VBRKKNA WHERE BUKRS = CCODE.

    " Calculate total amount
    YCL_CH05_VBRKKNA-NETWR = YCL_CH05_VBRKKNA-NETWR * YCL_CH05_VBRKKNA-KURRF.
    TOTAL = TOTAL + YCL_CH05_VBRKKNA-NETWR.

    " Output billing document details
    WRITE :/5(5) SY-DBCNT, YCL_CH05_VBRKKNA-VBELN,
             YCL_CH05_VBRKKNA-FKDAT,
             YCL_CH05_VBRKKNA-KUNNR,
             YCL_CH05_VBRKKNA-NAME1,
             YCL_CH05_VBRKKNA-ORT01,
             (17) YCL_CH05_VBRKKNA-NETWR.

  ENDSELECT.

***********************************************************************
* End of Selection
***********************************************************************
SKIP 1.
WRITE: /(17) TOTAL UNDER YCL_CH05_VBRKKNA-NETWR. " Display total amount under NETWR
