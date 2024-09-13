REPORT YCL_CH08_19_RSWHOR_AT_RUN_TIME LINE-SIZE 140
NO STANDARD PAGE HEADING.

****************************************************************
* <result>, <where condition>, <order by> In Internal Tables *
****************************************************************
****************************************************************
* Declare data: elementary & internal table (simple array) for fields, WHERE condition & order by.
* Declare structure KNA1. (TABLES etc.) provision to fetch all fields.
* Fill the first internal table with field names for which data to be retrieved.
* Fill the second internal table with the WHERE condition.
* Fill the third internal table with order by field names with order by option: ASCENDING/DESCENDING.
* SELECT...WRITE...ENDSELECT statements with the usage of the three internal tables.
****************************************************************

TABLES: KNA1.

DATA: FIELD(15) TYPE C,
      FIELDS_TAB LIKE STANDARD TABLE OF FIELD, " For <result> in internal table
      CONDT(50) TYPE C,
      CONDTS_TAB LIKE STANDARD TABLE OF CONDT, " For <where condition> in internal table
      ORDER(30) TYPE C,
      ORDER_TAB LIKE STANDARD TABLE OF ORDER. " For <order by> in internal table

START-OF-SELECTION.

  " Populate FIELDS_TAB with field names to be retrieved
  FIELD = 'KUNNR'.
  APPEND FIELD TO FIELDS_TAB.
  FIELD = 'NAME1'.
  APPEND FIELD TO FIELDS_TAB.
  FIELD = 'ORT01'.
  APPEND FIELD TO FIELDS_TAB.
  "FIELD = 'STRAS'. " Uncomment these lines to include 'STRAS'
  "APPEND FIELD TO FIELDS_TAB.

  " Populate CONDTS_TAB with WHERE conditions
  CONDT = 'NAME1 LIKE ''A%'' OR '.
  APPEND CONDT TO CONDTS_TAB.
  CONDT = 'NAME1 LIKE ''C%'' OR '.
  APPEND CONDT TO CONDTS_TAB.
  CONDT = 'NAME1 LIKE ''S%'''.
  APPEND CONDT TO CONDTS_TAB.

  " Populate ORDER_TAB with ORDER BY fields and options
  ORDER = 'ORT01 DESCENDING'.
  APPEND ORDER TO ORDER_TAB.
  ORDER = 'NAME1 ASCENDING'.
  APPEND ORDER TO ORDER_TAB.

  " Dynamic SELECT statement
  SELECT (FIELDS_TAB) FROM KNA1
    INTO CORRESPONDING FIELDS OF KNA1
    WHERE (CONDTS_TAB)
    ORDER BY (ORDER_TAB).

    WRITE:/5(5) SY-DBCNT, KNA1-ORT01, KNA1-NAME1, KNA1-KUNNR USING NO EDIT MASK,
          KNA1-STRAS.
  ENDSELECT.
