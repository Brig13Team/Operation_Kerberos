/*
    Author: Dorbedo

    Description:
        postinit client
*/
#define INCLUDE_GUI
#include "script_component.hpp"
CHECK(!hasInterface)

GVAR(spawns) = HASH_CREATE;
GVAR(vehiclesHash) = HASH_CREATE;

["test",getMarkerPos "respawn_west",0] call FUNC(registerSpawn);

{
    _x params ["_spawntype","_spawnLogic","_picture","_iconsize"];
    If !((isNil "_spawnLogic")||{isNull _spawnLogic}) then {
        private _spawnPos = getPos _spawnLogic;
        _spawnPos set[2,0];
        Private _spawnDir = getDir _spawnLogic;
        private _id = [_spawntype,_spawnPos,_spawnDir] call FUNC(registerSpawn);
        [
            localize format[LSTRING(%1),_spawntype],
            compile format["[player,'%1'] call %2;",_id,QFUNC(open)],
            compile format["[player,'%1'] call %2;",_id,QFUNC(canOpenMenu)],
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
    ["vehicles",    spawn_vehicles,     "tank",     2],
    ["drones",      spawn_drones,       "drone",    1],
    ["air",         spawn_air,          "heli",     1],
    ["air_light",   spawn_air_light,    "heli",     2],
    ["boat",        spawn_boat,         "harbour",  2],
    ["logistic",    spawn_logistic,     "logistic", 2],
    ["logistic",    spawn_logistic2,    "logistic", 2]
];
