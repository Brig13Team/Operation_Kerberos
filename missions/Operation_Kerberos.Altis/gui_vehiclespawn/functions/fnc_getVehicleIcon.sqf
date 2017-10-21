/**
 * Author: Dorbedo
 * returns the vehicleIcon
 *
 * Arguments:
 * 0: <CONFIG> vehicle config entry
 *
 * Return Value:
 * <STRING> Picture path
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_config"];

private _picture = getText(_config >> "Icon");

If (_picture isEqualTo "") exitWith {""};

private _char = count _picture;

if ((_char > 4)&&{(_picture select [_char-4])==".paa"}) exitWith {_picture};

getText(configFile >> "CfgVehicleIcons" >> _picture)
