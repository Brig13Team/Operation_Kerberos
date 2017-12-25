/*
 *  Author: Dorbedo
 *
 *  Description:
 *      rescueHandler
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

{
    private _position = getMarkerPos (format["rescuepoint_%1", _x]);
    if !(_position isEqualTo [0,0,0]) then {
        private _units = _position nearEntities [["Man","Ship_F","LandVehicle","Land_Suitcase_F","Air"], 10];
        {
            private _event = _x getVariable [QGVAR(rescueEvent),""];
            If !(_event isEqualTo "") then {
                _x setVariable [QGVAR(rescueEvent),""];
                [_event,[_x]] call CBA_fnc_globalEvent;
            };
        } forEach _units;
    };
} count [west, east, independent];

