/*
 * Author: Dorbedo
 *
 */
#include "script_component.hpp"

If (hasInterface) then {
    [] spawn FUNC(ArsenalRemoveRadio);
};

[
    QGVAR(removeRadio),
    {[] spawn FUNC(ArsenalRemoveRadio);}
] call CBA_fnc_addEventHandler;
