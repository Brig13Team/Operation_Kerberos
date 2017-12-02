/**
 * Author: Dorbedo
 * spawns the chosen Vehicle
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_control"];

If (GVAR(curVeh) isEqualTo "") exitWith {};

private _vehicleType = GVAR(curVeh);

If !([ace_player,_vehicleType] call FUNC(checkRestrictions)) exitWith {
    [LSTRING(ERRORMSG),LSTRING(ISRESTRICTED),"red"] spawn EFUNC(gui,message);
    true;
};

private _spawnposition =+ GVAR(curPos);
private _spawnDir = GVAR(curDir);
private _spawnposIsEmpty = [_spawnposition] call FUNC(checkPosEmpty);

If !(_spawnposIsEmpty) exitWith {
    [LSTRING(ERRORMSG),LSTRING(NOTEMPTY),"red"] call EFUNC(gui,message);
};

private _vehicle = createVehicle [_vehicleType, ASLtoAGL _spawnposition, [], 0 , "NONE"];
_vehicle setDir _spawnDir;

if ((_vehicle isKindOf "SDV") or (_vehicle isKindOf "Ship")) then {
    _vehicle setPosASL [_spawnposition select 0, _spawnposition select 1, 0];
} else {
    _vehicle setposASL _spawnposition;
    If !(surfaceIsWater _spawnposition) then {
        _vehicle setVectorUP (surfaceNormal [(getPos _vehicle) select 0,(getPos _vehicle) select 1]);
    };
};

if (([_vehicleType,"vehicleClass",""] call EFUNC(common,getCfgVehicles))isEqualTo "Autonomous") then {
    createVehicleCrew _vehicle;
};

_vehicle lock 0;

If (GVAR(option_noAmmo)) then {
    _vehicle setVehicleAmmo 0;
};

If (GVAR(option_spawnEmtpy)) then {
    clearBackpackCargoGlobal _vehicle;
    clearItemCargoGlobal _vehicle;
    clearWeaponCargoGlobal _vehicle;
    clearMagazineCargoGlobal _vehicle;
};

If (GVAR(option_noSpareParts)) then {
    // TODO this needs some fixing
    _vehicle setVariable ["ace_cargo_space", ([_vehicleType,"ace_cargo_space",0] call EFUNC(common,getCfgVehicles)),true];
    _vehicle setVariable ["ace_cargo_loaded",[],true];
};

If (GVAR(option_spawnAsDriver)) then {
    ace_player moveInDriver _vehicle;
};

[_vehicle] call FUNC(addVehicleSpecial);

(ctrlParent _control) closeDisplay 0;
[] call EFUNC(gui_main,close);

If (GVAR(option_openPylon)) then {
    [_vehicle,true] call ace_pylons_fnc_showDialog;
};
