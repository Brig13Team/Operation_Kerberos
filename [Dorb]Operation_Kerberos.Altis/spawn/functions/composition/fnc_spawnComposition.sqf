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
#define DEBUG_MODE_OFF
#include "script_component.hpp"

_this params ["_centerPos","_config","_centerDir"];
TRACEV_3(_centerPos,_config,_centerDir);
// put the centerpos on the ground
_centerPos set[2,0];
_centerPos = ATLToASL _centerPos;

[] call FUNC(delaySpawn);

private _objectives = [];
private _group = grpNull;

private _fnc_setObject = {
    _this params ["_curObj"];
    //TRACEV_1(_curObj);
    switch (true) do {
        case (_curObj isKindOf "StaticWeapon"): {
            // prevent the static units from looking north by default
            private _watchpos = [_spawnPos,250,_spawnDir] call BIS_fnc_relPos;
            _watchpos set [2,0];
            (gunner _curObj) doWatch _watchpos;
            If ("Artillery" in getArray(configFile>>"cfgVehicles">>typeOf _curObj>>"availableforsupporttypes")) then {
                [_curObj] call EFUNC(headquarter,fdc_register);
            };
        };
        case (_curObj isKindOf "CAManBase"): {
            // disable the moving of the units
            _curObj disableAI "PATH";
            _curObj addEventHandler ["FiredNear",LINKFUNC(composition_onFiredNear)];
        };
        case (_curObj isKindOf "HouseBase"): {
            // houses are always up
            _curObj setVectorUp [0,0,1];
        };
        case (_curObj isKindOf "LandVehicle"): {
            // lock the vehicles and remove the most of the fuel
            _curObj lock 1;
            _curObj setFuel 0.1;
            (driver _curObj) disableAI "PATH";
            (driver _curObj) addEventHandler ["FiredNear",LINKFUNC(composition_onFiredNear)];
            If ("Artillery" in getArray(configFile>>"cfgVehicles">>typeOf _curObj>>"availableforsupporttypes")) then {
                [_curObj] call EFUNC(headquarter,fdc_register);
            };
        };
        case (_curObj isKindOf "CamoNet_BLUFOR_F"): {
            _curObj setDammage 0;
        };
    };
};

private _fnc_spawnRelObj = {
    private _fnc_scriptname = "testinner";
    _this params ["_curRelObj","_curCfg"];
    private _classes = configProperties [_curCfg, "isClass(_x)", true];

    {
        private _curCfg = _x;
        private _curType = getText(_x>>"type");
        _curType = [_curType] call FUNC(composition_getReplacement);
        private _curPos = getArray(_x>>"pos");
        private _curDir = getNumber(_x>>"dir");
        private _curVecUp = getArray(_x>>"vecup");
        private _hasCrew = getNumber(_x>>"hascrew")>0;
        private _isSimpleObject = getNumber(_x>>"issimpleobj")>0;

        private _curRelObjPos = getPosWorld _curRelObj;
        private _curRelObjDir = getDir _curRelObj;
        private _curRelObjVecUp = vectorUp _curRelObj;

        // spawndirection
        private _spawnDir = _curRelObjDir + _curDir;
        // rotate the vector acording to objectdir
        private _relPos = [_curPos,-1 * _curRelObjDir] call BIS_fnc_rotateVector2D;
        // get the relative Position
        TRACEV_4(_relPos,_curRelObjPos,_curType,typeOf _curRelObj);
        private _spawnPos = _relPos vectorAdd _curRelObjPos;

        // vectorUp
        private _spawnVecUp = [_curVecUp,-1 * _curRelObjDir] call BIS_fnc_rotateVector2D;
        _spawnVecUp = _spawnVecUp vectorAdd _curRelObjVecUp;

        TRACEV_7(_curType,_curPos,_curDir,_curVecUp,_curRelObjPos,_curRelObjDir,_curRelObjVecUp);
        TRACEV_3(_spawnPos,_spawnDir,_spawnVecUp);

        // spawn the objects
        private ["_curObj"];
        If (_curType == "Land_CargoBox_V1_F") then {
            // the object is a Mission target
            _objectives pushBack _spawnPos;
        }else{
            If ((_curType isKindOf "CAManBase")) then {
                If (isNull _group) then {_group = createGroup GVARMAIN(side);};
                _curObj = [_spawnPos,_group,_curType,"NONE",_spawnDir] call FUNC(unit);
                _curObj setDir _spawnDir;
                _curObj setVectorUp _spawnVecUp;
                _soldierSpawn = [_spawnPos select 0,_spawnPos select 1,(_spawnPos select 2) + 0.1];
                _curObj setPosWorld _spawnPos;
            }else{
                If (_isSimpleObject) then {
                    _curObj = createSimpleObject [_curType, [0,0,0]];
                    GVAR(cleanUpDump) pushBack _curObj;
                    _curObj setPosWorld _spawnPos;
                    _curObj setDir _spawnDir;
                    _curObj setVectorUp _spawnVecUp;
                }else{
                    //LOG_5(_curPos,_group,_curType,_curDir,_hasCrew);
                    _curObj = ([ASLToATL _spawnPos,_group,_curType,_spawnDir,_hasCrew,true] call FUNC(vehicle)) select 1;
                    _curObj setPosWorld _spawnPos;
                    _curObj setVectorUp _spawnVecUp;
                };
            };
            //TRACEV_1(_curObj);
            _curObj call _fnc_setObject;
            If (isClass(_curCfg >> "objects")) then {
                [_curObj,(_curCfg >> "objects")] call _fnc_spawnRelObj;
            };
        };
    } forEach _classes;


};

private _allClasses = configProperties [_config, "isClass(_x)", true];
//LOG_1(_allClasses);

{
    private _curCfg = _x;
    private _curType = getText(_x>>"type");
    _curType = [_curType] call FUNC(composition_getReplacement);
    private _curPos = getArray(_x>>"pos");
    private _curDir = getNumber(_x>>"dir");
    private _curVecUp = getArray(_x>>"vecup");
    private _hasCrew = getNumber(_x>>"hascrew")>0;
    private _isSimpleObject = getNumber(_x>>"issimpleobj")>0;

    // spawndirection
    private _spawnDir = _centerDir + _curDir;
    // rotate the vector acording to centerdir
    private _relPos = [_curPos,-1 * _centerDir] call BIS_fnc_rotateVector2D;
    // get the relative Position
    //TRACEV_3(_centerPos,_curPos,_relPos);
    private _relPos = _relPos vectorAdd _centerPos;

    private _checkPos1 = _relPos vectorAdd [0,0,30];
    private _checkPos2 = _relPos vectorAdd [0,0,-30];

    ((lineIntersectsSurfaces[_checkPos1,_checkPos2,objNull,objNull,false]) select 0) params ["_spawnPos","_surfaceNormal"];

    // normalize the area

    // TODO


    // add the height of the Object
    If !((_curPos select 2) == 0) then {

        private _height = (_curPos select 2); // ATL-ASL = 5m (VA)
        //TRACEV_5(_checkPos1,_checkPos2,_spawnPos,_surfaceNormal,_height);
        private _heightVec = _surfaceNormal vectorMultiply _height;
        _spawnPos = _spawnPos vectorAdd _heightVec;
        //TRACEV_3(_height,_heightVec,_spawnPos);

        /*
        private _heightVec = _surfaceNormal vectorMultiply (_curPos select 2);
        TRACEV_3(_curType,_spawnPos,_heightVec);
        _heightVec = ASLToATL _heightVec;
        private _height = _heightVec select 2;
        _spawnPos = _spawnPos vectorAdd (_surfaceNormal vectorMultiply _height);
        TRACEV_1(_spawnPos);
        */
    };
    // vectorUp
    private _spawnVecUp = [_curVecUp,-1 * _centerDir] call BIS_fnc_rotateVector2D;
    _spawnVecUp = _spawnVecUp vectorAdd _surfaceNormal;

    private "_curObj";
    If (_curType == "Land_CargoBox_V1_F") then {
        // the object is a Mission target
        _objectives pushBack _spawnPos;
    }else{
        If ((_curType isKindOf "CAManBase")) then {
            If (isNull _group) then {_group = createGroup GVARMAIN(side);};
            _curObj = [_spawnPos,_group,_curType,"NONE",_spawnDir] call FUNC(unit);
            _curObj setDir _spawnDir;
            _curObj setVectorUp _spawnVecUp;
            _soldierSpawn = [_spawnPos select 0,_spawnPos select 1,(_spawnPos select 2) + 0.1];
            _curObj setPosWorld _spawnPos;
        }else{
            If (_isSimpleObject) then {
                _curObj = createSimpleObject [_curType, [0,0,0]];
                GVAR(cleanUpDump) pushBack _curObj;
                _curObj setPosWorld _spawnPos;
                _curObj setDir _spawnDir;
                _curObj setVectorUp _spawnVecUp;
            }else{
                //LOG_5(_curPos,_group,_curType,_curDir,_hasCrew);
                If (isNull _group) then {_group = createGroup GVARMAIN(side);};
                _curObj = ([ASLToATL _spawnPos,_group,_curType,_spawnDir,_hasCrew,true] call FUNC(vehicle)) select 1;
                _curObj setPosWorld _spawnPos;
                _curObj setVectorUp _spawnVecUp;
            };
        };
        //TRACEV_1(_curObj);
        _curObj call _fnc_setObject;

        If (isClass(_curCfg >> "objects")) then {
            //LOG_1(_curPos);
            [_curObj,(_curCfg >> "objects")] call _fnc_spawnRelObj;
        };
    };
    //LOG_1(_forEachIndex);
} forEach _allClasses;


//TRACEV_1(_objectives);

_objectives
