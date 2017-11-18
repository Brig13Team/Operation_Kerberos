/**
 * Author: Dorbedo
 * puts something into a parachute
 *
 * Arguments:
 * 0: <OBJECT> the unit
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_object", objNull, [objNull]]];

If (isNull _object) exitWith {};

If (_object isKindOf "CAManBase") exitWith {
    private _para = createVehicle ["NonSteerable_Parachute_F", (getPos _object), [], 0, "FLY"];
    _para setPos ((getPos _object) vectorAdd [0,0,1.5]);
    _object moveInDriver _para;
};

private _paraType = switch (side _object) do {
    case east : {"O_Parachute_02_F"};
    case resistance : {"I_Parachute_02_F"};
    default {"B_Parachute_02_F"};
};

private _para = createvehicle [_paraType, getPos _object, [], 0, "FLY"];
_para setPos ((getPos _object) vectorAdd [0,0,1.5]);
_para setDir (direction _veh);
_para setVelocity (velocity _object);
_object attachTo [_para,[0,0,1]];


[
    {
        (((getPos (_this select 0)) select 2)<1)||(isNull (_this select 1))
    },
    {
        detach (_this select 0);
        deleteVehicle (_this select 1);
    },
    [_object, _para],
    5*60
] call CBA_fnc_waitUntilAndExecute;
