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
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [
    ["_center",[],[[],objNull]],
    ["_radius",40,[0]],
    ["_dir",0,[0]],
    ["_author","BrigTeam",[""]]
];
CHECK(_center isEqualTo [])

If (IS_OBJECT(_center)) then {
    _dir = getDir _center;
    _center = getPos _center;
    _center set[2,0];
};
private _vectorUp = [0,0,1];


private _nearObjects = nearestObjects [_center,["Static","Thing","AllVehicles"],_radius];
TRACEV_1(_nearObjects);
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
    private _relObjDir = getDir _relObj;
    private _relObjPos = getPosWorld _relObj;
    private _relObjVecUp = vectorUp _relObj;
    HASH_SET(_hash,"type",typeOf _obj);
    // get the position acording to the relative object
    private _objPos = getPosWorld _obj;
    _objPos = [_objPos,_relObjDir] call BIS_fnc_rotateVector2D;
    private _curRelPos = _objPos vectorDiff _relObjPos;
    HASH_SET(_hash,"pos",_curRelPos);
    // dir and vector
    private _curDir = (getDir _obj) - (getDir _relObj);
    HASH_SET(_hash,"dir",_curDir);
    private _vecUp = vectorUp _obj;
    _vecUp = [_vecUp,_relObjDir] call BIS_fnc_rotateVector2D;
    _vecUp = _vecUp vectorAdd _relObjVecUp;
    HASH_SET(_hash,"vecup",_vecUp);

    // object properties
    private _hasCrew = [_obj] call FUNC(composition_hasCrew);
    private _isSimpleObject = [_obj,true] call FUNC(composition_isSimpleObject);
    HASH_SET(_hash,"hascrew",_hasCrew);
    HASH_SET(_hash,"issimpleobj",_isSimpleObject);
};

private _fnc_setObjAttBottom = {
    _this params ["_hash","_obj"];
    HASH_SET(_hash,"type",typeOf _obj);
    // get the position of the Object
    private _objPos = getPosWorld _obj;
    // rotate acording to centerdir
    _objPos = [_objPos,_dir] call BIS_fnc_rotateVector2D;
    // relativ to centerpos
    private _curRelPos = _objPos vectorDiff _center;
    // get the height of the object (difference between object center and terrain level)
    private _helperPos =+ _curRelPos;
    _helperPos set [2,0];
    GVAR(exporthelper) setPosATL _helperPos;
    private _height = (getPosWorld GVAR(exporthelper)) select 2;
    _curRelPos = _curRelPos vectorAdd [0,0,-1 * _height];
    HASH_SET(_hash,"pos",_curRelPos);
    // direction of the object
    private _curDir = (getDir _obj) - _dir; // rotate counterClockwise
    HASH_SET(_hash,"dir",_curDir);
    private _vecUp = vectorUp _obj;
    _vecUp = [_vecUp,_dir] call BIS_fnc_rotateVector2D;
    HASH_SET(_hash,"vecup",_vecUp);
    // object properties
    private _hasCrew = [_obj] call FUNC(composition_hasCrew);
    private _isSimpleObject = [_obj] call FUNC(composition_isSimpleObject);
    HASH_SET(_hash,"hascrew",_hasCrew);
    HASH_SET(_hash,"issimpleobj",_isSimpleObject);
};


If (({_x isKindOf "Land_CargoBox_V1_F"}count _nearObjects)>0) then {
    HASH_SET(_mainhash,"isobjective",1);
}else{
    HASH_SET(_mainhash,"isobjective",0);
};
private _helperToIgnore = ["","Logic",
    "Sign_Arrow_Direction_F","Sign_Arrow_Large_F",
    "Sign_Arrow_Large_Pink_F","Sign_Arrow_Direction_Pink_F",
    "Sign_Arrow_Large_Green_F","Sign_Arrow_Direction_Green_F",
    "Sign_Arrow_Large_Yellow_F","Sign_Arrow_Direction_Yellow_F"
];
// remove things we don't want
_nearObjects = _nearObjects select {
    (!isPlayer _x)&&
    (!(_x isKindOf "Animal"))&&
    (!(typeOf _x in _helperToIgnore))
};


private _registeredObjects = [];
private _registeredObjectshashes = [];
private _time = CBA_missiontime + 8;
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
HASH_SET(_mainhash,"author",_author);

[_mainhash] call FUNC(composition_exporttohpp);
