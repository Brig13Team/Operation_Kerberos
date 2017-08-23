/*
    Author: Dorbedo

    Description:
        postinit client
*/
#define INCLUDE_GUI
#include "script_component.hpp"
CHECK(!hasInterface)

GVAR(teleport_lead_active) = true;

private _exit = false;
switch (side player) do {
    case east : {
        If ((getMarkerPos "respawn_east") isEqualTo [0,0,0]) exitWith {_exit = true;};
        [getMarkerPos "respawn_east",localize LSTRING(BASE),"infanterie",{true},[]] call FUNC(registerTeleportTarget);
        [{(ace_player distance2D (getMarkerPos "respawn_east")) < 300},localize LSTRING(BASE),["default","infanterie","ship"],{true},[]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_east_1","Teleport 1",["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_east_1"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_east_1","Teleport 1","infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_east_1"]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_east_2","Teleport 2",["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_east_2"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_east_2","Teleport 2","infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "bay_teleport_east_2west"]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_east_3","Teleport 3",["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_east_3"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_east_3","Teleport 3","infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_east_3"]] call FUNC(registerTeleportPosition);
    };
    case resistance : {
        If ((getMarkerPos "respawn_guerilla") isEqualTo [0,0,0]) exitWith {_exit = true;};
        [getMarkerPos "respawn_guerilla",localize LSTRING(BASE),"infanterie",{true},[]] call FUNC(registerTeleportTarget);
        [{(ace_player distance2D (getMarkerPos "respawn_guerilla")) < 300},localize LSTRING(BASE),["default","infanterie","ship"],{true},[]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_guerilla_1","Teleport 1",["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_guerilla_1"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_guerilla_1","Teleport 1","infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_guerilla_1"]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_guerilla_2","Teleport 2",["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_guerilla_2"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_guerilla_2","Teleport 2","infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_guerilla_2"]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_guerilla_3","Teleport 3",["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_guerilla_3"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_guerilla_3","Teleport 3","infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_guerilla_3"]] call FUNC(registerTeleportPosition);
    };
    default {
        If ((getMarkerPos "respawn_west") isEqualTo [0,0,0]) exitWith {_exit = true;};
        [getMarkerPos "respawn_west",localize LSTRING(BASE),"infanterie",{true},[]] call FUNC(registerTeleportTarget);
        [{(ace_player distance2D (getMarkerPos "respawn_west")) < 300},localize LSTRING(BASE),["default","infanterie","ship"],{true},[]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_west_1","Teleport 1",["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_west_1"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_west_1","Teleport 1","infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_west_1"]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_west_2","Teleport 2",["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_west_2"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_west_2","Teleport 2","infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_west_2"]] call FUNC(registerTeleportPosition);

        [getMarkerPos "teleport_west_3","Teleport 3",["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_west_3"]] call FUNC(registerTeleportTarget);
        [getMarkerPos "teleport_west_3","Teleport 3","infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "teleport_west_3"]] call FUNC(registerTeleportPosition);
    };
};

if (_exit) exitWith {};

[
    localize LSTRING(TELEPORT),
    {createDialog QAPP(dialog);},
    {[] call FUNC(canOpenMenu)},
    ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(icon,icon_teleport)),
    3
] call EFUNC(gui_echidna,addApp);

[
    QGVAR(teleporterIcon),
    (parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(icon,icon_teleport),
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
