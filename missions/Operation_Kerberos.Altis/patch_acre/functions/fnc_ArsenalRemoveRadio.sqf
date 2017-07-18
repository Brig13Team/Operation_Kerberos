/*
 * Author: Dorbedo
 * removes the radio out of the saved arsenal classes
 *
 * Arguments:
 * none
 *
 * Return Value:
 * none
 *
 *
 * Public: Yes
 */
#include "script_component.hpp"
LOG("Cleaning Arsenal Classes started");
private _data = profileNamespace getvariable ["bis_fnc_saveInventory_data",[]];
CHECK(_data isEqualTo [])
for "_i" from 1 to ((count _data) -1) step 2 do {
    for "_j" from 0 to 2 do {
        { //acre_baseClass = "ACRE_PRC117F";
            private _baseClass = If (isClass(configFile >> "CfgWeapons" >> _x)) then {getText(configFile >> "CfgWeapons" >> _x >> "acre_baseClass")}else{""};
            If !(_baseClass isEqualTo "") then {
                (((_data select _i)select _j) select 1) set [_forEachIndex,_baseClass];
            };
        } forEach (((_data select _i)select _j) select 1);
    };
};
profileNamespace Setvariable ["bis_fnc_saveInventory_data",_data];
saveprofileNamespace;
LOG("Cleaning Arsenal Classes finished");
