#include "script_component.hpp"

If(!hasInterface)exitWith{};

player addAction ["<t color='#FFFF00'>"+localize "STR_DORB_TFR_SHORT"+"</t>",{[]call FM(ui_tfr_OpenMenu);},[],0.5,false,true,"","alive _target"];
player addaction ["<t size='1.5' shadow='2' color='#ffffff'>"+localize "STR_DORB_ARSENAL_OPEN_DESC"+"</t>",{["Open",true] call BIS_fnc_arsenal;},[],4,false,true,"","alive _target and((getposatl player) distance (getposatl base))<50"];

call FM(ui_teleport_addaction);
call FM(ui_spawn_addaction);
call FM(ui_crate_addaction);

["restart"] spawn FM(grouptracker);