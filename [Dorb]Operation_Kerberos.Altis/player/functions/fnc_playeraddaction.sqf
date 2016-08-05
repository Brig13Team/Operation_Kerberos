/*
	Author: Dorbedo
	
	Description:
	
	
*/
#include "script_component.hpp"
SCRIPT(playeraddaction);
[["<t color='#FFFF00'>"+localize ELSTRING(interface,TFR_SHORT)+"</t>",{[]call EFUNC(interface,tfr_OpenMenu);},[],0.5,false,true,"","alive _target"]] call CBA_fnc_addPlayerAction;
[["<t color='#FFFF00'>Hilfe zu Verwundungen</t>",{createDialog QEGVAR(interface,wounds)},[],0.5,false,true,"","alive _target && (player distance (getMarkerPos 'respawn_west') < 250)"]] call CBA_fnc_addPlayerAction;
[["<t color='#FFFF00'>Hilfe zu Versorgung</t>",{createDialog QEGVAR(interface,treatment)},[],0.5,false,true,"","alive _target && (player distance (getMarkerPos 'respawn_west') < 250)"]] call CBA_fnc_addPlayerAction;

/*
If ((isClass(configFile >> "CfgPatches" >> "rhsusf_c_weapons"))) then {
	[["<t size='1.5' shadow='2' color='#ffffff'>"+localize LSTRING(ARSENAL_OPEN_DESC)+"</t>",{["Open",true] call RHS_fnc_arsenal;},[],4,false,true,"","alive _target and((getposatl player) distance (getposatl base))<50"]] call CBA_fnc_addPlayerAction;
}else{
	[["<t size='1.5' shadow='2' color='#ffffff'>"+localize LSTRING(ARSENAL_OPEN_DESC)+"</t>",{["Open",true] call BIS_fnc_arsenal;},[],4,false,true,"","alive _target and((getposatl player) distance (getposatl base))<50"]] call CBA_fnc_addPlayerAction;
};
*/