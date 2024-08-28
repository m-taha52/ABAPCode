REPORT YCL_CH04_14_STRLEN.
*********************************************************
* STRLEN() – returns the length of a string variable *
*********************************************************
DATA: LEN(2) TYPE P DECIMALS 0.
PARAMETERS: ISTRING(50) TYPE C DEFAULT ' ABAP WORKBENCH '.
LEN = STRLEN( ISTRING ).
WRITE AT :/5 'String Length of:', (LEN) ISTRING, (2) LEN.