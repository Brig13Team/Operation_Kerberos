/*
    Author: Dorbedo
    
    Description:
        makes something only destroyable by c4
    
    Requirements:
        called via Eventhandler
        
    Return
    SCALAR
*/
#include "script_component.hpp"
if !((_this select 0) getVariable [QGVAR(dev_disabled),false]) exitWith {0};
switch (true) do {
        default { 0 };
        case ( (_this select 4) in ["demoCharge_remote_ammo","DemoCharge_Remote_Ammo_Scripted"]) : {(getDammage (_this select 0) + 0.51) min 1;};
        case ( (_this select 4) in ["satchelCharge_remote_ammo","SatchelCharge_Remote_Ammo_Scripted"]) : {1};
        case ( (_this select 4) isKindof "PipeBombBase") : {1};        
};