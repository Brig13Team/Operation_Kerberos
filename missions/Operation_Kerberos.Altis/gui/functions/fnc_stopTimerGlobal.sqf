/**
 * Author: Dorbedo
 * stops the timer globally
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

GVAR(timer_code) = {};
GVAR(timer_parameter) = [];
GVAR(timer_finish) = -1;

publicVariable QGVAR(timer_finish);
