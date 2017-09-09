/**
 * Author: Dorbedo
 * creates a missionHouse Objective
 *
 * Arguments:
 * 0: <ARRAY> centerposition
 * 1: <STRING> missiontype
 * 2: <SCALAR> amount
 * 3: <SCALAR> radius
 * 4: <BOOL> return only position (default: true)
 *
 * Return Value:
 * <ARRAY> return Positions/Objectives
 *
 */

#include "script_component.hpp"

params [
    ["_centerpos", [], [[]], [2, 3]],
    ["_type", "", [""]],
    ["_amount", 1, [0]],
    ["_radius", 300, [0]],
    ["_onlyPos", true, [true]]
];
TRACEV_5(_centerpos,_type,_amount,_radius,_onlyPos);

private _possibleHouseTypes = HASH_CREATE;
If !(_onlyPos) then {
    {
        private _curKey = _x;
        private _allCfgs = HASH_GET_DEF(GVAR(missionhouses),_curKey,[]);
        //TRACEV_1(_allCfgs);
        {
            If (getText(_x >> "type") isEqualTo _type) then {
                If (HASH_HASKEY(_possibleHouseTypes,_curKey)) then {
                    HASH_GET(_possibleHouseTypes,_curKey) pushBackUnique _x;
                } else {
                    HASH_SET(_possibleHouseTypes,_curKey,[_x]);
                };
            };
        } forEach _allCfgs
    } forEach HASH_KEYS(GVAR(missionhouses));
} else {
    {
        private _curKey = _x;
        private _allCfgs = HASH_GET_DEF(GVAR(missionhouses),_curKey,[]);
        {
            If ((getText(_x >> "type") isEqualTo _type)||{getText(_x >> "type") isEqualTo "%ALL"}) then {
                If (HASH_HASKEY(_possibleHouseTypes,_curKey)) then {
                    HASH_GET(_possibleHouseTypes,_curKey) pushBackUnique _x;
                } else {
                    HASH_SET(_possibleHouseTypes,_curKey,[_x]);
                };
            };
        } forEach _allCfgs
    } forEach HASH_KEYS(GVAR(missionhouses));
};

private _possibleHouses = [_centerpos, _radius, _amount, HASH_KEYS(_possibleHouseTypes)] call FUNC(getRandomHouse);
TRACEV_4(_centerpos,_possibleHouses,HASH_KEYS(_possibleHouseTypes),HASH_KEYS(GVAR(missionhouses)));
private _return = [];
{
    _x params ["_curHouse"];
    private _curHouseType = typeOf _curHouse;
    private _curCfg = selectRandom HASH_GET(_possibleHouseTypes,_curHouseType);
    //TRACEV_3(_curHouse, _curCfg, _onlyPos);
    private _temp = [_curHouse, _curCfg, _onlyPos] call FUNC(createMissionHouse);
    _return append _temp;
} forEach (_possibleHouses select {(!isNil "_x")&&{!isNull _x}});

TRACEV_2(_centerpos, _return);
_return
