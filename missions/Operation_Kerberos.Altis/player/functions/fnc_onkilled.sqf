
#include "script_component.hpp"
SCRIPT(XEH_killed);

CHECK(!hasInterface)
_this params ["_unit"];

CHECK((!(local _unit))||{!(isPlayer _unit)})


([_unit] call EFUNC(player,getLoadout)) params ["_loadout","_weaponsarray"];

If (!isNil QEFUNC(patch_acre,cleanLoadout)) then {
    _loadout = [_loadout] call EFUNC(patch_acre,cleanLoadout);
};

missionNamespace setVariable [QGVAR(respawnLoadout),_loadout],
missionNamespace getVariable [QGVAR(Weapons),_weaponsarray];
