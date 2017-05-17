/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Transports a group into the area
 *
 *  Parameter(s):
 *      0 : GROUP - the transporter Group
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_group"];
TRACEV_1(_group);
private _transporter = vehicle (leader _group);
private _isAir = _transporter isKindOf "Air";
private _unitsToUnload = [];

{
    if (group (_x select 0) != _group) then {
        _unitsToUnload pushBack (_x select 0);
    };
    nil;
} count (fullCrew [_transporter, "cargo", false]);

{
    [QGVAR(disableCollisionWith),[_x,_transporter],_x] call CBA_fnc_targetEvent;
    [QGVAR(disableCollisionWith),[_transporter,_x],_transporter] call CBA_fnc_targetEvent;
} forEach _unitsToUnload;
TRACEV_3(_unitsToUnload,_transporter,);
If (_isAir) then {
    private _droppos = getPos _transporter;
    _droppos set [2,(_droppos select 2)-4];
    {
        _x enableAI "Move";
        unassignVehicle (_x);
        _x allowDamage false;
        moveOut _x;
        private _parachute = createVehicle ["NonSteerable_Parachute_F",_droppos, [], 0, "FLY"];
        _x moveInDriver _parachute;
        _x allowDamage true;
    } forEach _unitsToUnload;
} else {
    {
        unassignVehicle (_x);
        _x allowDamage false;
        moveOut _x;
        _x allowDamage true;
    } forEach _unitsToUnload;
};

{
    (group _x) setVariable [QGVAR(state),"combat"];
} forEach _unitsToUnload;

//
