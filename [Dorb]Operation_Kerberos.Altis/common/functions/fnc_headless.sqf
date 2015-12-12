/*
    Author: Dorbedo
    
    Description:
        Headless perframeEH
        
    [{ [] call EFUNC(common,headless) } , 30, [] ] call CBA_fnc_addPerFrameHandler;
    
    
*/
#include "script_component.hpp"
SCRIPT(headless);

CHECK(!isMultiplayer)
CHECK((isnil "HC1")&&(isnil "HC2")&&(isnil "HC3"))
ISNILS(GVAR(headless_groups),[]);

private "_groups";
_groups = GVAR(headless_groups);

{
    [_x] call FUNC(headless_move);
}forEach _groups;

_groups = [];

{
    If (side _x != GVARMAIN(playerside) ) then {
        If (((groupOwner _x) < 3)&&(!(GETVAR(_x,EGVAR(mission,istarget),false)))) then {
            _groups pushBack _x;
        };
    };
}forEach allGroups;

If (!(GVAR(headless_groups) isEqualTo [])) then {
    LOG(FORMAT_2("Gewechselte Gruppen=%1 \n Neue Gruppen = %2",GVAR(headless_groups),_groups));
};
GVAR(headless_groups) = [];
GVAR(headless_groups) = _groups;
GVAR(headless_groups)
