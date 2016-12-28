/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Checks the supply and calls new units
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"


If (
        (GVAR(ressources_amount)>0)&&
        {[] call FUNC(canCallInUnits)}
    ) then {

    private _callinType = selectRandom ["infanterie","airdrop","mounted","sniper","tanks"];
    TRACE(FORMAT_1("Calling in Units: %1",_callinType));
    private _costs = switch (_callinType) do {
        case "infanterie" : {
            [] call FUNC(ressources_supplyInfanterie);
        };
        case "airdrop" : {
            [] call FUNC(ressources_supplyAirdrop);
        };
        case "mounted" : {
            [] call FUNC(ressources_supplyMounted);
        };
        case "sniper" : {
            [] call FUNC(ressources_supplySniper);
        };
        case "tanks" : {
            [] call FUNC(ressources_supplyTanks);
        };
        default {0};
    };



    GVAR(ressources_amount) = GVAR(ressources_amount) - _costs;

};
