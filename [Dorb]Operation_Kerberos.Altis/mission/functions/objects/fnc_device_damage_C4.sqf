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
switch (true) do {
        default { 0 };
        case ( (_this select 4) == "demoCharge_remote_ammo") : {SETVAR((_this select 0),EGVAR(mission,target_dead),true); 1 };
        case ( (_this select 4) == "DemoCharge_Remote_Ammo_Scripted") : {SETVAR((_this select 0),EGVAR(mission,target_dead),true); 1 };
        case ( (_this select 4) == "satchelCharge_remote_ammo") : {SETVAR((_this select 0),EGVAR(mission,target_dead),true); 1 };
        case ( (_this select 4) == "SatchelCharge_Remote_Ammo_Scripted") : {SETVAR((_this select 0),EGVAR(mission,target_dead),true); 1 };    
        case ( (_this select 4) isKindof "PipeBombBase") : {SETVAR((_this select 0),EGVAR(mission,target_dead),true); 1 };        
};

