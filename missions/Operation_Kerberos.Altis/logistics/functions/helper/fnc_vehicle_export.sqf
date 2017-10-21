/*
 *  Author: Dorbedo
 *
 *  Description:
 *      exports the values into config
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If (isNull GVAR(helper_vehicle)) exitWith {
    hint "no vehicle selected";
};

private _passengerpos = [];
{
    if !(_x isEqualTo []) then {
        _passengerpos pushBack [_forEachIndex,_x];
    };
} forEach GVAR(helper_passenger_pos);

private _passenger = str _passengerpos;
_passenger = [_passenger, "[", "{"] call CBA_fnc_replace;
_passenger = [_passenger, "]", "}"] call CBA_fnc_replace;

private _tab = "    ";
private _tab2 = "        ";

private _export = _tab + format ["class %1 {",typeOf GVAR(helper_vehicle)] + endl
+ _tab2 + format["max_width = %1;",GVAR(helper_veh_w)] + endl
+ _tab2 + format["max_length = %1;",GVAR(helper_veh_l)] + endl
+ _tab2 + format["max_height = %1;",GVAR(helper_veh_h)] + endl
+ _tab2 + format["cargo_point[] = {%1,%2,%3};",GVAR(helper_veh_x),GVAR(helper_veh_y),GVAR(helper_veh_z)] + endl
+ _tab2 + format["load_point[] = {%1,%2,%3};",GVAR(helper_veh_load_x),GVAR(helper_veh_load_y),GVAR(helper_veh_load_z)] + endl
+ _tab2 + format["cargo_pos[] = %1;",_passenger] + endl
+ _tab + "};" + endl;

copyToClipboard _export;
