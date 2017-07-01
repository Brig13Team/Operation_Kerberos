/*
    Author: Dorbedo

    Description:
    Tells the Crew to stay in a vehicle if it is damaged
    called via XEH

    Parameter(s):
        0 :    OBJECT - Fahrzeug

*/
#include "script_component.hpp"
_this params[["_vehicle",objNull,[objNull]]];
private _driver = driver _vehicle;
If ((isNil "_driver")||{isNull _driver}||{_driver == _vehicle}) exitWith {};


If (canFire _vehicle) exitWith {
    If !(_vehicle getVariable [QGVAR(awaiting_repair),false]) then {
        _vehicle setVariable [QGVAR(awaiting_repair),true,true];
        _vehicle allowCrewInImmobile true;
    };
};
_vehicle allowCrewInImmobile false;
