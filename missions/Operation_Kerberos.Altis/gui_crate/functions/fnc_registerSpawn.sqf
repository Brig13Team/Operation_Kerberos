/**
 * Author: Dorbedo
 * registers a cratespawner position
 *
 * Arguments:
 * 0: <ARRAY/STRING> a array with objects or a preset-name
 * 1: <ARRAY/OBJECT> the spawnposition where to register the spawn
 * 2: <SCALAR> the direction of a new box - Default: dir of Object or 0
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [
    ["_List","",["",[]]],
    ["_spawnPosition",[],[[],objNull],[3]],
    ["_spawnDir",nil,[0]]
];

If ((_spawnPosition isEqualTo [])||{_spawnPosition isEqualTo objNull}) exitWith {
    TRACEV_2(_this,_spawnPosition);ERROR("No spawnposition");
    ""
};

If ((isNil "_spawnDir")&&{IS_OBJECT(_spawnPosition)}) then {
    _spawnDir = getDir _spawnPosition;
} else {
    _spawnDir = 0;
};

if (IS_OBJECT(_spawnPosition)) then {
    _spawnPosition = getPosASL _spawnPosition;
};

private _id = str GVAR(spawnID);
INC(GVAR(spawnID));
TRACEV_5(_id,_List,_spawnPosition,_spawnDir,_this);

If (IS_ARRAY(_list)) then {
    _list = _list apply {
        If (isClass(configFile >> "CfgWeapons" >> _x)) then {
            configFile >> "CfgWeapons" >> _x
        } else {
            If (isClass(configFile >> "CfgGlasses" >> _x)) then {
                configFile >> "CfgGlasses" >> _x
            } else {
                If ((isClass(configFile >> "CfgVehicles" >> _x))&&{([_x,"vehicleClass",""] call EFUNC(common,getCfgVehicles))=='Backpacks'}) then {
                    configFile >> "CfgVehicles" >> _x
                } else {
                    configNull
                };
            };
        };
    };
    _list = _list - [configNull];
    _list = _list apply {[_x,""] call BIS_fnc_configPath};
} else {
    _list = [_list] call FUNC(getItemList);
};
[_list] call FUNC(updateLibary);
_list = [_list] call FUNC(sortItemList);

GVAR(spawns) setVariable [_id,[_List,_spawnPosition,_spawnDir]];

_id
