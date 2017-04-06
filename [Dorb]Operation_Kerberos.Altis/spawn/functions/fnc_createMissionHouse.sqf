/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns the intel
 *
 *  Parameter(s):
 *      0 : ARRAY - centerposition
 *
 *  Returns:
 *      ARRAY - intel-objects
 *
 */

#include "script_component.hpp"

_this params [["_centerposition",[],[[]]],["_type","",["",[]]],["_amount",1,[0]],["_radius",280,[0]]];
TRACEV_2(_this,_centerposition);
private _buildings = _centerposition nearObjects ["House", _radius];
_buildings = _buildings - (missionNamespace getVariable [QGVAR(usedHouses),[]]);
TRACEV_2(_centerposition,_buildings);
If (_buildings isEqualTo []) exitWith {ERROR(FORMAT_1("No Buildings found around %1",_centerposition));[]};
private _possibleBuildings = [];
private _targetPositions = [];
{
    private _temp = [_x,_type] call FUNC(composition_chooseHouse);
    //TRACEV_2(_temp,_x);
    If ((!isNil "_temp")&&{!isNull _temp}&&{!(_temp isEqualTo [])}) then {
        _possibleBuildings pushBack [_x,_temp];
    };
} forEach _buildings;
TRACEV_1(_possibleBuildings);
If (_possibleBuildings isEqualTo []) then {
    WARNING("No possible Buildings found - FALLBACK");
    _buildings = _buildings call BIS_fnc_arrayShuffle;
    {
        private _allPos = _x buildingPos -1;
        If !(_allPos isEqualTo []) then {
            _targetPositions append _allPos;
            GVAR(targetHouses) pushBack _x;
        };
        If ((count _targetPositions) > _amount) exitWit {};
    } forEach _buildings;
}else{
    _possibleBuildings = _possibleBuildings - GVAR(targetHouses);
    _possibleBuildings = _possibleBuildings call BIS_fnc_arrayShuffle;
    while {((count _possibleBuildings) > 0)&&(_amount > 0)} do {
        private _targetHouse = _possibleBuildings deleteAt 0;
        #ifdef DEBUG_MODE_FULL
            [getPos (_targetHouse select 0),format["house-%1",(_targetHouse select 0)],"ColorBlue","mil_box",0] call EFUNC(common,debug_marker_create);
        #endif
        _tempPos = _targetHouse call FUNC(composition_spawnHouse);
        _targetPositions append _tempPos;
        GVAR(targetHouses) pushBack _targetHouse;
        DEC(_amount);
    };
};

_targetPositions;
