/* -------------------------------------------
Description:
    !! Modifies the CBA-Log function if enabled
    Adds some aditional Makros

Author:
    Dorbedo
------------------------------------------- */

#define RECOMPILE_START if (isNil QGVARMAIN(recompile_cache)) then {GVARMAIN(recompile_cache)=[] call CBA_fnc_createNamespace;}; private _cache = {

#define RECOMPILE_END }; (GVARMAIN(recompile_cache)) setVariable [QUOTE(ADDON),_cache]; call _cache;



/* -------------------------------------------
Macro: FORMAT_#(STR, ARG1)
    Format - Useful for working around , in macro parameters.
    adds 9,10,12,14,16,18 parameters
Parameters:
    STRING - string used by format
    VARIABLE() - elements for usage in format

Example:
    (begin example)
        FORMAT('%1_%2',_var1,_var2);
    (end)

Author:
    Nou & Sickboy (original)
    Dorbedo
------------------------------------------- */
#define FORMAT_9(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8,ARG9) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8, ARG9]
#define FORMAT_10(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8,ARG9,ARG10) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8, ARG9, ARG10]
#define FORMAT_12(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8,ARG9,ARG10,ARG11,ARG12) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8, ARG9, ARG10, ARG11, ARG12]
#define FORMAT_14(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8,ARG9,ARG10,ARG11,ARG12,ARG13,ARG14) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8, ARG9, ARG10, ARG11, ARG12, ARG13, ARG14]
#define FORMAT_16(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8,ARG9,ARG10,ARG11,ARG12,ARG13,ARG14,ARG15,ARG16) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8, ARG9, ARG10, ARG11, ARG12, ARG13, ARG14, ARG15, ARG16]
#define FORMAT_18(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8,ARG9,ARG10,ARG11,ARG12,ARG13,ARG14,ARG15,ARG16,ARG17,ARG18) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8, ARG9, ARG10, ARG11, ARG12, ARG13, ARG14, ARG15, ARG16, ARG17, ARG18]

#ifdef DEBUG_MODE_OFF
    #define DEBUG_MODE_FULL
    #define DEBUG_MODE_NORMAL
    #define DEBUG_MODE_MINIMAL
    #undef DEBUG_MODE_FULL
    #undef DEBUG_MODE_NORMAL
    #undef DEBUG_MODE_MINIMAL
    #undef DEBUG_MODE_OFF
#endif

#ifdef PART
    #define DEBUG_COMPONENTNAME QUOTE(DOUBLES(COMPONENT,PART))
#else
    #define DEBUG_COMPONENTNAME QUOTE(COMPONENT)
#endif

#ifdef DEBUG_MODE_FULL
    /* -------------------------------------------
    Macro: TRACE_n()
        Log a message and 1-8 variables to the RPT log.
        Only run if <DEBUG_MODE_FULL> is defined.
    Parameters:
        MESSAGE -  Message to add to the trace [String]
        A..H - Variable names to log values of [Any]

    Example:
        (begin example)
            TRACE_3("After takeoff",_vehicle player,getPos (_vehicle player), getPosASL (_vehicle player));
        (end)

    Author:
        Spooner (original)
        Dorbedo
    ------------------------------------------- */
    #define TRACE_SYS(STRING) [STRING,"TRACE",DEBUG_COMPONENTNAME,__FILE__,__LINE__,diag_frameNo,If (isNil "_fnc_scriptName") then {""}else{if (isNil "_fnc_scriptNameParent") then {_fnc_scriptName}else{[_fnc_scriptName,_fnc_scriptNameParent]}}] call EFUNC(main,addToLog)
    #define TRACE(MESSAGE) TRACE_SYS(MESSAGE)
    #define TRACE_1(MESSAGE,A) TRACE_SYS(PFORMAT_1(MESSAGE,A))
    #define TRACE_2(MESSAGE,A,B) TRACE_SYS(PFORMAT_2(MESSAGE,A,B))
    #define TRACE_3(MESSAGE,A,B,C) TRACE_SYS(PFORMAT_3(MESSAGE,A,B,C))
    #define TRACE_4(MESSAGE,A,B,C,D) TRACE_SYS(PFORMAT_4(MESSAGE,A,B,C,D))
    #define TRACE_5(MESSAGE,A,B,C,D,E) TRACE_SYS(PFORMAT_5(MESSAGE,A,B,C,D,E))
    #define TRACE_6(MESSAGE,A,B,C,D,E,F) TRACE_SYS(PFORMAT_6(MESSAGE,A,B,C,D,E,F))
    #define TRACE_7(MESSAGE,A,B,C,D,E,F,G) TRACE_SYS(PFORMAT_7(MESSAGE,A,B,C,D,E,F,G))
    #define TRACE_8(MESSAGE,A,B,C,D,E,F,G,H) TRACE_SYS(PFORMAT_8(MESSAGE,A,B,C,D,E,F,G,H))
    #define TRACE_9(MESSAGE,A,B,C,D,E,F,G,H,I) TRACE_SYS(PFORMAT_9(MESSAGE,A,B,C,D,E,F,G,H,I))
    /* -------------------------------------------
    Macro: TRACE_MAP
        Logs the mapped functions

    Parameters:
        none

    Example:
        (begin example)
            TRACE_MAP;
        (end)

    Author:
        Dorbedo
    ------------------------------------------- */
    #define TRACE_MAP [If (isNil "_fnc_scriptMap") then {[]}else{_fnc_scriptMap},"TRACEMAP",DEBUG_COMPONENTNAME,__FILE__,__LINE__,diag_frameNo,If (isNil "_fnc_scriptName") then {""}else{if (isNil "_fnc_scriptNameParent") then {_fnc_scriptName}else{[_fnc_scriptName,_fnc_scriptNameParent]}}] call EFUNC(main,addToLog)
    /* -------------------------------------------
    Macro: TRACEV_n(VAR)
        Logs 1-9 Variables into LOG
        Only run if <DEBUG_MODE_FULL> is defined.
    Parameters:
        VAR -  Variable to be logged

    Example:
        (begin example)
            TRACEV_3(_this,_killer,_damage);
        (end)

    Author:
        Dorbedo
    ------------------------------------------- */
    #define TRACEV_1(VAR1) TRACE_SYS(FORMAT_2("%1 = %2",QUOTE(VAR1),RETNIL(VAR1)))
    #define TRACEV_2(VAR1,VAR2) TRACE_SYS(FORMAT_4("%1 = %2\n%3 = %4",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2)))
    #define TRACEV_3(VAR1,VAR2,VAR3) TRACE_SYS(FORMAT_6("%1 = %2\n%3 = %4\n%5 = %6",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2),QUOTE(VAR3),RETNIL(VAR3)))
    #define TRACEV_4(VAR1,VAR2,VAR3,VAR4) TRACE_SYS(FORMAT_8("%1 = %2\n%3 = %4\n%5 = %6\n%7 = %8",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2),QUOTE(VAR3),RETNIL(VAR3),QUOTE(VAR4),RETNIL(VAR4)))
    #define TRACEV_5(VAR1,VAR2,VAR3,VAR4,VAR5) TRACE_SYS(FORMAT_10("%1 = %2\n%3 = %4\n%5 = %6\n%7 = %8\n%9 = %10",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2),QUOTE(VAR3),RETNIL(VAR3),QUOTE(VAR4),RETNIL(VAR4),QUOTE(VAR5),RETNIL(VAR5)))
    #define TRACEV_6(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6) TRACE_SYS(FORMAT_12("%1 = %2\n%3 = %4\n%5 = %6\n%7 = %8\n%9 = %10\n%11 = %12",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2),QUOTE(VAR3),RETNIL(VAR3),QUOTE(VAR4),RETNIL(VAR4),QUOTE(VAR5),RETNIL(VAR5),QUOTE(VAR6),RETNIL(VAR6)))
    #define TRACEV_7(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7) TRACE_SYS(FORMAT_14("%1 = %2\n%3 = %4\n%5 = %6\n%7 = %8\n%9 = %10\n%11 = %12\n%13 = %14",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2),QUOTE(VAR3),RETNIL(VAR3),QUOTE(VAR4),RETNIL(VAR4),QUOTE(VAR5),RETNIL(VAR5),QUOTE(VAR6),RETNIL(VAR6),QUOTE(VAR7),RETNIL(VAR7)))
    #define TRACEV_8(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8) TRACE_SYS(FORMAT_16("%1 = %2\n%3 = %4\n%5 = %6\n%7 = %8\n%9 = %10\n%11 = %12\n%13 = %14\n%15 = %16",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2),QUOTE(VAR3),RETNIL(VAR3),QUOTE(VAR4),RETNIL(VAR4),QUOTE(VAR5),RETNIL(VAR5),QUOTE(VAR6),RETNIL(VAR6),QUOTE(VAR7),RETNIL(VAR7),QUOTE(VAR8),RETNIL(VAR8)))
    #define TRACEV_9(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8,VAR9) TRACE_SYS(FORMAT_18("%1 = %2\n%3 = %4\n%5 = %6\n%7 = %8\n%9 = %10\n%11 = %12\n%13 = %14\n%15 = %16\n%17 = %18",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2),QUOTE(VAR3),RETNIL(VAR3),QUOTE(VAR4),RETNIL(VAR4),QUOTE(VAR5),RETNIL(VAR5),QUOTE(VAR6),RETNIL(VAR6),QUOTE(VAR7),RETNIL(VAR7),QUOTE(VAR8),RETNIL(VAR8),QUOTE(VAR9),RETNIL(VAR9)))
    /* -------------------------------------------
    Macro: EXPLODE_n(VAR)
        DEPRECATED - Use param/params commands added in Arma 3 1.48

    Parameters:
        ARRAY - Array to read from [Array]
        A..H - Names of variables to set from array [Identifier]


    Example:
        (begin example)
            _array = ["fred", 156.8, 120.9];
            EXPLODE_3(_array,_name,_height,_weight);
        (end)

    Author:
        Spooner (original)
        Dorbedo
    ------------------------------------------- */
    #define EXPLODE_1(ARRAY,A) EXPLODE_1_SYS(ARRAY,A); TRACEV_1(A)
    #define EXPLODE_1_PVT(ARRAY,A) ARRAY params [#A]; TRACEV_1(A)
    #define EXPLODE_2(ARRAY,A,B) EXPLODE_2_SYS(ARRAY,A,B); TRACEV_2(A,B)
    #define EXPLODE_2_PVT(ARRAY,A,B) ARRAY params [#A,#B]; TRACEV_2(A,B)
    #define EXPLODE_3(ARRAY,A,B,C) EXPLODE_3_SYS(ARRAY,A,B,C); TRACEV_3(A,B,C)
    #define EXPLODE_3_PVT(ARRAY,A,B,C) ARRAY params [#A,#B,#C]; TRACEV_3(A,B,C)
    #define EXPLODE_4(ARRAY,A,B,C,D) EXPLODE_4_SYS(ARRAY,A,B,C,D); TRACEV_4(A,B,C,D)
    #define EXPLODE_4_PVT(ARRAY,A,B,C,D) ARRAY params [#A,#B,#C,#D]; TRACEV_4(A,B,C,D)
    #define EXPLODE_5(ARRAY,A,B,C,D,E) EXPLODE_5_SYS(ARRAY,A,B,C,D,E); TRACEV_5(A,B,C,D,E)
    #define EXPLODE_5_PVT(ARRAY,A,B,C,D,E) ARRAY params [#A,#B,#C,#D,#E]; TRACEV_5(A,B,C,D,E)
    #define EXPLODE_6(ARRAY,A,B,C,D,E,F) EXPLODE_6_SYS(ARRAY,A,B,C,D,E,F); TRACEV_6(A,B,C,D,E,F)
    #define EXPLODE_6_PVT(ARRAY,A,B,C,D,E,F) ARRAY params [#A,#B,#C,#D,#E,#F]; TRACEV_6(A,B,C,D,E,F)
    #define EXPLODE_7(ARRAY,A,B,C,D,E,F,G) EXPLODE_7_SYS(ARRAY,A,B,C,D,E,F,G); TRACEV_7(A,B,C,D,E,F,G)
    #define EXPLODE_7_PVT(ARRAY,A,B,C,D,E,F,G) ARRAY params [#A,#B,#C,#D,#E,#F,#G]; TRACEV_7(A,B,C,D,E,F,G)
    #define EXPLODE_8(ARRAY,A,B,C,D,E,F,G,H) EXPLODE_8_SYS(ARRAY,A,B,C,D,E,F,G,H); TRACEV_8(A,B,C,D,E,F,G,H)
    #define EXPLODE_8_PVT(ARRAY,A,B,C,D,E,F,G,H) ARRAY params [#A,#B,#C,#D,#E,#F,#G,#H]; TRACEV_8(A,B,C,D,E,F,G,H)
    #define EXPLODE_9(ARRAY,A,B,C,D,E,F,G,H,I) EXPLODE_9_SYS(ARRAY,A,B,C,D,E,F,G,H,I); TRACEV_9(A,B,C,D,E,F,G,H,I)
    #define EXPLODE_9_PVT(ARRAY,A,B,C,D,E,F,G,H,I) ARRAY params [#A,#B,#C,#D,#E,#F,#G,#H,#I]; TRACEV_9(A,B,C,D,E,F,G,H,I)
    //#define CHECK(CONDITION) if (CONDITION) exitWith {ERROR("CHECK-FAILED");};
    #define DEBUG_MODE_NORMAL
    #define DEBUG_MODE_MINIMAL

#else

    #define TRACE_SYS(STRING) /* disabled */
    #define TRACE(MESSAGE) /* disabled */
    #define TRACE_1(MESSAGE,A) /* disabled */
    #define TRACE_2(MESSAGE,A,B) /* disabled */
    #define TRACE_3(MESSAGE,A,B,C) /* disabled */
    #define TRACE_4(MESSAGE,A,B,C,D) /* disabled */
    #define TRACE_5(MESSAGE,A,B,C,D,E) /* disabled */
    #define TRACE_6(MESSAGE,A,B,C,D,E,F) /* disabled */
    #define TRACE_7(MESSAGE,A,B,C,D,E,F,G) /* disabled */
    #define TRACE_8(MESSAGE,A,B,C,D,E,F,G,H) /* disabled */
    #define TRACE_9(MESSAGE,A,B,C,D,E,F,G,H,I) /* disabled */
    #define TRACEV_1(VAR1) /* disabled */
    #define TRACEV_2(VAR1,VAR2) /* disabled */
    #define TRACEV_3(VAR1,VAR2,VAR3) /* disabled */
    #define TRACEV_4(VAR1,VAR2,VAR3,VAR4) /* disabled */
    #define TRACEV_5(VAR1,VAR2,VAR3,VAR4,VAR5) /* disabled */
    #define TRACEV_6(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6) /* disabled */
    #define TRACEV_7(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7) /* disabled */
    #define TRACEV_8(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8) /* disabled */
    #define TRACEV_9(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8,VAR9) /* disabled */

#endif

#ifdef DEBUG_MODE_NORMAL
    /* -------------------------------------------
    Macro: LOG(STRING)
        Log a timestamped message into the RPT log.
        Only run if <DEBUG_MODE_NORMAL> or higher is defined.

    Parameters:
        MESSAGE - Message to record [String]
    Example:
        (begin example)
            LOG("Initiated clog-dancing simulator.");
        (end)
    Author:
        Spooner (original)
        Dorbedo
    ------------------------------------------- */
    #define LOG(STRING) [STRING,"LOG",DEBUG_COMPONENTNAME,__FILE__,__LINE__,diag_frameNo,If (isNil "_fnc_scriptName") then {""}else{if (isNil "_fnc_scriptNameParent") then {_fnc_scriptName}else{[_fnc_scriptName,_fnc_scriptNameParent]}}] call EFUNC(main,addToLog)
    /* -------------------------------------------
    Macro: LOG_n(VAR)
        Log a timestamped Variable into the RPT log.
        Only run if <DEBUG_MODE_NORMAL> or higher is defined.

    Parameters:
        VAR - Variable to record [Any]
    Example:
        (begin example)
            LOG_1(_this);
        (end)
    Author:
        Dorbedo
    ------------------------------------------- */
    #define LOG_1(VAR1) LOG(FORMAT_2("%1 = %2",QUOTE(VAR1),RETNIL(VAR1)))
    #define LOG_2(VAR1,VAR2) LOG(FORMAT_4("%1 = %2\n%3 = %4",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2)))
    #define LOG_3(VAR1,VAR2,VAR3) LOG(FORMAT_6("%1 = %2\n%3 = %4\n%5 = %6",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2),QUOTE(VAR3),RETNIL(VAR3)))
    #define LOG_4(VAR1,VAR2,VAR3,VAR4) LOG(FORMAT_8("%1 = %2\n%3 = %4\n%5 = %6\n%7 = %8",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2),QUOTE(VAR3),RETNIL(VAR3),QUOTE(VAR4),RETNIL(VAR4)))
    #define LOG_5(VAR1,VAR2,VAR3,VAR4,VAR5) LOG(FORMAT_10("%1 = %2\n%3 = %4\n%5 = %6\n%7 = %8\n%9 = %10",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2),QUOTE(VAR3),RETNIL(VAR3),QUOTE(VAR4),RETNIL(VAR4),QUOTE(VAR5),RETNIL(VAR5)))
    #define LOG_6(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6) LOG(FORMAT_12("%1 = %2\n%3 = %4\n%5 = %6\n%7 = %8\n%9 = %10\n%11 = %12",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2),QUOTE(VAR3),RETNIL(VAR3),QUOTE(VAR4),RETNIL(VAR4),QUOTE(VAR5),RETNIL(VAR5),QUOTE(VAR6),RETNIL(VAR6)))
    #define LOG_7(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7) LOG(FORMAT_14("%1 = %2\n%3 = %4\n%5 = %6\n%7 = %8\n%9 = %10\n%11 = %12\n%13 = %14",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2),QUOTE(VAR3),RETNIL(VAR3),QUOTE(VAR4),RETNIL(VAR4),QUOTE(VAR5),RETNIL(VAR5),QUOTE(VAR6),RETNIL(VAR6),QUOTE(VAR7),RETNIL(VAR7)))
    #define LOG_8(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8) LOG(FORMAT_16("%1 = %2\n%3 = %4\n%5 = %6\n%7 = %8\n%9 = %10\n%11 = %12\n%13 = %14\n%15 = %16",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2),QUOTE(VAR3),RETNIL(VAR3),QUOTE(VAR4),RETNIL(VAR4),QUOTE(VAR5),RETNIL(VAR5),QUOTE(VAR6),RETNIL(VAR6),QUOTE(VAR7),RETNIL(VAR7),QUOTE(VAR8),RETNIL(VAR8)))
    #define LOG_9(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8,VAR9) LOG(FORMAT_18("%1 = %2\n%3 = %4\n%5 = %6\n%7 = %8\n%9 = %10\n%11 = %12\n%13 = %14\n%15 = %16\n%17 = %18",QUOTE(VAR1),RETNIL(VAR1),QUOTE(VAR2),RETNIL(VAR2),QUOTE(VAR3),RETNIL(VAR3),QUOTE(VAR4),RETNIL(VAR4),QUOTE(VAR5),RETNIL(VAR5),QUOTE(VAR6),RETNIL(VAR6),QUOTE(VAR7),RETNIL(VAR7),QUOTE(VAR8),RETNIL(VAR8),QUOTE(VAR9),RETNIL(VAR9)))
    #define WARNING(STRING) [STRING,"WARNING",DEBUG_COMPONENTNAME,__FILE__,__LINE__,diag_frameNo,If (isNil "_fnc_scriptName") then {""}else{if (isNil "_fnc_scriptNameParent") then {_fnc_scriptName}else{[_fnc_scriptName,_fnc_scriptNameParent]}}] call EFUNC(main,addToLog)

    #define LINKFUNC(VAR1) {_this call FUNC(VAR1);}
    #define LINKEFUNC(VAR1,VAR2) {_this call EFUNC(VAR1,VAR2);}

    #define DEBUG_MODE_MINIMAL

#else

    #define LOG_1(VAR1) /*disabled*/
    #define LOG_2(VAR1,VAR2) /*disabled*/
    #define LOG_3(VAR1,VAR2,VAR3) /*disabled*/
    #define LOG_4(VAR1,VAR2,VAR3,VAR4) /*disabled*/
    #define LOG_5(VAR1,VAR2,VAR3,VAR4,VAR5) /*disabled*/
    #define LOG_6(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6) /*disabled*/
    #define LOG_7(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7) /*disabled*/
    #define LOG_8(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8) /*disabled*/
    #define LOG_9(VAR1,VAR2,VAR3,VAR4,VAR5,VAR6,VAR7,VAR8,VAR9) /*disabled*/
    #define WARNING(VAR) /*disabled*/

#endif


#ifdef DEBUG_MODE_MINIMAL

    #define ERROR(STRING) [STRING,"ERROR",DEBUG_COMPONENTNAME,__FILE__,__LINE__,diag_frameNo,If (isNil "_fnc_scriptName") then {""}else{if (isNil "_fnc_scriptNameParent") then {_fnc_scriptName}else{[_fnc_scriptName,_fnc_scriptNameParent]}}] call EFUNC(main,addToLog)

#else

    #define ERROR(VAR) /*disabled*/

#endif
