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
TRACEV_3(_unitsToUnload,_transporter,_isAir);
If (_isAir) then {
    private _droppos = getPos _transporter;
    _droppos set [2,(_droppos select 2)-4];
    [_unitsToUnload,_droppos] spawn {
        _this params ["_unitsToUnload","_droppos"];
        {
            _x enableAI "Move";
            unassignVehicle (_x);
            _x allowDamage false;
            If ((backpack _x) isEqualTo "") then {
                _x addBackPack "rhs_d6_Parachute_backpack";
                moveOut _x;
            }else{
                moveOut _x;
                private _parachute = createVehicle ["rhs_d6_Parachute",_droppos, [], 0, "FLY"];
                uisleep 1;
                _x moveInDriver _parachute;
            };

            _x allowDamage true;
        } forEach _unitsToUnload;
    };
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
