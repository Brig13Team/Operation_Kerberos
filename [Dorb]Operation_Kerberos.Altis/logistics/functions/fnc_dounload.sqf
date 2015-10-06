/*
	Author: Dorbedo
	
	Description:
		unloads Object
		
	Parameter(s):
		0 : OBJECT - Target
		
	Returns:
		BOOL
*/
#include "script_component.hpp"
SCRIPT(dounload);
#define LOADTIME 3
params["_target",["_isdrop",false,[false]]];

CHECK(GETVAR(player,GVAR(isloading),false))

SETVAR(player,GVAR(isloading),true);
GVAR(isloading_pos) = getPos player;
private["_anim"];
_anim = getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "hatch_isclosed");
If (!(_anim isEqualTo "")) then {
	If (_target call compile _anim) then {
		_target call (compile (getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "hatch_open")));
		private "_isopened";
		_isopened = compile (getText(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "hatch_isopened"));
		waitUntil{uisleep 0.2;_target call _isopened;};
	};
};
_unloadcondition = {true};
If !(_isdrop) then {
	_unloadcondition = {(((getPos player) distance GVAR(isloading_pos))<1)};
};
[
	LOADTIME,
	_unloadcondition,
	{_this call FUNC(unload);SETVAR(player,GVAR(isloading),false);},
	{SETVAR(player,GVAR(isloading),false);},
	[_target]
] call EFUNC(interface,disp_progressbar);

