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

private _position = (getMarkerPos GVARMAIN(rescuemarker));
If (surfaceIsWater _position) then {
    // carrier detection:
    private _tempos1 = + _position;
    private _tempos2 = + _tempos1;
    _tempos1 set [2,0];
    _tempos2 set [2,40];
    private _objects = lineIntersectsWith[_tempos1,_tempos2];
    private _offset = 0.5;
    If (({(typeOf _x isKindOf "Land_Carrier_01_hull_base_F")||{(typeOf _x isKindOf "Land_Carrier_01_hull_GEO_Base_F")}} count _objects)>0) then {
        private _nearCarriers = _position nearObjects ["Land_Carrier_01_base_F",400];
        If !(_nearCarriers isEqualTo []) then {
            _offset = ((getPosASL (_nearCarriers select 0)) select 2) + 23.7;
        };
    };
    _position set [2,_offset];
};

private _units = _position nearEntities [["Man","Ship_F","LandVehicle","Land_Suitcase_F","Air"], 10];

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
