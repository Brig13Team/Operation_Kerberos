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
closeDialog 0;
disableSerialization;
createDialog "testobj";
private _ctrl = uiNamespace getVariable "testobject";

_this params [["_vehicleType","",[""]]];

private _model = getText(configFile>>"CfgVehicles">>_vehicleType>>"model");
private _localVeh = _vehicleType createVehicleLocal [0,0,0];
private _boundingCenter = boundingCenter _localVeh;
private _boundingBox = boundingBox _localVeh;
test2 = boundingBox _localVeh;
test3 = _boundingCenter;
private _size = sizeOf _vehicleType;

//private _scale = (0.4*20)/_size;
/*
private _scale = (selectMax [
    abs((_boundingBox select 0) select 0) + abs((_boundingBox select 1) select 0),
    abs((_boundingBox select 0) select 1) + abs((_boundingBox select 1) select 1),
    abs((_boundingBox select 0) select 2) + abs((_boundingBox select 1) select 2)
]) * 0.0027;
*/
private _max = (selectMax [
    abs((_boundingBox select 0) select 0) + abs((_boundingBox select 1) select 0),
    abs((_boundingBox select 0) select 1) + abs((_boundingBox select 1) select 1),
    abs((_boundingBox select 0) select 2) + abs((_boundingBox select 1) select 2)
]);
private ["_scale","_fix"];
If (_max<8) then {
    _scale = linearConversion [4, 13, _max, 1, 0.3, false];
    _fix = (_boundingCenter select 1);
}else{
    _scale = linearConversion [13, 48, _max, 0.35, 0.11, false];
    _fix = (_boundingCenter select 1)/10;
};
test4 = [_vehicleType,_scale,_max,_fix];
_scale = _scale * 0.8;

//test4 = [_scale,_max];

_ctrl ctrlSetModel _model;
_ctrl ctrlSetModelScale _scale;
private _pos = ctrlPosition _ctrl;
//test4 = [_pos,_boundingCenter];

//_pos = [
//    (_pos select 0)/*+(_boundingCenter select 0)*/,
//    (_pos select 1)/*+(_boundingCenter select 2)*/,
//    (_pos select 2)+(_boundingCenter select 1)
//    ];

If ((_boundingCenter select 1)>0) then {
    //private _fix = (_boundingCenter select 1);
    //If (_fix > 1) then {_fix = _fix/10;};
    _pos set[2,(_pos select 2)-(_fix min 0.2)];
    //_pos set[2,(_pos select 2)-((_boundingCenter select 1)/10)];
};
If (((_boundingCenter select 1)<0)) then {
    //private _fix = (_boundingCenter select 1);
    //If (_fix > 1) then {_fix = _fix/10;};
    _pos set[2,(_pos select 2)+(_fix max -0.2)];
    //_pos set[2,(_pos select 2)+((_boundingCenter select 1)/1)];
};


_ctrl ctrlSetPosition _pos;

//_localVeh setVectorDirAndUp [[0.5,0.8,0.2],[0,-0.2,0.8]];
//test2 = _localVeh call BIS_fnc_getPitchBank;
private _dir = 0;
GVAR(startObj) = diag_tickTime;
while {ctrlShown _ctrl} do {
    _dir = ((diag_tickTime - GVAR(startObj))mod 60) * 25;
    _localVeh setDir _dir;
    _localVeh setVectorUp [0,-0.2,0.8];

    private _vecDir = vectorDir _localVeh;
    private _vecUp = vectorUP _localVeh;
    _ctrl ctrlSetModelDirAndUp [_vecDir,_vecUp];

};

deleteVehicle _localVeh;

/*
RHS_C130J
[[-23.9066,-17.8063,-1.32879],[23.9009,18.0049,12.791]]
[-0,-0,0]
48,36,14


RHS_M2StaticMG_D
[[-1.78073,-1.90611,-2.0297],[1.78073,1.90611,2.0297]]
[0.351914,-0.316008,1.68593]
3.4 , 3.8 , 4

BWA3_Tiger_Gunpod_Heavy
[[-7.71457,-9.45533,-2.56486],[7.70531,9.57058,4.54044]]
[-0,-0,0]
14 , 18, 7

BWA3_Puma_Fleck
[[-2.8643,-7.01251,-0.582533],[2.881,6.93727,5.11914]]
5.6, 14.1 5.6
0.5
BWA3_Leopard2A6M_Fleck
[[-2.644,-6.76933,-0.520631],[2.55271,6.65428,5.54691]]
4, 13, 6
0.5
*/
