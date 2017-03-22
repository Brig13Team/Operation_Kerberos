/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Post-Init
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

GVAR(sides) = [GVARMAIN(playerside)];
GVAR(tempPropertiesRadio) = locationNull;
GVAR(tempProperties) = [];

[] call FUNC(createRadioList);
