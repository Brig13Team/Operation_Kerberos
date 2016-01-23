/*
    Author: Dorbedo
    
    Description:
        postinit server
*/
#include "script_component.hpp"

#ifdef DORB_PILOT_WHITELIST_ENABLED
    GVAR(reserved_pilot)=[];
    GVAR(reserved_pilot_slot) = true;
    [] call FUNC(userconfig);
    [QGVAR(pilot_whitelist), "onPlayerConnected", {
        [] call FUNC(userconfig);
        If (_uid in GVAR(reserved_pilot)) then {
            _owner publicVariableClient QGVAR(reserved_pilot_slot) ;
        };
    }] call BIS_fnc_addStackedEventHandler;
#endif


#ifdef DORB_ZEUS_WHITELIST_ENABLED
    GVAR(reserved_zeus)=[];
    GVAR(reserved_zeus_slot) = true;
    [] call FUNC(userconfig);
    [QGVAR(zeus_whitelist), "onPlayerConnected", {
        [] call FUNC(userconfig);
        If (_uid in GVAR(reserved_zeus)) then {
            _owner publicVariableClient QGVAR(reserved_zeus_slot) ;
        };
    }] call BIS_fnc_addStackedEventHandler;
#endif