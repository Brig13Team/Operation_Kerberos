/*
 *  Author: Dorbedo
 *
 *  Description:
 *      completes the entrie
 *
 *  Parameter(s):
 *      0 : STRING - Vehicle classname
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"


_this params [["_vehicleType","",[""]]];

private _model = getText(configFile>>"CfgVehicles">>_vehicleType>>"model");

private _localVeh = _vehicleType createVehicleLocal [0,0,0];
private _boundingBox = boundingBoxReal _localVeh;

private ["_posDiffZ","_maxSize"];
If ((toLower _model) isEqualTo "\a3\weapons_f\empty.p3d") then {
    _posDiffZ = 0;
    _maxSize = 0;
}else{
    _posDiffZ = ((getPosASL _localVeh)select 2) - ((getPosWorld _localVeh)select 2);
    private _diff = (_boundingBox select 1) vectorDiff (_boundingBox select 0);
    _maxSize = selectMax [_diff vectorDotProduct [1,0,0], _diff vectorDotProduct [0,1,0], _diff vectorDotProduct [0,0,1]];
};

private _posZ = 10;
/*
    SCALE = CONTAINERSIZE_in_SCREEN / MAXIMUM_SIZE * POS_Z
*/
private _scale = (GUI_ECHIDNA_W * 15)/_maxSize * _posZ;
private _posX = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 10.5;
private _posY = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 23 + (_scale * _posDiffZ) / _posZ;

private _ctrlPos = [_posX,_posZ,_posY];
private _vehicleHash = HASH_GET(GVAR(vehiclesHash),_vehicleType);

HASH_SET(_vehicleHash,"model",_model);
HASH_SET(_vehicleHash,"ctrlPos",_ctrlPos);
HASH_SET(_vehicleHash,"scale",_scale);
HASH_SET(_vehicleHash,"objInitialized",true);

HASH_SET(_vehicleHash,"propertiesList",[]);

// name
private _value = getText(configFile>>"CfgVehicles">>_vehicleType>>"displayName");
HASH_SET(_vehicleHash,"name",_value);
HASH_GET(_vehicleHash,"propertiesList") pushBack "displayName";

HASH_SET(_vehicleHash,"empty","");
HASH_GET(_vehicleHash,"propertiesList") pushBack "empty";

// mass
private _mass = format ["%1 t",((getMass _localVeh) / 1000)];
HASH_SET(_vehicleHash,"mass",_mass);
HASH_GET(_vehicleHash,"propertiesList") pushBack "mass";

private _positionNumber = count (fullCrew [_localVeh, "cargo", true]);
HASH_SET(_vehicleHash,"cargonumber",_positionNumber);
HASH_GET(_vehicleHash,"propertiesList") pushBack "cargonumber";

private _weaponAdded = false;
{
    private _curWeapon = _x;
    private _name = getText (configFile >> "CfgWeapons" >> _curWeapon >> "displayName");
    If !((_name isEqualTo "")||{(toUpper _name) in ["MASTERSAFE","SAFE","HORN","FLARES"]}) then {
        If (_weaponAdded) then {
            private _curKey = format["WEAPON_%1",_forEachIndex];
            HASH_SET(_vehicleHash,_curKey,_name);
            HASH_GET(_vehicleHash,"propertiesList") pushBack (_curKey);
        }else{
            HASH_SET(_vehicleHash,"weapons",_name);
            HASH_GET(_vehicleHash,"propertiesList") pushBack "weapons";
            _weaponAdded=true;
        };
    };
} forEach (weapons _localVeh);

deleteVehicle _localVeh;

GVAR(vehiclesHashModified) = true;
