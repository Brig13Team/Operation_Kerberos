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
#define INCLUDE_GUI
#include "script_component.hpp"
closeDialog 0;
disableSerialization;
createDialog "testobj";
private _ctrl = uiNamespace getVariable "testobject";

_this params [["_vehicleType","",[""]]];
CHECK(_vehicleType isEqualTo "")
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
    abs((_boundingBox select 0) select 1) + abs((_boundingBox select 1) select 1)
]);
/*
private ["_scale","_fix"];
If (_max<8) then {
    _scale = linearConversion [4, 13, _max, 1, 0.3, false];
    _fix = (_boundingCenter select 1);
}else{
    _scale = linearConversion [13, 48, _max, 0.35, 0.11, false];
    _fix = (_boundingCenter select 1)/10;
};
*/
private _scale = 0.125;
private _scale = 0.1;
//test4 = _size;
switch (_vehicleType) do {
    case "Land_VR_Block_01_F" : {
        _scale = 0.1;
        // 23.7487
    };
    case "Land_VR_Block_02_F" : {
        _scale = 0.131;
        // 17.4356
    };
    case "Land_VR_Block_03_F" : {
        _scale = 0.158;
        // 15.3704
    };
    case "Land_VR_Block_04_F" : {
        _scale = 0.15;
        // 17.3638
    };
    case "Land_VR_Block_05_F" : {
        _scale = 0.2;
        // 11.8743
    };
};
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


//_scale = linearConversion [15, 30, _modifier, 0.2, 0.1, false];
test4 = [_vehicleType,_modifier,_scale];
(ctrlPosition _ctrl) params ["_posX","_posZ","_posY"];

/*
If ((_boundingCenter select 1)>0) then {
    _pos set[2,(_pos select 2)-(_fix min 0.2)];

};
If (((_boundingCenter select 1)<0)) then {
    _pos set[2,(_pos select 2)+(_fix max -0.2)];
};
*/
/*
x = GUI_ECHIDNA_X;
y = GUI_ECHIDNA_Y;
w = GUI_ECHIDNA_W * 40;
h = GUI_ECHIDNA_H * 27.5;


*/
_posX = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 10;
test4 = [test4,[_posZ,_posZ + _scale *(_boundingCenter select 2)*5]];
_posZ = _posZ + _scale * (_boundingCenter select 2)*5;
_posY = GUI_ECHIDNA_Y +  GUI_ECHIDNA_H * 22.5;



_ctrl ctrlSetPosition [_posX,_posZ,_posY];
_ctrl ctrlSetModel _model;
_ctrl ctrlSetModelScale _scale;


private _dir = 0;
GVAR(startObj) = diag_tickTime;
//while {(ctrlShown _ctrl)&&((GVAR(startObj) + 2) > diag_tickTime)} do {
while {(ctrlShown _ctrl)} do {
    _dir = ((diag_tickTime - GVAR(startObj))mod 60) * 25;

    _localVeh setDir _dir;
    _localVeh setVectorUp [0,-0.2,0.8];

    private _vecDir = vectorDir _localVeh;
    private _vecUp = vectorUP _localVeh;

    //private _vecDir = [[0,0.970142,0.242536],_dir] call BIS_fnc_rotateVector2D;
    //private _vecUp = [[0,-0.242536,0.970142],_dir] call BIS_fnc_rotateVector2D;
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
