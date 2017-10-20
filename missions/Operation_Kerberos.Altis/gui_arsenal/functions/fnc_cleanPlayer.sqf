/*
 *  Author: Dorbedo
 *
 *  Description:
 *      cleans a player from restricted items
 *
 *  Parameter(s):
 *      0 : Object - the unit to be cleaned
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If (GVAR(level)<1) exitWith {};

params [["_player",objNull,[objNull]]];

CHECK((isNull _player)||{!isPlayer _player})

private _setGearFlag = false;
private _curLoadout = getUnitLoadout _player;

for "_i" from 0 to 8 do {
    private _curValue = _curLoadout select _i;
    If ((IS_STRING(_curValue))&&{[_curValue] call FUNC(isRestrictedArray)}) then {
        _setGearFlag = true;
        _curLoadout set [_i,""];
    }else{
        If ((IS_ARRAY(_curValue))&&{[_curValue] call FUNC(isRestrictedArray)}) then {
            _setGearFlag = true;
            _curLoadout set [_i,[]];
        };
    };
};

private _assignedItems = _curLoadout select 9;
{
    If ([_x] call FUNC(isRestrictedArray)) then {
        _setGearFlag = true;
        _assignedItems set [_forEachIndex,""];
    };
} forEach _assignedItems;

_curLoadout set [9,_assignedItems];

if (_setGearFlag) then {
    ERROR_WITH_TITLE("Not allowed Items detected","You have not allowed items. Parts of your Gear will be removed.");
    _player setUnitLoadout [_curLoadout, false];
};

/*
    [
        ["rhs_weap_m16a4_carryhandle","rhsusf_acc_SFMB556","rhsusf_acc_anpeq15side_bk","optic_Arco_blk_F",["rhs_mag_30Rnd_556x45_Mk318_Stanag",30],[],"bipod_01_F_blk"],
        ["BWA3_RGW90","","","",["BWA3_RGW90_HH",1],[],""],
        [],
        ["rhs_uniform_g3_m81",[["ACE_RangeTable_82mm",1],["ACE_fieldDressing",5],["ACE_elasticBandage",3],["ACE_quikclot",3],["ACE_CableTie",3],["ACE_EarPlugs",2],["ACE_epinephrine",3],["ACE_IR_Strobe_Item",1],["ACE_Flashlight_XL50",1],["ACE_MapTools",1],["ACE_microDAGR",1],["ACE_morphine",3],["ACE_packingBandage",3],["ACE_tourniquet",1],["ACRE_PRC343_ID_3",1]]],
        ["V_PlateCarrier2_tna_F",[["ACE_salineIV_500",2],["ACRE_PRC148_ID_1",1],["rhs_mag_30Rnd_556x45_Mk318_Stanag",9,30],["BWA3_DM51A1",2,1],["SmokeShell",2,1]]],
        ["B_TacticalPack_oli",[["ACE_fieldDressing",25],["ACE_elasticBandage",25],["ACE_quikclot",25],["ACE_packingBandage",25],["ACE_salineIV_500",5],["ACE_surgicalKit",3],["ACE_tourniquet",5],["ACE_morphine",25],["ACE_epinephrine",25],["ACE_atropine",6],["BWA3_RGW90_HH",1,1]]],
        "rhsusf_ach_helmet_M81",
        "G_Spectacles_Tinted",
        ["ACE_VectorDay","","","",[],[],""],
        ["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]
        ]

*/
