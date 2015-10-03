#include "script_component.hpp"
SCRIPT(XEH_respawn);
If(!hasInterface)exitWith{};

if (GETMVAR(EGVAR(interface,respawntime),-1) > 0) then { SETMVAR(EGVAR(interface,respawntime),diag_tickTime); };

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