
********************************************************
* DESCRIBE FIELD: Determine Attributes of Data Objects *
* Modularize Code Using Macro & Subroutine             *
********************************************************

************************************************************************
* This section declares various data objects.                         *
* These objects include references to fields from DDIC tables,        *
* a structure, and standard types like STRING, C, and I.              *
************************************************************************

DATA:
  NAME1 TYPE KNA1-NAME1,       " Customer Name field from KNA1 table
  FKDAT TYPE VBRK-FKDAT,       " Billing Date field from VBRK table
  NETWR TYPE VBRK-NETWR,       " Net Value field from VBRK table
  TEXT1 TYPE TBOOKSHOP-TEXT1,  " Text field from TBOOKSHOP table
  LENGTH TYPE TBOOKSHOP-LENGTH," Length field from TBOOKSHOP table
  WAERS TYPE WAERS,            " Currency key (reference to data element WAERS)
  INT1 TYPE MCSAPINT1,         " Custom data element for integers
  VBRK TYPE VBRK,              " Structure of the VBRK table (Billing Document)
  STRNG TYPE STRING,           " Standard string type for holding text
  TYP(1) TYPE C,               " Character type for holding field type
  LEN TYPE I,                  " Integer type for holding field length
  DECI TYPE I,                 " Integer type for holding number of decimals
  COMPO TYPE I.                " Integer type for holding number of components in a structure

***********************************************
* Macro Definition: DESCRIBE_FLD             *
* This macro simplifies the code by avoiding *
* repetition when describing fields.         *
* Parameters:                                *
* &1 - Field to be described                 *
* &2 - Text Symbol ID for output             *
***********************************************

DEFINE DESCRIBE_FLD.
  DESCRIBE FIELD &1 TYPE TYP.           " Get the type of the field (e.g., C, P, F)
  PERFORM GET_LENGTH USING &1 LEN TYP.  " Get the length of the field and store in LEN

  " Determine the output based on the type of the field
  IF TYP <> 'F' AND TYP <> 'P' AND TYP <> 'u' AND TYP <> 'v'.
    WRITE: /5 &2, TYP, (4) LEN.         " Output field type and length for simple data types
  ELSEIF TYP = 'F' OR TYP = 'P'.
    DESCRIBE FIELD &1 DECIMALS DECI.    " Get the number of decimals for packed or floating-point types
    WRITE: /5 &2, TYP, (4) LEN, (2) DECI. " Output field type, length, and decimals
  ELSEIF TYP = 'u' OR TYP = 'v'.
    DESCRIBE FIELD &1 TYPE TYP COMPONENTS COMPO. " Get the number of components for structures
    WRITE: /5 &2, TYP, (4) LEN, (3) COMPO. " Output field type, length, and number of components
  ENDIF.
END-OF-DEFINITION.

*****************************************
* START-OF-SELECTION Event              *
* This block executes when the program  *
* is run, calling the macro to describe *
* various fields.                       *
*****************************************

START-OF-SELECTION.
  " Call the macro to describe each field and output its attributes
  DESCRIBE_FLD NAME1 TEXT-001. " Describe the NAME1 field
  DESCRIBE_FLD FKDAT TEXT-002. " Describe the FKDAT field
  DESCRIBE_FLD NETWR TEXT-003. " Describe the NETWR field
  DESCRIBE_FLD TEXT1 TEXT-004. " Describe the TEXT1 field
  DESCRIBE_FLD LENGTH TEXT-005. " Describe the LENGTH field
  DESCRIBE_FLD WAERS TEXT-006. " Describe the WAERS field
  DESCRIBE_FLD INT1 TEXT-007. " Describe the INT1 field
  DESCRIBE_FLD VBRK TEXT-008. " Describe the VBRK structure
  DESCRIBE_FLD STRNG TEXT-009. " Describe the STRNG field

***************************************************************
* Subroutine GET_LENGTH                                       *
* This subroutine determines the length of a field based on   *
* its type.                                                   *
* Parameters:                                                 *
* FLD - The field whose length is to be determined (by value) *
* LNGT - The field to store the length (by reference)         *
* TP - The type of the field (by value)                       *
*                                                             *
* The subroutine returns the length in characters for types   *
* C, D, N, T. For other types, it returns the length in bytes.*
***************************************************************

FORM GET_LENGTH USING VALUE(FLD) LNGT VALUE(TP).
  " Determine the length mode (bytes or characters) based on field type
  IF TP <> 'C' AND TP <> 'D' AND TP <> 'N' AND TP <> 'T'.
    DESCRIBE FIELD FLD LENGTH LNGT IN BYTE MODE.      " Get length in bytes for non-character types
  ELSE.
    DESCRIBE FIELD FLD LENGTH LNGT IN CHARACTER MODE. " Get length in characters for character types
  ENDIF.
ENDFORM.
