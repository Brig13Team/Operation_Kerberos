/*
    Author: Dorbedo

    Description:
        Adds Action to Teleporter

*/
#include "script_component.hpp"
CHECK(!hasInterface)
GVAR(teleporterlogics) = [];

for "_i" from 1 to 9 do {
    if !(isNil (format["teleporter%1",_i])) then {
        [["<t size='1.5' shadow='2' color='#F9FE44'>" +localize LSTRING(TELEPORT) +"</t>", {createDialog QGVAR(teleporter);}, [], 5, false, true, "",format["alive _target and (getposatl player distance getposatl teleporter%1) < 6",_i]]] call CBA_fnc_addPlayerAction;
        GVAR(teleporterlogics) pushBack (missionNamespace getVariable [format["teleporter%1",_i],objNull]);
    };
};

private _id = addMissionEventHandler ["draw3D",{
    private _root = parsingNamespace getVariable "D_ROOTDIR";
    private _zoom = round(([0.5,0.5] distance worldToScreen positionCameraToWorld [0,1.05,1]) * (getResolution select 5));
    {
        If ((!isNull _x)&&{(player distance (getPosATL _x))<25}) then {
            private _spawnPos = getPos _x;
            _spawnPos set[2,1.5];
            private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance _x)))*_zoom*6);
            drawIcon3D [_root+"data\icon\icon_teleport.paa",[0.976,0.996,0.267,1],_spawnPos,_sizeicon*2,_sizeicon*2,0,localize LSTRING(TELEPORT),0,(_sizeicon*0.015),"PuristaMedium"];
        };
    }forEach GVAR(teleporterlogics);
}];