REPORT YCL_CH05_11_MISC.
*********************************************
* WRITE STATEMENT - MISCELLANEOUS FEATURES **
*********************************************
TYPE-POOLS: 
ICON, "TYPE GROUP for icon definitions
SYM. "TYPE GROUP for symbol definitions
DATA CBOX(1) TYPE C. "for check box
START-OF-SELECTION.
*********** outputting blank lines ************************
SET BLANK LINES ON. "blank lines outputted on with this setting
SKIP 2.
WRITE:/10(25) ' ' INTENSIFIED ON COLOR COL_TOTAL.
WRITE:/10(25) ' ' INTENSIFIED ON COLOR COL_KEY.
WRITE:/10(25) ' ' INTENSIFIED ON COLOR COL_POSITIVE.
WRITE:/10(25) ' ' INTENSIFIED ON COLOR COL_NEGATIVE.
WRITE:/10(25) ' ' INTENSIFIED ON COLOR COL_GROUP.
*********** output icons ***********************************
SKIP 1.
WRITE: /10 'ICON_SYSTEM_SAVE', ICON_SYSTEM_SAVE AS ICON,
/10 'ICON_CHECK ', ICON_CHECK AS ICON.
*********** output symbols *********************************
SKIP 1.
WRITE: /10 'SYM_FOLDER ', SYM_FOLDER AS SYMBOL,
/10 'SYM_DOCUMENTS ', SYM_DOCUMENTS AS SYMBOL.
*********** output HOTSPOT *********************************
SKIP 1.
" HOTSPOT like COLOR can be specified with
" (1) FORMAT statement like
" FORMAT HOTSPOT = <ON/OFF>. subsequent output will support
" HOTSPOT
"
" (2) it can be specified in a field of WRITE statement like
" WRITE XXX HOTSPOT.
WRITE /10: 'This is HOTSPOT output' HOTSPOT,
'This is NORMAL output '.
*********** output check box *********************************
SKIP 1.
" checkbox variable to be TYPE C, preferable length 1
" can assume only two values i.e. X when enabled
" SPACE when disabled
" if number oriented TYPE D, F, I, N, P, T, X: values 1 when enabled
" 0 when disabled
WRITE: /10 'Check Box:', CBOX AS CHECKBOX. " this phrase AS CHECKBOX
" to make output check box