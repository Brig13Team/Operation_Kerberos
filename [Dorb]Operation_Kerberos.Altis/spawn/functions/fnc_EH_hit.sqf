/*
    Author: Dorbedo

    Description:
    hit-EH
    called via XEH

    Parameter(s):
        0 : OBJECT - Fahrzeug
        1 : 

*/
#include "script_component.hpp"
_this params[["_vehicle",objNull,[objNull]],["_attack",objNull,[objNull]],["_dammage",0,[0]]];
If ((!alive _vehicle) || {_vehicle isKindOf "Air"}) exitWith {};

[_vehicle] call FUNC(stayInVehicle);