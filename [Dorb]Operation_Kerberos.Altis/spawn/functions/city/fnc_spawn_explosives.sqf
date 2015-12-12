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
    _dir = (_spawnposarray select _i)select 3;
    _pos = [(_spawnposarray select _i)select 0,(_spawnposarray select _i)select 1,(_spawnposarray select _i)select 2];
    _triggerConfig = "PressurePlate";
    _triggerSpecificVars = [];
    
    _magazineClass = _ap_mines SELRND;
    If (_type > 2) then {
        _magazineClass = _IED_urban SELRND;
    }else{
        If (_type > 1) then {
            _magazineClass = _trip_mines SELRND;
            _triggerConfig = "Tripwire";
        }else{
            _magazineClass = _at_mines SELRND;
        };
    };
    
    _magazineTrigger = ConfigFile >> "CfgMagazines" >> _magazineClass >> "ACE_Triggers" >> _triggerConfig;
    _triggerConfig = ConfigFile >> "ACE_Triggers" >> _triggerConfig;

    _ammo = getText(ConfigFile >> "CfgMagazines" >> _magazineClass >> "ammo");
    if (isText(_magazineTrigger >> "ammo")) then {
        _ammo = getText (_magazineTrigger >> "ammo");
    };
    _triggerSpecificVars pushBack _triggerConfig;

    _explosive = createVehicle [_ammo, _pos, [], 0, "NONE"];
    _explosive setPosATL _pos;
    _explosive setDir _dir;
    GVARMAIN(side) revealMine _explosive;

    If (dorb_debug) then {
        _mrkr = createMarker [format["minepos-%1",_pos],_pos];
        _mrkr setMarkerShape "ICON";
        _mrkr setMarkerColor "ColorBLUFOR";
        _mrkr setMarkerType "MinefieldAP";
    };
    
    
    [objNull,_explosive,_magazineClass,_triggerSpecificVars] call compile (getText (_triggerConfig >> "onPlace"));
};