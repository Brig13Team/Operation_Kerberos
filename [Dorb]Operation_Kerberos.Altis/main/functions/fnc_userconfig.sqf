/*
    Author: Dorbedo
    
    Description:
        Loads Variables from Userconfig
    
    Parameter(s):
        None
        
    Return
        None
*/
#include "script_component.hpp"

If !(isMultiplayer) exitWith {
    ["_SP_AI_", "_SP_PLAYER_"]
};

private _userconfig = compile preprocessFileLineNumbers "\userconfig\kerberos\dorb_userconfig.sqf";
if (!isNil "_userconfig") then {
    _userconfig;
}else{
    [];
};