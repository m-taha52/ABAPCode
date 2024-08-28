REPORT YCL_CH04_06_STRU_DATA_OBJ.

******************************************************
* Structured Data Objects: Access Individual Fields **
******************************************************
* This program demonstrates the use of structured data objects
* in ABAP. It declares a structured data object, assigns initial
* values to its fields, and outputs these values by accessing 
* the individual fields of the structured object.
**************************************************

* Declare a structured data object named CONTACT_MODES.
* Fields include NAME, LAND_LINE, CELL_NO, and EMAIL with their 
* corresponding data types and initial values.
DATA: BEGIN OF CONTACT_MODES,    " Start of structure definition
      NAME(25) TYPE C VALUE 'SURAJ NAIR',          " TYPE C: Character type with a length of 25 bytes
      LAND_LINE(12) TYPE N VALUE '009126960021',   " TYPE N: Numeric type with a length of 12 digits
      CELL_NO(14) TYPE N VALUE '00919502102377',   " TYPE N: Numeric type with a length of 14 digits
      EMAIL TYPE STRING VALUE 'snair23@gmail.com',  " TYPE STRING: Variable-length character string
      END OF CONTACT_MODES.                      " End of structure definition

* Output the values of the fields in the structured data object
* with descriptive labels.
WRITE: /5 'Name :', CONTACT_MODES-NAME,          " Output NAME field with label
       /5 'Land Line No. :', CONTACT_MODES-LAND_LINE, " Output LAND_LINE field with label
       /5 'Cell No. :', CONTACT_MODES-CELL_NO,   " Output CELL_NO field with label
       /5 'Email Address :', CONTACT_MODES-EMAIL. " Output EMAIL field with label
