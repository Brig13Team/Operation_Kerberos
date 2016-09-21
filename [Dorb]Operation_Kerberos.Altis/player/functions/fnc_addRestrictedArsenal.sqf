/*
	Author: Dorbedo

	Description:
		adds Arsenal to a unit
		can be called via unit-init
*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params [["_target",objNull,[objNull]]];


LOG_1(_target);
CHECK(isNull _target)

If (isNil QGVAR(arsenalList_Full)) exitWith {
	LOG("arsenal not initialized");
	If (isNil QGVAR(arsenalList_script)) then {
		LOG("spawn generating");
		GVAR(arsenalList_script) = false;
		[] spawn FUNC(getRestrictedArsenal);
	};
	LOG("arsenal waiting");
	[{(!(isNil QGVAR(arsenalList_Full)))&&((!isNil QGVAR(postInit))&&{GVAR(postInit)})},FUNC(addRestrictedArsenal),[_target]] call CBA_fnc_waitUntilAndExecute;
};
LOG("arsenal finished");
GVAR(arsenalList_Full) params ["_addWeapons","_addMagazines","_addItems","_addBackpacks"];

[_target,_addWeapons,true,false] call bis_fnc_addVirtualWeaponCargo;
[_target,_addMagazines,true,false] call bis_fnc_addVirtualMagazineCargo;
[_target,_addItems,true,false] call bis_fnc_addVirtualItemCargo;
[_target,_addBackpacks,true,false] call bis_fnc_addVirtualBackpackCargo;
//[["AmmoboxServer",_target,true],"bis_fnc_arsenal",false] call bis_fnc_mp;
[_target] call FUNC(addArsenalAction);
