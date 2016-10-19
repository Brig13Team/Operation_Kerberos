/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"
CHECK(!hasInterface)

GVAR(spawnpositions) = HASH_CREATE;

{
    HASH_SET(GVAR(spawnpositions),_x,[]);
} forEach ["vehicles","drones","air","air_light","boat","logistic"];

{
    _x params ["_spawntype","_spawnPos"];
    _spawnPos set[2,0];

    HASH_GET(GVAR(spawnpositions),_spawntype) pushBack _spawnPos;
} forEach [
///  spawntyp,      spawnposition,                  actionlocation
    ["vehicles",    getMarkerPos "spawn_vehicles"],
    ["drones",      getMarkerPos "spawn_drones"],
    ["air",         getMarkerPos "spawn_air"],
    ["air_light",   getMarkerPos "spawn_air_light"],
    ["boat",        getMarkerPos "spawn_boat"],
    ["logistic",    getMarkerPos "spawn_logistic"],
    ["logistic",    getMarkerPos "spawn_logistic2"]
];


{
    _x params ["_spawntype","_pic"];
    private _ACE_Action = [
        format [QGVAR(%1Action),_spawntype],
        localize format[LSTRING(%1),_spawntype],
        format[QEPAAPATH(icon,icon_%1),_pic],
        {[_spawntype] call FUNC(open);},
        {[player,_spawntype] call FUNC(canOpenMenu);}
    ] call ace_interact_menu_fnc_createAction;
    [ACE_Player, 1, ["ACE_SelfActions", QGVAR(selfactiongroup)], _ACE_Action] call ace_interact_menu_fnc_addActionToObject;
} foreach [
    ["vehicles","tank"],
    ["drones","drone"],
    ["air","heli"],
    ["air_light","heli"],
    ["boat","harbour"],
    ["logistic","logistik"]
];

/*
    [["<t size='1.5' shadow='2' color='#FF860F'>"   +localize LSTRING(VEHICLE_DESC) +"</t>",    {_this call FUNC(Open);}, [localize LSTRING(VEHICLE),    fahrzeuge       ], 5, false, true, "","alive _target and (getposatl player distance getposatl fahrzeuge) < 4"]] call CBA_fnc_addPlayerAction;
    [["<t size='1.5' shadow='2' color='#FF860F'>"   +localize LSTRING(DRONES_DESC)  +"</t>",    {_this call FUNC(Open);}, [localize LSTRING(DRONES),     drohnen         ], 5, false, true, "","alive _target and (getposatl player distance getposatl drohnen) < 4"]] call CBA_fnc_addPlayerAction;
    [["<t size='1.5' shadow='2' color='#FF860F'>"   +localize LSTRING(AIR_DESC)     +"</t>",    {_this call FUNC(Open);}, [localize LSTRING(AIR),        luftfahrzeuge   ], 5, false, true, "","alive _target and (getposatl player distance getposatl luftfahrzeuge) < 4"]] call CBA_fnc_addPlayerAction;
    [["<t size='1.5' shadow='2' color='#FF860F'>"   +localize LSTRING(WATER_DESC)   +"</t>",    {_this call FUNC(Open);}, [localize LSTRING(WATER),      marine          ], 5, false, true, "","alive _target and (getposatl player distance getposatl marine) < 4"]] call CBA_fnc_addPlayerAction;
    [["<t size='1.5' shadow='2' color='#FF860F'>"   +localize LSTRING(LOGISTIC_DESC)+"</t>",    {_this call FUNC(Open);}, [localize LSTRING(LOGISTIC),   logistik        ], 5, false, true, "","alive _target and (getposatl player distance getposatl logistik) < 4"]] call CBA_fnc_addPlayerAction;
*/

private _id = addMissionEventHandler ["draw3D",{
    private _root = parsingNamespace getVariable ["MISSION_ROOT",""];
    private _zoom = round(([0.5,0.5] distance worldToScreen positionCameraToWorld [0,1.05,1]) * (getResolution select 5));
    if(player distance (getPos fahrzeuge)<15)then{
        private _spawnPos = getPosATL fahrzeuge;
        _spawnPos set[2,1];
        private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance fahrzeuge)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_tank.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize LSTRING(VEHICLE),0,(_sizeicon*0.015),"PuristaMedium"];
    };
    if(player distance (getPos luftfahrzeuge)<15)then{
        private _spawnPos = getPosATL luftfahrzeuge;
        _spawnPos set[2,1];
        private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance luftfahrzeuge)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_heli.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize LSTRING(AIR),0,(_sizeicon*0.015),"PuristaMedium"];
    };
    if(player distance (getPos logistik)<15)then{
        private _spawnPos = getPosATL logistik;
        _spawnPos set[2,1];
        private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance logistik)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_logistik.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize LSTRING(LOGISTIC),0,(_sizeicon*0.015),"PuristaMedium"];
    };
    if(player distance (getPos drohnen)<15)then{
        private _spawnPos = getPosATL drohnen;
        _spawnPos set[2,1];
        private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance drohnen)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_drone.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize LSTRING(DRONES),0,(_sizeicon*0.015),"PuristaMedium"];
    };
    if(player distance (getPos marine)<15)then{
        private _spawnPos = getPosASL marine;
        _spawnPos set[2,4.3];
        private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance marine)))*_zoom*6);
        drawIcon3D [_root+"data\icon\icon_harbour.paa",[1,0.4,0,1],_spawnPos,_sizeicon,_sizeicon,0,localize LSTRING(WATER),0,(_sizeicon*0.015),"PuristaMedium"];
    };
}];
