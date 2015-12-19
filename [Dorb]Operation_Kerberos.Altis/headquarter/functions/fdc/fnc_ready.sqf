/*
    Author: Dorbedo
    
    Description:
        returns if fdc is ready
    
    Parameter(s):
        0 : OBJECT    - Artillery to register
    
*/
#include "script_component.hpp"
SCRIPT(ready);
_this params ["_type"];
private _return = switch (_type) do {
    case "artillery" : {(count GVAR(fdc_artilleries)>0)};
    case "mortar" : {(count GVAR(fdc_mortars)>0)};
    case "rocket" : {(count GVAR(fdc_rocket)>0)};
    default {((count GVAR(fdc_artilleries)>0)||(count GVAR(fdc_mortars)>0)||(count GVAR(fdc_rocket)<0))};
};
_return;