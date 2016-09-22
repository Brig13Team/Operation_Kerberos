/*
	Author: Dorbedo

	Description:
		adds Arsenal to a unit
		can be called via unit-init
*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params [["_target",objNull,[objNull]],["_side",west,[west]],["_onlyGear",false,[true]]];

CHECK(isNull _target)

If (isNil format[QGVAR(arsenalList_%1),str _side]) exitWith {
	If (isNil QGVAR(arsenalList_script)) then {
		GVAR(arsenalList_script) = false;
		[_side,_onlyGear] spawn FUNC(getSideRestrictedArsenal);
	};
	[{(!(isNil format[QGVAR(arsenalList_%1),(_this select 1)]))&&((!isNil QGVAR(postInit))&&{GVAR(postInit)})},FUNC(addSideRestrictedArsenal),[_target,_side]] call CBA_fnc_waitUntilAndExecute;
};
(missionNamespace getVariable format[QGVAR(arsenalList_%1),str _side]) params ["_addWeapons","_addMagazines","_addItems","_addBackpacks"];


_target setvariable ["bis_fnc_arsenal_condition",compile format["side _this == %1",_side],true];
[_target,_addWeapons,true,false] call bis_fnc_addVirtualWeaponCargo;
[_target,_addMagazines,true,false] call bis_fnc_addVirtualMagazineCargo;
[_target,_addItems,true,false] call bis_fnc_addVirtualItemCargo;
[_target,_addBackpacks,true,false] call bis_fnc_addVirtualBackpackCargo;
//[["AmmoboxServer",_target,true],"bis_fnc_arsenal",false] call bis_fnc_mp;
[_target] call FUNC(addArsenalAction);
