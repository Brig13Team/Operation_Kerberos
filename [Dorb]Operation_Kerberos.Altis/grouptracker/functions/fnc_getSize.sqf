/*
 *  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      returns the sizemarker of a group
 *
 *  Parameter(s):
 *      0 : GROUP - the group
 *
 *  Returns:
 *      STRING - markertype of the size
 *
 */
#include "script_component.hpp"

_this params ["_group","_symbol"];
if (!alive (leader _group)) exitWith {"Empty";};
if ((count (units _group)) < 2) exitWith {"Empty";};

if (_symbol in ["art","armor","plane","air" ]) exitWith {
    private _vehicles = [];
    {
        if ( (!((vehicle _x) isKindOf "Man")) && { !((vehicle _x) in _vehicles) } ) then { _vehicles pushBack (vehicle _x); };
    } forEach (units _group);
    private _ret = "Empty";
    // if ((count units _vehicles) == 1) then { _ret = "group_1"; };
    if ((count _vehicles) == 2) then { _ret = "group_2"; };
    if ((count _vehicles) >= 3) then { _ret = "group_3"; };
    _ret
};
if (_symbol in ["inf","mech_inf","motor_inf","recon","maint","support"]) exitWith {
    private _ret = "Empty";
    if ((count units _group) >=  2) then { _ret = "group_1"; };
    if ((count units _group) >=  9) then { _ret = "group_2"; };
    if ((count units _group) >= 13) then { _ret = "group_3"; };
    _ret
};
"Empty"
