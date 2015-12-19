/*
    Author: Dorbedo
    
    Description:
        searches Area around artilleriepositions and places Orders
        
*/
#include "script_component.hpp"
SCRIPT(defend_artypos);


If ((GVAR(fdc_mortars) isEqualTo [])&&(GVAR(fdc_artilleries) isEqualTo [])&&(GVAR(fdc_rocket) isEqualTo [])) exitwith {};

GVAR(fdc_mortars) = GVAR(fdc_mortars) - objNull;
GVAR(fdc_artilleries) = GVAR(fdc_artilleries) - objNull;
GVAR(fdc_rocket) = GVAR(fdc_rocket) - objNull;

private ["_searchArea","_newcommands"];
_newcommands = [];

_searchArea = {
    params["_unit","_min","_max","_type"];
    TRACEV_4(_unit,_min,_max,_type);
    private "_targetpos";
    _targetpos = 
    {
        if ((_x distance _unit)<_max) exitwith {getPos _x};
        []
    }forEach allPlayers;
    CHECK(_targetpos isEqualTo [])
    If ((_targetpos distance _unit)>_min) exitwith {
        _newcommands pushBack [_targetpos,_type,3];
    };
    If (!(GVAR(fdc_rocket) isEqualTo [])) exitwith {
        _newcommands pushBack [_targetpos,_type,3];
    };
    If (!(GVAR(fdc_artilleries) isEqualTo [])) exitwith {
        _newcommands pushBack [_targetpos,_type,3];
    };
    If (!(GVAR(fdc_mortars) isEqualTo [])) exitwith {
        _newcommands pushBack [_targetpos,_type,3];
    };
};



{
    [_x,70,850,1] call _searchArea;
}forEach GVAR(fdc_mortars);
{
    [_x,850,1200,0] call _searchArea;
}forEach GVAR(fdc_artilleries);
{
    [_x,820,1500,2] call _searchArea;
}forEach GVAR(fdc_rocket);

{
    _x call FUNC(fdc_placeOrder);
}forEach _newcommands;


