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
private _boundingCenter = boundingCenter _localVeh;
private _boundingBox = boundingBoxReal _localVeh;

private _modifier = abs((_boundingBox select 0) select 0) + abs((_boundingBox select 1) select 0) +
                    abs((_boundingBox select 0) select 1) + abs((_boundingBox select 1) select 1);

private _scale = switch (true) do {
    case (_modifier < 15) : {
        linearConversion [15, 4, _modifier, 0.28, 0.7, false];
    };
    case (_modifier > 30): {
        linearConversion [30, 80, _modifier, 0.13, 0.06, false];
    };
    default {
        linearConversion [15, 30, _modifier, 0.28, 0.13, false];
    };
};

private _posX = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 10;
private _posZ = 5 + _scale * (If (abs(_boundingCenter select 2)==0) then {0.8}else{abs(_boundingCenter select 2)})*5;
private _posY = GUI_ECHIDNA_Y +  GUI_ECHIDNA_H * 21;
TRACEV_5(_vehicleType,_modifier,_posZ,_scale,_boundingCenter);

private _ctrlPos = [_posX,_posZ,_posY];
private _vehicleHash = HASH_GET(GVAR(vehiclesHash),_vehicleType);

HASH_SET(_vehicleHash,"model",_model);
HASH_SET(_vehicleHash,"ctrlPos",_ctrlPos);
HASH_SET(_vehicleHash,"scale",_scale * 1.2);
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
