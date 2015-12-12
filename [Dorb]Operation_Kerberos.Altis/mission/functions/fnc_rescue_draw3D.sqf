/*
    Author: Dorbedo
    
    Description:
        3DIcons
*/
#include "script_component.hpp"
SCRIPT(rescue_draw3D);
CHECK(!hasInterface)
private["_id"];

_id = addMissionEventHandler ["draw3D",{ 
    private["_root","_zoom"];
    _root = parsingNamespace getVariable "D_ROOTDIR";
    _zoom = round(([0.5,0.5] distance worldToScreen positionCameraToWorld [0,1.05,1]) * (getResolution select 5));
    if(player distance (getMarkerPos "rescue_marker")<40)then{
        private ["_spawnPos","_sizeicon"];
        _spawnPos = (getMarkerPos "rescue_marker");
        _spawnPos set[2,1.5];
        _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance (getMarkerPos "rescue_marker"))))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_rescue.paa",[1,0,0,1],_spawnPos,_sizeicon*2,_sizeicon*2,0,localize LSTRING(RESCUE_MARKER),0,(_sizeicon*0.015),"PuristaMedium"];
    };
}];