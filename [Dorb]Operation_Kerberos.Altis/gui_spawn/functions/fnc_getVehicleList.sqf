/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _curList = missionNamespace getVariable [QGVAR(curVehList),[]];

private _return = [];

{
    private _vehicleType = _x;
    private _cfg = (configFile >> "CfgVehicles" >> _vehicleType);
    If (isClass(_cfg)) then {
        private ["_mod","_picture","_displayName"];
        If !(HASH_HASKEY(GVAR(vehiclesHash),_vehicleType)) then {
            private _temp = HASH_CREATE;
            HASH_SET(GVAR(vehiclesHash),_vehicleType,_temp);

            // listIcon
            _displayName = getText(configFile >> "cfgvehicles" >> _vehicleType >> "displayName");
            HASH_SET(_temp,"displayName",_displayName);

            // listIcon
            _picture = getText(configFile >> "cfgvehicles" >> _vehicleType >> "Icon");
            If (_picture in ["pictureThing","pictureStaticObject","iconobject_1x3"]) then {_picture = "";};
            HASH_SET(_temp,"picture",_picture);

            // get the mod
            _mod = toArray( configSourceMod (configFile >> "CfgVehicles">>_vehicleType));
            If (((count _mod) > 0)&&{(_mod select 0) == 64}) then {
                _mod deleteAt 0;
            };
            _mod = toString _mod;
            HASH_SET(_temp,"mod",_mod);

        }else{
            private _vehicleHash = HASH_GET(GVAR(vehiclesHash),_vehicleType);
            _picture = HASH_GET(_vehicleHash,"picture");
            _mod = HASH_GET(_vehicleHash,"mod");
            _displayName = HASH_GET(_vehicleHash,"displayName");
        };
        private _value = 0;
        _return pushBack [[_displayName,_mod],_picture,_vehicleType,_value];
    };
} forEach _curList;
_return
