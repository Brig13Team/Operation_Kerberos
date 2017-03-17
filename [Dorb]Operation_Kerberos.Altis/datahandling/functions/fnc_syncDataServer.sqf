/*
 *  Author: Dorbedo
 *
 *  Description:
 *      syncronizes the data to a client
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#include "script_component.hpp"
_this params ["_playerObject"];

private _data = [];
{
    _x params ["_varName","_namespace"];
    _data pushBack [_namespace,_varname,_namespace getVariable _varname];
    nil;
} count GVAR(dataToSync);

GVAR(syncData) = _data;

(owner _playerObject) publicVariableClient QGVAR(syncData);
