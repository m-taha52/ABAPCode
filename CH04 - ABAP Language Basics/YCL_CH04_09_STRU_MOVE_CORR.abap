REPORT YCL_CH04_09_STRU_MOVE_CORR.
*************************************************
* Structured Data Objects - MOVE-CORRESPONDING **
*************************************************
*******************************************************
* declare two structured data objects with one field **
* name differing in source & destination **
* **
* assign values to individual fields of source and **
* destination **
* **
* use MOVE-CORRESPONDING statement to transfer from **
* source to destination. output from destination **
*******************************************************
DATA: 

BEGIN OF CONTACT_MODES_SRCE,
    NAME(25) TYPE C VALUE 'GURU DAS',
    LAND_LINE(12) TYPE N VALUE '00912696113',
    CELL_NO(14) TYPE N VALUE '00919592302444',
    EMAIL TYPE STRING VALUE 'gu_das@gmail.com',
END OF CONTACT_MODES_SRCE,

BEGIN OF CONTACT_MODES_DEST,
    NAME(25) TYPE C VALUE 'ZZZZZZZZ',
    LAND_LINE_NO(12) TYPE N VALUE '999999999999',
    CELL_NO(12) TYPE N VALUE '999999999999', " length differs from source
    EMAIL TYPE STRING VALUE 'ZZZZZZZZZZZZZZZZ',
END OF CONTACT_MODES_DEST.

WRITE: 
/5 'Name :', CONTACT_MODES_DEST-NAME,
/5 'Land Line No. :', CONTACT_MODES_DEST-LAND_LINE_NO,
/5 'Cell No. :', CONTACT_MODES_DEST-CELL_NO,
/5 'Email Address :', CONTACT_MODES_DEST-EMAIL.