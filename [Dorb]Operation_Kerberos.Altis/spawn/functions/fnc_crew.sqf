/*
    Author: Dorbedo

    Description:
    Creates Crew for Vehicle/Static

    Parameter(s):
        0 :    OBJECT - Fahrzeug
        1 :    GROUP - Gruppe
        2 : BOOL - Mit Einheiten als Cargo

*/
#include "script_component.hpp"
SCRIPT(crew);
_this params[["_vehicle",objNull,[objNull]],["_gruppe",grpNull,[grpNull]],["_withCargo",false,[true]]];

CHECKRET(((isNull _vehicle)||(isNull _gruppe)),[]);
private _crew = [];
If (IS_SIDE(_gruppe)) then {_gruppe = createGroup _gruppe;};
Private ["_crewmen","_unit"];
for "_i" from 1 to (_vehicle emptyPositions "Driver") do {
    _crewmen = GVAR(list_crewmen) SELRND;
    _unit = _gruppe createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
    _unit assignAsDriver _vehicle;
    _unit moveinDriver _vehicle;
    _crew pushBack _unit;
};

for "_i" from 1 to (_vehicle emptyPositions "Gunner") do {
    _crewmen = GVAR(list_crewmen) SELRND;
    _unit = _gruppe createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
    _unit assignAsGunner _vehicle;
    _unit moveinGunner _vehicle;
    _crew pushBack _unit;
};

for "_i" from 1 to (_vehicle emptyPositions "Commander") do {
    _crewmen = GVAR(list_crewmen) SELRND;
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
        _crewmen = GVAR(list_soldiers) SELRND;
        _unit = _group2 createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
        _unit assignAsCargo _vehicle;
        _unit moveInCargo _vehicle;
        _crew pushBack _unit;
    };
    [_crew,_group2]
};
[_crew]
