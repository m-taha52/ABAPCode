REPORT YCL_CH04_04_CONSTANTS.
*********************************************************************
* declare Constant data objects, assign values (which is mandatory) *
* declarative statement CONSTANTS . *
* output constant data objects *
*********************************************************************
***********************************************************************
* key word CONSTANTS used to declare constants **
* **
* the VALUE clause is to assign a starting value. it is mandatory **
* **
***********************************************************************
CONSTANTS: 
INDIAN_REPUBLIC_DAY TYPE D VALUE '19500126',
AMERICAN_INDE_DAY TYPE D VALUE '17760704',
ZERO TYPE I VALUE IS INITIAL.

WRITE:
/5 'INDIAN_REPUBLIC_DAY', INDIAN_REPUBLIC_DAY,
/5 'AMERICAN_INDE_DAY', AMERICAN_INDE_DAY.