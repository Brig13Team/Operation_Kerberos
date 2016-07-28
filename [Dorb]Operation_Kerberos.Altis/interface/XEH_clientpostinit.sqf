/*
    Author: Dorbedo
    
    Description:
        postinit client
*/
#include "script_component.hpp"
QEGVAR(mission,endzeit) addPublicVariableEventHandler {[] spawn FUNC(disp_timer)};
[] spawn FUNC(disp_timer);

// backwards comp
[QGVAR(dispInfo),{
	_this params ["_title","_content"];
	private _text = _content;
	If (_content isEqualType []) then {
		_text = _content select 0;
		_content deleteAt 0;
		{_text append "\n";_text append str _x;} forEach _content;
	};
	[_title,_text] spawn FUNC(message)
] call CBA_fnc_addEventHandler;
[QGVAR(dispMessage),{_this spawn FUNC(message)}] call CBA_fnc_addEventHandler;
[QGVAR(message),{_this spawn FUNC(message)}] call CBA_fnc_addEventHandler;
[] call FUNC(teleport_init);
[] call FUNC(spawn_init);
[] call FUNC(crate_init);