FUNCTION YCL_CH07_SPLIT_STRING.
*"----------------------------------------------------------------------
*"*"Local Interface:
*" IMPORTING
*" VALUE(STRING_TO_SPLIT) TYPE STRING
*" TABLES
*" STABLE
*" EXCEPTIONS
*" IMPORT_PARAMETER_TYPE_INVALID
*" RETURN_TABLE_ELEMENT_NOT_TYPEC
*"----------------------------------------------------------------------
**********************************************************
* Purpose: Split a string into words and store in an internal table *
* Parameters: STRING_TO_SPLIT - String to be split *
*             STABLE - Internal table to hold the result *
**********************************************************

DATA: WORD    TYPE STRING,  " Variable to store the extracted word
      TYP     TYPE C,      " Variable to store data type
      LEN     TYPE I,      " Maximum length of each row in STABLE
      CLEN    TYPE I,      " Available characters in the current row of STABLE
      WLEN    TYPE I.      " Length of the extracted word

" Check and raise exceptions if the parameter types are incorrect
DESCRIBE FIELD STRING_TO_SPLIT TYPE TYP.
IF TYP <> 'C' AND TYP <> 'g'.
  MESSAGE S006(YCL_CH06_MCLASS01) RAISING IMPORT_PARAMETER_TYPE_INVALID.
ENDIF.

DESCRIBE FIELD STABLE TYPE TYP.
" Check if STABLE is of type C (character)
IF TYP <> 'C'.
  MESSAGE S007(YCL_CH06_MCLASS01) RAISING RETURN_TABLE_ELEMENT_NOT_TYPEC.
ENDIF.

" Clear existing rows in the internal table STABLE
REFRESH STABLE[].

" Determine the length of each row in STABLE
DESCRIBE FIELD STABLE LENGTH LEN IN CHARACTER MODE.
CLEN = LEN.

" Main processing loop
DO.
  " Exit loop if STRING_TO_SPLIT is empty
  IF STRING_TO_SPLIT IS INITIAL.
    EXIT.
  ENDIF.

  " Search for the first blank space in STRING_TO_SPLIT
  SEARCH STRING_TO_SPLIT FOR ' '.
  
  " If blank is found, split the string into WORD and residual STRING_TO_SPLIT
  IF SY-SUBRC = 0.
    SPLIT STRING_TO_SPLIT AT ' ' INTO WORD STRING_TO_SPLIT.
  ELSE.
    " If no blank is found, the entire STRING_TO_SPLIT is the last word
    WORD = STRING_TO_SPLIT.
    STRING_TO_SPLIT = ''.
  ENDIF.

  " Determine the length of the extracted WORD
  WLEN = STRLEN(WORD).

  " If this is the first word, initialize STABLE with WORD
  IF SY-INDEX = 1.
    STABLE = WORD.
  " If WORD fits into the current row of STABLE, concatenate it
  ELSEIF WLEN <= CLEN.
    CONCATENATE STABLE WORD INTO STABLE SEPARATED BY ' '.
  " If WORD does not fit, append STABLE to the internal table and start a new row
  ELSE.
    APPEND STABLE TO STABLE[].
    STABLE = WORD.
    CLEN = LEN.
  ENDIF.

  " Adjust the available characters in the current row of STABLE
  CLEN = CLEN - WLEN - 1.
ENDDO.

" Append the last row if it is not empty
IF STABLE <> ''.
  APPEND STABLE TO STABLE[].
ENDIF.

ENDFUNCTION.
