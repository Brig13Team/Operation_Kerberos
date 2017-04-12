/*
 *  Author: Dorbedo
 *
 *  Description:
 *      gets the cost of a unit
 *
 *  Parameter(s):
 *      0 : STRING/OBJECT - Unitclass
 *
 *  Returns:
 *      SCLALAR - costa of a Unit
 *
 */
 //#define DEBUG_MODE_FULL
 #include "script_component.hpp"
 this params [["_type","",["",objNull]]];
 If (_type isEqualTo "") exitWith {0};

 If (IS_OBJECT(_type)) then {
     If !(HASH_HASHKEY(GVAR(costs),typeOf _type)) then {
         [typeOf _type,_type] call FUNC(initVehicle);
     };
     _type = typeOf _type;
 } else {
     If !(HASH_HASHKEY(GVAR(costs),_type)) then {
         [_type] call FUNC(initVehicle);
     };
 };

 HASH_GET(GVAR(costs),_type);
