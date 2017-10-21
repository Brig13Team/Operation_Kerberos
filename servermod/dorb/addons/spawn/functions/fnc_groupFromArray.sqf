/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#include "script_component.hpp"

_this params [
    ["_centerPos",[],[]],
    ["_types",[],[]],
    ["_ranks",[],[]],
    ["_centerPoss",[],[]],
    ["_side",GVARMAIN(side),[west]]
];

private _group = createGroup _side;

{
    private ["_spawnpos","_unit"];
    private _isMan = getNumber(configFile >> "CfgVehicles" >> _x >> "isMan") == 1;

    If ((count _centerPoss)>(_forEachIndex)) then {
        _spawnpos = [(_centerPos select 0) + ((_centerPoss select (_forEachIndex)) select 0),
                    (_centerPos select 1) + ((_centerPoss select (_forEachIndex)) select 1),
                    (_centerPos select 2)
                    ];
    }else{
        _spawnpos = _centerPos;
    };
    If (_isMan) then {
        _unit = [_spawnpos,_group,_x,"NONE",random(360)] call FUNC(unit);
    }else{
        _unit = ([_spawnpos,_group,_x,random(360),true,true,"NONE"] call FUNC(vehicle)) select 1;
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
