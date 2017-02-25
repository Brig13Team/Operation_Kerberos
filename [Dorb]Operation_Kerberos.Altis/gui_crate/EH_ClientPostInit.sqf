/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"

CHECK(!hasInterface)

GVAR(cratelogics) = [];

/// get the crate-logics

for "_i" from 1 to 9 do {
    private _logicname = format["cratespawner%1",_i];
    if !(isNil _logicname) then {
        GVAR(cratelogics) pushBack (missionNamespace getVariable [_logicname,objNull]);
    };
};

[
    QGVAR(crateIcon),
    (parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(icon,icon_robot),
    {[ace_player] call FUNC(canOpenMenu);},
    []
] call EFUNC(gui,addNotification);


/*
private _id = addMissionEventHandler ["draw3D",{
    private _root = parsingNamespace getVariable ["MISSION_ROOT",""];
    private _zoom = round(([0.5,0.5] distance worldToScreen positionCameraToWorld [0,1.05,1]) * (getResolution select 5));
    {
        If ((!isNull _x)&&((player distance _x)<25)&&(isNull curatorCamera)&&(vehicle player == player)) then {
            private _spawnPos = getPos _x;
            _spawnPos set[2,1];
            private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance _x)))*_zoom*6);
            private _color = [RAL3024,0.8];
            If ([player] call FUNC(canOpenMenu)) then {
                _color = [RAL6018,0.8];
            };
            drawIcon3D [_root + QEPAAPATH(icon,icon_robot),_color,_spawnPos,_sizeicon,_sizeicon,0,localize LSTRING(header),0,(_sizeicon*0.015),"PuristaMedium"];
        };
    }forEach GVAR(cratelogics);
}];
*/
[
    localize LSTRING(header),
    {[] call FUNC(OpenMenu);},
    {[player] call FUNC(canOpenMenu);},
    ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(icon,icon_robot)),
    3
] call EFUNC(gui_tablet,addApp);
