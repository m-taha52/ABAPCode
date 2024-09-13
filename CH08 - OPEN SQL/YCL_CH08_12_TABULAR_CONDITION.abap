REPORT YCL_CH08_12_TABULAR_CONDITION.

****************************
* Tabular WHERE Condition *
****************************

*******************************************************
* This report demonstrates the use of a tabular WHERE condition *
* to filter billing documents and their associated items.       *
* Example customer codes: 473, 401081                       *
*                                                              *
* Billing documents will be loaded into the primary internal   *
* table PITAB and corresponding items into the secondary       *
* internal table SITAB.                                       *
*******************************************************

* Define data structures for primary and secondary tables
DATA: BEGIN OF PITAB_STRU,
         VBELN TYPE VBRK-VBELN,          " Billing Document Number
         FKDAT TYPE VBRK-FKDAT,          " Billing Document Date
         KUNAG TYPE VBRK-KUNAG,          " Customer Code
         NETWR TYPE VBRK-NETWR,          " Net Value
         WAERK TYPE VBRK-WAERK,          " Currency
       END OF PITAB_STRU,
       PITAB TYPE STANDARD TABLE OF PITAB_STRU
             WITH HEADER LINE.

DATA: BEGIN OF SITAB_STRU,
         VBELN TYPE VBRP-VBELN,          " Billing Document Number
         MATNR TYPE VBRP-MATNR,          " Material Code
         NETWR TYPE VBRP-NETWR,          " Net Value
       END OF SITAB_STRU,
       SITAB TYPE STANDARD TABLE OF SITAB_STRU
             WITH HEADER LINE.

* Define input parameters for customer codes
PARAMETERS: CUST_CD1 TYPE VBRK-KUNAG VALUE '473' OBLIGATORY,
            CUST_CD2 TYPE VBRK-KUNAG VALUE '401081' OBLIGATORY.

START-OF-SELECTION.

  * Load primary internal table PITAB with billing documents
  SELECT VBELN FKDAT KUNAG NETWR WAERK
    INTO TABLE PITAB
    FROM VBRK
    WHERE KUNAG IN ( CUST_CD1, CUST_CD2 ).

  * Load the secondary internal table SITAB with items for the billing documents
  SELECT VBELN MATNR NETWR
    INTO TABLE SITAB
    FROM VBRP
    FOR ALL ENTRIES IN PITAB
    WHERE VBELN = PITAB-VBELN.

  * Output data from PITAB
  WRITE: / 'Billing Documents for Customers:', CUST_CD1, 'and', CUST_CD2.
  WRITE: / 5 'Customer', 20 'Billing Document No.', 35 'Billing Document Date',
           55 'Net Value', 70 'Currency'.
  SKIP.

  LOOP AT PITAB INTO PITAB_STRU.
    WRITE: / 5 PITAB_STRU-KUNAG,
             20 PITAB_STRU-VBELN,
             35 PITAB_STRU-FKDAT,
             55 PITAB_STRU-NETWR,
             70 PITAB_STRU-WAERK.
  ENDLOOP.

  SKIP 2.

  * Output data from SITAB
  WRITE: / 'Materials for Billing Documents:', CUST_CD1, 'and', CUST_CD2.
  WRITE: / 5 'Billing Document No.', 20 'Material Code', 35 'Net Value'.
  SKIP.

  LOOP AT SITAB INTO SITAB_STRU.
    WRITE: / 5 SITAB_STRU-VBELN,
             20 SITAB_STRU-MATNR,
             35 SITAB_STRU-NETWR.
  ENDLOOP.
