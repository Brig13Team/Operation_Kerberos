/*
    Author: Dorbedo

    Description:
        removes/adds the group from/to the cache

    Parameter(s):
        
        0 : Group
        1 : add 

*/
#include "script_component.hpp"

_this params ["_group",["_add",false,[true]];
private _allVehicles = [];
{
    _allVehicles pushBackUnique _x;
    If !(vehicle _x == _x) then {
        If !((vehicle _x) in _allVehicles) then {
            _allVehicles = [vehicle _x] append _allVehicles;
        };
    };
    nil;
} count (units _group);

{
    _x enableSimulationGlobal (!_add);
    _x hideObjectGlobal _add;
    nil;
} count _allVehicles;

If (_add) then {
    GVAR(cachedGroups) pushBackUnique _group;
}else{
    private _index = GVAR(cachedGroups) find _group;
    If (_index >= 0) then {
        GVAR(cachedGroups) deleteAt _index;
    };
};
