/*
 *  Author: Dorbedo
 *  Original Author: ACRE2 team (https://github.com/IDI-Systems/acre2)
 *
 *  Description:
 *      returns all keys of a hash
 *
 *  Parameter(s):
 *      0 : LOCATION - Hash
 *
 *  Returns:
 *      ARRAY - Array with all keys
 *
 */
#include "script_component.hpp"

_this params [["_hash",locationNull,[locationNull]]];

If !(IS_HASH(_hash)) exitWith {[]};

((allVariables _hash) select {!isNil{_hash getVariable _x}});
