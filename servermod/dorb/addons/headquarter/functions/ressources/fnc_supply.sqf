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
        private _cfg = (ConfigFile >> "CfgKerberos" >> QEGVAR(spawn,unitlists) >> str GVARMAIN(side) >> GVARMAIN(side_type) >> "callIn");
        private _callInTypes = selectRandomWeighted [
            "supply_infanterie",getNumber(_cfg >> "supply_infanterie"),
            "supply_mounted",getNumber(_cfg >> "supply_mounted"),
            "supply_tanks",getNumber(_cfg >> "supply_tanks"),
            "supply_sniper",getNumber(_cfg >> "supply_sniper"),
            "supply_mechanized",getNumber(_cfg >> "supply_mechanized"),
            "supply_airdrop",getNumber(_cfg >> "supply_airdrop"),
            "supply_tankdrop",getNumber(_cfg >> "supply_tankdrop")
        ];
        private _callinType = selectRandomWeighted _callInTypes;
        TRACEV_2(_callinTypes,_callinType);

        private _costs = switch (_callinType) do {
            case "supply_infanterie" : {
                [] call FUNC(ressources_supplyInfanterie);
            };
            case "supply_mounted" : {
                [] call FUNC(ressources_supplyMounted);
            };
            case "supply_sniper" : {
                [] call FUNC(ressources_supplySniper);
            };
            case "supply_tanks" : {
                [] call FUNC(ressources_supplyTanks);
            };
            case "supply_mechanized" : {
                [] call FUNC(ressources_supplyMechanized);
            };
            case "supply_airdrop" : {
                private _centerpos = HASH_GET(GVAR(dangerzones),"centerpos");
                [_centerpos,"airdrop"] call EFUNC(spawn,offmap_airsupport);
            };
            case "supply_tankdrop" : {
                private _centerpos = HASH_GET(GVAR(dangerzones),"centerpos");
                [_centerpos,"tankdrop"] call EFUNC(spawn,offmap_airsupport);
            };
            default {0};
        };


        If (IS_SCALAR(_costs)) then {
            private _ressources = HASH_GET(GVAR(ressources),"amount",0) - _costs;
            HASH_SET(GVAR(ressources),"amount",_ressources);
        }else{
            ERROR("wrong supply return");
            TRACEV_1(_costs);
        };
};
