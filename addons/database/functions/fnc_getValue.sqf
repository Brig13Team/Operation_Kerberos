/*
 *  Author: Dorbedo
 *
 *  Description:
 *      get a Value from DB
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

switch (_return select 0) do {
    case 0 : {ERROR(format[ARR_2("Database Error: %1",(_result select 1))]);};
    case 2 : {_return = (_return select 1) call FUNC(bigData);};
};
(_return select 1);
