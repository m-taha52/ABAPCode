REPORT YCL_CH04_13_SPLIT.
*********************************************************
* SPLIT – Break One Source String Into Multiple Strings *
* (Break Into Words) *
*********************************************************
*****************************************************
* take input string as ISTRING through PARAMETERS **
* 5 destination variables provided **
* operate the SPLIT statement on ISTRING AT SPACE **
* output destination variables **
*****************************************************

DATA:STR1(10) TYPE C,
STR2(10) TYPE C,
STR3(10) TYPE C,
STR4(10) TYPE C,
STR5(10) TYPE C.

*************************************************
PARAMETERS: ISTRING(50) TYPE C DEFAULT 'NIGHT AT THE MUSEUM'.
SPLIT ISTRING AT SPACE INTO STR1 STR2 STR3 STR4." SPACE is a System Data
" Object - blank/s
WRITE /5:
STR1,
STR2,
STR3,
STR4.