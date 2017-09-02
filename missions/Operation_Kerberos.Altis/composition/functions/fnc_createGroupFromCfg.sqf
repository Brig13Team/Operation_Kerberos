/**
 * Author: Dorbedo
 * creates a group from the composition
 *
 * Arguments:
 * 0: <ARRAY> Centerposition
 * 1: <SCALAR> Centerdir
 * 2: <CONFIG> Group Config
 * 3: <LOCATION> hash with spawned Objects
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_spawnposition","_dir","_curCfg","_objectsHash"];

If (getText(_curCfg >> "dataType") == "Group") exitWith {};

private _LinkHash = HASH_CREATE;
If (isClass(_curCfg >> "CrewLinks")) then {
    {
        private _id = getNumber(_x >> item1);
        HASH_SET(_LinkHash,str _id,_x);
    } forEach (configProperties[_curCfg >> "CrewLinks" >> "Links","(isClass _x)",true]);
};

private _replacementNeeded = !(getText(_curCfg >> "side") == (str GVARMAIN(side)));
private _group = createGroup [GVARMAIN(side),true];
{
    private _unit = _group createUnit [_type,_pos,[],0,"NONE"];
    _unit enableSimulationGlobal false;
} forEach (configProperties[_curCfg >> "CrewLinks" >> "Links","(isClass _x)",true]);









