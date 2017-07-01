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
    GVAR(debugMarker_sync) = [];
};

If (isServer) then {
    GVAR(debugMarker_sync) = [];
    private _dangerzones = HASH_KEYS(GVAR(dangerzones)) select {IS_LHASH(HASH_GET(GVAR(dangerzones),_x))};
    {
        private _dz = _x;
        private _value = HASH_GET(HASH_GET(GVAR(dangerzones),_dz),"enemystrength");
        If ((!isNil "_value")&&{!(_value isEqualTo 0)}) then {
            private _position = [_dz] call FUNC(dzconvert);
            _position set [1,(_position select 1)-5];
            GVAR(debugMarker_sync) pushBack [
                format["HQ_DEBUGMARKER_%1",(count GVAR(debugMarker_sync))],
                _position,
                "ICON",
                "hd_dot",
                "ColorBlack",
                format["%1",_value toFixed 0]
            ];
        };
    } forEach _dangerzones;

    {
        private _attackLoc = _x;
        private _position = getPos _attackLoc;
        private _enemytype = HASH_GET_DEF(_attackLoc,"enemytype",[ARR_3(0,0,0)]);
        private _enemyvalue = HASH_GET_DEF(_attackLoc,"enemyvalue",0);
        private _enemystrength = HASH_GET_DEF(_attackLoc,"enemystrength",[ARR_3(0,0,0)]);
        private _enemydefence = HASH_GET_DEF(_attackLoc,"enemydefence",[ARR_3(0,0,0)]);
        GVAR(debugMarker_sync) pushBack [
            format["HQ_DEBUGMARKER_%1",(count GVAR(debugMarker_sync))],
            _position,
            "ICON",
            "hd_dot",
            "ColorBlack",
            format["%1 | %2 | %3 | %4",_enemyValue,_enemytype,_enemystrength,_enemydefence]
        ];
    } forEach HASH_GET_DEF(GVAR(attackpos),"Locations",[]);
    publicVariable QGVAR(debugMarker_sync);
};

If ((IS_ADMIN_LOGGED)||{!isMultiplayer}) then {
    {deleteMarkerLocal _x;} forEach GVAR(debugMarker);
    GVAR(debugMarker) = [];
    {
        _x params ["_name","_position","_shape","_type","_color","_text"];
        private _mark = createMarkerLocal [_name,_position];
        GVAR(debugMarker) pushBack _mark;
        _mark setMarkerShapeLocal _shape;
        _mark setMarkerTypeLocal _type;
        _mark setMarkerColorLocal _color;
        _mark setMarkerTextLocal _text;
    } forEach GVAR(debugMarker_sync);
};
