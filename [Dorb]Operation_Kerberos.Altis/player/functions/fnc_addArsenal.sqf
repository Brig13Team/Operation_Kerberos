/*
    Author: Dorbedo
    
    Description:
        adds Arsenal to a unit
        can be called via unit-init
        
    Parameter(s):
        none
        
    Return
        none
*/
#include "script_component.hpp"
CHECK(!isServer)
_this params [["_arsenalObject",objNull,[objNull]]];
If (isClass(missionConfigFile>>QGVAR(arsenal))) then {
    [_arsenalObject] spawn {
        waitUntil {sleep 1;(!(isNil QGVAR(arsenalList)));};
        [_this select 0,GVAR(arsenalList) select 0,false,true] call BIS_fnc_addVirtualBackpackCargo;
        [_this select 0,GVAR(arsenalList) select 1,false,true] call BIS_fnc_addVirtualItemCargo;
        [_this select 0,GVAR(arsenalList) select 2,false,true] call BIS_fnc_addVirtualMagazineCargo;
        [_this select 0,GVAR(arsenalList) select 3,false,true] call BIS_fnc_addVirtualWeaponCargo;
    };
}else{
    ["AmmoboxInit",[_arsenalObject,true,{true}]] call BIS_fnc_arsenal;
};