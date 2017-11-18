/**
 * Author: Dorbedo
 * calls in a Airdrop
 *
 * Arguments:
 * 0: <ARRAY> the target
 * 1: <CODE> callback
 * 2: <ANY> callbackparams
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_target", ["_callback", {}, [{}]], ["_callbackParams", []]];

private _spawnPos = [
    _target
//    ,3000,1000,4000
] call FUNC(offmap_getsavespawnposair);

If ((getTerrainHeightASL _spawnPos)<0) then {
    _spawnPos set [2, abs (getTerrainHeightASL _spawnPos) + 180];
} else {
    _spawnPos set [2,180];
};

private _transporttype = ["supply_airdrop_types"] call EFUNC(spawn,getUnit);
if (_transporttype isEqualTo []) exitWith {0};
private _dir = _spawnPos getDir _target;
([_spawnPos,GVARMAIN(side),_transporttype,_dir] call EFUNC(spawn,vehicle)) params ["_transportGroup","_transportVehicle"];

_transportGroup setVariable [QEGVAR(headquarter,state),"mission"];
_transportGroup addWaypoint [_target,200];
_transportVehicle doMove _target;
_transportVehicle setpos _spawnpos;
_transportVehicle flyInHeight 180;
_transportVehicle setSpeedMode "FULL";
_transportVehicle setBehaviour "SAFE";
_transportVehicle setCombatMode "GREEN";

private _groupType = ["airdrop"] call EFUNC(spawn,getGroup);
private _newGroup = [_spawnpos, _grouptype] call EFUNC(spawn,group);

{
    _x assignAsCargo _transportVehicle;
    _x moveInCargo _transportVehicle;
    [QEGVAR(common,disableCollisionWith),[_x,_transportVehicle],_x] call CBA_fnc_targetEvent;
    [QEGVAR(common,disableCollisionWith),[_transportVehicle,_x],_transportVehicle] call CBA_fnc_targetEvent;
} forEach (units _newGroup);

[
    {
        (_this select 0) params ["_transportGroup", "_newGroup", "_target", "_transportVehicle", "_timeout", "_callback", "_callbackparams"];

        If ((!(canmove _transportVehicle))||{CBA_missiontime > _timeout}) exitWith {
            [_this select 1] call CBA_fnc_removePerFrameHandler;
            {deleteVehicle _x} forEach (crew _transportVehicle);
            deleteGroup _transportGroup;
            deleteVehicle _transportVehicle;
        };
        If ((_transportVehicle distance2D _target) > 600) exitWith {};

        [_this select 1] call CBA_fnc_removePerFrameHandler;

        [
            {
                (_this select 0) params [["_units",[],[[]]]];
                If (_units isEqualTo []) exitWith {
                    [_this select 1] call CBA_fnc_removePerFrameHandler;
                };
                private _unit = _units deleteAt 0;
                unassignVehicle _unit;
                moveOut _unit;
                _unit allowDamage false;
                [_unit] call FUNC(offmap_parachute);
                _unit allowDamage true;
            },
            0.8,
            [(units _newGroup)]
        ] call CBA_fnc_addPerFrameHandler;
        [_newGroup,"combat"] call EFUNC(headquarter,registerGroup);
        [_transportVehicle] call FUNC(offmap_rtb);
        _callbackparams call _callback;
    },
    10,
    [_transportGroup, _newGroup, _target, _transportVehicle, CBA_missiontime + 10*60, _callback, _callbackparams]
] call CBA_fnc_addPerFrameHandler;

(([_newGroup] call EFUNC(headquarter,getstrengthAIGroup)) param [0,0])
