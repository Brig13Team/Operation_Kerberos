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

disableSerialization;

createDialog "testobj";

private _ctrl = uiNamespace getVariable "testobject";

hint str (ctrlPosition _ctrl);
_this params [["_sw",0,[0]]];

switch (_sw) do {
    case 0 : {
        _ctrl ctrlSetModel "\rhsusf\addons\rhsusf_heavyweapons\m2_mg"; // 8.18612
        _ctrl ctrlSetModelScale (0.4*20)/8.1;
        private _pos = ctrlPosition _ctrl;
        _pos set [2,(_pos select 2)-0.31];
        _ctrl ctrlSetPosition _pos;
    };
    case 1 : {
        _ctrl ctrlSetModel "\bwa3_leopard2a6m\bwa3_leopard2a6m.p3d"; // 19.6026
        _ctrl ctrlSetModelScale 0.4;
        //_ctrl ctrlSetModelScale (0.2*20)/20;

    };
    case 2 : {
        _ctrl ctrlSetModel "\rhsafrf\addons\rhs_ss21\SS21Veh.p3d";
        _ctrl ctrlSetModelScale 0.4;
    };
    case (3): {
        _ctrl ctrlSetModel "\rhsusf\addons\rhsusf_a2port_air\C130J\c130j.p3d"; // 41.6265
        _ctrl ctrlSetModelScale (0.4*20)/41.6265;
    };




    //cases (insertable by snippet)
};

_ctrl ctrlSetModelDirAndUp [[0.5,0.8,0.2],[0,-0.2,0.8]];
//_ctrl ctrlSetModelDirAndUp [[0,1,0],[0,0,1]];
//_ctrl ctrlSetModelScale (0.47 * 0.875 * (SafeZoneW Min SafeZoneH));


_ctrl ctrlCommit 0;

_ctrl ctrlSetModelDirAndUp [[0.5,0.8,0.2],[0,-0.4,0.6]];
