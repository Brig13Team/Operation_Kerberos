/*
 *  Author: iJesuz
 *
 *  Description:
 *      spawn side mission
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *      1 : ANY     - (optional) additional parameter
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_hash"];

private _name = HASH_GET(_hash, "type");
private _fnc = format["%1_%2", QFUNC(sidemission), _name];
_this call (missionNamespace getVariable [_fnc, {}]);

HASH_SET(_hash, "state", "init");
