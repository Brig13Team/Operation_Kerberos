/*
    Author: Dorbedo
    
    Description:
        
    
*/
#include "script_component.hpp"


["earthquake",{
    if (!(vehicle player isKindof 'Air')) then {
        private _rand=(floor(random 4)+1);
        [_rand]spawn BIS_fnc_earthquake;
    };
}] call CBA_fnc_addEventHandler;

["sandstorm",
    {[] call FUNC(objects_device_effect_sandstorm_init);}
] call CBA_fnc_remoteEvent;