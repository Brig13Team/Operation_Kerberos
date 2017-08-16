/*
    Author: Dorbedo

    Description:
        return artimetic mean of an array of points

    Parameter(s):
        0 :    ARRAY    - Array with Positions

    Returns:
    ARRAY : Array with Centerposition
    
*/
#include "script_component.hpp"
_this params [["_positionsarray",[],[[]]]];

CHECKRET((_positionsarray isEqualTo []),[]);
private _all_x = [((_positionsarray select 0) select 0)];
private _all_y = [((_positionsarray select 0) select 1)];
private "_all_z";
If ((count(_positionsarray select 0))>2) then {
    _all_z = [((_positionsarray select 0) select 2)];
}else{_all_z=[0]};

for "_i" from 1 to ((count _positionsarray)-1) do {
    private _currentpos = (_positionsarray select _i) param [_i,[],[[]],[2,3]];
    _all_x pushBack (_currentpos select 0);
    _all_x pushBack (_currentpos select 0);
    If ((count(_currentpos))>2) then {
        _all_x pushBack (_currentpos select 0);
    };
};

private _x_value = _all_x call FUNC(arithmeticMean);
private _y_value = _all_y call FUNC(arithmeticMean);
private _z_value = _all_z call FUNC(arithmeticMean);

If ((count _all_x)>(count _all_z)) then {
    [_x_value,_y_value];
}else{
    [_x_value,_y_value,_z_value];
};