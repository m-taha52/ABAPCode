REPORT YCL_CH04_02_LIST_SYS_FIELDS.

**************************
* Output System Fields **
**************************

* Output system fields with descriptive labels and proper alignment.
WRITE:/5 'SY-ABCDE', SY-ABCDE,    " SY-ABCDE: Custom field in the SAP system, typically used for special purposes.
      /5 'SY-DATUM', SY-DATUM,    " SY-DATUM: Current date in the format YYYYMMDD.
      /5 'SY-DBSYS', SY-DBSYS,    " SY-DBSYS: Database system used by the SAP system (e.g., 'ORACLE').
      /5 'SY-HOST', SY-HOST,      " SY-HOST: Hostname of the SAP application server.
      /5 'SY-LANGU', SY-LANGU,    " SY-LANGU: Language key for the SAP system, indicating the current language.
      /5 'SY-MANDT', SY-MANDT,    " SY-MANDT: Client number of the SAP system, identifying the logical client.
      /5 'SY-OPSYS', SY-OPSYS,    " SY-OPSYS: Operating system of the server (e.g., 'UNIX').
      /5 'SY-REPID', SY-REPID,    " SY-REPID: Name of the current report or program being executed.
      /5 'SY-SAPRL', SY-SAPRL,    " SY-SAPRL: SAP release version, indicating the version of SAP software.
      /5 'SY-SYSID', SY-SYSID,    " SY-SYSID: System ID of the SAP system, used to uniquely identify the system.
      /5 'SY-TCODE', SY-TCODE,    " SY-TCODE: Transaction code of the currently executed transaction.
      /5 'SY-UNAME', SY-UNAME,    " SY-UNAME: User ID of the currently logged-on user.
      /5 'SY-UZEIT', SY-UZEIT.    " SY-UZEIT: Current time in the format HHMMSS.
