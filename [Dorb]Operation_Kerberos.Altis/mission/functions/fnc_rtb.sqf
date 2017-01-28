/*
    Author: Dorbedo
    Description:
    Creates Mission "Return to Base".

    Parameter(s):
        0 :    ARRAY - Position der letzten AO
        1 : STRING - Taskname

    Returns:
    BOOL
*/
#include "script_component.hpp"
_this params["_position", "_taskID"];
private ["_position_home", "_player", "_tasks", "_data", "_taskVar"];
private _position_home = getMarkerPos GVARMAIN(RESPAWNMARKER);

//////////////////////////////////////////////////
////// Nachricht anzeigen                      /////
//////////////////////////////////////////////////

ISNILS(taskcancel,false);
If (taskcancel) then {
    sleep 150;
    taskcancel=false;
}else{
    sleep 30;
};

[LSTRING(RTB),[LSTRING(RTB_START_1)],"data\icon\icon_base.paa",false] call EFUNC(interface,disp_info_global);

//////////////////////////////////////////////////
////// Nebenmissionen beenden                 /////
//////////////////////////////////////////////////
["MISSION_ENDSEC",_taskID] call CBA_fnc_localEvent;

/*
_sideMission = missionNamespace getVariable [QGVAR(current_sidemission),""];
if (!(_sideMission isEqualTo "")) then {
    [_sideMission,"CANCELED",false] call BIS_fnc_taskSetState;
    missionNamespace setVariable [QGVAR(current_sidemission),""];
};
*/

//////////////////////////////////////////////////
////// Überprüfung + Ende                      /////
//////////////////////////////////////////////////
private _taskarray = [
    15,
    "",
    {
        private _allPlayers = call EFUNC(common,players);
        private _a = {(_x distance (_this select 0)) < 300} count _allPlayers;
        If (_a == (count _allPlayers)) then {true}else{false};
    },
    [_position_home],
    {true},
    {
        [LSTRING(RTB),[LSTRING(RTB_FINISHED),LSTRING(RTB_FINISHED2)],"data\icon\icon_base.paa",false] call EFUNC(interface,disp_info_global);
        [_position, 2000] spawn EFUNC(common,cleanup_big);
    }
];

_taskarray call FUNC(taskhandler);
[LSTRING(RTB),[LSTRING(RTB_FINISHED),LSTRING(RTB_FINISHED2)],"data\icon\icon_base.paa",false] call EFUNC(interface,disp_info_global);
[_position, 2000] spawn EFUNC(common,cleanup_big);
