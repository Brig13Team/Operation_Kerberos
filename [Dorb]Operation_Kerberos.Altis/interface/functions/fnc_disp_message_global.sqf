/*
    Author: Dorbedo
    
    Description:
        displays message global
        (is localized on client, if String is given)
    
    Parameter(s):
        0 :    STRING - Title 
        1 :    STRING - Beschreibung
    
    
    
*/
#include "script_component.hpp"
SCRIPT(disp_message_global);
params[["_title","",[""]],["_content","",[""]]];

[{_this spawn FUNC(disp_message);},[_title,_content],-1] call EFUNC(common,NetEvent);