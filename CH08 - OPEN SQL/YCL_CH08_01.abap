****************************************************
* INCLUDE program for heading of customer list **
* used by programs: - YCL_CH08_02.. **
* YCL_CH08_03.. **
****************************************************
TOP-OF-PAGE.
WRITE:/5 TEXT-001, CDATE, 92(3) SY-PAGNO.
WRITE:/5(89) SY-ULINE.
WRITE:/5 TEXT-002, 11 TEXT-003, 22 TEXT-004, 58 TEXT-005.
WRITE:/6 TEXT-006, 13 TEXT-007.
WRITE:/5(89) SY-ULINE.
******************************************************************