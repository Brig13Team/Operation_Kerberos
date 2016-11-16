/*
 *  Author: Dorbedo
 *
 *  Description:
 *      load the advertisements
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

If !(isMultiplayer) exitWith {
    [["Test-Advert", "content"]]
};

private _loadedAdverts = call compile preprocessFileLineNumbers "\userconfig\kerberos\dorb_adverts.sqf";
if (!isNil "_loadedAdverts") then {
    GVAR(advertisements) = _loadedAdverts;
};

If !( GVAR(advertisements) == GVAR(lastadvertisements) ) then {
    GVAR(lastadvertisements) = GVAR(advertisements);
    publicVariable QGVAR(advertisements);
};
