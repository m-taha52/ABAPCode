REPORT YCL_CH04_10_DATE_ARITHM.

********************
* Date Arithmetic **
********************
* This program demonstrates basic date arithmetic in ABAP. 
* It accepts two dates and a number of days as input and 
* performs the following operations:
* 1. Calculates and outputs the difference between the two dates.
* 2. Calculates and outputs the date obtained by adding the specified 
*    number of days to the second date.
* 3. Calculates and outputs the last day of the month for the first date.
**********************************************************

* Declare variables for arithmetic operations and date components.
DATA: VAR TYPE I,             " Integer variable to hold the difference between dates
      DATE TYPE D,            " Date variable to hold the calculated date
      YEAR(4) TYPE N,         " Numeric variable for the year component
      MONTH(2) TYPE N,        " Numeric variable for the month component
      DAY(2) TYPE N.          " Numeric variable for the day component

* PARAMETERS statement for user input.
PARAMETERS: DATE1 TYPE D DEFAULT '20131025', " First date input, default '2013-10-25'
            DATE2 TYPE D DEFAULT '20121125', " Second date input, default '2012-11-25'
            DAYS TYPE I DEFAULT 100.         " Number of days to add, default 100

*************************************************
* Calculate the difference between DATE1 and DATE2 and output it.
VAR = DATE1 - DATE2. 
WRITE:/5 'Diff. between Dates:', DATE1 DD/MM/YYYY,   " Output DATE1 in DD/MM/YYYY format
        DATE2 DD/MM/YYYY, '=', (5) VAR.             " Output DATE2 and the difference

* Calculate the date obtained by adding DAYS to DATE2 and output it.
DATE = DATE2 + DAYS. 
WRITE:/5 DATE2 DD/MM/YYYY, '+', (5) DAYS, '=', DATE DD/MM/YYYY.

* Extract year and month components from DATE1.
YEAR = DATE1+0(4).      " Extract year (first 4 characters)
MONTH = DATE1+4(2).     " Extract month (next 2 characters)

* Calculate the first day of the next month.
IF MONTH < 12.
    MONTH = MONTH + 1.   " Increment the month
ELSE.
    MONTH = 1.           " Reset to January
    YEAR = YEAR + 1.     " Increment the year
ENDIF.

* Set the calculated date to the first day of the next month.
DATE+0(4) = YEAR.       " Set the year component
DATE+4(2) = MONTH.      " Set the month component
DATE+6(2) = '01'.       " Set the day to the first day of the month

* Subtract 1 day to get the last day of the current month.
DATE = DATE - 1.

* Extract the day component to find the last day of the month.
DAY = DATE+6(2).        
WRITE:/5 'Last day of month for date', DATE1 DD/MM/YYYY, '=', DAY. " Output the last day
