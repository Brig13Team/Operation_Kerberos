/*
    Author: Dorbedo

    Description:
        3DIcons
*/
#include "script_component.hpp"
SCRIPT(draw3D);
CHECK(!hasInterface)
private["_id"];

_id = addMissionEventHandler ["draw3D",{
    private["_root","_zoom"];
    _root = parsingNamespace getVariable "D_ROOTDIR";
    _zoom = round(([0.5,0.5] distance worldToScreen positionCameraToWorld [0,1.05,1]) * (getResolution select 5));
    if(player distance (getPos cratespawner)<15)then{
        private ["_spawnPos","_sizeicon"];
        _spawnPos = getPosATL cratespawner;
        _spawnPos set[2,1];
        _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance cratespawner)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_robot.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize LSTRING(crate_header),0,(_sizeicon*0.015),"PuristaMedium"];
    };
}];