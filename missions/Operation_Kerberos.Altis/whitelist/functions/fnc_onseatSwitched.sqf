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
SCRIPT(EH_seatSwitched);

params["_unit1","_unit2","_vehicle"];
private["_assignedVehicleRole","_parameter"];
CHECK(!(_vehicle isKindOf "AIR"))
if (isPlayer _unit1) then {
    _assignedVehicleRole = assignedVehicleRole _unit1;
    _parameter = [group _unit1,_assignedVehicleRole select 0,_unit1];
    if (count _assignedVehicleRole > 1) then { _parameter pushBack (_assignedVehicleRole select 1); } else { _parameter pushBack []; };
    [QGVAR(pilotcheck),_parameter,_unit1] call CBA_fnc_targetEvent;
};

if (isPlayer _unit2) then {
    _assignedVehicleRole = assignedVehicleRole _unit2;
    _parameter = [group _unit2,_assignedVehicleRole select 0,_unit2];
    if (count _assignedVehicleRole > 1) then { _parameter pushBack (_assignedVehicleRole select 1); } else { _parameter pushBack []; };
    [QGVAR(pilotcheck),_parameter,_unit1] call CBA_fnc_targetEvent;
};
