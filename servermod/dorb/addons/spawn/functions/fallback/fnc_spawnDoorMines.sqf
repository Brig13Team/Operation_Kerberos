/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns doormines at building in a area
 *
 *  Parameter(s):
 *      0 : ARRAY - Centerposition
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_centerposition","_radius","_spawnamount"];

private _buildings = _centerposition nearObjects ["HouseBase", _radius];
_buildings = _buildings - (missionNamespace getVariable [QGVAR(usedHouses),[]]);
_buildings = _buildings call BIS_fnc_arrayShuffle;

private _errorCounter = 5000;

while {(_errorCounter > 0)&&(_spawnamount>0)} do {
    DEC(_errorCounter);
    private _curbuilding = selectRandom _buildings;
    private _tempArr = getArray(ConfigFile >> "CfgKerberos" >> "CfgCompositions" >> "housepositions" >> (typeOf _curbuilding) >> "doorpos" );
    If !(_tempArr isEqualTo []) then {
        _tempArr = _tempArr call BIS_fnc_arrayShuffle;
        If (count _tempArr > 2) then {_tempArr resize 2};
        private _minesArray = [];
        private _buildingPos = getPosWorld _curbuilding;
        private _buildingDir = getDir _curbuilding;
        {
            _x params ["_posX","_posY","_posZ","_dir"];
            // correct the position to be more evil
            private _moveDistance = 0.25;
            _posZ = _posZ -0.2;
            private _tempPos = [_posX,_posY] getPos [_moveDistance, (_dir + 90)];
            If ((_tempPos distance2D [0,0]) > ([_posX,_posY] distance2D [0,0])) then {
                _tempPos = [_posX,_posY] getPos [2*_moveDistance, (_dir - 90)];
            };
            _tempPos = _tempPos getPos [-0.4, (_dir)];
            _tempPos set [2,_posZ];
            // rotate and move the spawnposition according to the housedirection
            _tempPos = [_tempPos ,-1 * _buildingDir] call BIS_fnc_RotateVector2D;
            _tempPos = _tempPos vectorAdd _buildingPos;
            #ifdef DEBUG_MODE_FULL
                [_tempPos,"","ColorBlack"] call EFUNC(common,debug_marker_create);
            #endif
            _tempPos pushBack (_buildingDir + _dir + 90);
            _minesArray pushBack _tempPos;

        } forEach _tempArr;

        [_minesArray,2] call FUNC(fallback_spawnExplosives);
        DEC(_spawnamount);

        #ifdef DEBUG_MODE_FULL
            [getPos _curbuilding,format["doormines-%1",_spawnamount],"ColorRed","Minefield",0] call EFUNC(common,debug_marker_create);
        #endif
    };
};
