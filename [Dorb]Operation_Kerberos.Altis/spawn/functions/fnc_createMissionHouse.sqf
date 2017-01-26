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

_this params [["_centerposition",[],[[]]]];
TRACEV_2(_this,_centerposition);
private _buildings = _centerposition nearObjects ["House", 280];
_buildings = _buildings - (missionNamespace getVariable [QGVAR(usedHouses),[]]);
TRACEV_2(_centerposition,_buildings);
If (_buildings isEqualTo []) exitWith {ERROR(FORMAT_1("No Buildings found around %1",_centerposition));[]};
private _possibleBuildings = [];
private _targetPositions = [];
{
    private _temp = [_x,true] call FUNC(composition_chooseHouse);
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
        private _curType = typeOf _x;
        private _allPos = getArray(missionConfigFile >> "CfgCompositions" >> "housepositions" >> _curType >> "soldierpos");
        If !(_allPos isEqualTo []) exitWith {
            _targetPositions = _allPos;
            GVAR(targetHouses) pushBack _x;
        };
    } forEach _buildings;
}else{
    _possibleBuildings = _possibleBuildings - GVAR(targetHouses);
    private _targetHouse = selectRandom _possibleBuildings;
    TRACEV_2(_targetHouse,_possibleBuildings);
    _targetPositions = _targetHouse call FUNC(composition_spawnHouse);
    TRACEV_1(_targetPositions);
    GVAR(targetHouses) pushBack _targetHouse;
};

_targetPositions;
