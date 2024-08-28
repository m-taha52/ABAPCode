*******************************************************************
* Declare elementary DATA objects, assign values with declaration *
* Output data objects *
*******************************************************************

* The DATA statement is used to declare data objects (variables) 
* and assign initial values if required. The VALUE clause is optional.
* Different data types (C/D/F/I/N/P/T/X/STRING/XSTRING) have specific 
* length and value requirements, as detailed below.

DATA: CNAME(25) TYPE C VALUE 'MPHASIS - an H.P. Company',   " TYPE C: Character type with a length of 25 bytes.
      TODAY TYPE D VALUE '20130101',                        " TYPE D: Date type in YYYYMMDD format.
      FNUM TYPE F VALUE '12345.6789',                       " TYPE F: Floating-point number with a default length and precision.
      COUNT TYPE I VALUE 987654321,                         " TYPE I: Integer type for whole numbers.
      ECODE(7) TYPE N VALUE 2191778,                        " TYPE N: Numeric type with a length of 7 digits.
      BASIC_SAL(4) TYPE P DECIMALS 2 VALUE 20000,            " TYPE P: Packed number with 2 decimal places, used for monetary values.
      NOW TYPE T VALUE '094500',                            " TYPE T: Time type in HHMMSS format.
      HEXA(8) TYPE X VALUE '0123456789ABCDEF',               " TYPE X: Hexadecimal type with a length of 8 bytes.
      STRNG TYPE STRING VALUE 'MORGAN''S GATE'.              " TYPE STRING: Variable-length character string. Single quotes are doubled in the string.

* Output the values of the declared data objects with descriptive labels.
WRITE:/5 'TYPE C :', CNAME,    " Output TYPE C variable with label.
      /5 'TYPE D :', TODAY,    " Output TYPE D variable with label.
      /5 'TYPE F :', FNUM,     " Output TYPE F variable with label.
      /5 'TYPE I :', COUNT,    " Output TYPE I variable with label.
      /5 'TYPE N :', ECODE,    " Output TYPE N variable with label.
      /5 'TYPE P :', BASIC_SAL, " Output TYPE P variable with label.
      /5 'TYPE T :', NOW,      " Output TYPE T variable with label.
      /5 'TYPE X :', HEXA,     " Output TYPE X variable with label.
      /5 'TYPE STRING :', STRNG. " Output TYPE STRING variable with label.
