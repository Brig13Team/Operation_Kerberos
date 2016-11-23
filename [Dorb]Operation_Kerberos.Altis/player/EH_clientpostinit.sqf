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

["init"] spawn FUNC(grouptracker);

/*
 * Arsenal Restrictions
 *
*/
[
    QGVAR(cleanCargoRestriction),
    FUNC(checkContainerRestrictions)
] call CBA_fnc_addEventHandler;
[
    QGVAR(ArsenalAddAction),
    {
        If ((!isNil QEGVAR(patchacre,isDataSyncronized))&&{!EGVAR(patchacre,isDataSyncronized)}) exitWith {
            [
                {EGVAR(patchacre,isDataSyncronized)},
                {[QGVAR(ArsenalAddAction)] call CBA_fnc_localEvent;}
            ] call CBA_fnc_waitUntilAndExecute;
        };
        private _boxes = missionnamespace getvariable [QGVAR(arsenal_boxes),[]];
        {
            If (isNil "ace_interact_menu_fnc_addActionToObject") then {
                if (isnil {_x getvariable "bis_fnc_arsenal_action"}) then {
                   private _action = _x addaction [
                       format["<t color='#FFa500' size='1.5'>%1</t>",localize "STR_A3_Arsenal"],
                       {
                           private _box = _this select 0;
                           private _unit = _this select 1;
                           if !(isNil QEFUNC(patch_acre,ArsenalRemoveRadio)) then {
                               [] call EFUNC(patch_acre,ArsenalRemoveRadio);
                           };
                           ["Open",[nil,_box,_unit]] call bis_fnc_arsenal;
                       },
                       [],
                       6,
                       true,
                       false,
                       "",
                       "
                           _cargo = _target getvariable ['bis_addVirtualWeaponCargo_cargo',[[],[],[],[]]];
                           if ({count _x > 0} count _cargo == 0) then {
                               _target removeaction (_target getvariable ['bis_fnc_arsenal_action',-1]);
                               _target setvariable ['bis_fnc_arsenal_action',nil];
                           };
                           _condition = _target getvariable ['bis_fnc_arsenal_condition',{true}];
                           alive _target && {_target distance _this < 5 && {vehicle _this == _this}} && {call _condition}
                       "
                   ];
                   _x setvariable ["bis_fnc_arsenal_action",_action];
               };
            }else{
                if (isnil {_x getvariable "bis_fnc_arsenal_action"}) then {
                    private _action = [
                        QGVAR(Action_Arsenal),
                        localize "STR_A3_Arsenal",
                        "",
                        {
                            private _box = _target;
                            private _unit = player;
                            if !(isNil QEFUNC(patch_acre,ArsenalRemoveRadio)) then {
                                [] call EFUNC(patch_acre,ArsenalRemoveRadio);
                            };
                            ["Open",[nil,_box,_unit]] spawn bis_fnc_arsenal;
                        },
                        {
                            private _cargo = _target getvariable ['bis_addVirtualWeaponCargo_cargo',[[],[],[],[]]];
                            if ({count _x > 0} count _cargo == 0) then {
                                [_target,0,(_target getvariable ['bis_fnc_arsenal_action',-1])] call ACE_interact_menu_fnc_removeActionFromObject;
                                _target setvariable ['bis_fnc_arsenal_action',-1];
                            };
                            private _condition = _target getvariable ['bis_fnc_arsenal_condition',{true}];
                            alive _target && {(_target distance player) < 5 && {vehicle player == player}} && {call _condition}
                        }

                    ] call ACE_interact_menu_fnc_createAction;;
                    private _createdAction = [_x,0,["ACE_MainActions"],_action] call ace_interact_menu_fnc_addActionToObject;
                    _x setvariable ["bis_fnc_arsenal_action",_createdAction];
                };
            };
        } foreach _boxes;
    }
] call CBA_fnc_addEventHandler;

[{[QGVAR(ArsenalAddAction)] call CBA_fnc_localEvent;}] call CBA_fnc_execNextFrame;

[
    QGVAR(ArsenalRemoveAction),
    {
        _this params [["_box",objNull,[objNull]]];
        CHECK(isNull _box)
        [_box,true] call FUNC(addArsenalAction);
        private _action = _box getVariable ["bis_fnc_arsenal_action",-1];
        _box removeAction _action;
        _box setVariable ["bis_fnc_arsenal_action",-1];
    }
] call CBA_fnc_addEventHandler;

/*
 * Teleport
 *
*/
[
    {!isNil QGVARMAIN(missionkeyServer)},
    {
        GVARMAIN(missionkey) = GVARMAIN(missionkeyServer);
        private _serverkey = GVARMAIN(missionkeyServer);
        private _serverkeyLocal = profileNamespace getVariable [QGVARMAIN(missionkeyServer),"NoKey"];
        If (_serverkey isEqualTo _serverkeyLocal) then {
            // the client has already been on the server -> possible crash
            GVARMAIN(missionkey) = "teleport allowed";
        }else{
            profileNamespace setVariable [QGVARMAIN(missionkeyServer),_serverkey];
        };

    }
] call CBA_fnc_waitUntilAndExecute;

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
