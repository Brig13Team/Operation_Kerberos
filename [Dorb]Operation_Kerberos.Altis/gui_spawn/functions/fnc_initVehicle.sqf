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
//TRACEV_5(_vehicleType,getPosWorld _localVeh,getPos _localVeh,getPosASL _localVeh,getPosATL _localVeh);
private _boundingCenter = boundingCenter _localVeh;
private _boundingBox = boundingBoxReal _localVeh;

private _posDiffZ = ((getPosASL _localVeh)select 2) - ((getPosWorld _localVeh)select 2);

private _scale = 4.5 / ((abs((_boundingBox select 0) select 0) + abs((_boundingBox select 1) select 0)) max
                           (abs((_boundingBox select 0) select 1) + abs((_boundingBox select 1) select 1)));

private _posX = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 10;
private _posZ = 10;
private _posY = GUI_ECHIDNA_Y +  GUI_ECHIDNA_H * 23 + _posDiffZ * _scale * GUI_ECHIDNA_H * 5;
TRACEV_5(_vehicleType,_posDiffZ,_scale,_boundingCenter,_boundingBox);

private _ctrlPos = [_posX,_posZ,_posY];
private _vehicleHash = HASH_GET(GVAR(vehiclesHash),_vehicleType);

HASH_SET(_vehicleHash,"model",_model);
HASH_SET(_vehicleHash,"ctrlPos",_ctrlPos);
HASH_SET(_vehicleHash,"scale",_scale * 1);
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


deleteVehicle _localVeh;
