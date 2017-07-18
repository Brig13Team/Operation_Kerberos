/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawn minefields at random locations
 *
 *  Parameter(s):
 *      0 : ARRAY - positions
 *      1 : SCALAR - spawn radius
 *      2 : SCALAR - amount of minefields
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_position",[],[[]],[2,3]],["_radius",1300,[0]],["_amount",8,[0]]];
CHECK(_position isEqualTo [])

private _spawnpos = [];
private _temp = [];
private _forests = selectBestPlaces [_position, _radius, "forest+(trees*0.5)", 20, 30];
private _flatLand = selectBestPlaces [_position, _radius, "meadow + (trees*0.2)", 20, 60];

{
    If ((_x select 1)>0.5) then {
        private _temp = [[((_x select 0)select 0),((_x select 0)select 1),0],30,2,15];
        _spawnpos pushBack _temp;
    };
} forEach _forests;

{
    If ((_x select 1)>0.5) then {
        private _temp = [[((_x select 0)select 0),((_x select 0)select 1),0],30,0,20];
        _spawnpos pushBack _temp;
    };
} forEach _flatLand;

_spawnpos call BIS_fnc_arrayShuffle;

{
    _x call FUNC(spawnMinefieldACE);
    #ifdef DEBUG_MODE_FULL
        If ((_x select 2)>0) then {
            [((_spawnpos select _i) select 0),format["minepos-%1",((_spawnpos select _i) select 0)],"ColorBlue","MinefieldAP"] call EFUNC(common,debug_marker_create);
        }else{
            [((_spawnpos select _i) select 0),format["minepos-%1",((_spawnpos select _i) select 0)],"ColorBlue","Minefield"] call EFUNC(common,debug_marker_create);
        };
    #endif
} forEach _spawnpos;
