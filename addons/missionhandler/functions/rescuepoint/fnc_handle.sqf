#include "script_component.hpp"

/*
  Name: dorb_missionhandler_fnc_rescuepoint_handle
  Author: Dorbedo
  handles the

  Arguments:
    None

  Return Value:
    None

  Public: No
*/

{
    private _position = _x;

    private _units = _position nearEntities [["Man", "Ship_F", "LandVehicle", "Land_Suitcase_F", "Air"], 10];
    {
        private _event = _x getVariable [QEGVAR(mission,rescueEvent), ""];
        If !(_event isEqualTo "") then {
            _x setVariable [QEGVAR(mission,rescueEvent), ""];
            [_event, [_x]] call CBA_fnc_globalEvent;
        };
    } forEach _units;

} forEach (missionNamespace getVariable [QGVAR(rescuepoints), []]);

nil
