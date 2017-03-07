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

If ((side _caller == east)&&{isNil QGVAR(spawnlist_east)}) exitWIth {
    [
        {!(isNil QGVAR(spawnlist_east))},
        FUNC(open),
        _this
    ] call CBA_fnc_waitUntilAndExecute;
    [] spawn FUNC(createlist_east);
};
If ((side _caller == west)&&{isNil QGVAR(spawnlist_west)}) exitWIth {
    [
        {!(isNil QGVAR(spawnlist_west))},
        FUNC(open),
        _this
    ] call CBA_fnc_waitUntilAndExecute;
    [] spawn FUNC(createlist_west);
};

private _exit = true;
private _hash = locationNull;
If (side _caller == east) then {
    _hash = GVAR(spawnlist_east);
    _exit = false;
};
If (side _caller == west) then {
    _hash = GVAR(spawnlist_west);
    _exit = false;
};
CHECK(_exit)

GVAR(curPos) = [];
GVAR(curDir) = 0;

private _allPositions = HASH_GET(GVAR(spawnpositions),_spawntype);
TRACEV_2(_allPositions,_spawntype);
If (isNil "_allPositions") exitWith {ERROR("Wrong configured spawns - no positions found");};

{
    If ((GVAR(curPos) isEqualTo [])||{((_x select 0) distance _caller)<(GVAR(curPos) distance _caller)}) then {
        GVAR(curPos) =+ (_x select 0);
        GVAR(curDir) =+ (_x select 1);
    };
} forEach _allPositions;

If (GVAR(curPos) isEqualTo []) exitWith {
    ERROR("Opening Spawn Menu not possible -> no spawnpos found after action was executed");
};


private _vehiclelist = HASH_GET(_hash,_spawntype);

/*
 *      Empty the spawn area
 */
[GVAR(curPos)] call FUNC(clearPos);

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
