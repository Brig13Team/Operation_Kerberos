/*
    Author: Dorbedo

    Description:
        postinit client
*/
#define INCLUDE_GUI
#include "script_component.hpp"
CHECK(!hasInterface)

GVAR(spawns) = HASH_CREATE;

private _neededVersion = format["Version:%1_[%2,%3,%4,%5]",getText(missionConfigFile >> QUOTE(DOUBLES(CfgComponent,ADDON)) >> "version"),SafeZoneX,SafeZoneY,SafeZoneW,safeZoneH];
(profileNamespace getVariable [QGVARMAIN(vehiclesLib),["NotFound",[]]]) params [["_currentVersion","NotFound",[]],["_list",[],[[]]]];
If ((!(_list isEqualTo []))&&{_currentVersion isEqualTo _neededVersion}) then {
    GVAR(vehiclesHash) = [_list] call EFUNC(main,hash_Ldeserialize);
}else{
    GVAR(vehiclesHash) = HASH_CREATE;
};
GVAR(vehiclesHashModified) = false;

{
    _x params ["_spawntype","_spawnLogic","_picture","_iconsize"];
    If !((isNil "_spawnLogic")||{isNull _spawnLogic}) then {
        private _spawnPos = getPos _spawnLogic;
        _spawnPos set[2,0];
        Private _spawnDir = getDir _spawnLogic;
        private _id = [_spawntype,_spawnPos,_spawnDir] call FUNC(registerSpawn);
        [
            localize format[LSTRING(%1),_spawntype],
            compile format["[ace_player,'%1'] call %2;",_id,QFUNC(open)],
            compile format["[ace_player,'%1'] call %2;",_id,QFUNC(canOpenMenu)],
            ((parsingNamespace getVariable ["MISSION_ROOT",""]) + format[QEPAAPATH(icon,icon_%1),_picture]),
            _iconsize
        ] call EFUNC(gui_echidna,addApp);
        [
            format[QGVAR(interface_%1),_spawnLogic],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + format["data\icon\icon_%1.paa",_picture],
            {[ace_player,_this select 0] call FUNC(canOpenMenu);},
            [_id]
        ] call EFUNC(gui,addNotification);
    };
} forEach [
//   presetType,    spawnposition,      picture     isconsize
    ["vehicles_east",    spawn_vehicles,     "tank",     2],
    ["drones_east",      spawn_drones,       "drone",    1],
    ["air_east",         spawn_air,          "heli",     1],
    ["boat_east",        spawn_boat,         "harbour",  2],
    ["logistic_east",    spawn_logistic,     "logistic", 2]
];

[QGVAR(addVehicleSpecial),LINKFUNC(addVehicleSpecial)] call CBA_fnc_addEventHandler;
