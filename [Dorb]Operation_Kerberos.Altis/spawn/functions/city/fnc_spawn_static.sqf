/*
    Author: Dorbedo
    
    Description:
        Spawns Staticunits at arraypositions
    
    
    Parameter(s):
        0 : ARRAY    - Spawnpositions
        (Optional)
        1 : STRING    - side
        2 : ARRAY    - array with possible men, who can be spawned
    
    Return
    ARRAY - spawned Units
*/
#include "script_component.hpp"
SCRIPT(spawn_static);
params[["_spawnposarray",[],[[]],[2,3]],["_side",GVARMAIN(side),[east]],["_unitarray",dorb_staticlist,[]]];
CHECK(_spawnposarray isEqualTo [])
Private["_spawnedunit","_spawnedunits","_typ","_gruppe","_dir","_position"];

For "_i" from 0 to ((count _spawnposarray)-1) do {
    _typ = _unitarray SELRND;
    _gruppe = createGroup _side;
    _dir = (_spawnposarray select _i)select 3;
    _position = [(_spawnposarray select _i)select 0,(_spawnposarray select _i)select 1,(_spawnposarray select _i)select 2];
    _spawnedunit = _gruppe createVehicle [_typ,_position, [], _dir, "NONE"];
    If (!((crew _spawnedunit)isEqualTo [])) then {
        {_spawnedunit deleteVehicleCrew _x} forEach crew _spawnedunit;
        [_spawnedunit,_side] call FUNC(crew);
    }else{
        [_spawnedunit,_side] call FUNC(crew);
    };
    _spawnedunits pushBack _spawnedunit;
};
_spawnedunits
