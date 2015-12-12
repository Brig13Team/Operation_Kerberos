/*
    author: iJesuz

    description:
        part of only pilots

    parameter:
        0 : OBJECT - vehicle
        1 : UNIT - unit1
        2 : UNIT - unit2
*/
#include "script_component.hpp"
SCRIPT(XEH_seatSwitched);

params["_vehicle","_unit1","_unit2"];
private["_assignedVehicleRole","_parameter"];

if (isPlayer _unit1) then {
    _assignedVehicleRole = assignedVehicleRole _unit1;
    _parameter = [group _unit1,_assignedVehicleRole select 0,_unit1];
    if (count _assignedVehicleRole > 1) then { _parameter pushBack (_assignedVehicleRole select 1); } else { _parameter pushBack []; };

    _parameter remoteExec [QUOTE(FUNC(xeh_getin)),_unit1];
};

if (isPlayer _unit2) then {
    _assignedVehicleRole = assignedVehicleRole _unit2;
    _parameter = [group _unit2,_assignedVehicleRole select 0,_unit2];
    if (count _assignedVehicleRole > 1) then { _parameter pushBack (_assignedVehicleRole select 1); } else { _parameter pushBack []; };

    _parameter remoteExec [QUOTE(FUNC(xeh_getin)),_unit2];
};
