/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the hitpart Eventhandler
 *
 */
#include "script_component.hpp"

["BWA3_Puma_Fleck", "hitpart", {_this call rhs_fnc_hitHandler;},true,[],true] call CBA_fnc_addClassEventHandler;
["BWA3_Leopard2A6M_Fleck", "hitpart", {_this call rhs_fnc_hitHandler;},true,[],true] call CBA_fnc_addClassEventHandler;
