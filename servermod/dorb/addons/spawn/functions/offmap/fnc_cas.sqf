/**
 * Author: Dorbedo
 * creates a cas attack
 *
 * Arguments:
 * 0: <ARRAY/OBJECT> the target can be an unit or a position
 * 1: <STRING> the type of cas
 * 2: <CODE> callback
 * 3: <ANY> callbackparams
 *
 * Return Value:
 * nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_target", "_type", ["_callback", {}, [{}]], ["_callbackParams", []]];

private _targetPos = [_target] call CBA_fnc_getPos;

private _spawnPos = [
    _target
    ,12000,7000,20000
//    ,3000,1000,4000
] call FUNC(offmap_getsavespawnposair);

_spawnPos set [2,300];
private _dir = _spawnPos getDir _targetPos;
private _attackVehType = ["plane_cas"] call EFUNC(spawn,getUnit);

([_spawnPos, GVARMAIN(side), _attackVehType, _dir, true, true, "FLY"] call EFUNC(spawn,vehicle)) params ["_attackGroup", "_attackVeh"];
_attackGroup setVariable [QEGVAR(headquarter,state),"mission"];

private _targetLogic =  ([sideLogic] call CBA_fnc_getSharedGroup) createUnit ["LOGIC", _targetPos, [], 0, "NONE"];
(group _targetLogic) deleteGroupWhenEmpty true;

If !(IS_ARRAY(_target)) then {
    _targetLogic attachTo [_target,[0,0,0]];
};

private _weapons = [];
private _attackPosIntervall = 5;
private _isBomb = false;

switch (_type) do {
    case "plane_bomb";
    case "cluster" : {
        _isBomb = true;
        {
            private _curMags = _x;
            _curMags = _curMags select {((([getText(configFile >> "CfgMagazines" >> _x >> "pylonWeapon")] call BIS_fnc_itemtype) param [1,""]) == "BombLauncher")};
            private _curMagsWeighted = [];
            {
                _curMagsWeighted pushBack _x;
                private _curAmmo = getText(configFile >> "CfgMagazines" >> _x >> "ammo");
                If ((getArray(configFile >> "CfgAmmo" >> _curAmmo >> "submunitionAmmo")) isEqualTo []) then {
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
        _attackPosIntervall = 8
    };
    case "missiles" : {
        {
            private _curMags = _x;
            _curMags = _curMags select {((([getText(configFile >> "CfgMagazines" >> _x >> "pylonWeapon")] call BIS_fnc_itemtype) param [1,""]) == "MissileLauncher")};
            if (_curMags isEqualTo []) then {
                _attackVeh setPylonLoadOut [1+_forEachIndex,"",true];
            } else {
                private _pylonMag = selectRandom _curMags;
                _weapons pushBack (getText(configFile >> "CfgMagazines" >> _pylonMag >> "pylonWeapon"));
                _attackVeh setPylonLoadOut [1+_forEachIndex,_pylonMag,true];
            };
        } forEach (_attackVeh getCompatiblePylonMagazines 0);
        _attackPosIntervall = 5
    };
    case "gattling" : {
        {
            private _curWeapon = _x;
            If ((([_curWeapon] call BIS_fnc_itemtype) param [1,""]) == "MachineGun") exitWith {
                _weapons = [_curWeapon,_curWeapon,_curWeapon,_curWeapon,_curWeapon,_curWeapon,_curWeapon,_curWeapon,_curWeapon,_curWeapon,_curWeapon,_curWeapon,_curWeapon,_curWeapon,_curWeapon,_curWeapon];
            };
        } forEach (weapons _attackVeh);
        _attackPosIntervall = 4
    };
    default {/* use the standard weapons */};
};

// hardpoints[] = {"RHS_HP_LGB_500","RHS_HP_FFAR_USAF","RHS_HP_AGM65_3x","RHS_HP_BOMB_500_3x"};
// weapons[] = {"Gatling_30mm_Plane_CAS_01_F","Laserdesignator_pilotCamera","CMFlareLauncher"};

[_attackgroup] call CBA_fnc_clearWaypoints;
private _wp = _attackgroup addWaypoint [_targetPos, 0];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointCombatMode "RED";
_attackVeh flyInHeight 300;
_attackVeh doTarget _targetLogic;

[
    {
        (alive (_this select 0))&&
        {((_this select 0) distance (_this select 1))<800}
    },
    If (_isBomb) then {LINKFUNC(offmap_casBombStrike)} else {LINKFUNC(offmap_casStrike)},
    [_attackVeh,_targetLogic,_weapons,_callback,_callbackParams,_attackPosIntervall],
    60*6,
    {
        deleteVehicle (_this select 1);
        [_this select 0] call FUNC(offmap_rtb);
        [false, (_this select 4)] call (_this select 3);
    }
] call CBA_fnc_waitUntilAndExecute;

[_attackVeh,_attackGroup,_spawnpos]
