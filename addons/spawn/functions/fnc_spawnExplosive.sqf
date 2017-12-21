/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns a explosive
 *
 *  Parameter(s):
 *      0 : ARRAY - Position
 *      1 : SCALAR - type
 *      2 : SCALAR - direction
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

#define MINE_AP ["APERSBoundingMine_Range_Mag","APERSMine_Range_Mag"];
#define MINE_AT ["ATMine_Range_Mag","SLAMDirectionalMine_Wire_Mag"];
#define MINE_TRIP ["APERSTripMine_Wire_Mag"];
#define IED_LAND ["IEDLandBig_Remote_Mag","IEDLandSmall_Remote_Mag"];
#define IED_URBAN ["IEDUrbanBig_Remote_Mag","IEDUrbanSmall_Remote_Mag"];

_this params [["_pos",[],[[]],[3]],["_type",0,[0]],["_dir",random(360),[0]]];

private _triggerConfig = "PressurePlate";
private _triggerSpecificVars = [];

private _magazineClass = selectRandom MINE_AP;
If (_type > 2) then {
    _magazineClass = selectRandom IED_URBAN;
}else{
    If (_type > 1) then {
        _magazineClass = selectRandom MINE_TRIP;
        _triggerConfig = "Tripwire";
    }else{
        _magazineClass = selectRandom MINE_AT;
    };
};

private _magazineTrigger = ConfigFile >> "CfgMagazines" >> _magazineClass >> "ACE_Triggers" >> _triggerConfig;
private _triggerConfig = ConfigFile >> "ACE_Triggers" >> _triggerConfig;

private _ammo = getText(ConfigFile >> "CfgMagazines" >> _magazineClass >> "ammo");
if (isText(_magazineTrigger >> "ammo")) then {
    _ammo = getText (_magazineTrigger >> "ammo");
};
_triggerSpecificVars pushBack _triggerConfig;

private _explosive = createVehicle [_ammo, _pos, [], 0, "NONE"];
_explosive setPosATL _pos;
_explosive setDir _dir;
GVARMAIN(side) revealMine _explosive;

#ifdef DEBUG_MODE_FULL
    [_pos,"","","MinefieldAP"] call EFUNC(common,debug_marker_create);
#endif

[objNull,_explosive,_magazineClass,_triggerSpecificVars] call compile (getText (_triggerConfig >> "onPlace"));
