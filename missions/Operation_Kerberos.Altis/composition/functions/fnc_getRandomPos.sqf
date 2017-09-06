/**
 * Author: Dorbedo
 * searches a possible spawn position for composition
 *
 * Arguments:
 * 0: <ARRAY> centerposition
 * 1: <SCALAR> searchradius
 * 2: <SCALAR> size
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [
    ["_centerpos", [], [[]], [2, 3]],
    ["_searchradius", 1500, [0]],
    ["_amount", 1, [0]],
    ["_size", 35, [0]]
];

private _possibleSpawnpositions = [];
private _errorcounter = 0;

while {((count _possibleSpawnpositions)<_amount)&&(_errorcounter < (300+_amount))} do {
    // random position inside radius, not in water
    private _tempPos = [_centerposition, _radius, 0] call EFUNC(common,pos_random);
    // get a flat position
    private _spawnpos = [_tempPos, _size, _radius, 20, 0.09] call EFUNC(common,pos_flatempty);

    // fallback search
    If ((_spawnpos isEqualTo [])&&(_errorcounter > 200)) then {
        _spawnpos = [_tempPos, _size, _radius, 20, 0.5] call EFUNC(common,pos_flatempty);
    };

    // if no position was found exit
    If (!(_spawnpos isEqualTo [])) then {
        // _spawnpos is not too close to other positions
        If ((({((_spawnpos distance2D _x)<60)} count _possibleSpawnpositions)<1)&&
            {({((_spawnpos distance2D _x)<60)} count GVAR(spawnedCompositions))<1})
         then {
            // spawnposition is not on a road
            private _checkpos = ([_spawnpos,3,10] call EFUNC(common,pos_square)) select 1;
            private _isOnRoad = ({isOnRoad _x;} count _checkpos)>0;
            If !(_isOnRoad) then {
                _possibleSpawnpositions pushBack _spawnpos;
            };
        };
    };
    INC(_errorcounter);
};


private _allCompositionPositions = [];
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
            _bestdir = _gooddirs select _j;
            _bestdir_level = _templevel;
        };
    };

    // If there is no bestdir (because of terrain) -> randomize
    If (_bestdir < 0) then {_bestdir = random 360;};

    _allCompositionPositions pushBack [_centerposition, _bestdir];

} forEach _possibleSpawnpositions;

_allCompositionPositions
