/*
 *  Author: Dorbedo
 *
 *  Description:
 *      registers a data to be syncronized upon missionstart
 *
 *  Parameter(s):
 *      0 : STRING - name of Variable
 *      1 : NAMESPACE - the namespace where the variable is stored (default: missionNamespace)
 *              supports: [missionNamespace,uiNamespace,OBJECT,GROUP,LOCATION]
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params [["_varName","",[""]],["_namespace",missionNamespace,[missionNamespace,uiNamespace,objNull,grpNull,locationNuLL]]]

CHECK(_varname isEqualTo "")

GVAR(dataToSync) pushBackUnique [_varname,_namespace];
