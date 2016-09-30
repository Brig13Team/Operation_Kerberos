#include "script_component.hpp"
SCRIPT(XEH_respawn);
If(!hasInterface)exitWith{};

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

If !(isNull _unit) then {
	[
		_unit,
		missionNamespace getVariable QGVAR(respawnLoadout),
		missionNamespace getVariable QGVAR(Weapons)
	] call FUNC(setLoadout);
};
