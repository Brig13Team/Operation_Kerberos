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
#define DEBUG_MODE_OFF
#include "script_component.hpp"

_this params [["_centerposition",[],[[]]],["_type","",["",[]]],["_amount",1,[0]],["_radius",280,[0]]];
TRACEV_3(_this,_centerposition,_type);
private _buildings = _centerposition nearObjects ["House", _radius];
_buildings = _buildings - (missionNamespace getVariable [QGVAR(usedHouses),[]]);
TRACEV_2(_centerposition,_buildings);
If (_buildings isEqualTo []) exitWith {ERROR(FORMAT_1("No Buildings found around %1",_centerposition));[]};
private _possibleBuildings = [];
private _targetPositions = [];
{
    private _temp = [_x,_type] call FUNC(composition_chooseHouse);
    TRACEV_3(_temp,_x,_type);
    If ((!isNil "_temp")&&{!isNull _temp}&&{!(_temp isEqualTo [])}) then {
        _possibleBuildings pushBack [_x,_temp];
    };
} forEach _buildings;
TRACEV_1(_possibleBuildings);
If !(_possibleBuildings isEqualTo []) then {
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
If (_amount > 0) then {
    WARNING("Not enaugh possible Buildings found - FALLBACK");
    _buildings = _buildings - (missionNamespace getVariable [QGVAR(targetHouses),[]]);
    _buildings = _buildings call BIS_fnc_arrayShuffle;
    private _fastHousePositions = [];
    {
        private _curType = typeOf _x;
        private _housePos = getPosWorld _x;
        private _houseDir = getDir _x;
        private _allPos = getArray(missionConfigFile >> "CfgCompositions" >> "housepositions" >> _curType >> "soldierpos");
        If !(_allPos isEqualTo []) exitWith {
            _fastHousePositions = _allPos apply {_housePos vectorAdd ([[_x select 0,_x select 1,(_x select 2) + 0.1],-1 * _houseDir] call BIS_fnc_rotateVector2D);};
            GVAR(targetHouses) pushBack _x;
        };
    } forEach _buildings;
    _fastHousePositions = _fastHousePositions call BIS_fnc_arrayShuffle;
    _targetPositions append _fastHousePositions;
};

_targetPositions;
