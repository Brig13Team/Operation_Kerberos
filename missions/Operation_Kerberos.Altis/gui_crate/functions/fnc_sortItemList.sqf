/**
 * Author: Dorbedo
 * sorts the itemlist into the cathegories
 *
 * Arguments:
 * 0: <ARRAY> the itemarray
 *
 * Return Value:
 * <ARRAY> sorted itemlist
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_list"];

private _return = [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]];
private _magazines = [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]];
{
    private _cfg = [_x,configNull] call BIS_fnc_configPath;
    ((configName _cfg) call bis_fnc_itemType) params ["_weaponTypeCategory","_weaponTypeSpecific"];
    if (_weaponTypeCategory != "VehicleWeapon") then {
        //TRACEV_3(_weaponTypeCategory,_weaponTypeSpecific,(configName _cfg));
        private _index = switch (toLower _weaponTypeSpecific) do {
            case "assaultrifle";
            case "rifle";
            case "shotgun";
            case "submachinegun" : {ID_RIFLE};
            case "machinegun" : {ID_AUTOMATIC};
            case "sniperrifle" : {ID_SNIPER};
            case "launcher";
            case "missilelauncher";
            case "rocketlauncher" : {ID_LAUNCHER};
            case "handgun" : {ID_HANDGUN};
            case "accessorymuzzle";
            case "accessorypointer";
            case "accessorybipod";
            case "accessorysights" : {ID_OPTICS};
            case "smokeshell";
            case "unknownmagazine";
            case "grenade";
            case "shell";
            case "flare";
            case "throw" : {ID_GRANADES};
            case "mine";
            case "minebounding";
            case "minedirectional";
            case "put" : {ID_MINES};
            case "backpack" : {ID_BACKPACK};
            case "vest" : {ID_VEST};
            case "uniform" : {ID_UNIFORM};
            case "headgear";
            case "glasses";
            case "nvgoggles" : {ID_HEADGEAR};
            case "radio" : {ID_RADIO};
            case "watch";
            case "binocular";
            case "compass";
            case "gps";
            case "uavterminal";
            case "map";
            case "binocular";
            case "laserdesignator" : {ID_NAVIGATION};
            case "medikit";
            case "firstaidkit" : {ID_MEDIC};
            case "minedetector";
            case "toolkit" : {ID_OTHER};
            default {ID_OTHER};
        };
        If ((configName _cfg) isKindOf ["CBA_MiscItem",configFile >> "CfgWeapons"]) then {
            If ("medical" in ((gettext(_cfg >> "picture")) splitString "\")) then {
                _index = ID_MEDIC;
            } else {
                _index = ID_OTHER;
            };
        };
        (_return select _index) pushBack _x;
    };
    nil
} count _list;

_return
