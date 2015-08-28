/*
    Author: Dorbedo

    Description:
        3DIcons
*/
#include "script_component.hpp"
SCRIPT(spawn_draw3D);
CHECK(!hasInterface)
private["_id"];

_id = addMissionEventHandler ["draw3D",{
    private["_root","_zoom"];
    _root = parsingNamespace getVariable "D_ROOTDIR";
    _zoom = round(([0.5,0.5] distance worldToScreen positionCameraToWorld [0,1.05,1]) * (getResolution select 5));
    if(player distance (getPos fahrzeuge)<15)then{
        private ["_spawnPos","_sizeicon"];
        _spawnPos = getPosATL fahrzeuge;
        _spawnPos set[2,1];
        _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance fahrzeuge)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_tank.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize "STR_DORB_SPAWN_VEHICLE",0,(_sizeicon*0.015),"PuristaMedium"];
    };
    if(player distance (getPos luftfahrzeuge)<15)then{
        private ["_spawnPos","_sizeicon"];
        _spawnPos = getPosATL luftfahrzeuge;
        _spawnPos set[2,1];
        _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance luftfahrzeuge)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_heli.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize "STR_DORB_SPAWN_AIR",0,(_sizeicon*0.015),"PuristaMedium"];
    };
    if(player distance (getPos logistik)<15)then{
        private ["_spawnPos","_sizeicon"];
        _spawnPos = getPosATL logistik;
        _spawnPos set[2,1];
        _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance logistik)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_logistik.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize "STR_DORB_SPAWN_LOGISTIC",0,(_sizeicon*0.015),"PuristaMedium"];
    };
    if(player distance (getPos drohnen)<15)then{
        private ["_spawnPos","_sizeicon"];
        _spawnPos = getPosATL drohnen;
        _spawnPos set[2,1];
        _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance drohnen)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_drone.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize "STR_DORB_SPAWN_DRONES",0,(_sizeicon*0.015),"PuristaMedium"];
    };
    if(player distance (getPos marine)<15)then{
        private ["_spawnPos","_sizeicon"];
        _spawnPos = getPosASL marine;
        _spawnPos set[2,4.3];
        _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance marine)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_harbour.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize "STR_DORB_SPAWN_WATER",0,(_sizeicon*0.015),"PuristaMedium"];
    };
}];