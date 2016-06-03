/*
    Author: Dorbedo
    
    Description:
        postinit server
*/
#include "script_component.hpp"
#ifdef DORB_PILOT_WHITELIST_ENABLED
    GVAR(reserved_pilot_slot) = true;
    [QGVAR(pilot_whitelist), "onPlayerConnected", {
        private _userconfig = [] call FUNC(userconfig);
        If (_uid in _userconfig) then {
            _owner publicVariableClient QGVAR(reserved_pilot_slot) ;
        };
    }] call BIS_fnc_addStackedEventHandler;
#endif
