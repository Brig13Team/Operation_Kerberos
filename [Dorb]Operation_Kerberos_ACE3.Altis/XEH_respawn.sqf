#include "script_component.hpp"
scriptname "dorb\kerberos\XEH_respawn";
If(!hasInterface)exitWith{};


["restart"] spawn FM(grouptracker);

ISNILS(DORB_RESPAWN_FNC,[]);
{
	_this spawn compile _x;
}forEach DORB_RESPAWN_FNC;

ISNILS(DORB_INTEL_OBJ,[]);
{
	if (alive _x) then {
		removeAllActions _x;
		[_x] spawn FM(obj_stadt_found_intel);
	};
}forEach DORB_INTEL_OBJ;