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
	#undef CBA_OFF
#endif

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
Macro: MAP
    Executes the code given by the first argument on every array element given
    by the second argument.
    The side (right or left) of the array element depends on second argument
    (see examples).
Parameters:
    0 : String
    1 : Array
    2 : String (Optional) - Default: "r", Other Value: "l"

Example:
    (begin example)
        MAP("+1",[1,2,3,4,5]);
        MAPR("+1",[1,2,3,4,5]);
        MAPL("1+",[1,2,3,4,5]);
            ==> [2,3,4,5,6]
        MAP("setDir (random 360)",_enemys);
            ==> applies random direction to every unit in _enemys
        MAPL("position",_enemys);
            ==> returns array of positions
    (end)

Author:
    iJesuz
------------------------------------------- */
#define MAP(CODE,ARRAY) [CODE,ARRAY] call EFUNC(common,map)
#define MAPR(CODE,ARRAY) [CODE,ARRAY,"r"] call EFUNC(common,map)
#define MAPL(CODE,ARRAY) [CODE,ARRAY,"l"] call EFUNC(common,map)
/* -------------------------------------------
Macro(s):
        IS_ATTACK_HELI(VAR)
        IS_ATTACK_PLANE(VAR)

    check if air-vehicle is a CAS vehicle

Parameters:
    CONFIGNAME - the type of the vehicle

Example:
    (begin example)
        IS_ATTACK_HELI('B_Heli_Attack_01_F')
        IS_ATTACK_PLANE('B_Plane_CAS_01_F')
    (end)

Author:
    iJesuz
------------------------------------------- */
#define IS_ATTACK_HELI(THELI) if ((isClass(configFile >> "CfgVehicles" >> THELI)) && {"CAS_Heli" in getArray(configFile >> "CfgVehicles" >> THELI >> "availableForSupportTypes")}) then { true } else { false }
#define IS_ATTACK_PLANE(TPLANE) if ((isClass(configFile >> "CfgVehicles" >> TPLANE)) && {"CAS_Bombing" in getArray(configFile >> "CfgVehicles" >> TPLANE >> "availableForSupportTypes")}) then { true } else { false }