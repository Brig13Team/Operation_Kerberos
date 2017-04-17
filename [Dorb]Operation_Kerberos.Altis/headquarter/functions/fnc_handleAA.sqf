/**
 *  Author: Dorbedo
 *
 *  Description:
 *      Handles the AA
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

CHECK(!GVAR(active))

private _mobileaa = HASH_GET(GVAR(anitair),"mobile");
_mobileaa select {alive _x;};
HASH_SET(GVAR(anitair),"mobile",_mobileaa);

private _staticaa = HASH_GET(GVAR(anitair),"static");
_staticaa select {alive _x;};
HASH_SET(GVAR(anitair),"static",_staticaa);

_mobileaa append _staticaa;
private _targets = HASH_GET(GVAR(radars),"targets");

{
    private _assignedTarget = assignedTarget _x;
    If !(isNull _assignedTarget) then {
        if ((_x distance _assignedTarget)<3400) then {
            {
                _x commandWatch objNull;
            } forEach (crew _unit);
            [QGVAR(setVehicleAmmo),[_unit,1],_unit] call CBA_fnc_targetEvent;
        };
    };
} forEach _mobileaa;

{
    private _currentAA = _x;
    private _nearestTarget = objNull;
    {
        If (((_x distance _currentAA)<2500)&&{(_x distance _currentAA)<(_nearestTarget distance _currentAA)}) then {
            _nearestTarget = _x;
        };
    } forEach _targets;
    If !(isNull _nearestTarget) then {
        _currentAA commandWatch _nearestTarget;
        _currentAA commandTarget _nearestTarget;
    };
} forEach _mobileaa;
