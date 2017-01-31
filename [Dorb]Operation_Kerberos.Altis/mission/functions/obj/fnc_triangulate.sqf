/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_checkerPositions",[],[[]]],["_toCheck",[],[[]]]];
TRACEV_3(_this,_checkerPositions,_toCheck);
If !((_checkerPositions isEqualTypeAll [])&&(_toCheck isEqualTypeAll [])) exitWith {
    WARNING("Wrong Input");
    []
};

(_checkerPositions select 0) params ["_xA","_yA"];
(_checkerPositions select 1) params ["_xB","_yB"];
(_checkerPositions select 2) params ["_xC","_yC"];

private _return = [];
{
    _x params ["_xP","_yP"];
    private _max = (abs(_xA*(_yB - _yP)+_xB*(_yC-_yA)+_xC*(_yP-_yB)+_xP*(_yA-_yC))) max
        (abs(_xA*(_yB - _yC)+_xB*(_yP-_yA)+_xP*(_yC-_yB)+_xC*(_yA-_yP))) max
        (abs(_xA*(_yP - _yC)+_xP*(_yB-_yA)+_xB*(_yC-_yP)+_xC*(_yA-_yB)));
    private _comp = abs(_xA*(_yB - _yC)+_xB*(_yC-_yA)+_xC*(_yA-_yB));
    If ((_max - _comp)<0) then {_return pushBack _x;};
} forEach _toCheck;
TRACEV_1(_return);

_return;
