/*
	Author: Dorbedo

	Description:
		adds Arsenal to a unit
		can be called via unit-init
*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params [["_target",objNull,[objNull]],["_side",west,[west]]];

LOG_2(_target,_side);
CHECK(isNull _target)

If (isNil format[QGVAR(arsenalList_%1),str _side]) exitWith {
	LOG("arsenal not initialized");
	If (isNil QGVAR(arsenalList_script)) then {
		LOG("spawn generating");
		GVAR(arsenalList_script) = false;
		[_side] spawn FUNC(getSideRestrictedArsenal);
	};
	LOG("arsenal waiting");
	[{(!(isNil format[QGVAR(arsenalList_%1),(_this select 1)]))&&((!isNil QGVAR(postInit))&&{GVAR(postInit)})},FUNC(addSideRestrictedArsenal),[_target,_side]] call CBA_fnc_waitUntilAndExecute;
};
LOG("arsenal finished loading");
(missionNamespace getVariable format[QGVAR(arsenalList_%1),str _side]) params ["_addWeapons","_addMagazines","_addItems","_addBackpacks"];


_target setvariable ["bis_fnc_arsenal_condition",compile format["side _this == %1",_side],true];
[_target,_addWeapons,true,false] call bis_fnc_addVirtualWeaponCargo;
[_target,_addMagazines,true,false] call bis_fnc_addVirtualMagazineCargo;
[_target,_addItems,true,false] call bis_fnc_addVirtualItemCargo;
[_target,_addBackpacks,true,false] call bis_fnc_addVirtualBackpackCargo;
//[["AmmoboxServer",_target,true],"bis_fnc_arsenal",false] call bis_fnc_mp;
[_target] call FUNC(addArsenalAction);
