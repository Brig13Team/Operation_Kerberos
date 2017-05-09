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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_group"];

private _transporter = vehicle (leader _group);
private _isAir = _transporter isKindOf "Air";
private _unitsToUnload = (units _transporter) select {group _x != _group};

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



//
