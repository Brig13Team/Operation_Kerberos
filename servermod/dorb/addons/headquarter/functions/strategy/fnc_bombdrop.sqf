/**
 * Author: Dorbedo
 * drops clusterbombs at a location
 *
 * Arguments:
 * 0: <LOCATION> the attacklocation
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_attackLoc"];
//TRACEV_1(_attackLoc);

private _pos = locationPosition _attackLoc;
private _spawnPos = [_pos,5000,5000,10000] call FUNC(ressources_getsavespawnposair);
_spawnPos set [2,500];
_dir = [_spawnpos, _pos] call BIS_fnc_dirTo;
private _attackVehType = ["plane_bomb"] call EFUNC(spawn,getUnit);

([_spawnPos,GVARMAIN(side),_attackVehType,_dir,true,true,"FLY"] call EFUNC(spawn,vehicle)) params ["_attackGroup","_attackVeh"];
private _ressourcesHash = HASH_GET_DEF(GVAR(ressources),"cas",locationNull);


HASH_GET_DEF(_ressourcesHash,"units",[]) pushBack _attackVeh;
HASH_SET(_ressourcesHash,"nextexecution",CBA_missiontime + GVAR(ressources_CallInreplenish_CAS));

private _nearPlayers = ([] call CBA_fnc_players) select {((_x distance _pos)<400)&&{((getPosATL _x) select 2)<10}&&{(GVARMAIN(side) knowsAbout _x)>1.5}};

if !(_nearPlayers isEqualTo []) then {_pos = getPos (selectRandom _nearPlayers)};

private _target =  ([sideLogic] call CBA_fnc_getSharedGroup) createUnit ["LOGIC", _pos, [], 0, "NONE"];
(group _target) deleteGroupWhenEmpty true;
private _weapons = [];
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
    //TRACEV_2(_curMagsWeighted,typeOf _attackVeh);
    if (_curMags isEqualTo []) then {
        _attackVeh setPylonLoadOut [1+_forEachIndex,"",true];
    } else {
        private _pylonMag = selectRandomWeighted _curMagsWeighted;
        _weapons pushBack (getText(configFile >> "CfgMagazines" >> _pylonMag >> "pylonWeapon"));
        _attackVeh setPylonLoadOut [1+_forEachIndex,_pylonMag,true];
    };
} forEach (_attackVeh getCompatiblePylonMagazines 0);

//TRACEV_5(_attackGroup,_attackLoc,locationPosition _attackLoc,_target,getPos _target);

_attackGroup setVariable [QGVAR(target),_target];
_attackGroup setVariable [QGVAR(timeout),CBA_missiontime + 10*60];
_attackGroup setVariable [QGVAR(spawnpos),_spawnPos];
_attackGroup setVariable [QGVAR(state),"cas_support_bomb"];

[
    {
        params ["_vehicle","_target"];
        (_vehicle distance _target)<600
    },
    {
        //TRACEV_1(_this);
        _this spawn {
            params ["_vehicle","_target","_weapons","_attackLoc"];
            private _Lasertarget = createvehicle ["LaserTargetC", getPos _target, [], 0, "none"];
            {
                _vehicle fireattarget [_Lasertarget,_x];
                uisleep 0.1;
            } foreach _weapons;
            sleep 10;
            deleteVehicle _target;
            _attackLoc setVariable [QGVAR(timeout),0];
        };
    },
    [_attackVeh,_target,_weapons,_attackLoc],
    60*6,
    {
        deleteVehicle (_this select 1);
        (_this select 3) setVariable [QGVAR(timeout),0];
    }
] call CBA_fnc_waitUntilAndExecute;

[_attackVeh,_attackGroup,_spawnpos]
