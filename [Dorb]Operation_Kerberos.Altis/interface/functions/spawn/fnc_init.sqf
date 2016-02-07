/*
    Author: Dorbedo

    Description:
        3DIcons
*/
#include "script_component.hpp"
CHECK(!hasInterface)

[["<t size='1.5' shadow='2' color='#FF860F'>"   +localize LSTRING(SPAWN_VEHICLE_DESC) +"</t>",    {_this call FUNC(spawn_Open);}, [localize LSTRING(SPAWN_VEHICLE),    fahrzeuge       ], 5, false, true, "","alive _target and (getposatl player distance getposatl fahrzeuge) < 4"]] call CBA_fnc_addPlayerAction;
[["<t size='1.5' shadow='2' color='#FF860F'>"   +localize LSTRING(SPAWN_DRONES_DESC)  +"</t>",    {_this call FUNC(spawn_Open);}, [localize LSTRING(SPAWN_DRONES),     drohnen         ], 5, false, true, "","alive _target and (getposatl player distance getposatl drohnen) < 4"]] call CBA_fnc_addPlayerAction;
[["<t size='1.5' shadow='2' color='#FF860F'>"   +localize LSTRING(SPAWN_AIR_DESC)     +"</t>",    {_this call FUNC(spawn_Open);}, [localize LSTRING(SPAWN_AIR),        luftfahrzeuge   ], 5, false, true, "","alive _target and (getposatl player distance getposatl luftfahrzeuge) < 4"]] call CBA_fnc_addPlayerAction;
[["<t size='1.5' shadow='2' color='#FF860F'>"   +localize LSTRING(SPAWN_WATER_DESC)   +"</t>",    {_this call FUNC(spawn_Open);}, [localize LSTRING(SPAWN_WATER),      marine          ], 5, false, true, "","alive _target and (getposatl player distance getposatl marine) < 4"]] call CBA_fnc_addPlayerAction;
[["<t size='1.5' shadow='2' color='#FF860F'>"   +localize LSTRING(SPAWN_LOGISTIC_DESC)+"</t>",    {_this call FUNC(spawn_Open);}, [localize LSTRING(SPAWN_LOGISTIC),   logistik        ], 5, false, true, "","alive _target and (getposatl player distance getposatl logistik) < 4"]] call CBA_fnc_addPlayerAction;

private _id = addMissionEventHandler ["draw3D",{
    private _root = parsingNamespace getVariable "D_ROOTDIR";
    private _zoom = round(([0.5,0.5] distance worldToScreen positionCameraToWorld [0,1.05,1]) * (getResolution select 5));
    if(player distance (getPos fahrzeuge)<15)then{
        private _spawnPos = getPosATL fahrzeuge;
        _spawnPos set[2,1];
        private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance fahrzeuge)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_tank.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize LSTRING(SPAWN_VEHICLE),0,(_sizeicon*0.015),"PuristaMedium"];
    };
    if(player distance (getPos luftfahrzeuge)<15)then{
        private _spawnPos = getPosATL luftfahrzeuge;
        _spawnPos set[2,1];
        private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance luftfahrzeuge)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_heli.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize LSTRING(SPAWN_AIR),0,(_sizeicon*0.015),"PuristaMedium"];
    };
    if(player distance (getPos logistik)<15)then{
        private _spawnPos = getPosATL logistik;
        _spawnPos set[2,1];
        private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance logistik)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_logistik.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize LSTRING(SPAWN_LOGISTIC),0,(_sizeicon*0.015),"PuristaMedium"];
    };
    if(player distance (getPos drohnen)<15)then{
        private _spawnPos = getPosATL drohnen;
        _spawnPos set[2,1];
        private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance drohnen)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_drone.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize LSTRING(SPAWN_DRONES),0,(_sizeicon*0.015),"PuristaMedium"];
    };
    if(player distance (getPos marine)<15)then{
        private _spawnPos = getPosASL marine;
        _spawnPos set[2,4.3];
        private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance marine)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_harbour.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize LSTRING(SPAWN_WATER),0,(_sizeicon*0.015),"PuristaMedium"];
    };
}];