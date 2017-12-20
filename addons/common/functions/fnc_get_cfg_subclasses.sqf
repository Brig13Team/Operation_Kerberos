/*
    Author: Dorbedo
    
    Description:
        gets all specific subclasses of given type
        recursive
        made for Hitpoints
        
    Parameter(s):
        0 : STRING    - Classname
        1 : CONFIG    - Main Config where the subclasses are searched
        
    Returns
        All Subclasses of given Classname
        
*/
#include "script_component.hpp"
_this params [["_classname","",[""]],["_config",(configfile>>"CfGVehicles"),[configfile]]];
TRACEV_2(_classname,_config);

private _return = [];
private _subclasses = (_config) call BIS_fnc_getCfgSubClasses;
private _temp = [];
_temp = ((_config >> _classname) call BIS_fnc_getCfgSubClasses);
If (!(_temp isEqualTo [])) then {
    {
        _return pushBack (_config>>_classname>>_x);
    }forEach _temp;
};
_temp = [];
{
    If (_x == _classname) then {
        _temp = ((_config >> _classname) call BIS_fnc_getCfgSubClasses);
        {
            _return pushBack (_config>>_classname>>_x);
        }forEach _temp;
    }else{
        _temp = [_classname,(_config>>_x)] call FUNC(get_cfg_subclasses);
        _return append _temp;
    };
}forEach _subclasses;

_return;








