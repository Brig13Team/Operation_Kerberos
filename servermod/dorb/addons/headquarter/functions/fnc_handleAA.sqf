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

private _mobileaa = (HASH_GET(GVAR(antiair),"mobile")) select {alive _x;};
HASH_SET(GVAR(antiair),"mobile",_mobileaa);

private _staticaa = (HASH_GET(GVAR(antiair),"static")) select {alive _x;};
HASH_SET(GVAR(antiair),"static",_staticaa);

private _autonomousaa = (HASH_GET(GVAR(antiair),"autonomous")) select {alive _x;};
HASH_SET(GVAR(antiair),"autonomous",_autonomousaa);

_mobileaa append _staticaa;
private _targets = HASH_GET_DEF(GVAR(radars),"targets",[]);

{
    GVARMAIN(side) reportRemoteTarget [_x, 60];
    nil;
} count _targets;


{
    private _aa = _x;
    private _assignedTarget = assignedTarget _aa;
    If !(isNull _assignedTarget) then {
        if ((_aa distance _assignedTarget)<3400) then {
            {
                _x commandWatch objNull;
            } forEach (crew _unit);
            [QGVAR(setVehicleAmmo),[_aa,1],_aa] call CBA_fnc_targetEvent;
        };
    };
} forEach _mobileaa;


{
    [QGVAR(setVehicleAmmo),[_x,1],_x] call CBA_fnc_targetEvent;
} forEach _autonomousaa;



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
private _airInterceptionAvailible = ["radar_airinterception"] call FUNC(ressources_canUseCallIn);
TRACEV_2(_airInterceptionAvailible,_targets);

If (_airInterceptionAvailible) then {
    private _curTarget = selectRandom _targets;
    TRACEV_2(_airInterceptionAvailible,_curTarget);
    [_curTarget, "airinterception"] call EFUNC(spawn,offmap_airsupport);
};
