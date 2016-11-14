/*
 *  Author: Dorbedo
 *
 *  Description:
 *      puts a message into the log
 *
 *  Parameter(s):
 *      0 : STRING - Message to log
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params["_message"];
diag_log text _message;
nil;
