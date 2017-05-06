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

private _units = (getMarkerPos GVARMAIN(rescuemarker)) nearEntities [["Man","Ship_F","LandVehicle","Land_Suitcase_F","Air"], 10];

If !(isNil QEFUNC(gui_teleport,nearEnemys)) then {
    {
        If !([_x] call EFUNC(gui_teleport,nearEnemys)) then {
            _units = _units + (_x nearEntities [["Man","Ship_F","LandVehicle","Land_Suitcase_F","Air"], 10]);
        };
    } forEach (missionNamespace getVariable [QGVAR(rescuepositions),[]]);
};

{
    private _event = _x getVariable [QGVAR(rescueEvent),""];
    If !(_event isEqualTo "") then {
        _x setVariable [QGVAR(rescueEvent),""];
        [_event,[_x]] call CBA_fnc_globalEvent;
    };
}forEach _units;
