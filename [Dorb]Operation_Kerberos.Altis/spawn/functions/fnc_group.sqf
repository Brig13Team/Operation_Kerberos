/*
    Author: Dorbedo

    Description:
    spawns an group

    Parameter(s):
        0 : ARRAY             - Position AGL (3D)
        1 : STRING or CONFIG    - Groupname


    Returns:
    group
*/
#include "script_component.hpp"
_this params[["_position",[],[[]],[2,3]],["_type",[],[[],configfile]]];

If ((IS_ARRAY(_type))&&(isClass(missionConfigFile >> (_type select 0)))) exitWith {
    private _temp = [_position] append _type;
    _temp call FUNC(groupFromArray);
};

LOG_2(_position,_type);
CHECKRET((_position isEqualTo []),grpNull);
CHECKRET(((IS_STRING(_type))&&{_type isEqualTo ""}),grpNull);
private["_types","_ranks","_positions","_group"];
private _types = [];
private _ranks = [];
private _positions = [];
If ((count _position) <3) then {_position set [2,0];};
CHECKRET(((IS_ARRAY(_type))&&(_type isEqualTo [])),grpNull);

If (IS_ARRAY(_type)) then {
    _type = [_type,missionconfigfile] call BIS_fnc_configPath;
};

for "_i" from 0 to ((count _type) - 1) do {
    private _item = _type select _i;
    if (isClass _item) then {
        _types = _types + [getText(_item >> "vehicle")];
        _ranks = _ranks + [getText(_item >> "rank")];
        _positions = _positions + [getArray(_item >> "position")];
    };
};
_group = switch (getNumber(configFile >> "CfgVehicles" >> (_types select 0) >> "side")) do {
    case 0 : {createGroup east};
    case 1 : {createGroup west};
    case 2 : {createGroup resistance};
    default {createGroup GVARMAIN(side)};
};

CHECKRET((_types isEqualTo []),grpNull);

{
    private ["_spawnpos","_unit"];
    private _isMan = getNumber(configFile >> "CfgVehicles" >> _x >> "isMan") == 1;

    If ((count _positions)>(_forEachIndex)) then {
        _spawnpos = [(_position select 0) + ((_positions select (_forEachIndex)) select 0),
                    (_position select 1) + ((_positions select (_forEachIndex)) select 1),
                    (_position select 2)
                    ];
    }else{
        _spawnpos = _position;
    };
    If (_isMan) then {
        _unit = [_spawnpos,_group,_x,"FORM",random(360)] call FUNC(unit);
    }else{
        _unit = ([_spawnpos,_group,_x,random(360),true,true,"FORM"] call FUNC(vehicle)) select 1;
    };

    if ((count _ranks) > _forEachIndex) then {
        [_unit,(_ranks select (_forEachIndex))] call bis_fnc_setRank;
    }else{
        [_unit,0] call bis_fnc_setRank;
    };

}forEach _types;

#ifdef DEBUG_MODE_FULL
    [_group] call EFUNC(common,debug_marker_create);
#endif
_group;
