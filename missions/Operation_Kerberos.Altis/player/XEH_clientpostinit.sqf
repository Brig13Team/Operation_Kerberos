/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"

CHECK(!hasInterface)

uiNamespace setVariable [QEGVAR(gui,respawnTime),nil];

[] call FUNC(halo_addaction);
[] call FUNC(backpack_init);
[] call FUNC(initKnockKnock);


/*
 * Arsenal Restrictions
 *
*/
[
    QGVAR(cleanCargoRestriction),
    FUNC(checkContainerRestrictions)
] call CBA_fnc_addEventHandler;


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
        [_target,ace_player] call FUNC(canCopyLoadout);
    }
] call ace_interact_menu_fnc_createAction;
["CAManBase",0,["ACE_MainActions"],_action,true] call ace_interact_menu_fnc_addActionToClass;





waituntil {! isnull player};
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

[
    QGVARMAIN(arsenalClosed),
    {
        [player,QGVARMAIN(insignia)] call BIS_fnc_setUnitInsignia;
    }
] call CBA_fnc_addEventHandler;

/*
 *
 *      Base Protection
 *
 */
If ((getMissionConfigValue ["isKerberos", 0]) > 0) then {
    [
        {
            If ((vehicle player == player)&&{((player distance2D ((_this select 0)select 0)) < 250)||{(player distance2D ((_this select 0)select 1)) < 250}}) then {
                If (isDamageAllowed player) then {
                    player allowDamage false;
                };
            } else {
                If (!isDamageAllowed player) then {
                    player allowDamage true;
                };
            };
        },
        1,
        [getMarkerPos GVARMAIN(respawnmarker),getMarkerPos "respawn_west_tonos"]
    ] call CBA_fnc_addPerFrameHandler;

};
