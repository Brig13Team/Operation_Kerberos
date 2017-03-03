/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"

CHECK(!hasInterface)

GVAR(cratelogics) = [];

/// get the crate-logics

for "_i" from 1 to 9 do {
    private _logicname = format["cratespawner%1",_i];
    if !(isNil _logicname) then {
        GVAR(cratelogics) pushBack (missionNamespace getVariable [_logicname,objNull]);
    };
};

[
    QGVAR(crateIcon),
    (parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(icon,icon_robot),
    {[ace_player] call FUNC(canOpenMenu);},
    []
] call EFUNC(gui,addNotification);

[
    localize LSTRING(header),
    {[] call FUNC(OpenMenu);},
    {[player] call FUNC(canOpenMenu);},
    ((parsingNamespace getVariable ["MISSION_ROOT",""]) + QEPAAPATH(icon,icon_robot)),
    3
] call EFUNC(gui_echidna,addApp);
