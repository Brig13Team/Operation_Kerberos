/*
    Author: Dorbedo

    Description:
        postinit client
*/
#define INCLUDE_GUI
#include "script_component.hpp"
CHECK(!hasInterface)

GVAR(spawnpositions) = HASH_CREATE;
GVAR(interface) = [];

{
    _x params ["_spawntype","_spawnLogic","_picture"];
    If !((isNil "_spawnLogic")||{isNull _spawnLogic}) then {
        private _spawnPos = getPos _spawnLogic;
        _spawnPos set[2,0];
        Private _spawnDir = getDir _spawnLogic;
        /*
        If !(surfaceIsWater _spawnPos) then {
            _spawnPos = AGLToASL _spawnPos;
        };*/
        private _spawn = HASH_GET(GVAR(spawnpositions),_spawntype);
        If (isNil "_spawn") then {
            [
                localize format[LSTRING(%1),_spawntype],
                compile format["[player,'%1'] call %2;",_spawntype,QFUNC(open)],
                compile format["[player,'%1'] call %2;",_spawntype,QFUNC(canOpenMenu)],
                ((parsingNamespace getVariable ["MISSION_ROOT",""]) + format[QEPAAPATH(icon,icon_%1),_picture]),
                2
            ] call EFUNC(gui_echidna,addApp);
            HASH_SET(GVAR(spawnpositions),_spawntype,[[ARR_2(_spawnPos,_spawnDir)]]);
        }else{
            HASH_GET(GVAR(spawnpositions),_spawntype) pushBack [ARR_2(_spawnPos,_spawnDir)];
        };
        GVAR(interface) pushBack [_spawnPos,_picture,(localize format[LSTRING(%1),_spawntype]),_spawntype];
        [
            format[QGVAR(interface_%1),_spawnLogic],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + format["data\icon\icon_%1.paa",_picture],
            {[ace_player,_this select 0] call FUNC(canOpenMenu);},
            [_spawntype]
        ] call EFUNC(gui,addNotification);
    };
} forEach [
//   spawntyp,      spawnposition,      picture
    ["vehicles",    spawn_vehicles,     "tank"],
    ["drones",      spawn_drones,       "drone"],
    ["air",         spawn_air,          "heli"],
    ["air_light",   spawn_air_light,    "heli"],
    ["boat",        spawn_boat,         "harbour"],
    ["logistic",    spawn_logistic,     "logistic"],
    ["logistic",    spawn_logistic2,    "logistic"]
];

/*
private _id = addMissionEventHandler ["draw3D",{
    private _root = parsingNamespace getVariable ["MISSION_ROOT",""];
    private _zoom = round(([0.5,0.5] distance worldToScreen positionCameraToWorld [0,1.05,1]) * (getResolution select 5));
    {
        _x params ["_pos","_pic","_text","_spawntype"];
        If (((player distance _pos)<25)&&(isNull curatorCamera)&&(vehicle player == player)) then {
            private _picpos =+ _pos;
            _picpos set [2,((_pos select 2)+1.5)];
            private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance _pos)))*_zoom*6);
            _pic = _root + format["data\icon\icon_%1.paa",_pic];
            private _color = [RAL3024,0.8];
            If ([player,_spawntype] call FUNC(canOpenMenu)) then {
                _color = [RAL6018,0.8];
            };
            drawIcon3D [_pic,_color,_picpos,_sizeicon,_sizeicon,0,_text,0,(_sizeicon*0.015),"PuristaMedium"];
        };
    } forEach GVAR(interface);
}];
*/
