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
        (HASH_GET_DEF(GVAR(ressources),"amount",0)>-1)&&
        {[] call FUNC(ressources_CanCallInUnits)}
    ) then {

    private _callinType = selectRandom ["infanterie","airdrop","mounted","sniper","tanks","mechanized"];
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
        case "mechanized" : {
            [] call FUNC(ressources_supplyMechanized);
        };
        default {0};
    };


    If (IS_SCALAR(_costs)) then {
        private _ressources = HASH_GET(GVAR(ressources),"amount",0) - costs;
        HASH_SET(GVAR(ressources),"amount",_ressources);
    }else{
        ERROR("wrong supply return");
        TRACEV_1(_costs);
    };
};
