REPORT YCL_CH04_15_CONDENSE.

***********************
* CONDENSE Statement  *
***********************
****************************************************************
* This program demonstrates the use of the CONDENSE statement 
* to remove leading spaces and reduce multiple embedded blanks 
* in a string to a single space or no space at all.
****************************************************************

* Declare a variable to store the output string.
DATA: OSTRING(50) TYPE C.

* PARAMETERS statement to accept input string (ISTRING).
PARAMETERS: ISTRING(50) TYPE C DEFAULT ' ABAP LANGUAGE BASICS'.

* Assign the input string (ISTRING) to the output string (OSTRING).
MOVE ISTRING TO OSTRING.

* Condense OSTRING:
* - Removes leading spaces.
* - Reduces multiple embedded blanks to a single space.
CONDENSE OSTRING.
WRITE:/5 'Original String :', ISTRING,              " Output the original string
      /5 'Condensed String :', OSTRING.             " Output the condensed string

* Reassign the input string (ISTRING) to the output string (OSTRING).
MOVE ISTRING TO OSTRING.

* Condense OSTRING with NO-GAPS:
* - Removes leading spaces.
* - Removes all embedded blanks entirely.
CONDENSE OSTRING NO-GAPS.
WRITE:/5 'Condensed String (NO-GAPS) :', OSTRING.   " Output the string with no gaps
