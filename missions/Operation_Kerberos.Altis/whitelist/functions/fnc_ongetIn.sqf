/*
    author: iJesuz, Dorbedo

    description:
        part of only pilots

    parameter:
        0: OBJECT - the player
        1: STRING - position of player
        2: OBJECT - the vehicle
        3: ARRAY - turret
    returns:
        true
*/
#include "script_component.hpp"

params["_unit","_position","_vehicle","_turret"];

If (!isPlayer _unit) exitWith {};
If ((vehicle player) isKindOf "ParachuteBase") exitWith {};
If (!(_vehicle isKindOf "Air")) exitWith {};

if (!(((_turret isEqualTo [0]) || (_position == "driver")))) exitWith {};

If (missionNamespace getVariable [QGVAR(whitelistenabled),false]) then {

    private _eject = false;

    If (!((toLower (typeOf _unit)) in ["b_pilot_f","b_helipilot_f","o_pilot_f","o_helipilot_f","i_pilot_f","i_helipilot_f"])) then {
        _eject = true;
    };

    if ISCASVEHICLE_C(typeOf vehicle _unit) then {
        if (isNil QEGVAR(player,reserved_pilot_slot) ) then {
            _eject = true;
        };
        if (_unit getVariable ["DORB_ISCASPILOT",false]) then {
            _eject = false;
        };
    };

    If !(isMultiplayer) then {
        _eject = false;
    };

    if (_eject) then {
        if ((_position == "driver") || {isNull driver (vehicle _unit)}) then {
            (vehicle _unit) engineOn false;
        };
        unassignVehicle (vehicle _unit);
        _unit action ["Eject", vehicle _unit];
        _unit action ["GetOut", vehicle _unit];
        if (isPlayer _unit) then {
            [QEGVAR(gui,message),[LSTRING(TITLE),LSTRING(NOTALLOWED),"red"],_unit] call CBA_fnc_targetEvent;
        };
    };
} else {
    if ((!((toLower (typeOf _unit)) in ["b_pilot_f","b_helipilot_f","o_pilot_f","o_helipilot_f","i_pilot_f","i_helipilot_f"]))&&{isMultiplayer}) then {
        if ((_position == "driver") || {isNull driver (vehicle _unit)}) then { (vehicle _unit) engineOn false; };
        unassignVehicle (vehicle _unit);
        _unit action ["Eject", vehicle _unit];
        _unit action ["GetOut", vehicle _unit];
        if (isPlayer _unit) then {
            [QEGVAR(gui,message),[LSTRING(TITLE),LSTRING(NOTALLOWED),"red"],_unit] call CBA_fnc_targetEvent;
        };
    };
};
true
