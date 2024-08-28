REPORT YCL_CH04_17_DESCRIBE_FIELD.

********************************************************
* DESCRIBE FIELD: Determine Attributes of Data objects *
********************************************************

***********************************************************************
* This program declares various data objects (elementary and structured)
* and uses the DESCRIBE FIELD statement to determine and output their 
* attributes, such as type, length, output length, decimals, and components.
***********************************************************************

DATA: 
  NAME1 TYPE KNA1-NAME1,        " DDIC table field
  FKDAT TYPE VBRK-FKDAT,        " DDIC table field
  NETWR TYPE VBRK-NETWR,        " DDIC table field
  TEXT1 TYPE TBOOKSHOP-TEXT1,   " DDIC table field
  LENGTH TYPE TBOOKSHOP-LENGTH, " DDIC table field
  WAERS TYPE WAERS,             " Reference to data element
  INT1 TYPE MCSAPINT1,          " Reference to data element
  VBRK TYPE VBRK,               " Reference to table structure
  STRNG TYPE STRING,            " Locally defined string type

  TYP(1) TYPE C,                " For storing the type
  LEN TYPE I,                   " For storing the length
  OLEN TYPE I,                  " For storing the output length
  DECI TYPE I,                  " For storing the decimal places
  COMPO TYPE I.                 " For storing the number of components

**************************************************************************
* Describe the field NAME1
DESCRIBE FIELD NAME1 TYPE TYP.
IF TYP = 'C' OR TYP = 'D' OR TYP = 'N' OR TYP = 'T'.
  DESCRIBE FIELD NAME1 LENGTH LEN IN CHARACTER MODE.
ELSE.
  DESCRIBE FIELD NAME1 LENGTH LEN IN BYTE MODE.
ENDIF.
WRITE:/5 'KNA1-NAME1 TYPE & LENGTH :', TYP, (3) LEN.

*********************************************************************
* Describe the field FKDAT
DESCRIBE FIELD FKDAT TYPE TYP.
IF TYP = 'C' OR TYP = 'D' OR TYP = 'N' OR TYP = 'T'.
  DESCRIBE FIELD FKDAT LENGTH LEN IN CHARACTER MODE.
ELSE.
  DESCRIBE FIELD FKDAT LENGTH LEN IN BYTE MODE.
ENDIF.
WRITE:/5 'VBRK-FKDAT TYPE & LENGTH :', TYP, (3) LEN.

**********************************************************************
* Describe the field NETWR
DESCRIBE FIELD NETWR TYPE TYP.
IF TYP = 'C' OR TYP = 'D' OR TYP = 'N' OR TYP = 'T'.
*  DESCRIBE FIELD NETWR LENGTH LEN IN CHARACTER MODE.
ELSE.
  DESCRIBE FIELD NETWR LENGTH LEN IN BYTE MODE.
ENDIF.
IF TYP = 'F' OR TYP = 'P'.
  DESCRIBE FIELD NETWR DECIMALS DECI.
ENDIF.
DESCRIBE FIELD NETWR OUTPUT-LENGTH OLEN.
WRITE:/5 'VBRK-NETWR TYPE, LENGTH OUTPUT-LENGTH & DECIMALS :', 
        TYP, (3) LEN, (2) OLEN, (2) DECI.

***********************************************************************
* Describe the field TEXT1
DESCRIBE FIELD TEXT1 TYPE TYP.
IF TYP = 'C' OR TYP = 'D' OR TYP = 'N' OR TYP = 'T'.
  DESCRIBE FIELD TEXT1 LENGTH LEN IN CHARACTER MODE.
ELSE.
  DESCRIBE FIELD TEXT1 LENGTH LEN IN BYTE MODE.
ENDIF.
WRITE:/5 'TBOOKSHOP-TEXT1 TYPE & LENGTH :', TYP, (4) LEN.

*********************************************************************
* Describe the field LENGTH (INT2 type)
DESCRIBE FIELD LENGTH TYPE TYP.
IF TYP = 'C' OR TYP = 'D' OR TYP = 'N' OR TYP = 'T'.
*  DESCRIBE FIELD LENGTH LENGTH LEN IN CHARACTER MODE.
ELSE.
  DESCRIBE FIELD LENGTH LENGTH LEN IN BYTE MODE.
ENDIF.
WRITE:/5 'TBOOKSHOP-LENGTH TYPE & LENGTH (DDIC TYPE INT2) :', TYP, (3) LEN.

*******************************************************************
* Describe the field WAERS
DESCRIBE FIELD WAERS TYPE TYP.
IF TYP = 'C' OR TYP = 'D' OR TYP = 'N' OR TYP = 'T'.
  DESCRIBE FIELD WAERS LENGTH LEN IN CHARACTER MODE.
ELSE.
  DESCRIBE FIELD WAERS LENGTH LEN IN BYTE MODE.
ENDIF.
WRITE:/5 'CURRENCY CODE WAERS TYPE & LENGTH :', TYP, (3) LEN.

********************************************************************
* Describe the field INT1
DESCRIBE FIELD INT1 TYPE TYP.
IF TYP = 'C' OR TYP = 'D' OR TYP = 'N' OR TYP = 'T'.
*  DESCRIBE FIELD INT1 LENGTH LEN IN CHARACTER MODE.
ELSE.
  DESCRIBE FIELD INT1 LENGTH LEN IN BYTE MODE.
ENDIF.
WRITE:/5 'DDIC TYPE INT1 & LENGTH (REF. TO DATA ELEMENT) :', TYP, (3) LEN.

************************************************************************
* Describe the structure VBRK
DESCRIBE FIELD VBRK TYPE TYP COMPONENTS COMPO LENGTH LEN IN BYTE MODE.
WRITE:/5 'VBRK TYPE, LENGTH & COMPONENTS :', TYP, (4) LEN, (3) COMPO.

************************************************************************
* Describe the string field STRNG
DESCRIBE FIELD STRNG TYPE TYP.
IF TYP = 'C' OR TYP = 'D' OR TYP = 'N' OR TYP = 'T'.
*  DESCRIBE FIELD STRNG LENGTH LEN IN CHARACTER MODE.
ELSE.
  DESCRIBE FIELD STRNG LENGTH LEN IN BYTE MODE.
ENDIF.
WRITE:/5 'LOCALLY DEFINED TYPE ''STRING'' TYPE & LENGTH :', TYP, (3) LEN.
