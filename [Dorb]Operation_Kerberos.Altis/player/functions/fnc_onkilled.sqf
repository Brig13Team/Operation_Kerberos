
#include "script_component.hpp"
SCRIPT(XEH_killed);

CHECK(!hasInterface)
_this params ["_unit"];

([_unit] call EFUNC(player,getLoadout)) params ["_loadout","_weaponsarray"];

missionNamespace setVariable [QGVAR(respawnLoadout),_loadout],
missionNamespace getVariable [QGVAR(Weapons),_weaponsarray];
