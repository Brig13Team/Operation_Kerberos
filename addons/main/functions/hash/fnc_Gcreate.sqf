/*
 *  Author: Dorbedo
 *
 *  Description:
 *      creates a local hash
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _ret = createSimpleObject [DORB_HASH_TYPE, AGLToASL DORB_HASH_POSITION];
DORB_HASH_CREATED_NEW_GLOBAL pushBack _ret;
_ret;
