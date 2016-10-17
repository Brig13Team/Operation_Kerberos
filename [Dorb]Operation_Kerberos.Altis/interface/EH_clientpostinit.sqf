/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"
CHECK(!hasInterface)
QEGVAR(mission,endzeit) addPublicVariableEventHandler {[] spawn FUNC(disp_timer)};
[] spawn FUNC(disp_timer);

// backwards comp
[QGVAR(dispInfo),{
    _this params ["_title","_content"];
    private _text = _content;
    If (_content isEqualType []) then {
        _content = _content apply {if (isLocalized _x) then {localize _x}else{_x};};
        _text = _content joinString " <br />";
        /*_text = _content select 0;
        _content deleteAt 0;
        {_text append "\n";_text append str _x;} forEach _content;
        */
    };
    [_title,_text] spawn EFUNC(gui,message);}
] call CBA_fnc_addEventHandler;
[QGVAR(dispMessage),{_this spawn EFUNC(gui,message)}] call CBA_fnc_addEventHandler;
[QGVAR(message),{_this spawn EFUNC(gui,message)}] call CBA_fnc_addEventHandler;
[] call FUNC(teleport_init);
[] call FUNC(spawn_init);
[] call FUNC(crate_init);

If (ACTIVEMOD_TFAR) then {
    [["<t color='#FFFF00'>"+localize ELSTRING(interface,TFR_SHORT)+"</t>",{[]call EFUNC(interface,tfr_OpenMenu);},[],0.5,false,true,"","alive _target"]] call CBA_fnc_addPlayerAction;
};
