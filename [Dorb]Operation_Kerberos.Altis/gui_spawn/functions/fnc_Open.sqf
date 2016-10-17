/*
    Author: Dorbedo

    Description:
        gets vehiclelist, creates dialog
        called Via dialog

    Parameter(s):
        0:OBJECT    - Caller
        3:ARRAy     - Paramter
            0:STRING    - Spawnname
            1:OBJECT    - Object where the Data is stored

*/
#define INCLUDE_GUI
#include "script_component.hpp"

#define CHECK_RADIUS 10



_this params ["_caller","_spawntype"];

private _exit = true;
private _hash = locationNull;
If (side _caller == east) then {
    If (isNil QGVAR(spawnlist_east)) then {
        [] call FUNC(createlist_east);
    };
    _hash = GVAR(spawnlist_east);
    _exit = false;
};
If (side _caller == west) then {
    If (isNil QGVAR(spawnlist_west)) then {
        [] call FUNC(createlist_west);
    };
    _hash = GVAR(spawnlist_west);
    _exit = false;
};
CHECK(_exit)

GVAR(curPos) = [-100000,-100000,-100000];

private _allPositions = HASH_GET(GVAR(spawnpositions),_spawntype);
{
    If ((GVAR(curPos) distance _caller)>(_caller distance _x)) then {
        GVAR(curPos) = _x;
    };
} forEach _allPositions;

private _vehiclelist = HASH_GET(_hash,_spawntype);

/*
 *      Empty the spawn area
 */

{
    private _veh = _x;
    if (((getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "vehicleClass"))isEqualTo "Autonomous")) then {
        {_veh deleteVehicleCrew _x} forEach crew _veh;
        deleteVehicle _veh;
    };
    { if(!(alive _x)) then { deleteVehicle _x; }; } forEach (crew _veh);
    if (count crew _x == 0) then {deletevehicle _x};
} forEach (nearestObjects [GVAR(curPos), ["AllVehicles"], CHECK_RADIUS]);

{deletevehicle _x;} forEach (nearestObjects [GVAR(curPos), ["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder","allDead","Thing"], CHECK_RADIUS]);

/*
 *      Create the dialog
 */


disableSerialization;
createDialog QAPP(dialog);

ctrlSetText[IDC_SPAWN_DLG_HEADER,localize format[LSTRING(%1),_spawntype]];
private _sel = [];
for "_i" from 0 to ((count _vehiclelist)-1) do {
    private _vehicle = _vehiclelist select _i;
    /// class, picture, "MOD", "descriptionname", "descriptionname", picture
    _sel pushBack [["",format["%1",(_vehicle select 2)],format["| %1",(_vehicle select 3),""]],[],[(_vehicle select 0),(_vehicle select 1),(_vehicle select 4),format["%1",(_vehicle select 5),""]]];
};

private _ctrlList = findDisplay IDD_SPAWN_DLG displayCtrl IDC_SPAWN_DLG_LIST;

lnbClear IDC_SPAWN_DLG_LIST;
lnbAddArray [IDC_SPAWN_DLG_LIST,_sel];

if(((lnbSize _ctrlList) select 0)>0) then {lbSetCurSel [IDC_SPAWN_DLG_LIST, 1];};

for "_i" from 0 to ((lnbSize _ctrlList) select 0) do {
    private _pic = _ctrlList lnbData [_i,1];
    if (!(_pic in ["pictureThing","pictureStaticObject","iconobject_1x3"])) then {
        _ctrlList lnbSetPicture [ [_i, 0],(_ctrlList lnbData [_i,1])];
    };
};
