/*
    Author: Dorbedo

    Description:
        disables TFR

    Parameter(s):
        0 : OBJECT - Unit where the TFR is disabled
    Returns:
        nothing

*/
#include "script_component.hpp"
SCRIPT(disableTFR);
_this params [
    ["_unit",objNull,[objNull]]
    ];
SETPAVAR(_unit,tf_unable_to_use_radio,true);
