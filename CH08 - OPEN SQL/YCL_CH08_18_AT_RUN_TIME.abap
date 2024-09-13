REPORT YCL_CH08_18_SRCE_AT_RUN_TIME LINE-SIZE 150
NO STANDARD PAGE HEADING.

*******************************************************
* <source> In SELECT At Runtime, Dynamic Data Objects *
*******************************************************
*************************************************
* From which database table/view to retrieve data is decided at runtime.
* The runtime database table name is input through PARAMETERS statement. (TABLE_NM)
* When you are retrieving data from a database table/view into an internal table,
* the internal table must have a structure which can accommodate the retrieved fields. (all
* fields of database table/view for now)
* When retrieving data, one row at a time from the internal table into a structure,
* you do not know the structure's attributes in terms of fields/components till runtime.
* So you are creating a dynamic structure data object using the table/view name input.
* The way to create a dynamic structure data object is:
* (a) Declare using DATA statement a reference variable like: DATA STRU_REF TYPE REF TO DATA.
* (b) Create dynamic structure data object by referring to the input table/view name
* like: CREATE DATA STRU_REF TYPE (TABLE_NM).
* This will create a structure data object having the same fields as the table/view input in TABLE_NM.
* The reference variable STRU_REF will point to the structure data object.
* To refer/point to the data, you need to de-reference the reference variable STRU_REF.
* You are de-referencing and assigning to a Field Symbol <FS_STRU> like ASSIGN STRU_REF->* TO <FS_STRU>.
* You are creating a dynamic internal table data object using the table/view name input.
* The way to create dynamic internal table data object is:
* (a) Declare using DATA statement a reference variable like: DATA ITAB_REF TYPE REF TO DATA.
* (b) Create dynamic internal table data object by referring to the input table/view name
* like: CREATE DATA ITAB_REF TYPE STANDARD TABLE OF (TABLE_NM).
* This will create an internal table data object having the same fields as the table structure TABLE_NM.
* The reference variable ITAB_REF will point to the internal table data object.
* To refer/point to the data in the internal table, you need to de-reference the reference variable ITAB_REF.
* You are de-referencing and assigning to a Field Symbol <FS_ITAB> like: ASSIGN ITAB_REF->* TO <FS_ITAB>.
* To access the individual fields of structure, you are using the Field Symbol assignment statement form:
* ASSIGN COMPONENT <component number> OF <structure name> TO <field symbol name>.
* The individual fields accessed in this way are output.
* The concept of creating dynamic data objects is introduced in a preview manner.
*************************************************
*************************************************
* Input the table/view name from which data to be retrieved
* Create a dynamic structure data object of type same as the inputted table/view.
* De-reference and assign to Field Symbol
* Create a dynamic internal table data object whose structure type is same as the inputted table/view.
* De-reference and assign to another Field Symbol
* Use the SELECT statement variation with runtime <source> to fetch data into dynamic internal table data object
* Set up LOOP...ENDLOOP
* Assign individual fields of structure data object to another Field Symbol & output
* LOOP...ENDLOOP will run through till all rows fetched & outputted
*************************************************

DATA: STRU_REF TYPE REF TO DATA, " reference variable for structure
      ITAB_REF TYPE REF TO DATA. " reference variable for internal table

FIELD-SYMBOLS: <FS_STRU> TYPE ANY, " Field Symbol for table/view structure
               <FS_ITAB> TYPE TABLE OF ANY, " Field Symbol for internal table
               <FS_FLD> TYPE ANY. " Field Symbol for individual fields

PARAMETERS: TABLE_NM TYPE DD03L-TABNAME DEFAULT 'T001' VALUE CHECK.

START-OF-SELECTION.
  " Create dynamic structure data object
  CREATE DATA STRU_REF TYPE (TABLE_NM).
  ASSIGN STRU_REF->* TO <FS_STRU>.

  " Create dynamic internal table data object
  CREATE DATA ITAB_REF TYPE STANDARD TABLE OF (TABLE_NM).
  ASSIGN ITAB_REF->* TO <FS_ITAB>.

  " Fetch data into dynamic internal table data object
  SELECT * FROM (TABLE_NM) INTO TABLE <FS_ITAB>.

  " Loop through the internal table and output fields
  LOOP AT <FS_ITAB> INTO <FS_STRU>.
    DO 6 TIMES.
      IF SY-INDEX = 1. " Skip the presumed client code (first) field
        CONTINUE.
      ENDIF.
      ASSIGN COMPONENT SY-INDEX OF STRUCTURE <FS_STRU> TO <FS_FLD>.
      " Output the field
      IF SY-INDEX = 2.
        WRITE:/5 <FS_FLD>. " New line for the first outputted field
      ELSE.
        WRITE: <FS_FLD>.
      ENDIF.
    ENDDO.
  ENDLOOP.
