REPORT YCL_CH04_12_CONCATENATE.
*******************************************************
* CONCATENATE - Join Multiple Strings Into One String *
*******************************************************
********************************************
* input a date IDATE through PARAMETERS **
* use CONCATENATE statement to join MM **
* [IDATE+4(2)] '/' DD [IDATE+6(2)] '/' **
* YYYY [IDATE+0(4)] in CDATE. CDATE will **
* will contain MM/DD/YYYY. **
* Output IDATE and CDATE **
* **
* repeat the CONCATENATE statement by **
* specifying separator string/character **
* Output IDATE and CDATE **
********************************************

DATA: CDATE(10) TYPE C.

PARAMETERS IDATE TYPE D DEFAULT '20130116'.

CONCATENATE IDATE+4(2) '/' IDATE+6(2) '/' IDATE+0(4) INTO CDATE.

WRITE:/5 IDATE, CDATE.

CONCATENATE IDATE+4(2) IDATE+6(2) IDATE+0(4) INTO CDATE
SEPARATED BY '/'. "use of separator character

WRITE:/5 IDATE, CDATE.