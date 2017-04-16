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


If !(GVAR(debugMarkerActive)) exitWith {[_this select 1] call CBA_fnc_removePerFrameHandler;};

If (isNil QGVAR(debugMarker)) then {
    GVAR(debugMarker) = [];
};

{deleteMarker _x;} forEach GVAR(debugMarker);
GVAR(debugMarker) = [];

private _dangerzones = HASH_KEYS(GVAR(dangerzones)) select {IS_HASH(HASH_GET(GVAR(dangerzones),_x))};
{
    private _dz = _x;
    private _value = HASH_GET(HASH_GET(GVAR(dangerzones),_dz),"enemystrength");
    If (!isNil "_value") then {
        private _position = [_dz] call FUNC(dzconvert);
        _position set [1,(_position select 1)-5];
        private _mark = createMarker [format["HQ_DEBUGMARKER_%1",(count GVAR(debugMarker))],_position];
        GVAR(debugMarker) pushBack _mark;
        _mark setMarkerShape "ICON";
        _mark setMarkerType "hd_dot";
        _mark setMarkerColor "ColorBlack";
        _mark setMarkerText format["%1",_value toFixed 0];
        TRACEV_2(_dz,_value);
    };
} forEach _dangerzones;

{
    private _attackLoc = _x;
    private _position = getPos _attackLoc;
    private _enemytype = HASH_GET_DEF(_attackLoc,"enemytype",[0,0,0]);
    private _enemyvalue = HASH_GET_DEF(_attackLoc,"enemyvalue",0);
    private _enemystrenght = HASH_GET_DEF(_attackLoc,"enemystrenght",[ARR_3(0,0,0)]);
    private _enemydefence = HASH_GET_DEF(_attackLoc,"enemydefence",[ARR_3(0,0,0)]);
    private _mark = createMarker [format["HQ_DEBUGMARKER_%1",(count GVAR(debugMarker))],_position];
    GVAR(debugMarker) pushBack _mark;
    _mark setMarkerShape "ICON";
    _mark setMarkerType "hd_dot";
    _mark setMarkerColor "ColorBlack";
    _mark setMarkerText format["%1 | %2 | %3 | %4",_enemyValue,_enemytype apply {_x toFixed 0},_enemystrenght apply {_x toFixed 0},_enemydefence apply {_x toFixed 0}];
    TRACEV_5(_attackLoc,_position,_enemytype,_enemyvalue,_enemythreat);
} forEach HASH_GET_DEF(GVAR(attackpos),"Locations",[]);;
