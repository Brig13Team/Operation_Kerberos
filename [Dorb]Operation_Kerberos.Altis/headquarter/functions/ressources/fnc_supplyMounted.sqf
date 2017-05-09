/*
 *  Author: Dorbedo
 *
 *  Description:
 *      supplys with Infantry
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      SCALAR - costs
 *
 */
#include "script_component.hpp"

private _centerpos = HASH_GET(GVAR(dangerzones),"centerpos");

private _transporttype = ["ifv"] call EFUNC(spawn,getUnit);
private _spawnPos = [_centerpos] call FUNC(ressources_getsaveSpawnPos);

([_spawnPos,GVARMAIN(side),_transporttype] call EFUNC(spawn,vehicle)) params ["_transportGroup","_transportVehicle"];

private _groupType = ["mounted"] call EFUNC(spawn,getGroup);
private _newGroup = [_spawnpos, _grouptype] call EFUNC(spawn,group);

{
    _x assignAsCargo _transportVehicle;
    _x moveInCargo _transportVehicle;
}forEach units _newGroup;

_transportGroup setVariable [QGVAR(spawnpos),_spawnPos];
_transportGroup setVariable [QGVAR(timeout),15*60];
_transportGroup setVariable [QGVAR(state),"supplyunload"];

_newGroup setVariable [QGVAR(spawnpos),_spawnPos];
_newGroup setVariable [QGVAR(timeout),15*60];
_newGroup setVariable [QGVAR(state),"inTransport"];


/*

_transportGroup addWaypoint [_centerpos,200];
_transportVehicle doMove _centerpos;

[
    {
        (_this select 0) params ["_transportGroup","_newGroup","_centerpos","_transportVehicle","_spawnPos"];
        If (((_transportVehicle distance _centerpos) > 400)&&(canMove _transportVehicle)) exitWith {};
        [_this select 1] call CBA_fnc_removePerFrameHandler;

        {
            unassignVehicle (_x);
            moveOut _x;
        } forEach (units _newGroup);
        [_newGroup,"attack"] call FUNC(registerGroup);
        [_newGroup,"idle",getPos (leader _newGroup)] call FUNC(state_set);

        If (canMove _transportVehicle) then {
            [_transportGroup,"attack"] call FUNC(registerGroup);
            [_transportGroup,"idle",getPos (leader _newGroup)] call FUNC(state_set);
        }else{
            private _defendPos = getPos (selectrandom (HASH_GET(GVAR(POI),"Locations")));
            [_transportGroup,"defend"] call FUNC(registerGroup);
            [_newGroup,"idle",_defendPos] call FUNC(state_set);
        };
    },
    10,
    [_transportGroup,_newGroup,_centerpos,_transportVehicle,_spawnPos]
] call CBA_fnc_addPerFrameHandler;
*/
((([_newGroup] call FUNC(getstrengthAIGroup)) param [0,0]) + (([_newGroup] call FUNC(getstrengthAIGroup)) param [0,0]));
