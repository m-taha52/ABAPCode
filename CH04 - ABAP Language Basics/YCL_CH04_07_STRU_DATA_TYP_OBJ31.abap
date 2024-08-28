REPORT YCL_CH04_07_STRU_DATA_TYP_OBJ1.

************************************************************
* User-Defined TYPE, Reference to Structured Data Objects **
************************************************************
* This program demonstrates the creation and usage of a user-defined
* structured TYPE in ABAP. It declares two structured data objects 
* (source and destination) by referring to this user-defined TYPE. 
* Values are assigned to individual fields of the source structure,
* and then the entire structure is transferred to the destination 
* structure using the MOVE statement. Finally, the data from the 
* destination structure is output.
************************************************************

* Declare a user-defined structured TYPE named CONTACT_MODES_TYPE.
TYPES: BEGIN OF CONTACT_MODES_TYPE,          " Start of user-defined structure
       NAME(25) TYPE C,                      " NAME: Character type with a length of 25 bytes
       LAND_LINE(12) TYPE N,                 " LAND_LINE: Numeric type with a length of 12 digits
       CELL_NO(14) TYPE N,                   " CELL_NO: Numeric type with a length of 14 digits
       EMAIL TYPE STRING,                    " EMAIL: Variable-length character string
       END OF CONTACT_MODES_TYPE.            " End of user-defined structure

* Declare two structured data objects: CONTACT_MODES_SRCE and CONTACT_MODES_DEST,
* by referring to the user-defined structured TYPE CONTACT_MODES_TYPE.
DATA: CONTACT_MODES_SRCE TYPE CONTACT_MODES_TYPE,   " Source structure
      CONTACT_MODES_DEST TYPE CONTACT_MODES_TYPE.   " Destination structure

* Assign values to individual fields of the source structure.
CONTACT_MODES_SRCE-NAME = 'ATUL VASAN'.              " Assign name
CONTACT_MODES_SRCE-LAND_LINE = '00912696008'.        " Assign landline number
CONTACT_MODES_SRCE-CELL_NO = '00919502102355'.       " Assign cell phone number
CONTACT_MODES_SRCE-EMAIL = 'atulvs@yahoo.co.in'.     " Assign email address

* Transfer the entire structure data from source to destination using the MOVE statement.
MOVE CONTACT_MODES_SRCE TO CONTACT_MODES_DEST.      " Move data from source to destination

* Output the data from the destination structure to verify the transfer.
WRITE: /5 'Name :', CONTACT_MODES_DEST-NAME,           " Output NAME from destination
       /5 'Land Line No. :', CONTACT_MODES_DEST-LAND_LINE, " Output LAND_LINE from destination
       /5 'Cell No. :', CONTACT_MODES_DEST-CELL_NO,    " Output CELL_NO from destination
       /5 'Email Address :', CONTACT_MODES_DEST-EMAIL. " Output EMAIL from destination
