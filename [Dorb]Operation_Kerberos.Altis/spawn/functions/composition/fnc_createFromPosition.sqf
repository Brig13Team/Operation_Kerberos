/*
 *  Author: Dorbedo
 *
 *  Description:
 *      creates a composition from a position/object
 *
 *  Parameter(s):
 *      0 : OBJECT/ARRAY - the center of the composition
 *      1 : SCALAR - Radius
 *      2 : SCALAR - Direction
 *
 *  Returns:
 *      HASH - the composition
 *
 */
#include "script_component.hpp"
private _fnc_scriptname = "test";
_this params [["_center",[],[[],objNull]],["_radius",35,[0]],["_dir",0,[0]]];

CHECK(_center isEqualTo [])

If (IS_OBJECT(_center)) then {
    _dir = getDir _center;
    _center = getPos _center;
};
private _vectorUp = [0,0,1];


private _nearObjects = nearestObjects [_center,["Static","Thing","AllVehicles"],_radius];

private _mainhash = HASH_CREATE;
GVAR(tempHash) = _mainhash;

If !(isNil QGVAR(exporthelper)) then {
    deleteVehicle GVAR(exporthelper);
    deleteVehicle GVAR(exporthelper2);
    deleteVehicle GVAR(exporthelper3);
};
_center set[2,0];
GVAR(exporthelper) = ([sideLogic] call CBA_fnc_getSharedGroup) createUnit ["LOGIC", [0, 0, 0], [], 0, "NONE"];
GVAR(exporthelper2) = createVehicle ["Sign_Arrow_Large_F", _center, [], 0, "CAN_COLLIDE"];
GVAR(exporthelper3) = createVehicle ["Sign_Arrow_Direction_F", _center, [], 0, "CAN_COLLIDE"];
GVAR(exporthelper) setPosATL _center;
GVAR(exporthelper) setDir _dir;
GVAR(exporthelper2) setPosATL _center;
GVAR(exporthelper3) setPosATL _center;
GVAR(exporthelper3) setDir _dir;
//_nearObjects = _nearObjects - [GVAR(exporthelper)] - [GVAR(exporthelper2)];

private _fnc_getObjbelow = {
    _this params [["_object",objNull,[objNull]],["_objectsToIgnore",[],[[]]]];

    private _objPosASL = getPosASL _object;
    private _terrainPosATL = getPosATL _object;
    _terrainPosATL set [2,0];
    private _terrainPosASL = ATLtoASL _terrainPosATL;
    private _nextObject = lineIntersectsObjs [_objPosASL, _terrainPosASL, objNull, _object, false, 2];
    _nextObject = _nextObject - _objectsToIgnore;
    private _testavar = str _nextObject;
    if (_nextObject isEqualTo []) exitWith {_object;};
    _objectsToIgnore pushBack _object;
    [_nextObject select 0,_objectsToIgnore] call _fnc_getObjbelow;
};

private _fnc_setObjAtt = {
    _this params ["_hash","_obj","_relObj"];
    HASH_SET(_hash,"type",typeOf _obj);
    private _curPos = If (surfaceIsWater (getPos _obj)) then {getPosASL _obj}else{getPosATL _obj};
    private _curRelPos = _relObj worldToModel _curPos;
    HASH_SET(_hash,"pos",_curRelPos);
    private _curDir = (getDir _obj) + (getDir _relObj);
    HASH_SET(_hash,"dir",_curDir);
    HASH_SET(_hash,"vecup",vectorUp _obj);
    private _hasCrew = (count (getArray(configFile >> (typeOf _obj) >> "typicalCargo" ))) > 0;
    private _isSimpleObject = !((_hasCrew)||(_obj isKindOf "CAManBase"));
    HASH_SET(_hash,"hascrew",_hasCrew);
    HASH_SET(_hash,"issimpleobj",_isSimpleObject);
};

private _fnc_setObjAttBottom = {
    _this params ["_hash","_obj"];
    HASH_SET(_hash,"type",typeOf _obj);
    //private _curRelPos = GVAR(exporthelper) getPos [GVAR(exporthelper) distance2D _obj,[GVAR(exporthelper),_obj]call BIS_fnc_relativeDirTo];
    private _curRelPos = GVAR(exporthelper) worldToModel (getPos _obj);
    HASH_SET(_hash,"pos",_curRelPos);
    private _curDir = (getDir _obj) + _dir;
    HASH_SET(_hash,"dir",_curDir);
    HASH_SET(_hash,"vecup",vectorUp _obj);
    private _hasCrew = (count (getArray(configFile >> (typeOf _obj) >> "typicalCargo" ))) > 0;
    private _isSimpleObject = !((_hasCrew)||(_obj isKindOf "CAManBase"));
    HASH_SET(_hash,"hascrew",_hasCrew);
    HASH_SET(_hash,"issimpleobj",_isSimpleObject);
};


If (({_x isKindOf "Land_CargoBox_V1_F"}count _nearObjects)>0) then {
    HASH_SET(_mainhash,"isobjective",1);
}else{
    HASH_SET(_mainhash,"isobjective",0);
};

_nearObjects = _nearObjects select {(!isPlayer _x)&&(!(_x isKindOf "Animal"))&&(!(typeOf _x in ["","Sign_Arrow_Direction_F","Sign_Arrow_Large_F"]))};


private _registeredObjects = [];
private _registeredObjectshashes = [];
private _time = CBA_missiontime + 6;
while { ((count _nearObjects)>0)&&(_time > CBA_missiontime)} do {
    private _curObj = _nearObjects deleteAt 0;
    If !((_curObj == GVAR(exporthelper))||(_curObj == GVAR(exporthelper2))) then {

        private _objBelow = [_curObj] call _fnc_getObjbelow;

        If ((_curObj == _objBelow)||(isNull _objBelow)) then {
            /// register as lowest Object
            private _tempHash = HASH_CREATE;
            private _tempKey = format["Obj_%1", count (HASH_KEYS(_mainhash)) ];
            HASH_SET(_mainhash,_tempKey,_tempHash);
            [_tempHash,_curObj] call _fnc_setObjAttBottom;
            private _index = count _registeredObjects;
            _registeredObjects set[_index,_curObj];
            _registeredObjectshashes set [_index,_tempHash];
        }else{
            If (_objBelow in _registeredObjects) then {
                // get the hash of the lowest object
                private _index = _registeredObjects find _objBelow;
                private _curHash = _registeredObjectshashes select _index;
                private _objectshash = HASH_GET(_curHash,"objects");
                If (isNil "_objectshash") then {
                    _objectshash = HASH_CREATE;
                    HASH_SET(_curHash,"objects",_objectshash);
                };
                // register the Object as a sub-object
                private _tempHash = HASH_CREATE;
                private _tempKey = format["Obj_%1", count (HASH_KEYS(_objectshash)) ];
                HASH_SET(_objectshash,_tempKey,_tempHash);
                [_tempHash,_curObj,_objBelow] call _fnc_setObjAtt;
                private _index = count _registeredObjects;
                _registeredObjects set[_index,_curObj];
                _registeredObjectshashes set [_index,_tempKey];
            }else{
                _nearObjects pushBack _curObj;
            };
        };
    };
};
test = _mainhash;
_mainhash;
