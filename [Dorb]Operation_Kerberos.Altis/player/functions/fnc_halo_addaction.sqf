/*
    Author: Dorbedo

    Description:
        adds an Action to a definined Object

    Parameter(s):
        none

    Return
        none
*/
#include "script_component.hpp"
SCRIPT(halo_addaction);
CHECK(!hasInterface)
CHECK(isNil "halo")
If (isNil "ace_interact_menu_fnc_addActionToObject") then {
    halo addAction ["<t size='1.5' shadow='2' color='#ff0000'>"+localize LSTRING(HALO)+"</t> <img size='3' color='#ff0000' shadow='2' image='\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa'/>",{_this call FUNC(halo);},[750,75], 4, false,true, "","alive _target and (getposatl player distance getposatl halo) < 4"];
}else{
    private _action = [
        QGVAR(Action_Halo),
        localize LSTRING(HALO),
        "\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa",
        {
            [_target,ACE_player,-1,[]] spawn FUNC(halo);
        },
        {
            alive _target
        }
    ] call ACE_interact_menu_fnc_createAction;;
    [halo,0,["ACE_MainActions"],_action] call ace_interact_menu_fnc_addActionToObject;
};
