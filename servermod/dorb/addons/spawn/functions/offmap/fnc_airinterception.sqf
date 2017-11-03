/**
 * Author: Dorbedo
 * drops a vehicle a the target position
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
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_target", ["_callback", {}, [{}]], ["_callbackParams", []]];


private _targetPos = [_target] call CBA_fnc_getPos;
private _spawnPos = [_target,3000,1000,4000] call FUNC(offmap_getsavespawnposair);

_spawnPos set [2,800];

If ((getTerrainHeightASL _spawnPos)<0) then {
    _spawnPos set [2, abs (getTerrainHeightASL _spawnPos) + 300];
} else {
    _spawnPos set [2,300];
};

private _dir = _spawnPos getDir _target;
private _attackVehType = ["plane_ai"] call EFUNC(spawn,getUnit);

([_spawnPos, GVARMAIN(side), _attackVehType, _dir] call EFUNC(spawn,vehicle)) params ["_attackgroup", "_attackVeh"];

{
    private _curMags = _x;
    _curMags = _curMags select {getNumber(configFile >> "CfgAmmo" >> (getText(configFile >> "CfgMagazines" >> _x >> "ammo")) >> "airLock") > 1};
    if (_curMags isEqualTo []) then {
        _attackVeh setPylonLoadOut [1+_forEachIndex,"",true];
    } else {
        private _pylonMag = selectRandom _curMags;
        _attackVeh setPylonLoadOut [1+_forEachIndex,_pylonMag,true];
    };
} forEach (_attackVeh getCompatiblePylonMagazines 0);


_attackgroup setVariable [QEGVAR(headquarter,state),"mission"];

[_attackgroup] call CBA_fnc_clearWaypoints;
private _wp = _attackgroup addWaypoint [_targetPos, 0];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointCombatMode "RED";

If (IS_OBJECT(_target)) then {

    [
        {
            (!(Alive(_this select 2)))||(!(canMove _attackVeh))
        },
        {
            if (canMove (_this select 0)) then {
                [_attackVeh] call FUNC(offmap_rtb);
                (_this select 5) call (_this select 4);
            };
        },
        60*10,
        {
            [_attackVeh] call FUNC(offmap_rtb);
        }
    ] call CBA_fnc_waitUntilAndExecute;

} else {

    [
        {
            (_this select 0) params ["_attackgroup", "_attackVeh", "_target", "_timeout", "_callback", "_callbackparams"];

            If (!(canmove _attackVeh)) exitWith {
                [_this select 1] call CBA_fnc_removePerFrameHandler;
            };

            If (CBA_missiontime > _timeout) then {
                [_this select 1] call CBA_fnc_removePerFrameHandler;
                [_attackVeh] call FUNC(offmap_rtb);
                _callbackparams call _callback;
            };

            If (isNull(assignedTarget _attackVeh)) then {
                private _possibleTargets = allPlayers select {
                    (alive _x)&&
                    {side _x == GVARMAIN(playerside)}&&
                    {!(vehicle _x == _x)}&&
                    {!((vehicle _x)isKindOf "ParachuteBase")}&&
                    {!(isTouchingGround (vehicle _x))}
                };
                _possibleTargets append (allUnitsUAV select {
                    (alive _x)&&
                    {_x isKindOf "Plane"}&&
                    {side _x == GVARMAIN(playerside)}
                    });
                If (_possibleTargets isEqualTo []) exitWith {
                    [_this select 1] call CBA_fnc_removePerFrameHandler;
                };
                private _newTarget = (selectRandom _possibleTargets);
                TRACEV_3(_possibleTargets,_newTarget,assignedTarget _attackVeh);
                _attackVeh commandTarget (selectRandom _possibleTargets);
            };
        },
        60,
        [_attackgroup, _attackVeh, _target, CBA_missiontime + 10*60, _callback, _callbackparams]
    ] call CBA_fnc_addPerFrameHandler;

};

[_attackVeh,_attackGroup,_spawnpos]
