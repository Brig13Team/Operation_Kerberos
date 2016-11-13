/*
    Author: Dorbedo

    Description:
        adds Arsenal to a unit
        can be called via unit-init
*/

#include "script_component.hpp"
_this params [["_target",objNull,[objNull]]];

CHECK(isNull _target)

If (isNil QGVAR(arsenalList_Full)) exitWith {
    If (isNil QGVAR(arsenalList_script)) then {
        GVAR(arsenalList_script) = false;
        [] spawn FUNC(getRestrictedArsenal);
    };
    [{(!(isNil QGVAR(arsenalList_Full)))&&((!isNil QGVAR(postInit))&&{GVAR(postInit)})},FUNC(addRestrictedArsenal),[_target]] call CBA_fnc_waitUntilAndExecute;
};
GVAR(arsenalList_Full) params ["_addWeapons","_addMagazines","_addItems","_addBackpacks","_fixWeapons","_fixMagazines","_fixItems","_fixBackpacks"];

[_target,_addWeapons,true,false] call bis_fnc_addVirtualWeaponCargo;
[_target,_addMagazines,true,false] call bis_fnc_addVirtualMagazineCargo;
[_target,_addItems,true,false] call bis_fnc_addVirtualItemCargo;
[_target,_addBackpacks,true,false] call bis_fnc_addVirtualBackpackCargo;
//[["AmmoboxServer",_target,true],"bis_fnc_arsenal",false] call bis_fnc_mp;
private _fix = _target getVariable ["bis_addVirtualWeaponCargo_cargo",[[],[],[],[]]];
{
    private _index = _forEachIndex;
    {
        (_fix select _index) pushBackUnique _x;
    } forEach _x;
} forEach [_fixItems,_fixWeapons,_fixMagazines,_fixBackpacks];
_target setVariable ["bis_addVirtualWeaponCargo_cargo",_fix,true];

[_target] call FUNC(addArsenalAction);
