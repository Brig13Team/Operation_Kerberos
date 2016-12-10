/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the current time
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      ARRAY - [YY:MM:DD:HH:MM:SS]
 *
 */
#include "script_component.hpp"
CHECK(!GVAR(initialized))
private _return = call compile ("extdb3" callExtension "9:LOCAL_TIME");
(_return select 1);
