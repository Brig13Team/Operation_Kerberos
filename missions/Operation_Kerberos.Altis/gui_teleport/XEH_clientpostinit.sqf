/*
    Author: Dorbedo

    Description:
        postinit client
*/
#define INCLUDE_GUI
#include "script_component.hpp"
CHECK(!hasInterface)

[
    getMarkerPos GVARMAIN(RESPAWNMARKER), // Position as Array or code
    localize LSTRING(BASE), // The Name wich will be displayed
    "infanterie", // teleporter Type ("air","infanterie","sea","default")
    {true}, // condition
    [] // parameter for condition
] call FUNC(registerTeleportTarget);

[
    {
        (ace_player distance2D (getMarkerPos GVARMAIN(RESPAWNMARKER))) < 300
    }, // Position as Array or code
    localize LSTRING(BASE), // The Name wich will be displayed
    ["default","infanterie","ship"], // teleporter Type ("air","infanterie","sea","default")
    {true}, // condition
    [] // parameter for condition
] call FUNC(registerTeleportPosition);

[getMarkerPos "bay_east",localize LSTRING(BAY_EAST),["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "bay_east"]] call FUNC(registerTeleportTarget);
[getMarkerPos "bay_east_sea",localize LSTRING(BAY_EAST),"ship",{!(_this call FUNC(nearEnemys))},[getMarkerPos "bay_east_sea"]] call FUNC(registerTeleportTarget);
[getMarkerPos "bay_east",localize LSTRING(BAY_EAST),"infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "bay_east"]] call FUNC(registerTeleportPosition);

[getMarkerPos "bay_west",localize LSTRING(BAY_WEST),["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "bay_west"]] call FUNC(registerTeleportTarget);
[getMarkerPos "bay_west_sea",localize LSTRING(BAY_WEST),"ship",{!(_this call FUNC(nearEnemys))},[getMarkerPos "bay_west_sea"]] call FUNC(registerTeleportTarget);
[getMarkerPos "bay_west",localize LSTRING(BAY_WEST),"infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "bay_west"]] call FUNC(registerTeleportPosition);

[getMarkerPos "bay_north",localize LSTRING(BAY_NORTH),["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "bay_north"]] call FUNC(registerTeleportTarget);
[getMarkerPos "bay_north",localize LSTRING(BAY_NORTH),"infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "bay_north"]] call FUNC(registerTeleportPosition);

[getMarkerPos "bay_south",localize LSTRING(BAY_SOUTH),["default","infanterie"],{!(_this call FUNC(nearEnemys))},[getMarkerPos "bay_south"]] call FUNC(registerTeleportTarget);
[getMarkerPos "bay_south_sea",localize LSTRING(BAY_SOUTH),"ship",{!(_this call FUNC(nearEnemys))},[getMarkerPos "bay_south_sea"]] call FUNC(registerTeleportTarget);
[getMarkerPos "bay_south",localize LSTRING(BAY_SOUTH),"infanterie",{!(_this call FUNC(nearEnemys))},[getMarkerPos "bay_south"]] call FUNC(registerTeleportPosition);


If (((getMarkerpos "respawn_west_land") distance2D [0,0,0])>100) then {
    [getMarkerPos "respawn_west_land",localize LSTRING(BAY_TONOS),["default","infanterie"],{true},[]] call FUNC(registerTeleportTarget);
    [getMarkerPos "respawn_west_land",localize LSTRING(BAY_TONOS),["default","infanterie"],{true},[]] call FUNC(registerTeleportPosition);
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
