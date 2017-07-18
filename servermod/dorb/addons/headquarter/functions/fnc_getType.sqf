/**
 *  Author: Dorbedo
 *
 *  Description:
 *      gets the type of a unit
 *
 *  Parameter(s):
 *      0 : STRING/OBJECT - Unitclass
 *
 *  Returns:
 *      SCLALAR - type of a Unit
 *
 */
 //#define DEBUG_MODE_FULL
 #include "script_component.hpp"
 _this params [["_type","",["",objNull]]];
 If (_type isEqualTo "") exitWith {0};

 If (IS_OBJECT(_type)) then {
     _type = typeOf _type;
 };

getNumber (configFile >> "CfgVehicles" >> _type >> "type");
