/**
 * Author: Dorbedo
 * opens the main menu
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

If !(hasInterface) exitWith {};

If !(call FUNC(canOpenMenu)) exitWith {
    LOG("Menu can not be opened");
};

createDialog QAPP(dialog);
