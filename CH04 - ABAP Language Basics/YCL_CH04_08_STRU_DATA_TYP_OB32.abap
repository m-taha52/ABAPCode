REPORT YCL_CH04_08_STRU_DATA_TYP_OBJ2.
*******************************************************************
* User Defined TYPE in DDIC, Reference to Structured Data Object **
*******************************************************************
******************************************************
* declare two structured data objects **
* (source, destination) by referring to structured **
* TYPE defined in DDIC Type Group **
* assign values to individual fields of source **
* use MOVE statement to transfer entire data of **
* source to destination. output from destination **
******************************************************


TYPE-POOLS YCLG1. "list Type Group you are using in this program

DATA:
CONTACT_MODES_SRCE TYPE YCLG1_CONTACT_MODES_TYPE,
CONTACT_MODES_DEST TYPE YCLG1_CONTACT_MODES_TYPE.
CONTACT_MODES_SRCE-NAME = 'AGHA SHEIK'.
CONTACT_MODES_SRCE-LAND_LINE = '00912696010'.
CONTACT_MODES_SRCE-CELL_NO = '00919502102350'.
CONTACT_MODES_SRCE-EMAIL = 'asheik41@yahoo.co.in'.

MOVE CONTACT_MODES_SRCE TO CONTACT_MODES_DEST. "MOVE stru to stru

WRITE: 
/5 'Name :', CONTACT_MODES_DEST-NAME,
/5 'Land Line No. :', CONTACT_MODES_DEST-LAND_LINE,
/5 'Cell No. :', CONTACT_MODES_DEST-CELL_NO,
/5 'Email Address :', CONTACT_MODES_DEST-EMAIL.