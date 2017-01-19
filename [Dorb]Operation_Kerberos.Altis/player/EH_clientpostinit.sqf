/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"

CHECK(!hasInterface)

SETUVAR(EGVAR(gui,respawnTime),nil);

[] call FUNC(addbriefing);
[] call FUNC(halo_addaction);
[] call FUNC(backpack_init);
[] call FUNC(onrespawn);
[] call FUNC(initKnockKnock);


/*
 * Arsenal Restrictions
 *
*/
[
    QGVAR(cleanCargoRestriction),
    FUNC(checkContainerRestrictions)
] call CBA_fnc_addEventHandler;

// backwards compatibility
FUNC(addArsenal) = EFUNC(gui_arsenal,addArsenal);



/*
 * Copy Loadout Action
 *
*/


private _action = [
    QGVAR(copy_loadout),
    localize LSTRING(ACTION_COPY_LOADOUT),
    "",
    {
        private _loadout = [_target] call FUNC(getLoadout);
        [player,_loadout select 0,_loadout select 1] call FUNC(setLoadout);
    },
    {
        [_target,player] call FUNC(canCopyLoadout);
    }
] call ace_interact_menu_fnc_createAction;
["CAManBase",0,["ACE_MainActions"],_action] call ace_interact_menu_fnc_addActionToClass;





waituntil {! isnull player};
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

[
    QEGVAR(gui,dispInfo),
    [
        ELSTRING(MAIN,NAME),
        [
            ELSTRING(MAIN,WELCOME1),
            ELSTRING(MAIN,WELCOME2),
            ELSTRING(MAIN,WELCOME3),
            " ",
            ELSTRING(MAIN,AUTHOR)
        ]
    ]
] call CBA_fnc_localEvent;
