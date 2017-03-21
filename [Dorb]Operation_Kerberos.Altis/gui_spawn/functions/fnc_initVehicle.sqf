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


_this params [["_vehicleType","",[""]]];

private _model = getText(configFile>>"CfgVehicles">>_vehicleType>>"model");


private _localVeh = _vehicleType createVehicleLocal [0,0,0];
private _boundingCenter = boundingCenter _localVeh;
private _boundingBox = boundingBox _localVeh;


private _modifier = abs((_boundingBox select 0) select 0) + abs((_boundingBox select 1) select 0) +
                    abs((_boundingBox select 0) select 1) + abs((_boundingBox select 1) select 1);

private _scale = switch (true) do {
    case (_modifier < 15) : {
        linearConversion [15, 5, _modifier, 0.2, 0.7, false];
    };
    case (_modifier > 30): {
        linearConversion [30, 50, _modifier, 0.1, 0.09, false];
    };
    default {
        linearConversion [15, 30, _modifier, 0.2, 0.1, false];
    };
};

(ctrlPosition _ctrl) params ["_posX","_posZ","_posY"];

_posX = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 10;
_posZ = _posZ + _scale * (_boundingCenter select 2)*5;
_posY = GUI_ECHIDNA_Y +  GUI_ECHIDNA_H * 22.5;

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


deleteVehicle _localVeh;
