/*
    Author: Dorbedo

    Description:
    spawns a vehicle

    Parameter(s):
        0 : ARRAY     - Position AGL (3D)
        1 : GROUP/SIDE     - Group
        2 : STRING     - Unittyp
        (optional)
        3 : SCALAR    - Direction
        4 : BOOL        - with Crew
        5 : BOOL        - Precise Position (default: true)
        6 : STRING    - special properties

    Returns:
    [_vehicle,_crew,_group]
*/
#include "script_component.hpp"
_this params[
    ["_position",[],[[]],[2,3]],
    ["_group",grpNull,[grpNull,east]],
    ["_unittype","",[""]],
    ["_direction",(floor(random 360)),[0]],
    ["_withcrew",true,[true]],
    ["_precisePos",true,[true]],
    ["_special","NONE",[""]]
    ];
TRACEV_6(_position,_unittype,_group,_direction,_withcrew,_precisePos,_special);
private _changeleader = false;
If (IS_SIDE(_group)) then {
    _group = createGroup _group;
    _changeleader=true;
};

CHECKRET(((_position isEqualTo [])||(_unittype isEqualTo "")||(isNull _group)),[]);


private _simulation = getText(configFile >> "CfgVehicles" >> _unittype >> "simulation");
private "_vehicle";
switch (tolower _simulation) do {
    case "soldier": {
        _vehicle = _group createunit [_unittype,_position,[],0,_special];
    };
    case "airplanex";
    case "helicopterrtd";
    case "helicopterx": {
        If (((_position select 2)>30)&&(_special=="NONE")) then {
            _special = "FLY";
        };
        _vehicle = createVehicle [_unittype,_position,[],0,_special];
    };
    default {
        _vehicle = createvehicle [_unittype,_position,[],0,_special];
        _group addVehicle _vehicle;
    };
};

_vehicle setDir _direction;

If (_precisePos) then {_vehicle setPos _position;};

if (_simulation == "airplanex") then {
    _vehicle setVelocity [100 * (sin _direction), 100 * (cos _direction), 0];
};
If (_withcrew) then {
    _group = [_vehicle,_group] call FUNC(crew);
};
if (_changeleader) then {
    _group selectLeader (commander _vehicle);
};
[_group,_vehicle];