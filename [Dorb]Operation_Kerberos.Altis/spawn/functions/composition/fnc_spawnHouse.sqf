/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns a house composition
 *
 *  Parameter(s):
 *      0 : OBJECT - the house
 *      1 : CONFIG - the composition to spawn
 *
 *  Returns:
 *      ARRAY - Position for Missionobjective, empty if none availlible
 *
 */

#include "script_component.hpp"

_this params ["_house","_config"];
TRACEV_3(_this,_house,_config);
[] call FUNC(delaySpawn);

private _housetype = getText(_config>>"type");
private _housePos = getPosWorld _house;
private _houseDir = getDir _house;

If !(_housetype isEqualTo (typeOf _house)) exitWith {
    ERROR("Housetype does not match config");
};

private _fnc_setObject = {
    _this params ["_curObj"];
    //TRACEV_1(_curObj);
    switch (true) do {
        case (_curObj isKindOf "StaticWeapon"): {
            // prevent the static units from looking north by default
            private _watchpos = [_targetPos,250,(_curDir + (getDir _house))] call BIS_fnc_relPos;
            _watchpos set [2,0];
            (gunner _curObj) doWatch _watchpos;
        };
        case (_curObj isKindOf "CAManBase"): {
            // disable the moving of the units
            _curObj disableAI "PATH";
            _curObj addEventHandler ["FiredNear",LINKFUNC(composition_onFiredNear)];
        };
        case (_curObj isKindOf "LandVehicle"): {
            // lock the vehicles and remove the most of the fuel
            _curObj lock 1;
            _curObj setFuel 0.1;
            (driver _curObj) disableAI "PATH";
            (driver _curObj) addEventHandler ["FiredNear",LINKFUNC(composition_onFiredNear)];
        };
    };
};

Private _allObjects = configProperties [_config,"isClass(_x)",true];
private _group = grpNull;
private _objectives = [];
{
    private _curCfg = _x;
    private _curType = getText(_x>>"type");
    _curType = [_curType] call FUNC(composition_getReplacement);
    private _curPos = getArray(_x>>"pos");
    private _curVecUp = getArray(_x>>"vecup");
    private _curDir = getNumber(_x>>"dir");
    private _hasCrew = getNumber(_x>>"hascrew")>0;
    private _isSimpleObject = getNumber(_x>>"issimpleobj")>0;
    private _object = objNull;
    //private _targetPos = _house modelToWorld _curPos;
    private _targetPos = _housePos vectorAdd ([_curPos,-1 * _houseDir] call BIS_fnc_rotateVector2D);

    If (_curType == "Land_CargoBox_V1_F") then {
        _objectives pushBack _targetPos;
    }else{
        If (_curType isKindOf "CAManBase") then {
            If (isNull _group) then {_group = createGroup GVARMAIN(side);};
            _object = [[0,0,0],_group,_curType,"NONE",0] call FUNC(unit);
        }else{
            If (_isSimpleObject) then {
                _object = createSimpleObject [getText(configFile>>"CfgVehicles">>_curType>>"model"), [0,0,100]];
            }else{
                If (isNull _group) then {_group = createGroup GVARMAIN(side);};
                _object = ([[0,0,0],_group,_curType,(_curDir + (getDir _house)),((_hasCrew)||{_curType isKindOf "StaticWeapon"}),true] call FUNC(vehicle)) select 1;
            };
        };
        _object setPosWorld _targetPos;
        _object setDir (_curDir + (getDir _house));
        _object setVectorUp _curVecUp;
        [_object] call _fnc_setObject;
    };
} forEach _allObjects;

If ((!(isNull _group))&&{!(isNil QEFUNC(headquarter,registergroup))}) then {
    [_group,"defence"] call EFUNC(headquarter,registergroup);
};
GVAR(usedHouses) pushBack _house;
_objectives;
