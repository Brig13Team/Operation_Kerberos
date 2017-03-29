/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Checks if a player can be given the ability to speak a language
 *
 *  Parameter(s):
 *      0 : STRING - the language key
 *
 *  Returns:
 *      BOOL - the language can be added
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_languageKey","NoKey",[""]]];

({ ((_x select 0) == _languageKey) } count acre_sys_core_languages)>0
