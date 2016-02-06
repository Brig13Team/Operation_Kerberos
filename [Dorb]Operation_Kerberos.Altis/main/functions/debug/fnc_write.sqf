/*
    Author: Dorbedo
    
    Description:
        writes message into logfile
    
    Parameter(s):
        0: STRING - Message
        
    Return
        None
*/
#include "script_component.hpp"
_this params["_message"];
diag_log text _message;
nil;