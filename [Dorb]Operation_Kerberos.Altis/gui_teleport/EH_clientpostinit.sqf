/*
    Author: Dorbedo

    Description:
        postinit client
*/
#define INCLUDE_GUI
#include "script_component.hpp"
CHECK(!hasInterface)

GVAR(teleporter) = HASH_CREATE;

/// Button 1
private _hash = HASH_CREATE;
HASH_SET(GVAR(teleporter),"button_1",_hash);
HASH_SET(_hash,"target",(getMarkerPos GVARMAIN(RESPAWNMARKER)));
HASH_SET(_hash,"name",localize LSTRING(BASE));
HASH_SET(_hash,"active",true);

/// Button 2
private _hash = HASH_CREATE;
HASH_SET(GVAR(teleporter),"button_2",_hash);
HASH_SET(_hash,"target",(getMarkerPos "teleport_vehicles"));
HASH_SET(_hash,"name",localize LSTRING(VEHICLES));
HASH_SET(_hash,"active",true);

/// Button 3
private _hash = HASH_CREATE;
HASH_SET(GVAR(teleporter),"button_3",_hash);
HASH_SET(_hash,"target",(getMarkerPos "teleport_luftwaffe"));
HASH_SET(_hash,"name",localize LSTRING(AIR));
HASH_SET(_hash,"active",true);

/// Button 4
private _hash = HASH_CREATE;
HASH_SET(GVAR(teleporter),"button_4",_hash);
HASH_SET(_hash,"target",(getMarkerPos "teleport_shooting"));
HASH_SET(_hash,"name",localize LSTRING(SHOOTING));
HASH_SET(_hash,"active",true);

/// Button 5
private _hash = HASH_CREATE;
HASH_SET(GVAR(teleporter),"button_5",_hash);
HASH_SET(_hash,"target",(getMarkerPos "teleport_hafen"));
HASH_SET(_hash,"name",localize LSTRING(MARINE));
HASH_SET(_hash,"active",true);

/// Button 6
private _hash = HASH_CREATE;
HASH_SET(GVAR(teleporter),"button_6",_hash);
HASH_SET(_hash,"target",(getMarkerPos "teleport_logistic"));
HASH_SET(_hash,"name",localize LSTRING(LOGISTIC));
HASH_SET(_hash,"active",true);

/// Button 7 -> teleport to lead
private _hash = HASH_CREATE;
HASH_SET(GVAR(teleporter),"button_7",_hash);
HASH_SET(_hash,"target",{_this call FUNC(lead);});
HASH_SET(_hash,"name",localize LSTRING(LEADER));
HASH_SET(_hash,"active",true);




GVAR(teleporterlogics) = [];

for "_i" from 1 to 9 do {
    if !(isNil (format["teleporter%1",_i])) then {
        //[["<t size='1.5' shadow='2' color='#F9FE44'>" +localize LSTRING(TELEPORT) +"</t>", {createDialog QAPP(dialog);}, [], 5, false, true, "",format["alive _target and (getposatl player distance getposatl teleporter%1) < 6",_i]]] call CBA_fnc_addPlayerAction;
        GVAR(teleporterlogics) pushBack (missionNamespace getVariable [format["teleporter%1",_i],objNull]);
    };
};

[
    QGVAR(teleporterIcon),
    (parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(icon,icon_teleport),
    {[ace_player] call FUNC(canOpenMenu);},
    []
] call EFUNC(gui,addNotification);
/*
private _id = addMissionEventHandler ["draw3D",{
    private _root = parsingNamespace getVariable "MISSION_ROOT";
    private _zoom = round(([0.5,0.5] distance worldToScreen positionCameraToWorld [0,1.05,1]) * (getResolution select 5));
    {
        If ((!isNull _x)&&(isNull curatorCamera)&&{(player distance (getPosATL _x))<25}) then {
            private _spawnPos = getPos _x;
            _spawnPos set[2,1.5];
            private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance _x)))*_zoom*6);
            //drawIcon3D [_root+"data\icon\icon_teleport.paa",[0.976,0.996,0.267,1],_spawnPos,_sizeicon*2,_sizeicon*2,0,localize LSTRING(TELEPORT),0,(_sizeicon*0.015),"PuristaMedium"];
            drawIcon3D [(parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(icon,icon_teleport),[0.976,0.996,0.267,1],_spawnPos,_sizeicon*2,_sizeicon*2,0,localize LSTRING(TELEPORT),0,(_sizeicon*0.015),"PuristaMedium"];
        };
    }forEach GVAR(teleporterlogics);
}];
*/
[
    localize LSTRING(TELEPORT),
    {createDialog QAPP(dialog);},
    {[] call FUNC(canOpenMenu)},
    ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(icon,icon_teleport)),
    3
] call EFUNC(gui_tablet,addApp);


/*
 * Teleport
 *
*/
[
    {!isNil QGVARMAIN(missionkeyServer)},
    {
        GVARMAIN(missionkey) = GVARMAIN(missionkeyServer);
        private _serverkey = GVARMAIN(missionkeyServer);
        private _serverkeyLocal = profileNamespace getVariable [QGVARMAIN(missionkeyServer),"NoKey"];
        If (_serverkey isEqualTo _serverkeyLocal) then {
            // the client has already been on the server -> possible crash
            GVARMAIN(missionkey) = "teleport allowed";
        }else{
            profileNamespace setVariable [QGVARMAIN(missionkeyServer),_serverkey];
        };

    }
] call CBA_fnc_waitUntilAndExecute;
