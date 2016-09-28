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
        {
            private _classnamearray = _x splitString "_";
            If (((_classnamearray select 0) isEqualTo "ACRE")&&{((_classnamearray select 1) in ["PRC148","PRC152","PRC117F","PRC77","PRC343"])&&(count _classnamearray > 2)}) then {
                _classnamearray resize 2;
                (((_data select _i)select _j) select 1) set [_forEachIndex,_classnamearray joinString "_"];
                LOG("Changing classname in Arsenal");
            };
        } forEach (((_data select _i)select _j) select 1);
    };
};
profileNamespace Setvariable ["bis_fnc_saveInventory_data",_data];
LOG("Cleaning Arsenal Classes finished");
