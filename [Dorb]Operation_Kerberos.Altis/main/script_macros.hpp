/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Script macros which are used inside this mission/addon
 *      Contains new macros and modified CBA macros
 *
 */
#include "script_RAL_Codes.hpp"
 /*
  *  Macro:
  *      CBA_OFF
  *
  *  Description:
  *      turns of the inclusion of CBA-Macros
  *      this is needed to use macros inside the missionconfigfile
  *
  *  Parameters:
  *      none
  *
  *  Example:
  *      #define CBA_OFF
  *      #include "script_component.hpp"
  *
  *  Author: Dorbedo
  *
  */
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
    #define GVARMAIN(var1) DOUBLES(PREFIX,var1)
    #define QGVAR(var1) QUOTE(GVAR(var1))
    #define EGVAR(var1,var2) TRIPLES(PREFIX,var1,var2)
    #define QEGVAR(var1,var2) QUOTE(EGVAR(var1,var2))

    #define ARR_1(ARG1) ARG1
    #define ARR_2(ARG1,ARG2) ARG1, ARG2
    #define ARR_3(ARG1,ARG2,ARG3) ARG1, ARG2, ARG3
    #define ARR_4(ARG1,ARG2,ARG3,ARG4) ARG1, ARG2, ARG3, ARG4
    #define ARR_5(ARG1,ARG2,ARG3,ARG4,ARG5) ARG1, ARG2, ARG3, ARG4, ARG5
    #define ARR_6(ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) ARG1, ARG2, ARG3, ARG4, ARG5, ARG6
    #define ARR_7(ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7
    #define ARR_8(ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8

    #undef CBA_OFF
#endif
/*
 *  Macro:
 *      PAAPATH(var)
 *      QPAAPATH(var)
 *      EPAAPATH(var,var2)
 *      QEPAAPATH(var,var2)
 *
 *  Description:
 *      used as a shortcut for picturefiles
 *
 *  Parameters:
 *      none
 *
 *  Example:
 *      // returns "data/clan.paa"
 *      QPATH(clan)
 *
 *  Author: Dorbedo
 *
 */
#define PAAPATH(VAR1) data\##VAR1.paa
#define QPAAPATH(VAR1) QUOTE(PAAPATH(VAR1))
#define EPAAPATH(VAR1,VAR2) data\##VAR1##\##VAR2##.paa
#define QEPAAPATH(VAR1,VAR2) QUOTE(EPAAPATH(VAR1,VAR2))

/*
 *  Macro:
 *      SYS_SYSTEM(VAR), COMPILE_FIRST(VAR), COMPILE_SYS_FIRST(VAR), COMPILE_SYS, FUNCSYS(VAR)
 *
 *  Description:
 *      internal macros for compiling
 *      called from missionconfigfile to prevent manipulation through modifications
 *
 *  Parameters:
 *      none
 *
 *  Example:
 *      none
 *
 *  Author: Dorbedo
 *
 */
#define SYS_SYSTEM(VAR) (parsingNamespace getVariable 'TRIPLES(PREFIX,SYSTEM,VAR)')
#define COMPILE_FIRST(VAR) {parsingNamespace setVariable [ARR_2('TRIPLES(PREFIX,SYSTEM,VAR)',compile getText(missionConfigFile>>'system'>>'VAR'))];parsingNamespace getVariable 'TRIPLES(PREFIX,SYSTEM,VAR)';}
#define COMPILE_SYS_FIRST {parsingNamespace setVariable [ARR_2('TRIPLES(PREFIX,SYSTEM,compile)',compile getText(missionConfigFile>>'system'>>'compile'))];parsingNamespace setVariable [ARR_2('TRIPLES(PREFIX,SYSTEM,compile_sys)',compile getText(missionConfigFile>>'system'>>'compile_sys'))];parsingNamespace getVariable 'TRIPLES(PREFIX,SYSTEM,compile)';}
#define COMPILE_SYS call (parsingNamespace getVariable [ARR_2('TRIPLES(PREFIX,SYSTEM,compile)',COMPILE_SYS_FIRST)])
#define FUNCSYS(VAR) (parsingNamespace getVariable [ARR_2('TRIPLES(PREFIX,SYSTEM,VAR)',COMPILE_FIRST(VAR))])

/*
 *  Macro:
 *      GUI_*
 *
 *      ***** OBSOLETE *****
 *
 *  Description:
 *      should be removed after the gui has been reworked
 *
 *  Parameters:
 *      none
 *
 *  Example:
 *      text
 *
 *  Author: Dorbedo
 *
 */

#define GUI_DIM(Var1) (Var1*0.9*(safeZoneW min safeZoneH))
#define GUI_DIM2(Var1) (0.5-(safeZoneW min safeZoneH)*(0.45+0.09*Var1))

#define GUI_W(Var1) GUI_DIM(Var1)
#define GUI_H(Var1) GUI_DIM(Var1)
#define GUI_X(Var1) GUI_DIM2(Var1)
#define GUI_Y(Var1) GUI_DIM2(Var1)
#define GUI_XW(Var1,Var2) GUI_DIM2(Var1)+GUI_DIM(Var2)
#define GUI_YH(Var1,Var2) GUI_DIM2(Var1)+GUI_DIM(Var2)

/*
 *  Macro:
 *      CHECK(VAR)
 *
 *  Description:
 *      Exits the scope if the check failed
 *
 *  Parameters:
 *      VAR - Boolean
 *
 *  Example:
 *      CHECK(isServer)
 *
 *  Author: Dorbedo
 *
 */
#define CHECK(CONDITION) if (CONDITION) exitWith {};

/*
 *  Macro:
 *      CHECKRET(CONDITION,RETURN)
 *
 *  Description:
 *      exits the scope and return a value if the check failed
 *
 *  Parameters:
 *      CONDITION - Boolean
 *      RETURN - any
 *
 *  Example:
 *      CHECKRET(isAlive,objNull)
 *
 *  Author: Dorbedo
 *
 */
#define CHECKRET(CONDITION,RETURN) if (CONDITION) exitWith {RETURN;};
/*
 *  Macro:
 *      TILGE
 *
 *  Description:
 *      deletes marker,objects, vehicles(incl. crew),arrays (with including the other things)
 *      shortcurt for a call of a function
 *
 *  Parameters:
 *      none
 *
 *  Example:
 *      [obj1,"marker1",group1] TILGE;
 *
 *  Author: Dorbedo
 *
 */
#define TILGE call TRIPLES(dorb,common,DOUBLES(fnc,delete))
/*
 *  Macro:
 *      SCRIPT(VAR)
 *
 *  Description:
 *      sets the scriptname of a script
 *      adds the _fnc_scriptname private
 *
 *  Parameters:
 *      VAR - name of the script
 *
 *  Example:
 *      #define ADDON dorb_test
 *      SCRIPT(greatScript)
 *      hint _fnc_scriptname; // "dorb_test_fnc_greatSCript"
 *
 *  Author: Dorbedo
 *
 */
#ifdef PART
    #define SCRIPT(NAME) \
    private _fnc_scriptName = QUOTE(DOUBLES(ADDON,TRIPLES(fnc,PART,NAME))); \
    scriptName _fnc_scriptName
#else
    #define SCRIPT(NAME) \
    private _fnc_scriptName = QUOTE(TRIPLES(ADDON,fnc,NAME)); \
    scriptName _fnc_scriptName
#endif
/*
 *  Macro:
 *      SCRIPTIN(VAR,VAR2)
 *
 *      ***** OBSOLETE *****
 *
 *  Description:
 *      does the same as SCRIPT, but adds another value
 *      ***** should be removed due to beeing useless
 *
 *  Parameters:
 *      none
 *
 *  Example:
 *      text
 *
 *  Author: Dorbedo
 *
 */
#ifdef PART
    #define SCRIPTIN(NAME,NAME2) \
    private _fnc_scriptName = QUOTE(TRIPLES(ADDON,fnc,TRIPLES(fnc,NAME,NAME2))); \
    scriptName _fnc_scriptName
#else
    #define SCRIPTIN(NAME,NAME2) \
    private _fnc_scriptName = QUOTE(DOUBLES(ADDON,TRIPLES(fnc,NAME,NAME2))); \
    scriptName _fnc_scriptName
#endif

/*
 *  Macro:
 *      INCLUDE_HEADER
 *
 *  Description:
 *      adds a header to the function when compiling
 *      should not be used
 *
 *  Parameters:
 *      none
 *
 *  Example:
 *      none
 *
 *  Author: Dorbedo
 *
 */
#define INCLUDE_HEADER 0
#ifdef DEBUG_MODE_NORMAL
    #define INCLUDE_HEADER 1
#endif
#ifdef DEBUG_MODE_FULL
    #define INCLUDE_HEADER 2
#endif
/*
 *  Macro:
 *      PATHTO_SYS_LONG(var1,var2,var3,var4)
 *
 *  Description:
 *      if the functionpath is longer then expected (used in component-parts)
 *
 *  Parameters:
 *      none
 *
 *  Example:
 *      none
 *
 *  Author: Dorbedo
 *
 */
#define PATHTO_SYS_LONG(var1,var2,var3,var4) ##var1\##var2\##var3\##var4.sqf
/*
 *  Macro:
 *      PREP(NAME)
 *
 *  Description:
 *      compiles a function, located inside the COMPONENT/functions
 *      saves the compiled function inside missionnamespace
 *      functionfiles are named "fnc_NAME.sqf"
 *
 *  Parameters:
 *      NAME - the name of the function
 *
 *  Example:
 *      text
 *
 *  Author: Dorbedo
 *
 */
#define PREP(var1) ['PATHTO_SYS(COMPONENT,functions,DOUBLES(fnc,var1))', 'TRIPLES(ADDON,fnc,var1)',INCLUDE_HEADER] COMPILE_SYS
/*
 *  Macro:
 *      PREPS(PART,NAME)
 *
 *  Description:
 *      compiles the function of a part of a component
 *
 *  Parameters:
 *      PART - the partname
 *      NAME - functionname
 *
 *  Example:
 *      PREPS(debug,putinlog) // PREFIX_COMPONENT_fnc_debug_putinlog = compile "COMPONENT/functions/debug/putinlog.sqf";
 *
 *  Author: Dorbedo
 *
 */
#define PREPS(var1,var2) ['PATHTO_SYS_LONG(COMPONENT,functions,var1,DOUBLES(fnc,var2))', 'TRIPLES(ADDON,fnc,DOUBLES(var1,var2))',INCLUDE_HEADER] COMPILE_SYS
/*
 *  Macro:
 *      PREPMAIN
 *
 *  Description:
 *      same as PREP, but without the component inside the functionname
 *
 *  Parameters:
 *      none
 *
 *  Example:
 *      PREPMAIN(test) - PREFIX_fnc_test = compile "COMPONENT/functions/fnc_test.sqf";
 *
 *  Author: Dorbedo
 *
 */
#define PREPMAIN(var1) ['PATHTO_SYS(COMPONENT,functions,DOUBLES(fnc,var1))', 'TRIPLES(PREFIX,fnc,var1)',INCLUDE_HEADER] COMPILE_SYS

#ifndef STRING_MACROS_GUARD
    #define STRING_MACROS_GUARD
    #define LSTRING(var1) QUOTE(TRIPLES(STR,ADDON,var1))
    #define ELSTRING(var1,var2) QUOTE(TRIPLES(STR,DOUBLES(PREFIX,var1),var2))
    #define CSTRING(var1) QUOTE(TRIPLES($STR,ADDON,var1))
    #define ECSTRING(var1,var2) QUOTE(TRIPLES($STR,DOUBLES(PREFIX,var1),var2))
#endif

/*
 *  Macro:
 *
 *
 *  Description:
 *      wrapper for getvariable - used for faster writing
 *      copy of ACE3
 *
 *  Parameters:
 *      none
 *
 *  Example:
 *      none
 *
 *  Author:
 *      ACE3-Team
 *
 */

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

/*
 *  Macro:
 *      MAP(CODE,ARRAY)
 *
 *      ***** OBSOLETE *****
 *
 *  Description:
 *      executes code on every array element
 *
 *  Parameters:
 *      CODE - the code to be executed
 *      ARRAY - the array
 *
 *  Example:
 *      MAP("_this + 1",[2,3,4]) // [3,4,5]
 *
 *  Author:
 *      iJesuz
 *
 */
#define MAP(CODE,ARRAY) ARRAY apply CODE

/*
 *  Macro:
 *      *POLAR_*(PHI,RADIUS)
 *
 *  Description:
 *       prefix:
 *          non: arma-like polarcoordinates
 *              (angle between y-axis and radius)
 *          "N": normal polarcoordinates
 *              (angle between x-axis and radius)
 *          postfix:
 *              "X": x-value
 *              "Y": y-value
 *              "2D": 2D coordinate
 *              "3D": 3D coordinate (z = 0)
 *
 *  Parameters:
 *      PHI - Number
 *      RADIUS - Number
 *
 *  Example:
 *      text
 *
 *  Author:
 *      iJesuz
 *
 */
#define POLAR_X(PHI,RADIUS) ((sin (PHI)) * (RADIUS))
#define POLAR_Y(PHI,RADIUS) ((cos (PHI)) * (RADIUS))
#define POLAR_2D(PHI,RADIUS) [POLAR_X(PHI,RADIUS),POLAR_Y(PHI,RADIUS)]
#define POLAR_3D(PHI,RADIUS) [POLAR_X(PHI,RADIUS),POLAR_Y(PHI,RADIUS),0]
#define NPOLAR_X(PHI,RADIUS) POLAR_Y(PHI,RADIUS)
#define NPOLAR_Y(PHI,RADIUS) POLAR_X(PHI,RADIUS)
#define NPOLAR_2D(PHI,RADIUS) [NPOLAR_X(PHI,RADIUS),NPOLAR_Y(PHI,RADIUS)]
#define NPOLAR_3D(PHI,RADIUS) [NPOLAR_X(PHI,RADIUS),NPOLAR_Y(PHI,RADIUS),0]
/*
 *  Macro:
 *      ISCASVEHICLE(VEH)
 *
 *  Description:
 *      the vehicles is a cas vehicle
 *
 *  Parameters:
 *      VEH - the classname of the vehicles
 *
 *  Example:
 *      If (ISCASVEHICLE("plane_x")) exitWith {};
 *
 *  Author:
 *      iJesuz
 *
 */
#define ISCASVEHICLE(ARG) [ARG, ["RHS_UH1Y_UNARMED"], ["RHS_UH1Y","rhsusf_f22","B_T_VTOL_01_armed_blue_F","B_T_VTOL_01_armed_F","B_T_VTOL_01_armed_olive_F"]] call TRIPLES(PREFIX,makro,iscasvehicle)
#define ISCASVEHICLE_C(ARG) (ISCASVEHICLE(ARG))
/*
 *  Macro:
 *      isHeadless
 *
 *  Description:
 *      function called on a headless CLient
 *
 *  Parameters:
 *      none
 *
 *  Example:
 *      CHECK(isHeadless)
 *
 *  Author: Dorbedo
 *
 */
#define isHeadless (!IsDedicated && !hasInterface)
/*
 *  Macro:
 *
 *
 *  Description:
 *      come config helper
 *
 *  Parameters:
 *      none
 *
 *  Example:
 *      none
 *
 *  Author: Dorbedo
 *
 */
#define SOLDIER_SYS(VAR1,VAR2,VAR3,VAR4) class VAR1 { \
                            vehicle = QUOTE(VAR2); \
                            rank = QUOTE(VAR3); \
                            position[] = VAR4; \
                        };
#define SOLDIERR_1(TYPE,RANK) SOLDIER_SYS(soldier_1,TYPE,RANK,{ARR_3(0,0,0)})
#define SOLDIER_1(TYPE) SOLDIERR_1(TYPE,PRIVATE)
#define SOLDIERR_2(TYPE,RANK) SOLDIER_SYS(soldier_2,TYPE,RANK,{ARR_3(-1,-1,0)})
#define SOLDIER_2(TYPE) SOLDIERR_2(TYPE,PRIVATE)
#define SOLDIERR_3(TYPE,RANK) SOLDIER_SYS(soldier_3,TYPE,RANK,{ARR_3(1,-1,0)})
#define SOLDIER_3(TYPE) SOLDIERR_3(TYPE,PRIVATE)
#define SOLDIERR_4(TYPE,RANK) SOLDIER_SYS(soldier_4,TYPE,RANK,{ARR_3(-2,-2,0)})
#define SOLDIER_4(TYPE) SOLDIERR_4(TYPE,PRIVATE)
#define SOLDIERR_5(TYPE,RANK) SOLDIER_SYS(soldier_5,TYPE,RANK,{ARR_3(2,-2,0)})
#define SOLDIER_5(TYPE) SOLDIERR_5(TYPE,PRIVATE)
#define SOLDIERR_6(TYPE,RANK) SOLDIER_SYS(soldier_6,TYPE,RANK,{ARR_3(-3,-3,0)})
#define SOLDIER_6(TYPE) SOLDIERR_6(TYPE,PRIVATE)
#define SOLDIERR_7(TYPE,RANK) SOLDIER_SYS(soldier_7,TYPE,RANK,{ARR_3(3,-3,0)})
#define SOLDIER_7(TYPE) SOLDIERR_7(TYPE,PRIVATE)
#define SOLDIERR_8(TYPE,RANK) SOLDIER_SYS(soldier_8,TYPE,RANK,{ARR_3(-4,-4,0)})
#define SOLDIER_8(TYPE) SOLDIERR_8(TYPE,PRIVATE)
#define SOLDIERR_9(TYPE,RANK) SOLDIER_SYS(soldier_9,TYPE,RANK,{ARR_3(4,-4,0)})
#define SOLDIER_9(TYPE) SOLDIERR_9(TYPE,PRIVATE)
#define SOLDIERR_10(TYPE,RANK) SOLDIER_SYS(soldier_10,TYPE,RANK,{ARR_3(-5,-5,0)})
#define SOLDIER_10(TYPE) SOLDIERR_10(TYPE,PRIVATE)
#define SOLDIERR_11(TYPE,RANK) SOLDIER_SYS(soldier_11,TYPE,RANK,{ARR_3(5,-5,0)})
#define SOLDIER_11(TYPE) SOLDIERR_11(TYPE,PRIVATE)
#define SOLDIERR_12(TYPE,RANK) SOLDIER_SYS(soldier_12,TYPE,RANK,{ARR_3(-6,-6,0)})
#define SOLDIER_12(TYPE) SOLDIERR_12(TYPE,PRIVATE)
#define SOLDIERR_13(TYPE,RANK) SOLDIER_SYS(soldier_13,TYPE,RANK,{ARR_3(6,-6,0)})
#define SOLDIER_13(TYPE) SOLDIERR_13(TYPE,PRIVATE)
#define SOLDIERR_14(TYPE,RANK) SOLDIER_SYS(soldier_14,TYPE,RANK,{ARR_3(-7,-7,0)})
#define SOLDIER_14(TYPE) SOLDIERR_14(TYPE,PRIVATE)
#define SOLDIERR_15(TYPE,RANK) SOLDIER_SYS(soldier_15,TYPE,RANK,{ARR_3(7,-7,0)})
#define SOLDIER_15(TYPE) SOLDIERR_15(TYPE,PRIVATE)
/* -------------------------------------------
Macro: HASH-System
    Hash system - Original from ACRE2,
    was modified to make it fit with CBA and own system
    additional hash macros were created

Author:
    Dorbedo
Original Author:
    ACRE2(https://github.com/IDI-Systems/acre2)
------------------------------------------- */
/* -------------------------------------------
Macro: HASH_CREATE
    Creates a new hash

Parameters:
    none

Example:
    _hash = HASH_CREATE;

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_CREATE (call EFUNC(main,HashCreate))
/* -------------------------------------------
Macro: HASH_DELETE(hash)
    deletes a hash
    the hash is not deleted instant. it' possible to receive the values for a short timeperiod

Parameters:
    0 : HASH

Example:
    HASH_DELETE(_hash);

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_DELETE(hash) (DORB_HASH_TO_DELETE pushBack hash)
/* -------------------------------------------
Macro: HASH_HASKEY(hash,key)
    checks if a hash has a defined key

Parameters:
    0 : HASH
    1 : STRING

Example:
    If !(HASH_HASKEY(_hash,"s")) then {....};

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_HASKEY(hash, key) (!(isNil {hash getVariable key}))
/* -------------------------------------------
Macro: HASH_SET(hash, key, val)
    sets a hash value

Parameters:
    0 : HASH
    1 : STRING
    2 : ANY

Example:
    HASH_SET(_hash, "status", 10);

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_SET(hash, key, val) (hash setVariable [key, val])
/* -------------------------------------------
Macro: HASH_GET(hash, key)
    returns a value from a hash
    can return nil

Parameters:
    0 : HASH
    1 : STRING

Example:
    _value = HASH_GET(_hash, "key");

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_GET(hash, key) (hash getVariable key)
/* -------------------------------------------
Macro: HASH_GET_DEF(hash, key, default)
    returns a value from a hash
    use to define a default value, if the key has no value

Parameters:
    0 : HASH
    1 : STRING
    2 : ANY

Example:
    _hash = HASH_GET(_hash, "key", []);

Author:
    Dorbedo
------------------------------------------- */
#define HASH_GET_DEF(hash, key, default) (hash getVariable [key, default])
/* -------------------------------------------
Macro: HASH_REM(hash, key)
    removes the key from a hash

Parameters:
    0 : HASH
    1 : STRING

Example:
    HASH_REM(_hash, "remove");

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_REM(hash, key) (hash setVariable [key, nil])
/* -------------------------------------------
Macro: HASH_COPY(hash)
    copys a hash into a new one

Parameters:
    0 : HASH

Example:
    _newhash = HASH_COPY(_oldhash);

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_COPY(hash) ([hash] call EFUNC(main,HashCopy))
/* -------------------------------------------
Macro: HASH_KEYS(hash)
    returns all keys from a hash

Parameters:
    0 : HASH

Example:
    _allKeys = HASH_KEYS(_hash);

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_KEYS(hash) ([hash] call EFUNC(main,HashKeys))
/* -------------------------------------------
Macro: HASH_SERIALIZE(hash)

Parameters:
    0 : HASH

Example:
    _hash = HASH_CREATE;

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_SERIALIZE(HASH) ([HASH] call EFUNC(main,serialize))
/* -------------------------------------------
Macro: HASH_DESERIALIZE(ARRAY)

Parameters:
    0 : ARRAY (serialized hash)

Example:
    _hash = HASH_DESERIALIZE(_array);

Author:
    Dorbedo
------------------------------------------- */
#define HASH_DESERIALIZE(ARRAY) ([ARRAY] call EFUNC(main,deserialize))
/* -------------------------------------------
Macro: HASH_SIZE(HASH)
    returns the amount of keys in a hash

Parameters:
    0 : HASH

Example:
    _size = HASH_SIZE(_hash);

Author:
    Dorbedo
------------------------------------------- */
#define HASH_SIZE(HASH) (count HASH_KEYS)
/* -------------------------------------------
Macro: HASH_ISEMPTY(HASH)
    checks if a hash is empty

Parameters:
    0 : HASH

Example:
    IF (HASH_ISEMPTY(_hash)) then {};

Author:
    Dorbedo
------------------------------------------- */
#define HASH_ISEMPTY(HASH) ((count HASH_KEYS)<1)
/* -------------------------------------------
Macro: HASH_GETKEY(hash, value)
    returns a key of a hash, which contaions the same value
    returns nil if no hash is availible

Parameters:
    0 : HASH
    1 : ANY

Example:
    _key = HASH_GETKEY(_hash, 999.9)

Author:
    Dorbedo
------------------------------------------- */
#define HASH_GETKEY(HASH,VALUE) ([HASH,VALUE] call EFUNC(main,HashGetKeyFromValue))
/* -------------------------------------------
Macro: HASH_HASVALUE(hash, value)
    checks if a hash has the provided value

Parameters:
    0 : HASH
    1 : ANY

Example:
    _key = HASH_HASVALUE(_hash, 999.9)

Author:
    Dorbedo
------------------------------------------- */
#define HASH_HASVALUE(HASH,VALUE) (!isNil{([HASH,VALUE] call EFUNC(main,HashGetKeyFromValue))})
/* -------------------------------------------
Macro: HASH_MERGE(hash1, hash2)
    merges hash2 into hash1

Parameters:
    0 : HASH
    1 : HASH

Example:
    HASH_MERGE(_hash,_otherHash);

Author:
    Dorbedo
------------------------------------------- */
#define HASH_MERGE(PRIMHASH,SECHASH) ([PRIMHASH,SECHASH] call EFUNC(main,HashMerge))
/* -------------------------------------------
Macro: HASH_CLEAR(hash)
    clears all values of a hash

Parameters:
    0 : HASH

Example:
    HASH_CLEAR(_hash);

Author:
    Dorbedo
------------------------------------------- */
#define HASH_CLEAR(HASH) ({HASH setVariable [_x,nil];}forEach (allVariables HASH))

#define HASHLIST_CREATELIST(keys) []
#define HASHLIST_CREATEHASH(hashList) HASH_CREATE
#define HASHLIST_SELECT(hashList, index) (hashList select index)
#define HASHLIST_SET(hashList, index, value) (hashList set[index, value])
#define HASHLIST_PUSH(hashList, value) (hashList pushBack value)
//------Internal-------//
#define DORB_HASH_POOL GVARMAIN(HASHPOOL)
#define DORB_HASH_TO_DELETE GVARMAIN(HASHTODELETE)
#define DORB_HASH_CREATED_NEW GVARMAIN(HASHCREATEDNEW)
#define DORB_HASH_CREATED GVARMAIN(HASHCREATED)
#define DORB_HASH_COLLECTOR_HANDLER GVAR(hashCollector_handler)
#define DORB_HASH_COLLECTOR_NEXTEXEC GVAR(hashCollector_nextExecution)
#define DORB_HASH_COLLECTOR_NEXTEXEC_DELAY (6*60)
#define DORB_HASH_COLLECTOR_SEARCHTIME (0.001)
#define DORB_HASH_COLLECTOR_NAMESPACES GVAR(hashCollector_namespaces)
#define DORB_HASH_COLLECTOR_VARIABLES GVAR(hashCollector_variables)
#define DORB_HASH_COLLECTOR_ARRAYS GVAR(hashCollector_arrays)
#define DORB_HASH_COLLECTOR_FOUND GVAR(hashCollector_found)
#define DORB_HASH_COLLECTOR_ID GVAR(hashCollector_ID)
#define DORB_HASH_COLLECTOR_IGNORE GVAR(hashCollector_ignore)

#define DORB_HASH_SYS_TYPE QUOTE(#CBA_HASH#)
#define DORB_HASH_SYS_LOCATION QUOTE(CBA_NamespaceDummy)
#define DORB_HASH_SYS_NAME QUOTE(mission_hash)
#define IS_HASH(hash) (hash isEqualType locationNull && {(text hash) isEqualTo DORB_HASH_SYS_NAME})
#define DORB_HASH_SYS_CREATE(VAR) private VAR = createLocation [ARR_4(DORB_HASH_SYS_LOCATION, [ARR_3(-10000,-10000,-10000)], 0, 0)]; \
    VAR setText DORB_HASH_SYS_NAME; \
    DORB_HASH_POOL pushBack VAR
#define IS_SERIALIZEDHASH(array) (IS_ARRAY(array) && {(count array) > 0} && {IS_STRING((array select 0))} && {(array select 0) == "ACRE_HASH"})
////-------------------//

/* -------------------------------------------
Macro: ACTIVEMOD_TFAR
    Checks if the Mod Task Force Radio is loaded

Parameters:
    none

Example:
    (begin example)
        If ACTIVEMOD_TFAR then ...
    (end)

Author:
    Dorbedo
------------------------------------------- */
#define ACTIVEMOD_TFAR (isClass(configFile >> "CfgPatches" >> "task_force_radio"))
#define ACTIVEMOD_ACRE (isClass(configFile >> "CfgPatches" >> "acre_main"))
#define ACTIVEMOD_BW (isClass(configFile >> "CfgPatches" >> "BWA3_Tracked"))

/* -------------------------------------------
Macro: DATA_*
    Some database macros

Parameters:
    none

Example:

Author:
    Dorbedo
------------------------------------------- */
#define DB_SEND EFUNC(database,sendNoReturn)
#define DB_SENDRET EFUNC(database,sendWithReturn)
#define DB_GETSINGLE EFUNC(database,getSingleValue)
#define DB_GET EFUNC(database,getValue)
#define DB_TIME EFUNC(database,getTime)
