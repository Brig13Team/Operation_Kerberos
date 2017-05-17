/*
    Author: Dorbedo

    Description:
    Creates Crew for Vehicle/Static

    Parameter(s):
        0 :    OBJECT - Fahrzeug
        1 :    GROUP - Gruppe
        2 : BOOL - Mit Einheiten als Cargo

*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params[["_vehicle",objNull,[objNull]],["_gruppe",grpNull,[grpNull,east]],["_withCargo",false,[true]]];

CHECKRET(((isNull _vehicle)||(IS_GROUP(_gruppe)&&{isNull _gruppe})),[]);
private _crew = [];
If (IS_SIDE(_gruppe)) then {
    _gruppe = createGroup _gruppe;
    _gruppe addVehicle _vehicle;
};
Private ["_crewmen","_unit"];

private _list_crewmen = ["crewmen"] call EFUNC(spawn,getUnit);
If ((_vehicle isKindOf "UAV_base_01_F")||(_vehicle isKindOf "UAV_base_01_F")||(_vehicle isKindOf "UGV_base_01_F")||(toLower (typeOf _vehicle) in ["b_sam_system_01_f","b_sam_system_02_f","b_aaa_system_01_f"])) exitWith {
    switch (side _gruppe) do {
        case (civilian);
        case (west) : {
            _list_crewmen = ["B_soldier_UAV_F"];
        };
        case (resistance) : {
            _list_crewmen = ["I_soldier_UAV_F"];
        };
        default {
            _list_crewmen = ["O_soldier_UAV_F"];
        };
    };
    createVehicleCrew _vehicle;
    (crew _vehicle) joinSilent _gruppe;
    [crew _vehicle]
};


private _list_soldiers = ["soldiers"] call EFUNC(spawn,getUnit);
//TRACEV_3(_list_crewmen,_gruppe,_vehicle);
{
    _crewmen = selectRandom _list_crewmen;
    _unit = _gruppe createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
    _unit assignAsDriver _vehicle;
    _unit moveinDriver _vehicle;
    _crew pushBack _unit;
} forEach fullCrew [_vehicle,"driver",true];

{
    _crewmen = selectRandom _list_crewmen;
    _unit = _gruppe createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
    _unit assignAsCommander _vehicle;
    _unit moveinCommander _vehicle;
    _crew pushBack _unit;
} forEach fullCrew [_vehicle,"commander",true];

{
    if (isNull (_x select 0)) then {
        _crewmen = selectRandom _list_crewmen;
        _unit = _gruppe createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
        _unit assignAsGunner _vehicle;
        _unit moveinGunner _vehicle;
        _crew pushBack _unit;
    };
} forEach fullCrew [_vehicle,"gunner",true];

{
    _x params ["_curUnit","_role","_cargoIndex","_turretPath","_isPersonTurret"];
    If ((isNull _curUnit)&&(!_isPersonTurret)) then {
        _crewmen = selectRandom _list_crewmen;
        _unit = _gruppe createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
        _unit assignAsTurret [_vehicle,_turretPath];
        _unit moveInTurret [_vehicle,_turretPath];
        _crew pushBack _unit;
    };
} forEach fullCrew [_vehicle,"turret",true];

If !(_withCargo) exitWith {[_crew]};

private "_group2";
{
    _x params ["_curUnit","_role","_cargoIndex","_turretPath","_isPersonTurret"];
    If (isNull _curUnit) then {
        If (isNil "_group2") then {
            _group2 = createGroup (side _gruppe);
        };
        _crewmen = selectRandom _list_soldiers;
        _unit = _group2 createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
        _unit assignAsCargoIndex [_vehicle, _cargoIndex];
        _unit moveInCargo [_vehicle, _cargoIndex];
        _crew pushBack _unit;
    };
} forEach fullCrew [_vehicle,"cargo",true];
[_crew,_group2];


/*
for "_i" from 1 to (_vehicle emptyPositions "Driver") do {
    _crewmen = selectRandom _list_crewmen;
    _unit = _gruppe createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
    _unit assignAsDriver _vehicle;
    _unit moveinDriver _vehicle;
    _crew pushBack _unit;
};

for "_i" from 1 to (_vehicle emptyPositions "Gunner") do {
    _crewmen = selectRandom _list_crewmen;
    _unit = _gruppe createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
    _unit assignAsGunner _vehicle;
    _unit moveinGunner _vehicle;
    _crew pushBack _unit;
};

for "_i" from 1 to (_vehicle emptyPositions "Commander") do {
    _crewmen = selectRandom _list_crewmen;
    _unit = _gruppe createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
    _unit assignAsCommander _vehicle;
    _unit moveinCommander _vehicle;
    _crew pushBack _unit;
};

If (_withCargo) exitWith {
    private ["_platzanzahl"];
    _platzanzahl = _vehicle emptyPositions "cargo";
    _group2 = createGroup GVARMAIN(side);
    for "_i" from 0 to (_platzanzahl - 1) do {
        _crewmen = selectRandom _list_soldiers;
        _unit = _group2 createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
        _unit assignAsCargo _vehicle;
        _unit moveInCargo _vehicle;
        _crew pushBack _unit;
    };
    [_crew,_group2];
};

[_crew];
*/
