/*
    Author: Dorbedo
    
    Description:
        Repairpoint init
    
*/
#include "script_component.hpp"
SCRIPT(repairpoint_init);
ISNILS(EGVAR(player,respawn_fnc),[]);

private ["_reppoint"];
_reppoint = [];

For "_i" from 0 to 20 do {
    If (!isNil format["DORB_REPPOINT_%1",_i]) then {
        _reppoint pushback format["DORB_REPPOINT_%1",_i];
    };
};

{
    EGVAR(player,respawn_fnc) pushback format[QUOTE(%1 addAction [localize 'STR_DORB_COMMON_REP_POINT2',{_this call FUNC(repairpoint);},[],6,true,true,'','(vehicle player != player)&&((driver (vehicle player)) == player)&&((player distance %1)<15)']),_x];
}forEach _reppoint;
