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
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_mission", "_targets"];

{
    _x setVectorUp [0,0,1];
    _x setVariable [QGVAR(mission),_mission];
    _x setVariable [QGVAR(isActive), true, true];
    _x addEventHandler ["HandleDamage", {
            params ["_radiotower","_selection","_newdamage","_source","_projectile"];
            switch (true) do {
                case (_projectile == "DemoCharge_Remote_Ammo_Scripted");
                case (_projectile == "demoCharge_remote_ammo")/* : {
                    private _dmg = (getDammage _radiotower + 0.51) min 1;
                    if ((_dmg >= 1) && {_radiotower getVariable [QGVAR(isActive), true]}) then {
                        _this call FUNC(statemachine_increaseCounter);
                    };
                    _dmg
                }*/;
                case (_projectile == "satchelCharge_remote_ammo");
                case (_projectile == "SatchelCharge_Remote_Ammo_Scripted");
                case (_projectile isKindof "PipeBombBase") : {
                    if (_radiotower getVariable [QGVAR(isActive), true]) then {
                        _this call FUNC(statemachine_increaseCounter);
                    };
                    1;
                };
                default { 0 };
            };
        }];
} forEach _targets;

_targets
