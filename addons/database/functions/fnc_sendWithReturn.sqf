/*
 *  Author: Dorbedo
 *
 *  Description:
 *      sets a single Value to DB
 *
 *  Parameter(s):
 *      ARRAY - DB-Query array - [protocol,value1,value2,....]
 *
 *  Returns:
 *      ANY - return of protocol
 *
 */
#include "script_component.hpp"

If (isNil "_this") exitWith {};

private _query = [0, GVAR(sessionID)];
_query append _this;
_query = _query joinString ":";
private _return = call compile ("extdb3" callExtension _query);
((_return select 1) select 0)
