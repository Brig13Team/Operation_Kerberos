/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Damage only allowed by C4
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      SCALAR - Damage
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

switch (true) do {
        default { 0 };
        case ( (_this select 4) == "demoCharge_remote_ammo");
        case ( (_this select 4) == "DemoCharge_Remote_Ammo_Scripted");
        case ( (_this select 4) == "satchelCharge_remote_ammo");
        case ( (_this select 4) == "SatchelCharge_Remote_Ammo_Scripted");
        case ( (_this select 4) isKindof "PipeBombBase") : {1};
};
