/*
    Author: Dorbedo

    Description:
        postinit client
*/
#include "script_component.hpp"

CHECK(!hasInterface)

/*
 *  Set the Variables
 *  In addition to the arsenals added via FUNC(addArsenal)
 */

GVAR(fullArsenal) = false;
GVAR(allowedradius) = 10;
GVAR(allowedPositions) = [
    getMarkerPos "arsenalTest",
    getmarkerpos GVARMAIN(RESPAWNMARKER)
];


/*
 *  no edit below needed
 *
 */
If !(IS_ARRAY(GVAR(allowedPositions))) then {
    GVAR(allowedPositions) = [];
};
IF !(IS_SCALAR(GVAR(allowedradius))) then {
    GVAR(allowedradius) = 5;
};
If !(IS_BOOL(GVAR(fullArsenal))) then {
    GVAR(fullArsenal) = true;
};


[
    localize LSTRING(header),
    {[] call FUNC(OpenMenu);},
    {[player] call FUNC(canOpenMenu);},
    "\A3\ui_f\data\logos\arsenal_1024_ca.paa",
    2
] call EFUNC(gui_tablet,addApp);


[
    QGVAR(ArsenalAddAction),
    {
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
                    private "_action";
                    If (GVAR(fullArsenal)) then {
                         _action = [
                            QGVAR(Action_Arsenal),
                            localize "STR_A3_Arsenal",
                            "",
                            {
                                ["Open",true] spawn bis_fnc_arsenal;
                            },
                            {
                                alive _target && {(_target distance player) < 5 && {vehicle player == player}}
                            }
                        ] call ACE_interact_menu_fnc_createAction;
                    }else{
                        _action = [
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
                        ] call ACE_interact_menu_fnc_createAction;
                    };

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
