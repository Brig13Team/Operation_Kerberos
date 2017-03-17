/*
 *  Author: Dorbedo
 *
 *  Description:
 *      receving of synconized data
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#include "script_component.hpp"

_this params ["_varname","_value"];

{
    _x params ["_namespace","_varname","_data"];
    _namespace setVariable [_varname,([_data] call EFUNC(main,deserialize))];
} forEach _value;

GVAR(DataIsSynced) = true;
