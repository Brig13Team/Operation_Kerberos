#include "script_component.hpp"

/*
  Name: dorb_composition_fnc_getReplacement
  Author: Dorbedo
  returns the replacement for a unit, if another faction/side was chosen

  Arguments:
    0: the unit class <STRING>

  Return Value:
    the replacement, empty string if there is no replacement possible <STRING>

  Public: Yes
*/

params [["_unittype", "", [""]]];

private _return = _unittype;

private _unitside = getNumber(configFile >> "CfgVehicles" >> _unittype >> "side");

private _needReplacement = switch _unitside do {
    case 0 : {GVARMAIN(playerside) == east};
    case 1 : {GVARMAIN(playerside) == west};
    default {false};
};

If !(_needReplacement) exitWith {_return};

switch (true) do {
    case ((_unittype isKindOf "rhs_zsutank_base")||(_unittype isKindOf "RHS_Ural_Zu23_Base")) : {
        _return = "B_APC_Tracked_01_AA_F";
    };
    case (_unittype isKindOf "House_F");
    case (_unittype isKindOf "StaticWeapon") : {
        // nothing, just use the same unit
    };
    case (_unittype isKindOf "CAManBase") : {
        _return = ["soldier"] call EFUNC(spawn,getUnit);
    };
    case (_unittype isKindOf "Tank") : {
        _return = ["tanks"] call EFUNC(spawn,getUnit);
    };
    case (_unittype isKindOf "Truck_F") : {
        _return = ["transporter_lorry"] call EFUNC(spawn,getUnit);
    };
    case (_unittype isKindOf "helicopter") : {
        _return = ["helicopter"] call EFUNC(spawn,getUnit);
    };
    case (_unittype isKindOf "Car_F") : {
        _return = ["transporter_sniper"] call EFUNC(spawn,getUnit);
    };
    default {TRACEV_1(_unittype);};
};

TRACEV_3(_unittype,_unitside,_return);

_return;
