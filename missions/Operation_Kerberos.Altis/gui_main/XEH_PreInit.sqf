#include "script_component.hpp"

ADDON = false;

RECOMPILE_START;
#include "XEH_PREP.hpp"
RECOMPILE_END;

ADDON = true;

with uiNamespace do {
    GVAR(currentDisplays) = [];
    GVAR(metroBttns) = [];
};

GVAR(Applications) = [] call CBA_fnc_createNamespace;

[
    {
        private _ACE_Action = [
            QGVAR(selfactiongroup),
            localize LSTRING(SELFACTIONGROUP),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + QUOTE(gui\data\logo\logo_512.paa),
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu)
        ] call ace_interact_menu_fnc_createAction;
        [ace_player, 1, ["ACE_SelfActions"], _ACE_Action] call ace_interact_menu_fnc_addActionToObject;
    }
] call CBA_fnc_execNextFrame;
