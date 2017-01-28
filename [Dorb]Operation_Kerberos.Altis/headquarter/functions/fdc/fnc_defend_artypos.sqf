/*
    Author: Dorbedo

    Description:
        searches Area around artilleriepositions and places Orders

*/
#include "script_component.hpp"

private _newcommands = [];
private _fnc_searchArea = {
    _this params["_unit","_min","_max","_type"];
    //TRACEV_4(_unit,_min,_max,_type);
    private _targetpos = [];
    {
        if (((_x distance _unit)<_max)&&{(GVARMAIN(side) knowsAbout _x)>1})exitwith {
            _targetpos = getPos _x;
        };
    }forEach allPlayers;
    CHECK(_targetpos isEqualTo [])
    If ((_targetpos distance _unit)>_min) exitwith {
        [_targetpos,_type,1] call FUNC(fdc_placeOrder);
    };
    If (!((HASH_GET(GVAR(FDC),"artilleries")) isEqualTo [])) exitwith {
        [_targetpos,_type,1] call FUNC(fdc_placeOrder);
    };
    If (!((HASH_GET(GVAR(FDC),"rockets")) isEqualTo [])) exitwith {
        [_targetpos,_type,2] call FUNC(fdc_placeOrder);
    };
    [_targetpos,_type,-1] call FUNC(fdc_placeOrder);
};

{
    [_x,70,850,1] call _fnc_searchArea;
}forEach ( HASH_GET(GVAR(FDC),"mortars") );
{
    [_x,850,1200,0] call _fnc_searchArea;
}forEach (HASH_GET(GVAR(FDC),"artilleries"));
{
    [_x,820,1500,2] call _fnc_searchArea;
}forEach (HASH_GET(GVAR(FDC),"rockets"));
