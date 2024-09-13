REPORT YCL_CH08_05_AGGREGATE_FUNC NO STANDARD PAGE HEADING
       LINE-SIZE 120 LINE-COUNT 60.

**********************************************
* SELECT Statement with Aggregate Functions *
**********************************************

**************************************************************
* This report demonstrates the use of aggregate functions
* in SQL to summarize data. 
* 
* Note: Open SQL aggregate functions do not support expressions
* like SUM(NETWR * KURRF), which means you cannot directly 
* aggregate computed fields. For complex calculations, you may
* need to use intermediate tables to store computed results and
* then perform aggregation.
* 
* Aggregate functions like SUM, MAX, MIN, and COUNT can be used
* for summarizing data such as quantities sold. These functions 
* are suitable for fields like quantities where summarization 
* is straightforward.
* 
* This report summarizes material-wise quantities sold. The
* source of data is the table VBRP. For material descriptions,
* the table MAKT is used, and both tables are joined in the view
* YCL_CH08_VBRP_MK.
**************************************************************

* Define the structure to hold the aggregated sales data
DATA: BEGIN OF SALES_STRU,
        MATNR TYPE MATNR,       " Material Number
        MAKTX TYPE MAKTX,       " Material Description
        VRKME TYPE VRKME,       " Sales Unit of Measure
        CONT TYPE I,            " Number of Sales Transactions
        TOTAL TYPE FKIMG,       " Total Quantity Sold
        MAX TYPE FKIMG,         " Maximum Quantity Sold at a Time
        MIN TYPE FKIMG,         " Minimum Quantity Sold at a Time
      END OF SALES_STRU.

*******************************************
* Output header information
TOP-OF-PAGE.
  WRITE: /5 TEXT-001, 115(3) SY-PAGNO.
  SKIP 1.
  WRITE: /5(112) SY-ULINE.
  WRITE: /5 TEXT-002, 10 TEXT-003, 30 TEXT-004,
         70 TEXT-005, 74 TEXT-006, 82 TEXT-007,
         96 TEXT-008, 109 TEXT-009.
  WRITE: /6 TEXT-010.
  WRITE: /5(112) SY-ULINE.
*******************************************

START-OF-SELECTION.

  " Retrieve aggregated sales data for each material
  SELECT MATNR, MAKTX, VRKME,
         COUNT( * ) AS CONT,      " Count of sales transactions
         SUM( FKIMG ) AS TOTAL,  " Total quantity sold
         MAX( FKIMG ) AS MAX,    " Maximum quantity sold at a time
         MIN( FKIMG ) AS MIN     " Minimum quantity sold at a time
    FROM YCL_CH08_VBRP_MK
    INTO SALES_STRU
    GROUP BY MATNR, MAKTX, VRKME
    HAVING SUM( FKIMG ) <> 0  " Exclude materials with no sales
    ORDER BY MATNR.

  " Output the aggregated data
  WRITE: /5(4) SY-DBCNT,                   " Number of records selected
         SALES_STRU-MATNR USING NO EDIT MASK, " Material Number without leading zeros
         SALES_STRU-MAKTX,               " Material Description
         SALES_STRU-VRKME,               " Sales Unit of Measure
         (5) SALES_STRU-CONT,            " Number of Sales Transactions
         (12) SALES_STRU-TOTAL,          " Total Quantity Sold
         (12) SALES_STRU-MAX,            " Maximum Quantity Sold at a Time
         (12) SALES_STRU-MIN.            " Minimum Quantity Sold at a Time
ENDSELECT.
