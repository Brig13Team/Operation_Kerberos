/*
    Author: Dorbedo

    Description:
        postinit client
*/
#define INCLUDE_GUI
#include "script_component.hpp"
CHECK(!hasInterface)

GVAR(spawns) = HASH_CREATE;

{
    _x params ["_spawntype","_spawnLogic","_picture"];
    If !((isNil "_spawnLogic")||{isNull _spawnLogic}) then {
        private _spawnPos = getPos _spawnLogic;
        _spawnPos set[2,0];
        Private _spawnDir = getDir _spawnLogic;
        private _id = [_spawnPos,_spawntype,_spawnDir] call FUNC(registerSpawn);
        [
            localize format[LSTRING(%1),_spawntype],
            compile format["[player,'%1'] call %2;",_id,QFUNC(open)],
            compile format["[player,'%1'] call %2;",_id,QFUNC(canOpenMenu)],
            ((parsingNamespace getVariable ["MISSION_ROOT",""]) + format[QEPAAPATH(icon,icon_%1),_picture]),
            2
        ] call EFUNC(gui_echidna,addApp);
        [
            format[QGVAR(interface_%1),_spawnLogic],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + format["data\icon\icon_%1.paa",_picture],
            {[ace_player,_this select 0] call FUNC(canOpenMenu);},
            [_id]
        ] call EFUNC(gui,addNotification);
    };
} forEach [
//   presetType,    spawnposition,      picture
    ["vehicles",    spawn_vehicles,     "tank"],
    ["drones",      spawn_drones,       "drone"],
    ["air",         spawn_air,          "heli"],
    ["air_light",   spawn_air_light,    "heli"],
    ["boat",        spawn_boat,         "harbour"],
    ["logistic",    spawn_logistic,     "logistic"],
    ["logistic",    spawn_logistic2,    "logistic"]
];
