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

{
    private _cfg = [_x,configNull] call BIS_fnc_configPath;
    ((configName _cfg) call bis_fnc_itemType) params ["_weaponTypeCategory","_weaponTypeSpecific"];
    if (_weaponTypeCategory != "VehicleWeapon") then {
        private _index = switch (toLower _weaponTypeSpecific) do {
            case "assaultrifle";
            case "rifle";
            case "shotgun";
            case "submachinegun" : {ID_RIFLE};
            case "machinegun" : {ID_AUTOMATIC};
            case "sniperrifle" : {ID_SNIPER};
            case "launcher";
            case "missilelauncher";
            case "submachinegun" : {ID_LAUNCHER};
            case "handgun" : {ID_HANDGUN};
            case "AccessoryMuzzle";
            case "AccessoryPointer";
            case "AccessorySights" : {ID_OPTICS};
            case "throw" : {ID_GRANADES};
            case "put" : {ID_MINES};
            case "backpack" : {ID_BACKPACK};
            case "vest" : {ID_VEST};
            case "uniform" : {ID_UNIFORM};
            case "headgear";
            case "glasses";
            case "nvgoggles" : {ID_HEADGEAR};
            case "radio" : {ID_RADIO};
            case "watch";
            case "Binocular";
            case "Compass";
            case "GPS";
            case "UAVTerminal";
            case "Map";
            case "Binocular";
            case "LaserDesignator" : {ID_NAVIGATION};
            case "medikit";
            case "firstaidkit" : {ID_MEDIC};
            case "minedetector";
            case "toolkit" : {ID_OTHER};
            default {ID_OTHER};
        };
        (_return select _index) pushBack _x;
    };
} count _list;

_return
