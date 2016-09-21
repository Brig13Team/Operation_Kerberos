/*
 * Author: Dorbedo
 * checks if unit hase some disallowed Items
 *
 * Arguments:
 * 0: Unit <Object>
 *
 * Return Value:
 * has not allowedItem <BOOL>
 *
 * Public: Yes
 */
#include "script_component.hpp"

_this params [["_unit",objNull,[objNull]]];
if (isNull _unit) exitWith {false};
private _hasdisallowedItem = false;

if (_unit isKindOf "Man") then {
    private _disallowedItems = getArray (missionConfigFile >> QGVAR(arsenal) >> format ["%1",EGVAR(playerside)] >> "blacklist" >> "items");
    private _disallowedAmmo = getArray (missionConfigFile >> QGVAR(arsenal) >> format ["%1",EGVAR(playerside)] >> "blacklist" >> "items");

    ({_x in } count (assignedItems _unit) >0) then {_hasdisallowedItem = true;};

    backpackItems unit
}else{


};
_hasdisallowedItem;
