/*
 *  Author: Dorbedo
 *
 *  Description:
 *      updates the value of a waypoint
 *
 *  Parameter(s):
 *      0 : STRING - The waypoint key
 *      (optional)
 *      1 : SCLAR - the value of the waypoint
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params[
    ["_key","",[""]],
    ["_value",-1,[0]];
    ];
CHECK(_key isEqualTo "");

If (_value < 0) then {
    _value = 0;
    private _dangerkey = (getArray(missionconfigFile >> "maps" >> worldname >> _startKey >> "position")) call FUNC(dz_convert);
    private _keyX = parsenumber ((_dangerkey splitString "_") select 0);
    private _keyY = parsenumber ((_dangerkey splitString "_") select 1);
    private _maxKey = (HASH_GET(GVAR(dangerzones),"distance") * 2)/HASH_GET(GVAR(dangerzones),"gridsize");

    {
        _x params ["_tempkeyX","_tempkeyY"];
        If ((_tempkeyX>=0)&&(_tempkeyX<_maxKey)&&(_tempkeyY>=0)&&(_tempkeyY<_maxKey)) then {
            private _tempkey = format ["%1_%2",_tempkeyX,_tempkeyY];
            private _zoneHash = HASH_GET(GVAR(dangerzones),_tempkey);
            private _strenghtEnemy = HASH_GET(_zoneHash,"enemystrenght");
            If ((!(isNil "_strenghtEnemy"))&&{_strenghtEnemy > 0}) then {
                _value = _value + 1;
            };
        };
    } forEach [
        [_keyX,_keyY],
        [_keyX-1,_keyY-1],
        [_keyX-1,_keyY+1],
        [_keyX+1,_keyY+1],
        [_keyX+1,_keyY+1]
    ];
};
HASH_SET(GVAR(waypoints),_key,_value);
