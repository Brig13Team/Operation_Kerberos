/*
    Author: Dorbedo

    Description:
        deletes locations,objects,marker and groups or an array including these
    Parameter(s):
        0: ARRAY/OBJECT/LOCATION/GROUP/STRING - thing to delete
    Return:
        none
*/
#include "script_component.hpp"
_this params [["_delete",objNull,[[],objNull,"",grpNull,locationNull]]];
switch (typeName _delete) do {
    case "ARRAY" : {
        {_x call EFUNC(COMPONENT,delete);} forEach _delete;
    };
    case "OBJECT" : {
        If (vehicle _delete != _delete) then {
            unassignVehicle _delete;
        }else{
            if ({_x != _delete} count (crew _delete) > 0) then {
                (crew _delete) call EFUNC(COMPONENT,delete);;
            };
        };
        deleteVehicle _delete;
    };
    case "GROUP" : {
        If !(local _delete) then {
            _delete deleteGroupWhenEmpty true;
            [QGVAR(delete),[_delete],_delete] call CBA_fnc_targetEvent;
        }else{
            _delete deleteGroupWhenEmpty true;
            (units _delete) call EFUNC(COMPONENT,delete);;
            {deleteWaypoint _x} forEach (wayPoints _delete);
            deleteGroup _delete;
        };
    };
    case "LOCATION" : {
        If (IS_HASH(_delete)) then {
            HASH_DELETE(_delete);
        }else{
            deleteLocation _delete;
        };
    };
    case "STRING" : {
        deleteMarker _this;
    };
    default {};
};
nil;
