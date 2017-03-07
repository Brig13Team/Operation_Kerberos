/*
 *  Author: Dorbedo
 *
 *  Description:
 *      creates a house-composition
 *
 *  Parameter(s):
 *      0 : OBJECT - The House
 *      1 : SCALAR - Radius
 *
 *  Returns:
 *      HASH - the composition
 *
 */
#include "script_component.hpp"

_this params [["_house",objNull,[objNull]],["_radius",35,[0]],["_author","BrigTeam",[""]]];

CHECK(isNull _house)
CHECK(!(_house isKindOf "house"))

private _housetype = typeOf _house;
private _nearObjects = nearestObjects [_house,["Static","Thing","AllVehicles"],_radius];
private _houseDir = getDir _house;
private _housePos = getPosWorld _house;

private _hash = HASH_CREATE;
GVAR(tempHash) = _hash;

HASH_SET(_hash,"type",_housetype);
If (({_x isKindOf "Land_CargoBox_V1_F"}count _nearObjects)>0) then {
    HASH_SET(_hash,"hasmissiontarget",1);
}else{
    HASH_SET(_hash,"hasmissiontarget",0);
};
LOG_1(_nearObjects);

{
    private _curtypename = toLower (typename _x);
    If ((!isPlayer _x)&&(!(_curtypename in ["camera","#dynamicsound"]))&&(!(_x isKindOf "Animal"))&&(!(_x == _house))) then {
        private _curObj = _x;
        private _curType = typeOf _x;
        LOG_2(_curtypename,_curType);
        //private _curPos = getPos _curObj;
        private _curPos = getPosWorld _curObj;
        private _curVecUp = vectorUp _curObj;
        private _curDir = (getDir _curObj) + _houseDir;
        //private _curRelPos = _house worldToModel _curPos;
        private _curRelPos = _curPos vectorDiff _housePos;
        private _temphash = HASH_CREATE;
        private _hasCrew = !((crew _curObj) isEqualTo []);
        private _isSimpleObject = [_curObj] call FUNC(composition_issimpleobject);

        private _keyname = format["obj_%1",_forEachIndex];
        LOG_1(_keyname);
        HASH_SET(_hash,_keyname,_temphash);
        HASH_SET(_temphash,"type",_curType);
        HASH_SET(_temphash,"pos",_curRelPos);
        HASH_SET(_temphash,"dir",_curDir);
        HASH_SET(_temphash,"vecup",_curVecUp);
        HASH_SET(_temphash,"hascrew",_hasCrew);
        HASH_SET(_temphash,"issimpleobj",_isSimpleObject);
    };
} forEach _nearObjects;


HASH_SET(_hash,"author",_author);
_hash;
