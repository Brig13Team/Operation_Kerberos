#include "script_component.hpp"
SCRIPT(XEH_respawn);
If(!hasInterface)exitWith{};

if (time > 5) then { missionNamespace setVariable [format["dorb_interface_respawn_%1",getPlayerUID player],serverTime]; };

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