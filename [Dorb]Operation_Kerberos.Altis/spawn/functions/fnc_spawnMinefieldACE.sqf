/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Creates a ACE-Minefield
 *
 *  Parameter(s):
 *      0 : ARRAY - Centerposition of the minefield
 *      1 : SCALAR - Radius
 *      2 : SCALAR - Type of minefield (0:AT&AP | 1:AT | 2:AP)
 *      3 : SCALAR - Amount of mines
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

#define MINES_AT "ATMine_Range_Mag","SLAMDirectionalMine_Wire_Mag"
#define MINES_AP "APERSBoundingMine_Range_Mag","APERSMine_Range_Mag"

_this params [["_centerpos",[],[[]],[2,3]],["_spawnrad",25,[0]],["_type",0,[0]],["_amount",15,[0]]];
CHECK(_centerpos isEqualTo [])

if (_type < 1) then {
    _amount = _amount * 2;
};

for "_i" from 0 to _amount do {
    private _pos = [_centerpos,_spawnrad,0] call EFUNC(common,pos_random);

    private _magazineClass = switch (_type) do {
        case "1" : {
            selectRandom [MINES_AT];
        };
        case "2" : {
            selectRandom [MINES_AP];
        };
        default {
            selectRandom [MINES_AT,MINES_AP];
        };
    };

    private _dir = floor(random 360);
    private _triggerConfig = "PressurePlate";
    private _triggerSpecificVars = [];

    private _magazineTrigger = ConfigFile >> "CfgMagazines" >> _magazineClass >> "ACE_Triggers" >> _triggerConfig;
    private _triggerConfig = ConfigFile >> "ACE_Triggers" >> _triggerConfig;

    private _ammo = getText(ConfigFile >> "CfgMagazines" >> _magazineClass >> "ammo");
    if (isText(_magazineTrigger >> "ammo")) then {
        _ammo = getText (_magazineTrigger >> "ammo");
    };
    private _triggerSpecificVars pushBack _triggerConfig;

    private _explosive = createVehicle [_ammo, _pos, [], 0, "NONE"];
    _explosive setPosATL _pos;
    GVARMAIN(side) revealMine _explosive;

    [objNull,_explosive,_magazineClass,_triggerSpecificVars] call compile (getText (_triggerConfig >> "onPlace"));
};
