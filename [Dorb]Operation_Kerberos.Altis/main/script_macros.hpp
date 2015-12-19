/* -------------------------------------------
Macro: CBA_OFF
    turns off the including of CBA because of compatibility issues during description.ext
    If CBA_OFF is defined, some important MAKROS are copied out of CBA
Parameters:
    none

Example:
    (begin example)
        CBA_OFF
        #include "script_component.hpp"
    (end)

Author:
    Dorbedo
------------------------------------------- */
#ifndef CBA_OFF
    #include "\x\cba\addons\main\script_macros_mission.hpp"
#else
    #define DOUBLES(var1,var2) ##var1##_##var2
    #define TRIPLES(var1,var2,var3) ##var1##_##var2##_##var3
    #define QUOTE(var1) #var1
    #define ADDON DOUBLES(PREFIX,COMPONENT)
    #define MAIN_ADDON DOUBLES(PREFIX,main)
    #define CSTRING(var1) QUOTE(TRIPLES($STR,ADDON,var1))
    #define ECSTRING(var1,var2) QUOTE(TRIPLES($STR,DOUBLES(PREFIX,var1),var2))
    #define FUNC(var1) TRIPLES(ADDON,fnc,var1)
    #define FUNCMAIN(var1) TRIPLES(PREFIX,fnc,var1)
    #define EFUNC(var1,var2) TRIPLES(DOUBLES(PREFIX,var1),fnc,var2)
    #define GVAR(var1) DOUBLES(ADDON,var1)
    #define EGVAR(var1,var2) TRIPLES(PREFIX,var1,var2)

    #define ARR_1(ARG1) ARG1
    #define ARR_2(ARG1,ARG2) ARG1, ARG2
    #define ARR_3(ARG1,ARG2,ARG3) ARG1, ARG2, ARG3
    #define ARR_4(ARG1,ARG2,ARG3,ARG4) ARG1, ARG2, ARG3, ARG4
    #define ARR_5(ARG1,ARG2,ARG3,ARG4,ARG5) ARG1, ARG2, ARG3, ARG4, ARG5
    #define ARR_6(ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) ARG1, ARG2, ARG3, ARG4, ARG5, ARG6
    #define ARR_7(ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7
    #define ARR_8(ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8

    #define GUI_DIM(Var1) (Var1*0.9*(safeZoneW min safeZoneH))
    #define GUI_DIM2(Var1) (0.5-(safeZoneW min safeZoneH)*(0.45+0.09*Var1))
    #define GUI_W(Var1) GUI_DIM(Var1)
    #define GUI_H(Var1) GUI_DIM(Var1)
    #define GUI_X(Var1) GUI_DIM2(Var1)
    #define GUI_Y(Var1) GUI_DIM2(Var1)
    #define GUI_XW(Var1,Var2) ( GUI_DIM2(Var1) + GUI_DIM(Var2) )
    #define GUI_YH(Var1,Var2) ( GUI_DIM2(Var1) + GUI_DIM(Var2) )

    #undef CBA_OFF
#endif
/* -------------------------------------------
Macro: GUI_*
    Macros for definining the right size of the gui

Parameters:
    GUI_W,GUI_H - 0...1 Size of the Interface
    GUI_X,GUI_H - 0...1 Position of the Interface
    GUI_XW,GUI_YW - (0...1,0...1) Position and Size
Example:
    x = GUI_XW(0,0.1);
    y = GUI_YH(0,0.2);
    w = GUI_W(0.118);
    h = GUI_H(0.53);

Author:
    Dorbedo
------------------------------------------- */
#define GUI_DIM(Var1) (Var1*0.9*(safeZoneW min safeZoneH))
#define GUI_DIM2(Var1) (0.5-(safeZoneW min safeZoneH)*(0.45+0.09*Var1))

#define GUI_W(Var1) GUI_DIM(Var1)
#define GUI_H(Var1) GUI_DIM(Var1)
#define GUI_X(Var1) GUI_DIM2(Var1)
#define GUI_Y(Var1) GUI_DIM2(Var1)
#define GUI_XW(Var1,Var2) GUI_DIM2(Var1)+GUI_DIM(Var2)
#define GUI_YH(Var1,Var2) GUI_DIM2(Var1)+GUI_DIM(Var2)
/* -------------------------------------------
Macro: FMP
    Spawns CBA_fnc_globalExecute

Parameters:
    none

Example:
    (begin example)
        {-1,{hint _this},["Makro Test"]} FMP;
    (end)

Author:
    Dorbedo
------------------------------------------- */
#define FMP spawn CBA_fnc_globalExecute
/* -------------------------------------------
Macro: CHECK()
    Checks Condition - Exit if true

    Hint: no ';' after CHECK()

Parameters:
    CODE - Condition to Check

Example:
    (begin example)
        // if is server exit
        CHECK(isServer)
    (end)

Author:
    Dorbedo
------------------------------------------- */
#define CHECK(CONDITION) if (CONDITION) exitWith {};
/* -------------------------------------------
Macro: SELRND()
    Selects a random element of an array

Parameters:
    ARRAY - array to select from

Example:
    (begin example)
        _winner = ["Klaus","Dieter","Thorsten"] SELRND;
    (end)

    (begin example)
        _gamers = ["Felix","Hans","Heinrich"];
        _looser = _gamers SELRND;
    (end)

Author:
    Dorbedo
------------------------------------------- */
#define SELRND call TRIPLES(dorb,makro,selectrandom)
/* -------------------------------------------
Macro: TILGE
    deletes:
        - Marker
        - Objects (vehicles incl Crew)
        - Groups
        - Arrays including these

Parameters:
    none

Example:
    (begin example)
        [veh1  ,  group1  ,  [ "Marker1" , "marker2" ]  ,  [ [ Veh2 ] , soldier1 ] , [ group2 ] ]     TILGE;
        [soldier3,soldier4] TILGE;
        "marker3" TILGE;
    (end)

Author:
    Dorbedo
------------------------------------------- */
#define TILGE call TRIPLES(dorb,makro,delete)
/* -------------------------------------------
Macro: SCRIPT(VAR)
   Sets name of script
   Overrides CBA "SCRIPT"
Parameters:
    NAME - Name of script [Indentifier]

Example:
    (begin example)
        SCRIPT(boom);
    (end)

Author:
    Dorbedo
------------------------------------------- */
#ifdef PART
    #define SCRIPT(NAME) scriptName 'PREFIX\COMPONENT\PART\NAME'
#else
    #define SCRIPT(NAME) scriptName 'PREFIX\COMPONENT\NAME'
#endif

/* -------------------------------------------
Macro: SCRIPTIN(VAR)
   Sets name of an inner script
Parameters:
    NAME - Name of script [Indentifier]

Example:
    (begin example)
        SCRIPTIN(boom);
    (end)

Author:
    Dorbedo
------------------------------------------- */
#ifdef PART
    #define SCRIPTIN(NAME,NAME2) scriptName 'PREFIX\COMPONENT\PART\NAME_NAME2'
#else
    #define SCRIPTIN(NAME,NAME2) scriptName 'PREFIX\COMPONENT\NAME_NAME2'
#endif


#define PATHTO_SYS_LONG(var1,var2,var3,var4) ##var1\##var2\##var3\##var4.sqf

#ifdef DISABLE_COMPILE_CACHE
    #define PREP(var1) TRIPLES(ADDON,fnc,var1) = compile preProcessFileLineNumbers 'PATHTO_SYS(COMPONENT,functions,DOUBLES(fnc,var1))'
    #define PREPMAIN(var1) TRIPLES(PREFIX,fnc,var1) = compile preProcessFileLineNumbers 'PATHTO_SYS(COMPONENT,functions,DOUBLES(fnc,var1))'
    #define PREPS(var1,var2) TRIPLES(ADDON,fnc,DOUBLES(var1,var2)) = compile preProcessFileLineNumbers 'PATHTO_SYS_LONG(COMPONENT,functions,var1,DOUBLES(fnc,var2))'
#else
    #define PREP(var1) ['PATHTO_SYS(COMPONENT,functions,DOUBLES(fnc,var1))', 'TRIPLES(ADDON,fnc,var1)'] call SLX_XEH_COMPILE_NEW
    #define PREPMAIN(var1) ['PATHTO_SYS(COMPONENT,functions,DOUBLES(fnc,var1))', 'TRIPLES(PREFIX,fnc,var1)'] call SLX_XEH_COMPILE_NEW
    #define PREPS(var1,var2) ['PATHTO_SYS_LONG(COMPONENT,functions,var1,DOUBLES(fnc,var2))', 'TRIPLES(ADDON,fnc,DOUBLES(var1,var2))'] call SLX_XEH_COMPILE_NEW
#endif


#define EGVAR(var1,var2) TRIPLES(PREFIX,var1,var2)
#define QEGVAR(var1,var2) QUOTE(EGVAR(var1,var2))
#define QGVARMAIN(var1) QUOTE(GVARMAIN(var1))

#ifndef STRING_MACROS_GUARD
#define STRING_MACROS_GUARD
    #define LSTRING(var1) QUOTE(TRIPLES(STR,ADDON,var1))
    #define ELSTRING(var1,var2) QUOTE(TRIPLES(STR,DOUBLES(PREFIX,var1),var2))
    #define CSTRING(var1) QUOTE(TRIPLES($STR,ADDON,var1))
    #define ECSTRING(var1,var2) QUOTE(TRIPLES($STR,DOUBLES(PREFIX,var1),var2))
#endif

//// Variablen - Copy of ACE3-macros

#define GETVAR_SYS(var1,var2) getVariable [ARR_2(QUOTE(var1),var2)]
#define SETVAR_SYS(var1,var2) setVariable [ARR_2(QUOTE(var1),var2)]
#define SETPVAR_SYS(var1,var2) setVariable [ARR_3(QUOTE(var1),var2,true)]

#define GETVAR(var1,var2,var3) var1 GETVAR_SYS(var2,var3)
#define GETMVAR(var1,var2) missionNamespace GETVAR_SYS(var1,var2)
#define GETUVAR(var1,var2) uiNamespace GETVAR_SYS(var1,var2)
#define GETPRVAR(var1,var2) profileNamespace GETVAR_SYS(var1,var2)
#define GETPAVAR(var1,var2) parsingNamespace GETVAR_SYS(var1,var2)

#define SETVAR(var1,var2,var3) var1 SETVAR_SYS(var2,var3)
#define SETPVAR(var1,var2,var3) var1 SETPVAR_SYS(var2,var3)
#define SETMVAR(var1,var2) missionNamespace SETVAR_SYS(var1,var2)
#define SETUVAR(var1,var2) uiNamespace SETVAR_SYS(var1,var2)
#define SETPRVAR(var1,var2) profileNamespace SETVAR_SYS(var1,var2)
#define SETPAVAR(var1,var2) parsingNamespace SETVAR_SYS(var1,var2)

#define GETGVAR(var1,var2) GETMVAR(GVAR(var1),var2)
#define GETEGVAR(var1,var2,var3) GETMVAR(EGVAR(var1,var2),var3)

/* -------------------------------------------
Macro(s): MAP(CODE,ARRAY)
    executes code on every array element

Parameters:
    0 : STRING/CODE
    1 : ARRAY

Example:
    (begin example)
        MAP("_this+1",[2,3,4]);
            ==> [3,4,5]
    (end)

Author:
    iJesuz
------------------------------------------- */
#define MAP(CODE,ARRAY) [CODE,ARRAY] call TRIPLES(dorb,makro,map)


/* -------------------------------------------
Macro(s):
    ISCASVEHICLE(VAR)

    check if air-vehicle is a CAS vehicle

Parameters:
    CONFIGNAME - the type of the vehicle

Example:
    (begin example)
        ISCASVEHICLE('B_Heli_Attack_01_F')
        ISCASVEHICLE_C('B_Plane_CAS_01_F')
    (end)

Author:
    iJesuz
------------------------------------------- */

#define ISCASVEHICLE(ARG) [ARG, ["RHS_UH1Y_UNARMED"], ["RHS_UH1Y","rhsusf_f22"]] call TRIPLES(PREFIX,makro,iscasvehicle)
#define ISCASVEHICLE_C(ARG) (ISCASVEHICLE(ARG))
