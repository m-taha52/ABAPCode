REPORT YCL_CH07_02_DESCRIBE_FLD_SROUT.

********************************************************
* DESCRIBE FIELD: Determine Attributes of Data Objects *
* Modularized Program - Usage of Subroutine            *
********************************************************

************************************************************************
* Declaration of data objects                                          *
* - Elementary data objects refer to DDIC table fields                 *
* - Elementary data object refers to DDIC data element                 *
* - Structure data object refers to DDIC table structure               *
* - Elementary data object of type STRING                              *
************************************************************************

DATA: 
  NAME1   TYPE KNA1-NAME1,       " Customer Name field from KNA1 table
  FKDAT   TYPE VBRK-FKDAT,       " Billing Date field from VBRK table
  NETWR   TYPE VBRK-NETWR,       " Net Value field from VBRK table
  TEXT1   TYPE TBOOKSHOP-TEXT1,  " Text field from TBOOKSHOP table
  LENGTH  TYPE TBOOKSHOP-LENGTH, " Length field from TBOOKSHOP table
  WAERS   TYPE WAERS,            " Currency key (reference to data element WAERS)
  INT1    TYPE MCSAPINT1,        " Custom data element for integers
  VBRK    TYPE VBRK,             " Structure of the VBRK table (Billing Document)
  STRNG   TYPE STRING.           " Standard string type for holding text

***************************************************************
* START-OF-SELECTION Event                                    *
* The main processing block that triggers when the program is *
* executed. Calls the subroutine PROCESS for each field.      *
***************************************************************

START-OF-SELECTION.
  PERFORM PROCESS USING NAME1  TEXT-001.  " Process and output attributes of NAME1
  PERFORM PROCESS USING FKDAT  TEXT-002.  " Process and output attributes of FKDAT
  PERFORM PROCESS USING NETWR  TEXT-003.  " Process and output attributes of NETWR
  PERFORM PROCESS USING TEXT1  TEXT-004.  " Process and output attributes of TEXT1
  PERFORM PROCESS USING LENGTH TEXT-005.  " Process and output attributes of LENGTH
  PERFORM PROCESS USING WAERS  TEXT-006.  " Process and output attributes of WAERS
  PERFORM PROCESS USING INT1   TEXT-007.  " Process and output attributes of INT1
  PERFORM PROCESS USING VBRK   TEXT-008.  " Process and output attributes of VBRK
  PERFORM PROCESS USING STRNG  TEXT-009.  " Process and output attributes of STRNG

*****************************************************************
* Subroutine PROCESS                                            *
* This subroutine processes a field to determine its attributes *
* and outputs the results.                                      *
* Parameters:                                                   *
* - FLD: The field whose attributes are to be determined (by value) *
* - TSYM: Text symbol ID for output (by value)                  *
*****************************************************************

FORM PROCESS USING VALUE(FLD) VALUE(TSYM).
  " Local variables to hold the field attributes
  DATA: 
    TYP(1)  TYPE C,  " Holds the field type (e.g., C, N, D, etc.)
    LEN     TYPE I,  " Holds the field length
    DECI    TYPE I,  " Holds the number of decimals (for packed or floating-point types)
    COMPO   TYPE I.  " Holds the number of components (for structures)

  " Determine the type of the field
  DESCRIBE FIELD FLD TYPE TYP. 

  *******************************************************
  * Determine the length of the field                   *
  * - For character types (C, D, N, T), use character mode *
  * - For other types, use byte mode                    *
  *******************************************************
  
  IF TYP <> 'C' AND TYP <> 'D' AND TYP <> 'N' AND TYP <> 'T'.
    DESCRIBE FIELD FLD LENGTH LEN IN BYTE MODE.        " Length in bytes
  ELSE.
    DESCRIBE FIELD FLD LENGTH LEN IN CHARACTER MODE.   " Length in characters
  ENDIF.

  *******************************************************
  * Output the attributes of the field                  *
  * - For simple types, output type and length          *
  * - For packed (P) and floating-point (F) types, include decimals *
  * - For structures (type 'u' or 'v'), include the number of components *
  *******************************************************
  
  IF TYP <> 'F' AND TYP <> 'P' AND TYP <> 'u' AND TYP <> 'v'.
    WRITE: /5 TSYM, TYP, (4) LEN.                     " Output field type and length
  ELSEIF TYP = 'F' OR TYP = 'P'.
    DESCRIBE FIELD FLD DECIMALS DECI.                 " Determine number of decimals
    WRITE: /5 TSYM, TYP, (4) LEN, (2) DECI.           " Output type, length, and decimals
  ELSEIF TYP = 'u' OR TYP = 'v'.
    DESCRIBE FIELD FLD TYPE TYP COMPONENTS COMPO.     " Determine number of components for structures
    WRITE: /5 TSYM, TYP, (4) LEN, (3) COMPO.          " Output type, length, and number of components
  ENDIF.

ENDFORM. 
