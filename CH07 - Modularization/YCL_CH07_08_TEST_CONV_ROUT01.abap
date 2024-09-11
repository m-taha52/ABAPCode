REPORT YCL_CH07_08_TEST_CONV_ROUT01.

DATA: STRING10 TYPE C LENGTH 10.  " Variable to hold the customer code with length 10

**************************************************
* Function Modules CONVERSION_EXIT_ALPHA_INPUT **
* and CONVERSION_EXIT_ALPHA_OUTPUT in action    **
**************************************************
* This report demonstrates how to use conversion
* routines for handling customer codes with and
* without leading zeros.
**************************************************

PARAMETERS: CUST_CD TYPE KUNNR.  " Input parameter for customer code (KUNNR type)

START-OF-SELECTION.
  " Assign the customer code to STRING10
  STRING10 = CUST_CD.

  " Output customer code without edit mask
  WRITE: /5 'CUST_CD',
         /5 'CUST_CD (USING NO EDIT MASK):', CUST_CD USING NO EDIT MASK.

  SKIP 2.

  " Output STRING10 with and without edit mask
  WRITE: /5 'STRING10',
         /5 'STRING10 (USING EDIT MASK):', STRING10 USING EDIT MASK '==ALPHA'.
