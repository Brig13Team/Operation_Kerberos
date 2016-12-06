/*
 *  Author: Dorbedo
 *
 *  Description:
 *      send data into the database
 *      aka "fire and forget"
 *
 *  Parameter(s):
 *      ARRAY - DB-Query array - [protocol,value1,value2,....]
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

CHECK(isNil "_this")

private _query = [1,GVAR(sessionID)];
_query append _this;
_query = _query joinString ":";
"extdb3" callExtension _query;
nil;
