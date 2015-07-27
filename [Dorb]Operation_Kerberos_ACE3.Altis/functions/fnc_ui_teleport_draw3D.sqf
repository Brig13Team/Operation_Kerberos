/*
    Author: Dorbedo

    Description:
        3DIcons
*/
#include "script_component.hpp"

CHECK(!hasInterface)
private["_id"];

_id = addMissionEventHandler ["draw3D",{
    private["_root","_zoom"];
    _root = parsingNamespace getVariable "D_ROOTDIR";
    _zoom = round(([0.5,0.5] distance worldToScreen positionCameraToWorld [0,1.05,1]) * (getResolution select 5));
    if(player distance (getPos teleporter)<25)then{
        private ["_spawnPos","_sizeicon"];
        _spawnPos = getPosATL teleporter;
        _spawnPos set[2,1.5];
        _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance teleporter)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_teleport.paa",[0.976,0.996,0.267,1],_spawnPos,_sizeicon*2,_sizeicon*2,0,localize "STR_DORB_TELEPORT",0,(_sizeicon*0.015),"PuristaMedium"];
    };
    if(player distance (getPos teleporter2)<25)then{
        private ["_spawnPos","_sizeicon"];
        _spawnPos = getPosATL teleporter2;
        _spawnPos set[2,1.5];
        _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance teleporter2)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_teleport.paa",[0.976,0.996,0.267,1],_spawnPos,_sizeicon*2,_sizeicon*2,0,localize "STR_DORB_TELEPORT",0,(_sizeicon*0.015),"PuristaMedium"];
    };
    if(player distance (getPos teleporter3)<25)then{
        private ["_spawnPos","_sizeicon"];
        _spawnPos = getPosASL teleporter3;
        _spawnPos set[2,3.5];
        _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance teleporter3)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_teleport.paa",[0.976,0.996,0.267,1],_spawnPos,_sizeicon*2,_sizeicon*2,0,localize "STR_DORB_TELEPORT",0,(_sizeicon*0.015),"PuristaMedium"];
    };
}];