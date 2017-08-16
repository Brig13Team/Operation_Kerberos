#include "script_component.hpp"
/**
 * Author: Dorbedo
 * recompiles functions defined via macro
 *
 * Arguments:
 * 0: component name <STRING>
 *
 * Return Value:
 * scripthandle <handle>
 *
 */

params[["_componentname","",[""]]];

if !(canSuspend) then {
    _this spawn FUNC(recompile);
};

If !(_componentname isEqualTo "") exitWith {
    [] call (GVARMAIN(recompile_cache) getVariable [_componentname,{}]);
};

{
    [] call (GVARMAIN(recompile_cache) getVariable [_x,{}]);
} count (allVariables GVARMAIN(recompile_cache));
