/*
 *  Author: Dorbedo
 *
 *  Description:
 *      closes the tablet
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

if (!canSuspend) exitWith {
    [] spawn FUNC(close);
};

CHECK(!dialog)

closeDialog IDD_ECHIDNA_MAIN;
false;
