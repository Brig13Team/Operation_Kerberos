/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Opens the tablet
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#define INCLUDE_GUI
#include "script_component.hpp"

CHECK(!([] call FUNC(canOpenMenu)))

createDialog QAPP(dialog);
