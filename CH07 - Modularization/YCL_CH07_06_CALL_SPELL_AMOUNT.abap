REPORT YCL_CH07_06_CALL_SPELL_AMOUNT LINE-SIZE 170.

*****************************************
* Calling Function Module SPELL_AMOUNT *
*****************************************

***************************************************
* Purpose: Convert numerical amount to words *
* Input: PARAMETERS for amount and currency *
* Output: Written representation of the amount *
***************************************************

DATA: RET_SPELL TYPE SPELL.  " Structure to hold the result from SPELL_AMOUNT

PARAMETERS: AMOUNT TYPE P DECIMALS 2 DEFAULT '87654321.90'.  " Amount to be converted (with default value)

START-OF-SELECTION.

  " Call the function module SPELL_AMOUNT to convert the amount to words
  CALL FUNCTION 'SPELL_AMOUNT'
    EXPORTING
      AMOUNT   = AMOUNT        " Amount figure to be converted
      CURRENCY = 'INR'         " Currency code (INR)
      FILLER   = ' '           " Filler (not used)
      LANGUAGE = SY-LANGU      " Language code (system default)
    IMPORTING
      IN_WORDS = RET_SPELL     " Output structure containing the spellings
    EXCEPTIONS
      NOT_FOUND = 1            " Exception if the amount is not found
      TOO_LARGE  = 2           " Exception if the amount is too large
      OTHERS     = 3           " Other exceptions
    .

  " Check if there was an error during function call
  IF SY-SUBRC <> 0.
    " Display error message if function module fails
    MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
      WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ELSE.
    " Output the result if there was no error
    WRITE: /5: RET_SPELL-WORD,  " Written representation of the whole amount
           RET_SPELL-DECWORD.  " Written representation of the decimal part
  ENDIF.
