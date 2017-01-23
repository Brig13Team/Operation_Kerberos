/*
 *  Author: Dorbedo
 *
 *  Description:
 *      creates a composition
 *
 *  Parameter(s):
 *      0 : ARRAY - centerposition
 *      1 : STRING - type
 *      2 : SCALAR - amount
 *      3 : SCALAR - radius
 *
 *  Returns:
 *      ARRAY - objects
 *
 */

#include "script_component.hpp"

_this params [["_centerposition",[],[[]]],["_type","isObjective",[""]],["_amount",1,[0]],["_radius",1200,[0]]];
TRACEV_4(_centerposition,_type,_amount,_radius);

private _possibleSpawnpositions = [];
private _errorcounter = 0;

while {((count _possibleSpawnpositions)<_amount)&&(_errorcounter < (100+_amount))} do {
    // random position inside radius, not in water
    private _tempPos = [_centerposition,_radius,0] call EFUNC(common,pos_random);
    // get a flat position
    private _spawnpos = [_tempPos,15,_radius,20,0.05] call EFUNC(common,pos_flatempty);
    If (_spawnpos isEqualTo []) then {
        _spawnpos = [_tempPos,15,_radius,20,0.15] call EFUNC(common,pos_flatempty);
    };
    // if no position was found exit
    If (!(_spawnpos isEqualTo [])) then {
        // _spawnpos is not too close to other positions
        If (({((_spawnpos distance2D _x)<30)} count _possibleSpawnpositions)<1) then {
            // spawnposition is not on a road
            private _checkpos = ([_spawnpos,3,10] call EFUNC(common,pos_square)) select 1;
            private _isOnRoad = ({isOnRoad _x;} count _checkpos)>0;
            If (!_isOnRoad) then {
                _possibleSpawnpositions pushBack _spawnpos;
            };
        };
    };
    INC(_errorcounter);
};


private _allTargetPositions = [];

{
    /// Get gooddirs -> good sight from the defined pos
    private _gooddirs = [];
    private "_i";
    for [{_i= 1},{_i <= 360},{_i = _i + 10}] do {
        private _defencepos =+ _x;
        _defencepos set [2,((_defencepos select 2)+0.9)];
        private _aimpos = [_x, 450, 50] call BIS_fnc_relPos;
        //_aimpos set[2,(_defencepos select 2)];
        private _isgooddir = terrainIntersect[_defencepos,_aimpos];
        If (!_isgooddir) then {
            _gooddirs pushBack _i;
        };
    };

    /// choose the best dir

    private _bestdir = -1;
    private _bestdir_level = 0;
    private _defencepos = ATLtoASL _x;
    for "_j" from 0 to ((count _gooddirs)-1) do {
        private _templevel = 0;
        for [{_k= 1},{_k <= 450},{_k = _k + 20}] do {
            _aimpos = [_x, _k, (_gooddirs select _j)] call BIS_fnc_relPos;
            _aimpos = ATLtoASL _aimpos;
            private _differenz = ((_defencepos select 2)-(_aimpos select 2));
            _currentlevel = _differenz * ((floor((23-(_k/20))/3))max 0.2);
            _templevel = _templevel + _currentlevel;
        };
        If (_templevel > _bestdir_level) then {
            _bestdir = (_gooddirs select _j);
            _bestdir_level = _templevel;
        };
    };


    // If there is no bestdir (because of terrain) -> randomize

    If (_bestdir < 0) then {_bestdir = random 360;};


    /// debug
    #ifdef DEBUG_MODE_FULL
        [_x,format["defencepos-%1",_x],"ColorBlue","mil_arrow2",_bestdir] call EFUNC(common,debug_marker_create);
    #endif

    ///// spawn defence
    private _currentComposition = [_type,_centerposition] call FUNC(composition_chooseComposition);

    private _curTargetPos = [_x,_currentComposition,_bestdir] call FUNC(composition_spawnComposition);
    TRACEV_1(_curTargetPos);
    If !(_curTargetPos isEqualTo []) then {
        _allTargetPositions pushBack _curTargetPos;
    };

}forEach _possibleSpawnpositions;
TRACEV_1(_allTargetPositions);
_allTargetPositions;
