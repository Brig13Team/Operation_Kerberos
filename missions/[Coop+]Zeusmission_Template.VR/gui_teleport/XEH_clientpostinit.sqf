/*
    Author: Dorbedo

    Description:
        postinit client
*/
#define INCLUDE_GUI
#include "script_component.hpp"
CHECK(!hasInterface)

GVAR(teleport_lead_active) = true;

switch (str(side player)) do {
    case "WEST" : {
        // Position as Array or code, The Name wich will be displayed ,teleporter Type ("air","infanterie","sea","default"), condition, parameter for condition
        [getMarkerPos "respawn_west",localize LSTRING(BASE),"infanterie",{true},[]] call FUNC(registerTeleportTarget);
        // Position as Array or code, The Name wich will be displayed ,teleporter Type ("air","infanterie","sea","default"), condition, parameter for condition
        [{(ace_player distance2D (getMarkerPos "respawn_west")) < 300},localize LSTRING(BASE),["default","infanterie","ship"],{true},[]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_west_marina",localize LSTRING(MARINA),["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_west_marina"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_west_marina",localize LSTRING(MARINA),"infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_west_marina"]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_west_logistics",localize LSTRING(LOGISTIC),["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_west_logistics"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_west_logistics",localize LSTRING(LOGISTIC),"infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_west_logistics"]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_west_vehicles",localize LSTRING(VEHICLES),["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_west_vehicles"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_west_vehicles",localize LSTRING(VEHICLES),"infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_west_vehicles"]] call FUNC(registerTeleportPosition);

    };
    case "EAST" : {
        [getMarkerPos "respawn_east",localize LSTRING(BASE),"infanterie",{true},[]] call FUNC(registerTeleportTarget);
        [{(ace_player distance2D (getMarkerPos "respawn_east")) < 300},localize LSTRING(BASE),["default","infanterie","ship"],{true},[]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_east_marina",localize LSTRING(MARINA),["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_east_marina"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_east_marina",localize LSTRING(MARINA),"infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_east_marina"]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_east_logistics",localize LSTRING(LOGISTIC),["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_east_logistics"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_east_logistics",localize LSTRING(LOGISTIC),"infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_east_logistics"]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_east_vehicles",localize LSTRING(VEHICLES),["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_east_vehicles"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_east_vehicles",localize LSTRING(VEHICLES),"infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_east_vehicles"]] call FUNC(registerTeleportPosition);
    };
    case "GUER" : {
        [getMarkerPos "respawn_guerilla",localize LSTRING(BASE),"infanterie",{true},[]] call FUNC(registerTeleportTarget);
        [{(ace_player distance2D (getMarkerPos "respawn_guerilla")) < 300},localize LSTRING(BASE),["default","infanterie","ship"],{true},[]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_resistance_marina",localize LSTRING(MARINA),["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_resistance_marina"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_resistance_marina",localize LSTRING(MARINA),"infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_resistance_marina"]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_resistance_logistics",localize LSTRING(LOGISTIC),["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_resistance_logistics"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_resistance_logistics",localize LSTRING(LOGISTIC),"infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_resistance_logistics"]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_resistance_vehicles",localize LSTRING(VEHICLES),["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_resistance_vehicles"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_resistance_vehicles",localize LSTRING(VEHICLES),"infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_resistance_vehicles"]] call FUNC(registerTeleportPosition);
    };
};


[
    localize LSTRING(TELEPORT),
    "NONE",
    (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_teleport.paa',
    {createDialog QAPP(dialog);},
    {[ace_player] call FUNC(canOpenMenu);},
    []
] call EFUNC(gui_main,addApp);

[
    QGVAR(teleporterIcon),
    (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_teleport.paa',
    {[] call FUNC(canOpenMenu)},
    []
] call EFUNC(gui,addNotification);


/*
 * Teleport
 *
*/
GVARMAIN(missiontime) = CBA_missiontime;
[
    {!isNil QGVARMAIN(missionkey)},
    {
        // the missionkey transfered from the Server
        private _serverkey = GVARMAIN(missionkey);
        // prevent just to just disconnect and reconnect to get a free teleport
        private _localKey = uiNamespace getVariable [QGVARMAIN(missionkey),""];
        // check if the player was already on the server -> he has the same key as the server
        // if he doen't have the variable, he is new, or has cleared his profileNamespace, so no free teleport
        If (_localKey isEqualTo "") then {
            _localKey = profileNamespace getVariable [QGVARMAIN(missionkey),"no free teleport"];
        };
        If (_serverkey isEqualTo _localKey) then {
            // the client has already been on the server -> possible gamecrash. gets a free teleport to group up with squad
            GVAR(freeTeleport) = true;
        }else{
            GVAR(freeTeleport) = false;
            profileNamespace setVariable [QGVARMAIN(missionkey),_serverkey];
            uiNamespace setVariable [QGVARMAIN(missionkey),_serverkey];
        };

    }
] call CBA_fnc_waitUntilAndExecute;
