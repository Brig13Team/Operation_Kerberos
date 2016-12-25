/*
 *  Author: Dorbedo
 *
 *  Description:
 *      updates the groupmaker of a group
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#include "script_component.hpp"

_this params ["_group",["_delete",false,[false]]];

private _grouphash = _group getVariable QGVAR(grouphash);

If !(HASH_HASKEY(_groupHash,"marker1")) then {
    [_group] call FUNC(createMarker);
}else{
    private _marker1 = HASH_GET(_groupHash,"marker1");
    private _marker2 = HASH_GET(_groupHash,"marker2");
    private ["_size","_symbolpost","_position"];
    if (_delete) then {
        _position = HASH_GET(_groupHash,"positions") deleteAt 0;
        _symbolpost = HASH_GET(_groupHash,"symbol") deleteAt 0;
        _size = HASH_GET(_groupHash,"size") deleteAt 0;
    }else{
        _position = HASH_GET(_groupHash,"positions") select 0;
        _symbolpost = HASH_GET(_groupHash,"symbol") select 0;
        _size = HASH_GET(_groupHash,"size") select 0;
    };
    If (_position isEqualTo [0,0,0]) exitWith {};

    private _symbol = HASH_GET(_grouphash,"prefix") + _symbolpost;
    _marker1 setMarkerPosLocal _position;
    _marker1 setMarkerTextLocal (groupID _group);
    _marker1 setMarkerTypeLocal _symbol;

    _marker2 setMarkerPosLocal _position;
    _marker2 setMarkerTypeLocal _size;
};
