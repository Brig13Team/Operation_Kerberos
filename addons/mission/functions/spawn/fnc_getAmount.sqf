/*
 *  Author: iJesuz
 *
 *  Description:
 *      get random amount of mission targets
 *      (can be used for sidemission too)
 *
 *  Parameter(s):
 *      0 : STRING  - name
 *
 *  Returns:
 *      NUMBER (default: 1)
 */
#include "script_component.hpp"

_this params ["_type"];

private _calc = {
    _this params ["_config"];

    if !(isNumber (_config >> "min")) exitWith { 1 };
    if !(isNumber (_config >> "max")) exitWith { 1 };

    private _min = getNumber(_config >> "min");
    private _max = getNumber(_config >> "max");
    private _avg = (floor (random ((_max - _min) + 1))) + _min;

    _avg
};

private _return = 1;
{
    private _class = ConfigFile >> "CfgKerberos" >> "mission" >> _x >> _type >> "object";
    if (isClass _class) exitWith {
        _return = [_class] call _calc;
    };
} forEach ["main", "side"];

_return
