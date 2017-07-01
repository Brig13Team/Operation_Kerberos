/*
 *  Author: iJesuz
 *
 *  Description:
 *      return TRUE if __THIS has active mission and FALSE if not
 *
 *  Parameter(s):
 *      -
 *
 *  Returns:
 *      BOOLEAN
 */
#include "script_component.hpp"

private _missions = THIS_GET("missions");

if (_missions isEqualTo []) exitWith { false };

true
