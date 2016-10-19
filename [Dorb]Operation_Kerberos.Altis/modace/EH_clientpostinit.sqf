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
 * Advanced Medical -> Add a chance to revive players
 *
*/
["ace_medical_treatmentAdvanced_CPRLocal",{
    _this params ["_caller","_target"]; If ((_target getVariable ["Ace_medical_inReviveState",false])&&{(random 1) >= 0.80}) then {
        _target setVariable ["Ace_medical_inCardiacArrest",true,true];
        _target setVariable ["Ace_medical_inReviveState",false,true];
    };
}] call CBA_fnc_addEventHandler;
/*
 * Change Team Colors -> Ace Copy
 *
*/
[] call FUNC(addColorActions);
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
            if (isnil {_x getvariable "bis_fnc_arsenal_action"}) then {
                private _action = _x addaction [
                    format["<t color='#FFa500' size='1.5'>%1</t>",localize "STR_A3_Arsenal"],
                    {
                        _box = _this select 0;
                        _unit = _this select 1;
                        if !(isNil QEFUNC(patchacre,ArsenalRemoveRadio)) then {
                            [] call EFUNC(patchacre,ArsenalRemoveRadio);
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
