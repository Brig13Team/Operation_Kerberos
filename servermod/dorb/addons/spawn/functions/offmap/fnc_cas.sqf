/**
 * Author: Dorbedo
 * creates a cas attack
 *
 * Arguments:
 * 0: <ARRAY/OBJECT> the target can be an unit or a position
 * 1: <STRING> the type of cas
 * 1: <CODE> callback
 * 1: <ANY> callbackparams
 *
 * Return Value:
 * nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_target", "_type", ["_callback", {}, [{}]], ["_callbackParams", []]];

private _targetPos = [_target] call CBA_fnc_getPos;

private _spawnPos = [_targetPos] call FUNC(offmap_getsavespawnposair);

_spawnPos set [2,300];
private _dir = _targetPos getDir _spawnPos;
private _attackVehType = [_type] call EFUNC(spawn,getUnit);

([_spawnPos, GVARMAIN(side), _attackVehType, _dir, true, true, "FLY"] call EFUNC(spawn,vehicle)) params ["_attackGroup", "_attackVeh"];

private _targetLogic =  ([sideLogic] call CBA_fnc_getSharedGroup) createUnit ["LOGIC", _targetPos, [], 0, "NONE"];
(group _targetLogic) deleteGroupWhenEmpty true;

If !(IS_ARRAY(_target)) then {
    _targetLogic attachTo _target;
};

private _weapons = [];

switch (_type) do {
    case "cas_cluster" : {
        {
            private _curMags = _x;
            _curMags = _curMags select {((([getText(configFile >> "CfgMagazines" >> _x >> "pylonWeapon")] call BIS_fnc_itemtype) param [1,""]) == "BombLauncher")};
            private _curMagsWeighted = [];
            {
                _curMagsWeighted pushBack _x;
                private _curAmmo = getText(configFile >> "CfgMagazines" >> _x >> "ammp");
                If ((getArray(configFile >> "CfgMagazines" >> _curAmmo >> "submunitionAmmo")) isEqualTo []) then {
                    _curMagsWeighted pushBack 0.001;
                } else {
                    _curMagsWeighted pushBack 1;
                };
                nil
            } count _curMags;
            if (_curMags isEqualTo []) then {
                _attackVeh setPylonLoadOut [1+_forEachIndex,"",true];
            } else {
                private _pylonMag = selectRandomWeighted _curMagsWeighted;
                _weapons pushBack (getText(configFile >> "CfgMagazines" >> _pylonMag >> "pylonWeapon"));
                _attackVeh setPylonLoadOut [1+_forEachIndex,_pylonMag,true];
            };
        } forEach (_attackVeh getCompatiblePylonMagazines 0);
    };
    default {/* use the standard weapons */};
};

[_attackgroup] call CBA_fnc_clearWaypoints;
private _wp = _attackgroup addWaypoint [_targetPos, 0];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointCombatMode "RED";
_attackVeh flyInHeight 600;


[
    {
        (alive (_this select 0))&&
        {((_this select 0) distance (_this select 1))<600}
    },
    {
        If !(alive (_this select 0)) exitWIth {
            deleteVehicle (_this select 1);
            [false, (_this select 4)] call (_this select 3);
        };
        _this spawn {
            params ["_vehicle","_target","_weapons","_callback","_callbackparams"];
            private _Lasertarget = createvehicle ["LaserTargetC", getPos _target, [], 0, "none"];
            {
                _vehicle fireattarget [_Lasertarget,_x];
                uisleep 0.1;
            } foreach _weapons;
            sleep 10;
            deleteVehicle _target;
            [_vehicle] call FUNC(offmap_rtb);
            [true, _callbackParams] call _callback;
        };
    },
    [_attackVeh,_targetLogic,_weapons,_callback,_callbackParams],
    60*6,
    {
        deleteVehicle (_this select 1);
        [_this select 0] call FUNC(offmap_rtb);
        [false, (_this select 4)] call (_this select 3);
    }
] call CBA_fnc_waitUntilAndExecute;
