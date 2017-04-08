/*
 * Author: Dorbedo
 *
 */
#include "script_component.hpp"

If (hasInterface) then {
    [] spawn FUNC(ArsenalRemoveRadio);

    [
        QGVARMAIN(arsenalClosed),
        {[] spawn FUNC(ArsenalRemoveRadio);}
    ] call CBA_fnc_addEventHandler;
};
