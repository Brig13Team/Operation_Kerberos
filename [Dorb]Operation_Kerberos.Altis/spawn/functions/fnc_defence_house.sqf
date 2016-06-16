/*
    Author: Dorbedo

    Description:
        spawns predefined things into houses

    Parameter(s):
        0 : OBJECT - House

    
*/
#include "script_component.hpp"
_this params [["_house",objNull,[objNull]]];

If (isNull _house) exitWith {};

private _houseType = typeOf _house;

private _allCfg = (format["getText(_x >> 'housetype') isEqualTo '%1'",_houseType]) configClasses (missionConfigFile >> "city_houses" >> str GVARMAIN(side));

if ((count _cfg)<1) exitWith {};

private _cfg = selectRandom _allCfg;

private _material = getArray(_cfg>>"material");
private _vehicles = getArray(_cfg>>"vehicles");
private _soldiers = getArray(_cfg>>"soldiers");
private _targets = getArray(_cfg>>"targets");

[_house,_material,_vehicles,_soldiers] call FUNC(exec_housemacro);


