REPORT YCL_CH04_16_SY_INDEX.
******************************************************
* Demonstrate the Behavior of System Field SY-INDEX **
******************************************************
***************************************************************
* SY-INDEX contains the pass no of current loop **
* **
* if you are in the outer loop, it will contain pass no of **
* outer loop. if you are in the inner loop, it will **
* contain pass no of inner loop **
* **
* the inner loop will perform twice (IF SY-INDEX > 2. EXIT.) **
* for every pass of outer loop. the outer loop will **
* perform thrice (IF SY-INDEX > 3. EXIT.) **
* **

* the WRITE statement in outer loop outputs starting from **
* column 5. SY-INDEX is TYPE I. TYPE I outputs by default in **
* 11 columns. SY-index is being output in two columns **
* (its value never excedding 3 in this program) **
* **
* the WRITE statement in inner loop outputs starting from **
* column 10. **
***************************************************************
DO.
    IF SY-INDEX > 3.  
        EXIT.
    ENDIF.

    WRITE:/5 'Outer Loop:', (2) SY-INDEX.

    DO.
         IF SY-INDEX > 2.
             EXIT.
         ENDIF.

    WRITE:/10 'Inner Loop:', (2) SY-INDEX.

    ENDDO.
ENDDO.