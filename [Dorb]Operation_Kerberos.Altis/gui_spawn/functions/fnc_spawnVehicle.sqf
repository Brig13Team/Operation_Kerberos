/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

private _dialog = uiNamespace getVariable [QEGVAR(gui_Echidna,dialog),(findDisplay IDD_ECHIDNA_SPAWN)];
private _vehicleList = _dialog displayCtrl IDC_ECHIDNA_SPAWN_VEHICLELIST;


private _vehicleType = _vehicleList lnbData [lnbCurSelRow _vehicleList, 0];

TRACEV_1(_vehicleType);


If ((isNil "_vehicleType")||{_vehicleType isEqualTo ""}) exitWith {};

If ([player,_vehicleType] call FUNC(checkRestrictions)) exitWith {
    [LSTRING(ERRORMSG),LSTRING(ISRESTRICTED),"red"] call EFUNC(gui,message);
};

private _spawnposition =+ GVAR(curPos);
private _spawnDir = GVAR(curDir);
private _spawnposIsEmpty = [_spawnposition] call FUNC(checkPosEmpty);

If !(_spawnposIsEmpty) exitWith {
    [LSTRING(ERRORMSG),LSTRING(NOTEMPTY),"red"] call EFUNC(gui,message);
};


private _vehicle = createVehicle [_vehicleType, _spawnposition, [], 0 , "NONE"];
_vehicle setDir _spawnDir;

if ((_vehicle isKindOf "SDV") or (_vehicle isKindOf "Ship")) then {
    _vehicle setPosASL [_spawnposition select 0, _spawnposition select 1, 0];
} else {
    _vehicle setposATL [_spawnposition select 0, _spawnposition select 1, 0.2];
    _vehicle setVectorUP (surfaceNormal [(getPosatl _vehicle) select 0,(getPosatl _vehicle) select 1]);
};

if ((getText(configFile >> "CfgVehicles" >> _vehicleType >> "vehicleClass"))isEqualTo "Autonomous") then {
    createVehicleCrew _vehicle;
};


closeDialog (ctrlIDD _dialog);
[] call EFUNC(gui_echidna,close);

If (GVAR(vehiclesHashModified)) then {
    [] spawn {
        private _version = format["Version:%1_[%2,%3,%4,%5]",getText(missionConfigFile >> QUOTE(DOUBLES(CfgComponent,ADDON)) >> "version"),SafeZoneX,SafeZoneY,SafeZoneW,safeZoneH];
        private _serializedHash = [GVAR(vehiclesHash)] call EFUNC(main,hash_serialize);
        profileNamespace setVariable [QGVARMAIN(vehiclesLib),[_Version,_serializedHash]];
        saveProfileNamespace;
    };
};
