/*
    Author: Dorbedo

    Description:
        makes something only destroyable by c4
        2x democharge or 1x Sachelcharge

    Requirements:
        called via Eventhandler

    Return
    SCALAR
*/
#include "script_component.hpp"
switch (true) do {
        default { 0 };
        case ( (_this select 4) == "demoCharge_remote_ammo") : {(_this select 0) setVariable [QEGVAR(mission,target_dead),true]; (getDammage (_this select 0) + 0.51) min 1; };
        case ( (_this select 4) == "DemoCharge_Remote_Ammo_Scripted") : {(_this select 0) setVariable [QEGVAR(mission,target_dead),true]; (getDammage (_this select 0) + 0.51) min 1; };
        case ( (_this select 4) == "satchelCharge_remote_ammo") : {(_this select 0) setVariable [QEGVAR(mission,target_dead),true]; 1 };
        case ( (_this select 4) == "SatchelCharge_Remote_Ammo_Scripted") : {(_this select 0) setVariable [QEGVAR(mission,target_dead),true]; 1 };
        case ( (_this select 4) isKindof "PipeBombBase") : {(_this select 0) setVariable [QEGVAR(mission,target_dead),true]; 1 };
};

