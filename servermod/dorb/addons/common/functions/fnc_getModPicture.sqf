/**
 * Author: Dorbedo
 * returns the beautified modname of a unit/weapon
 *
 * Arguments:
 * 0: <CONFIG> the config entry of the target
 *
 * Return Value:
 * <STRING> the beautified modname
 *
 */

#include "script_component.hpp"

params [["_config",configNull,[configNull]]];

private _modName = [_config] call FUNC(getMod);

if !(_modName isEqualTo "") then {
    _modName = (modParams [_modName,["logoSmall"]]) param [0,""];
};
_modName
