/*
    Author: Dorbedo
    
    Description:
        creates the unitslists
    
    Parameter(s):
        0 : SCALAR (opt)    - Number
    
*/
#include "script_component.hpp"
SCRIPT(choose_army);

If !(_this params[["_Army","",[""]]]) then {
    private _ArmyArray = [
        ["regular",1], //mixed
        //fighting troups
        ["armored",1],
        ["infanterie",1],
        // special troups
        ["airborne",1],
        ["specops",1],    // special trained soldiers
        ["droneoperations",1], // droneoperations
        //other
        ["guards",1]
    ];
    GVARMAIN(side_type) = [_ArmyArray,1] call EFUNC(common,sel_array_weighted)
}else{
    GVARMAIN(side_type) = _Army;
};
if (isNil QGVARMAIN(side)) then {
    GVARMAIN(side) = switch (GVARMAIN(playerside)) do {
        case "east" : {"west"};
        default {"east"};
    };
};

private _path = (missionConfigFile >> "unitlists" >> str GVARMAIN(side) >> GVARMAIN(side_type));


GVAR(list_crewmen) = getArray(_path >> "crewmen");
GVAR(list_divers) = getArray(_path >> "divers");
GVAR(list_soldiers) = getArray(_path >> "soldiers");

GVAR(list_veh_transport) = getArray(_path >> "veh_transport");
GVAR(list_veh_mechanized) = getArray(_path >> "veh_mechanized");
GVAR(list_veh_armored) = getArray(_path >> "veh_armored");
GVAR(list_veh_antiair) = getArray(_path >> "veh_antiair");

GVAR(list_boat_patrol) = getArray(_path >> "boat_patrol");

GVAR(list_hq_mobile) = getArray(_path >> "hq_mobile");

GVAR(list_static) = getArray(_path >> "static");
GVAR(list_static_high) = getArray(_path >> "static_high");
GVAR(list_static_aa) = getArray(_path >> "static_aa");

GVAR(list_art_mortar) = getArray(_path >> "art_mortar");
GVAR(list_art_shells) = getArray(_path >> "art_shells");
GVAR(list_art_rocket) = getArray(_path >> "art_rocket");


EGVAR(headquater,callIn_airinterception) = getNumber(_path >> "callIn" >> "airinterception" >> "amount");
GVAR(callIn_airinterception) = getArray(_path >> "callIn" >> "airinterception" >> "units");

EGVAR(headquater,callIn_cas) = getNumber(_path >> "callIn" >> "cas" >> "amount");
GVAR(callIn_cas) = getArray(_path >> "callIn" >> "cas" >> "units");

EGVAR(headquater,callIn_motorized) = getNumber(_path >> "callIn" >> "motorized" >> "amount");
GVAR(callIn_motorized) = getArray(_path >> "callIn" >> "motorized" >> "units");

EGVAR(headquater,callIn_armored) = getNumber(_path >> "callIn" >> "armored" >> "amount");
GVAR(callIn_armored) = getArray(_path >> "callIn" >> "armored" >> "units");

EGVAR(headquater,callIn_airborne) = getNumber(_path >> "callIn" >> "airborne" >> "amount");
GVAR(callIn_airborne) = getArray(_path >> "callIn" >> "airborne" >> "units");
GVAR(callIn_transport) = getArray(_path >> "callIn" >> "transport" >> "units");

GVAR(list_civ_cars) = getArray(_path >> "civ_cars");
GVAR(list_civ_cars_garage) = getArray(_path >> "civ_smallcars");


GVAR(list_pow) = getArray(_path >> "pow");
GVAR(list_intel) = getArray(_path >> "intel");
GVAR(list_tower) = getArray(_path >> "tower");
GVAR(list_prototype) = getArray(_path >> "prototyp");
GVAR(list_weaponcache) = getArray(_path >> "weaponcache");
GVAR(list_commander) = getArray(_path >> "commander");
GVAR(list_radar) = getArray(_path >> "radar");
GVAR(list_device) = getArray(_path >> "device");
GVAR(list_emp) = getArray(_path >> "emp");

GVAR(group_patrol) = getArray(_path >> "group_patrol");
GVAR(group_strikeforce) = getArray(_path >> "group_strikeforce");
GVAR(group_defence) = getArray(_path >> "group_defence");

