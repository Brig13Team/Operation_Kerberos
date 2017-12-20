/*
 *  Author: DOrbedo
 *
 *  Description:
 *      returns all local global hashes
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      array
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
(nearestObjects [DORB_HASH_POSITION, [], 1] select {((typeOf _x) isEqualTo "CBA_NamespaceDummy")&&{local _x}});
