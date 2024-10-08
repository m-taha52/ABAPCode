REPORT YCL_CH04_05_TRANSF_DATE_MOVE.
**************************************************
* Date Transformation with MOVE Offset & Length **
* convert YYYYMMDD to MM-DD-YYYY **
**************************************************
*********************************************
* Source-Offsets Destination-Offsets *
* 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 8 9 *
* ----------------- --------------------- *
* |Y|Y|Y|Y|M|M|D|D| |M|M|-|D|D|-|Y|Y|Y|Y| *
* ----------------- --------------------- *
*********************************************
DATA: 
SOURCE     TYPE D VALUE '20130116',
DESTIN(10) TYPE C.
*****************************************

MOVE SOURCE+4(2) TO DESTIN+0. "MOVE MM to DESTIN
MOVE '-'         TO DESTIN+2. "MOVE '-' TO DESTIN
MOVE SOURCE+6(2) TO DESTIN+3. "MOVE DD to DESTIN
MOVE '-'         TO DESTIN+5. "MOVE '-' TO DESTIN
MOVE SOURCE+0(4) TO DESTIN+6. "MOVE YYYY to DESTIN

WRITE:
/5 'SOURCE-DEFAULT OUTPUT (DDMMYYYY) :', SOURCE,
/5 'DESTIN-TRANSFORMED OUTUT (MM/DD/YYYY) :', DESTIN.