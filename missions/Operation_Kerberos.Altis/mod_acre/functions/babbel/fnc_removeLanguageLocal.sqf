/*
 *  Author: Dorbedo
 *
 *  Description:
 *      removes a Language locally
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

ACRE_SPOKEN_LANGUAGES = ACRE_SPOKEN_LANGUAGES - [_languageID];

If (_languageID == ACRE_CURRENT_LANGUAGE_ID) then {[ACRE_SPOKEN_LANGUAGES select 0] call acre_sys_core_fnc_setSpeakingLanguage;};
