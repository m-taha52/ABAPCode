REPORT YCL_CH04_11_TRANSLATE.

***************************************
* TRANSLATE: UPPER CASE, LOWER CASE  **
***************************************
* This program demonstrates the use of the TRANSLATE statement 
* to convert a string to either upper case or lower case.
************************************************

* Declare a variable to store the translated string.
DATA: OSTRING(50) TYPE C.

* PARAMETERS statement to accept input string (ISTRING).
* LOWER CASE clause allows input in both lower and upper case.
* Without this clause, all input is converted to upper case by default.
PARAMETERS: ISTRING(50) TYPE C LOWER CASE DEFAULT 'MpHasIS - An H.p. CoMPanY'.

* Assign the input string (ISTRING) to the output string (OSTRING).
OSTRING = ISTRING.

* Convert OSTRING to upper case and display it.
TRANSLATE OSTRING TO UPPER CASE.
WRITE:/5 'Original String :', ISTRING,              " Output the original string
      /5 'UPPER CASE STRING:', OSTRING.             " Output the string in upper case

* Reassign the input string (ISTRING) to the output string (OSTRING).
OSTRING = ISTRING;

* Convert OSTRING to lower case and display it.
TRANSLATE OSTRING TO LOWER CASE.
WRITE:/5 'lower case string:', OSTRING.             " Output the string in lower case
