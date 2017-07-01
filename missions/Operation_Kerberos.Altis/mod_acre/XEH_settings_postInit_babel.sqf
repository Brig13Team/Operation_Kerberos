/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Settings for babel
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


private _babelPreSet = 0;
/*
 *  0 = no Babel
 *  1 = every side has it's own babel (curator-logics can speak everything)
 *  2 = every side has it's own babel and a common language
 *  3 = middle-east scenario
 *
 *
 */


switch (_babelPreSet) do {
    default {};
    case (1): {
        [] spawn {
            ["east", "Opfor"] call acre_api_fnc_babelAddLanguageType;
            ["west", "Blufor"] call acre_api_fnc_babelAddLanguageType;
            ["ind", "Indepedent"] call acre_api_fnc_babelAddLanguageType;
            ["civ", "Civilian"] call acre_api_fnc_babelAddLanguageType;
            ["logic", "Zeus"] call acre_api_fnc_babelAddLanguageType;
            CHECK(!hasInterface)
            waitUntil { !isNull acre_player };
            _side = side acre_player;
            switch _side do {
                case east: {["east"] call acre_api_fnc_babelSetSpokenLanguages;};
                case west: {["west"] call acre_api_fnc_babelSetSpokenLanguages;};
                case independent: {["ind"] call acre_api_fnc_babelSetSpokenLanguages;};
                case civilian: {["civ"] call acre_api_fnc_babelSetSpokenLanguages;};
                default {["logic"] call acre_api_fnc_babelSetSpokenLanguages;};
            };
        };
    };
    case (2): {
        [] spawn {
            ["east", "Opfor"] call acre_api_fnc_babelAddLanguageType;
            ["west", "Blufor"] call acre_api_fnc_babelAddLanguageType;
            ["ind", "Indepedent"] call acre_api_fnc_babelAddLanguageType;
            ["civ", "Civilian"] call acre_api_fnc_babelAddLanguageType;
            ["logic", "Zeus"] call acre_api_fnc_babelAddLanguageType;
            CHECK(!hasInterface)
            waitUntil { !isNull acre_player };
            switch (side acre_player) do {
                case east: {["east"] call acre_api_fnc_babelSetSpokenLanguages;};
                case west: {["west"] call acre_api_fnc_babelSetSpokenLanguages;};
                case independent: {["ind"] call acre_api_fnc_babelSetSpokenLanguages;};
                case civilian: {["civ"] call acre_api_fnc_babelSetSpokenLanguages;};
                default {["east", "west", "ind", "civ", "logic"] call acre_api_fnc_babelSetSpokenLanguages;};
            };
        };
    };
    case (3): {
        [] spawn {
            ["arab", LSTRING(ARAB)] call acre_api_fnc_babelAddLanguageType;
            ["english", LSTRING(ENGLISH)] call acre_api_fnc_babelAddLanguageType;
            ["german", LSTRING(GERMAN)] call acre_api_fnc_babelAddLanguageType;
            ["arab", localize LSTRING(ARAB)] call acre_api_fnc_babelAddLanguageType;
            ["english", localize LSTRING(ENGLISH)] call acre_api_fnc_babelAddLanguageType;
            ["german", localize LSTRING(GERMAN)] call acre_api_fnc_babelAddLanguageType;
            CHECK(!hasInterface)
            waitUntil { !isNull acre_player };
            switch (side acre_player) do {
                case west: {["english"] call acre_api_fnc_babelSetSpokenLanguages;};
                case east;
                case independent;
                case civilian : {["arab"] call acre_api_fnc_babelSetSpokenLanguages;};
                default {["arab", "english", "german"] call acre_api_fnc_babelSetSpokenLanguages;};
            };
        };
    };

};

[QGVAR(addLanguage),{_this call FUNC(babbel_addLanguageLocal);}] call CBA_fnc_addEventHandler;
[QGVAR(removeLanguage),{_this call FUNC(babbel_removeLanguageLocal);}] call CBA_fnc_addEventHandler;
