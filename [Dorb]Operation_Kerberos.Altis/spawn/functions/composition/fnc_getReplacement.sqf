/*
 *  Author: Dorbedo
 *
 *  Description:
 *      replacement function for predefined compositions
 *      only changes if the unit has the same side as GVARMAIN(playerside)
 *
 *  Parameter(s):
 *      0 : STRING - Vehicletype
 *
 *  Returns:
 *      STRING - replaced vehicletype
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_unittype","",[""]]];

private _return = _unittype;

private _unitside = getNumber(configFile >> "CfgVehicles" >> _unittype >> "side");

private _needReplacement = switch _unitside do {
    case 0 : {GVARMAIN(playerside) == east};
    case 1 : {GVARMAIN(playerside) == west};
    default {false};
};

If !(_needReplacement) exitWith {_return};

_return = switch (true) do {
    case (_unittype isKindOf "House_F") : {_unittype};

    case (_unittype isKindOf "CAManBase") : {
        ["soldier"] call FUNC(getUnit);
    };
    case (_unittype isKindOf "StaticWeapon") : {
        _unittype
    };
    case (_unittype isKindOf "Tank") : {
        ["tanks"] call FUNC(getUnit);
    };
    case (_unittype isKindOf "Truck_F") : {
        ["transporter_lorry"] call FUNC(getUnit);
    };
    case (_unittype isKindOf "helicopter") : {
        ["helicopter"] call FUNC(getUnit);
    };
    default {
        TRACEV_1(_unittype);
        _unittype
    };
};

_return;
