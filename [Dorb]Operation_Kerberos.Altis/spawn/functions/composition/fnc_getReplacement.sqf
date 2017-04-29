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
#define DEBUG_MODE_FULL
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

switch (true) do {
    case (_unittype isKindOf "rhs_zsutank_base") : {
        _return = "B_APC_Tracked_01_AA_F";
    };
    case (_unittype isKindOf "House_F");
    case (_unittype isKindOf "StaticWeapon") : {};
    case (_unittype isKindOf "CAManBase") : {
        _return = ["soldier"] call FUNC(getUnit);
    };
    case (_unittype isKindOf "Tank") : {
        _return = ["tanks"] call FUNC(getUnit);
    };
    case (_unittype isKindOf "Truck_F") : {
        _return = ["transporter_lorry"] call FUNC(getUnit);
    };
    case (_unittype isKindOf "helicopter") : {
        _return = ["helicopter"] call FUNC(getUnit);
    };
    case (_unittype isKindOf "Car_F") : {
        _return = ["transporter_sniper"] call FUNC(getUnit);
    };
    default {TRACEV_1(_unittype);};
};

_return;
