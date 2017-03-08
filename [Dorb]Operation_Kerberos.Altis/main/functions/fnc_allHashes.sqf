/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns all Hash locations (including new ones, lost ones)
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      ARRAY - Array of locations
 *
 */
#include "script_component.hpp"

private _namespaces = call CBA_fnc_allNamespaces;

_namespaces select {IS_HASH(_x)};
