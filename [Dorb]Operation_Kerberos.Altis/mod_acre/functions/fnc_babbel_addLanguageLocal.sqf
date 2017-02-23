/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds a Language locally to a user
 *
 *  Parameter(s):
 *       0 : STRING - the language key
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_languageKey","",[]]];

If ((_languageKey isEqualTo "")||{!([_languageKey] call FUNC(babbel_canAddLanguage))}) exitWith {};


private _languageID = [_languageKey] call acre_sys_core_fnc_getLanguageId;

ACRE_SPOKEN_LANGUAGES pushBackUnique _languageID;
