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


private _modifier = abs((_boundingBox select 0) select 0) + abs((_boundingBox select 1) select 0) +
                     abs((_boundingBox select 0) select 1) + abs((_boundingBox select 1) select 1);

private _scale = switch (true) do {
    case (_modifier < 15) : {
        linearConversion [15, 4, _modifier, 0.28, 0.7, false];
    };
    case (_modifier > 30): {
        linearConversion [30, 80, _modifier, 0.13, 0.07, false];
    };
    default {
        linearConversion [15, 30, _modifier, 0.28, 0.13, false];
    };
};

private _posX = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 10;
private _posZ = 8;
private _posY = GUI_ECHIDNA_Y +  GUI_ECHIDNA_H * 23 + _posDiffZ * _scale * GUI_ECHIDNA_H * 5;
TRACEV_6(_vehicleType,_modifier,_modifier2,_posZ,_scale,_boundingCenter);

private _ctrlPos = [_posX,_posZ,_posY];
private _vehicleHash = HASH_GET(GVAR(vehiclesHash),_vehicleType);

HASH_SET(_vehicleHash,"model",_model);
HASH_SET(_vehicleHash,"ctrlPos",_ctrlPos);
HASH_SET(_vehicleHash,"scale",_scale * 1.3);
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
