/**
 * Author: Dorbedo
 * clears the cargo if an unit
 *
 * Arguments:
 * 0: <OBJECT> the object
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_object", objNull, [objNull]]];

if (isNull _object) exitWith {};

clearWeaponCargoGlobal _object;
clearItemCargoGlobal _object;
clearMagazineCargoGlobal _object;
clearBackpackCargoGlobal _object;
