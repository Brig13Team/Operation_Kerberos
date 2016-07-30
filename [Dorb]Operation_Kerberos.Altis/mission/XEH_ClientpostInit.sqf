/*
    Author: Dorbedo
    
    Description:
        
    
*/
#include "script_component.hpp"


[QGVAR(earthquake),{
    if (!(vehicle player isKindof 'Air')) then {
        private _rand=(floor(random 4)+1);
        [_rand]spawn BIS_fnc_earthquake;
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(sandstorm),
    {[] call FUNC(objects_device_effect_sandstorm_init);}
] call CBA_fnc_remoteEvent;

[QGVAR(killedMessage),
    {[localize LSTRING(KILL),[format [localize LSTRING(KILL_KILLED),_this select 0]],"data\icon\icon_target.paa",true] call EFUNC(interface,disp_info);}
] call CBA_fnc_addEventHandler;

[QGVAR(suitcase_handle),
    {
        params ["_suitcase"];
        [{_this call FUNC(objects_handle); }, 1, [_suitcase]] call CBA_fnc_addPerFrameHandler;
    }
] call CBA_fnc_addEventHandler;
