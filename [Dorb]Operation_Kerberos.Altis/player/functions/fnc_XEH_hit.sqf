#include "script_component.hpp"
_this spawn {
	scriptname "dorb\player\XEH_hit";
	If(!(isPlayer (_this select 0)))exitWith{};
	If(!(isPlayer (_this select 1)))exitWith{};
	If((_this select 0)==(_this select 1))exitWith{};
    [
        QGVAR(teamfire),
        _this
    ] call CBA_fnc_globalEvent;
};