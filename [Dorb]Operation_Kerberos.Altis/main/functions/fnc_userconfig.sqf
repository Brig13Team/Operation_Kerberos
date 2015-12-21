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
DORB_RESERVED_PILOT = ["_SP_AI_", "_SP_PLAYER_"];
DORB_RESERVED_ZEUS = ["_SP_AI_", "_SP_PLAYER_"];
};

private _userconfig = compile preprocessFileLineNumbers "\userconfig\kerberos\dorb_userconfig.sqf";
if (!isNil "_userconfig") then {
    [] call _userconfig; // Load the global defaults
};
ISNILS(DORB_RESERVED_PILOT,[]);
ISNILS(DORB_RESERVED_ZEUS,[]);

/// compatibility -> remove after change of userconfig

GVAR(reserved_pilot) = DORB_RESERVED_PILOT;
GVAR(reserved_zeus) = DORB_RESERVED_ZEUS;