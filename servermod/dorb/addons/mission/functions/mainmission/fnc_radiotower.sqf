/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "radiotower"
 *
 *  Parameter(s):
 *      0 : HASH        - mission hash
 *      1 : [OBJECT]    - mission target
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_targets"];

{
    _x setVectorUp [0,0,1];

    _x setVariable [QGVAR(isActive), true, true];
    _x addEventHandler ["HandleDamage", {
            params ["_radiotower","_selection","_newdamage","_source","_projectile"];
            switch (true) do {
                case ( (_this select 4) == "DemoCharge_Remote_Ammo_Scripted");
                case ( (_this select 4) == "demoCharge_remote_ammo") : {
                    private _dmg = (getDammage _radiotower + 0.51) min 1;
                    if ((_dmg >= 1) && {_radiotower getVariable [QGVAR(isActive), true]}) then {
                        [_radiotower] call FUNC(statemachine_increaseCounter);
                    };
                    _dmg
                };
                case ( (_this select 4) == "satchelCharge_remote_ammo");
                case ( (_this select 4) == "SatchelCharge_Remote_Ammo_Scripted");
                case ( (_this select 4) isKindof "PipeBombBase") : {
                    if (_radiotower getVariable [QGVAR(isActive), true]) then {
                        [_radiotower] call FUNC(statemachine_increaseCounter);
                    };
                    1;
                };
                default { 0 };
            };
        }];
} forEach _targets;
