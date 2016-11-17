/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns a predefined composition
 *
 *  Parameter(s):
 *      0 : ARRAY - Position
 *      1 : CONFIG - the composition to spawn
 *      2 : SCALAR - the direction of the composition
 *
 *  Returns:
 *      ARRAY - Position for Missionobjective, empty if none availlible
 *
 */
#include "script_component.hpp"
private _fnc_scriptname = "test";
_this params ["_position","_config","_direction"];

[] call FUNC(delaySpawn);

private _objectives = [];
private _group = grpNull;


private _fnc_spawnRelObj = {
    private _fnc_scriptname = "testinner";
    _this params ["_curRelObj","_curCfg"];
    private _classes = "isClass(_x)" configClasses _curCfg;

    {
        private _curCfg = _x;
        private _curType = getText(_x>>"type");
        private _relPos = getArray(_x>>"pos");
        private _curPos = _curRelObj modelToWorldVisual _relPos;
        private _relPosObj = _curRelObj modelToWorldVisual [0,0,0];
        //LOG_4(_curType,_relPos,_curPos,_relPosObj);
        private _curDir = getNumber(_x>>"dir") + getDir _curRelObj;
        private _hasCrew = getNumber(_x>>"hascrew")>0;
        private _isSimpleObject = getNumber(_x>>"issimpleobj")>0;
        private ["_curObj","_curVecUp"];
        If (_curType isKindOf "HouseBase") then {
            _curVecUp = [0,0,1];
        }else{
            _curVecUp = getArray(_curCfg >> "vecup") vectorAdd (vectorUp _curRelObj);
        };

        If (_curType == "Land_CargoBox_V1_F") then {
            _objectives pushBack _curPos;
        }else{
            If ((_curType isKindOf "CAManBase")) then {
                If (isNull _group) then {_group = createGroup GVARMAIN(side);};
                [_curPos,_group,_curType,"NONE",_curDir] call FUNC(unit);
            }else{
                If (false && _isSimpleObject) then {
                    _curObj = createSimpleObject [_curType, [0,0,0]];
                    _curObj setPos _curPos;
                    _curObj setDir _curDir;
                    _curObj setVectorUp _curVecUp;
                }else{
                    LOG_5(_curPos,_group,_curType,_curDir,_hasCrew);
                    _curObj = ([_curPos,_group,_curType,_curDir,_hasCrew,true] call FUNC(vehicle)) select 1;
                    _curObj setVectorUp _curVecUp;
                };
            };


            If (isClass(_curCfg >> "objects")) then {
                [_curObj,(_curCfg >> "objects")] call _fnc_spawnRelObj;
            };
        };
    } forEach _classes;


};





private _allClasses = "isClass(_x)" configClasses _config;
LOG_1(_allClasses);

{
    private _curCfg = _x;
    private _curType = getText(_x>>"type");
    private _curPos = _position vectorAdd ([getArray(_x>>"pos"), -1 * _direction] call BIS_fnc_rotateVector2D);
    _curPos set [2,getArray(_x>>"pos") select 2];

    LOG_1(_curType,_curPos);
    private _curDir = getNumber(_x>>"dir") + _direction;
    private _hasCrew = getNumber(_x>>"hascrew")>0;
    private _isSimpleObject = getNumber(_x>>"issimpleobj")>0;
    private ["_curObj","_curVecUp"];
    If (_curType isKindOf "HouseBase") then {
        _curVecUp = [0,0,1];
    }else{
        _curVecUp = getArray(_curCfg >> "vecup") vectorAdd (surfaceNormal _curPos);
    };

    If (_curType == "Land_CargoBox_V1_F") then {
        _objectives pushBack _curPos;
    }else{
        If ((_curType isKindOf "CAManBase")) then {
            If (isNull _group) then {_group = createGroup GVARMAIN(side);};
            [_curPos,_group,_curType,"NONE",_curDir] call FUNC(unit);
        }else{
            If (false && _isSimpleObject) then {
                _curObj = createSimpleObject [_curType, [0,0,0]];
                _curObj setPos _curPos;
                _curObj setDir _curDir;
                _curObj setVectorUp _curVecUp;
            }else{
                //LOG_5(_curPos,_group,_curType,_curDir,_hasCrew);
                If (isNull _group) then {_group = createGroup GVARMAIN(side);};
                _curObj = ([_curPos,_group,_curType,_curDir,_hasCrew,true] call FUNC(vehicle)) select 1;
                //_curObj setPos _curPos;
                //_curObj setDir _curDir;
                _curObj setVectorUp _curVecUp;
                private _name = configName _curCfg;
                LOG_3(_curPos,_name,_curType);
            };
        };


        If (isClass(_curCfg >> "objects")) then {
            LOG_1(_curPos);
            [_curObj,(_curCfg >> "objects")] call _fnc_spawnRelObj;
        };
    };
    //LOG_1(_forEachIndex);
} forEach _allClasses;




_objectives
