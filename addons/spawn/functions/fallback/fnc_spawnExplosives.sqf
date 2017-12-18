/*
    Author: Dorbedo

    Description:
        Spawns Mines/IEDs at arraypositions


    Parameter(s):
        0 : ARRAY    - Spawnpositions [x,y,z,dir]
        (Optional)
        1 : ARRAY    - Type of Mines/IEDs (0=AP,1=AT,2=Tripwire,3=IED)


*/
#include "script_component.hpp"
SCRIPT(spawn_explosives);
params[["_spawnposarray",[],[[]],[2,3]],["_type",0,[0]]];
CHECK(_spawnposarray isEqualTo [])
Private["_spawnedunit","_spawnedunits","_typ","_gruppe","_dir","_position"];
_ap_mines = ["APERSBoundingMine_Range_Mag","APERSMine_Range_Mag"];
_at_mines = ["ATMine_Range_Mag","SLAMDirectionalMine_Wire_Mag"];
_trip_mines = ["APERSTripMine_Wire_Mag"];
_IED_land = ["IEDLandBig_Remote_Mag","IEDLandSmall_Remote_Mag"];
_IED_urban = ["IEDUrbanBig_Remote_Mag","IEDUrbanSmall_Remote_Mag"];

For "_i" from 0 to ((count _spawnposarray)-1) do {
    (_spawnposarray select _i) params ["_coord_x","_coord_y","_coord_z","_dir"];
    private _pos = [_coord_x,_coord_y,_coord_z];
    private _triggerConfig = "PressurePlate";
    private _triggerSpecificVars = [];

    private _magazineClass = selectRandom _ap_mines;
    If (_type > 2) then {
        _magazineClass = selectRandom _IED_urban;
    }else{
        If (_type > 1) then {
            _magazineClass = selectRandom _trip_mines;
            _triggerConfig = "Tripwire";
        }else{
            _magazineClass = selectRandom _at_mines;
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
};
