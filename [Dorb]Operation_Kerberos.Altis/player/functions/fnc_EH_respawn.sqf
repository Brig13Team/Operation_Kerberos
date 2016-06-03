#include "script_component.hpp"
SCRIPT(XEH_respawn);
If(!hasInterface)exitWith{};

private _respawntime = uiNamespace getVariable QEGVAR(interface,RespawnTime);
if (isNil "_respawntime") then {
    uiNamespace setVariable [QEGVAR(interface,RespawnTime),-1];
} else {
    uiNamespace setVariable [QEGVAR(interface,RespawnTime),CBA_missionTime];
};

["restart"] spawn FUNC(grouptracker);

ISNILS(GVAR(respawn_fnc),[]);
{
    _this spawn compile _x;
}forEach GVAR(respawn_fnc);

ISNILS(EGVAR(mission,intel_obj),[]);
{
    if (alive _x) then {
        removeAllActions _x;
        [_x] spawn EFUNC(mission,stadt_found_intel);
    };
}forEach EGVAR(mission,intel_obj);