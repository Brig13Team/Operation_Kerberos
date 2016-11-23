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

If !(_housetype isEqualTo (typeOf _house)) exitWith {
    ERROR("Housetype does not match config");
};

Private _allObjects = "isClass(_x)" configClasses _config;
private _group = grpNull;
private _objectives = [];
{
    private _curCfg = _x;
    private _curType = getText(_x>>"type");
    private _curPos = getArray(_x>>"pos");
    private _curVecUp = getArray(_x>>"vecup");
    private _curDir = getNumber(_x>>"dir");
    private _hasCrew = getNumber(_x>>"hascrew")>0;
    private _isSimpleObject = getNumber(_x>>"issimpleobj")>0;
    private _object = objNull;
    private _targetPos = _house modelToWorld _curPos;

    If (_curType == "Land_CargoBox_V1_F") then {
        _objectives pushBack _targetPos;
    }else{
        If (_isSimpleObject) then {
            _object = createSimpleObject [getText(configFile>>"CfgVehicles">>_curType>>"model"), [0,0,100]];
        }else{
            _object = createVehicle [_curType, [0,0,100], [], 0, "CAN_COLLIDE"];
        };
        _object setPos _targetPos;
        _object setDir (_curDir + (getDir _house));
        _object setVectorUp _curVecUp;
        If (_hasCrew) then {
            If (isNull _group) then {
                _group = createGroup GVARMAIN(side);
            };
            [_object,_group] call FUNC(crew);
        };
    };
} forEach _allObjects;

If ((!(isNull _group))&&{!(isNil QEFUNC(headquarter,registergroup))}) then {
    [_group,"defence"] call EFUNC(headquarter,registergroup);
};

_objectives;
