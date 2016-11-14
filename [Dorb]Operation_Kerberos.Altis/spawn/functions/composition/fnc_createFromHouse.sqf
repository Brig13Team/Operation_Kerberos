/*
 *  Author: DOrbedo
 *
 *  Description:
 *      creates a house-composition
 *
 *  Parameter(s):
 *      0 : OBJECT - The House
 *
 *  Returns:
 *      HASH - the composition
 *
 */
#include "script_component.hpp"

_this params [["_house",objNull,[objNull]],["_radius",35,[0]]];

CHECK(isNull _house)
CHECK(!(_house isKindOf "house"))

private _housetype = typeOf _house;
private _nearObjects = _house nearObjects _radius;
private _housePosAGL = getPos _house;


private _hash = HASH_CREATE;
GVAR(tempHash) = _hash;

HASH_SET(_hash,"type",_housetype);

{
    private _curtypename = toLower (typename _x);
    If ((!isPlayer _x)&&(!(_curtypename in ["camera","#dynamicsound"]))) then {
        private _curObj = _x;
        private _curType = _x;
        private _curPos = getPos _curObj;
        private _curVecUp = vectorUp _curObj;
        private _curRelPos = _house worldToModel _curPos;
        private _temphash = HASH_CREATE;
        private _hasCrew = !((crew _curObj) isEqualTo []);
        private _isSimpleObject = (({_curObj isKindOf _x} count ["CAManBase","Static","LandVehicle","Air","Ship"])<1);


        HASH_SET(_hash,format["obj_%1",_forEachIndex],_temphash);
        HASH_SET(_temphash,"type",_curType);
        HASH_SET(_temphash,"pos",_curRelPos);
        HASH_SET(_temphash,"vecup",_curVecUp);
        HASH_SET(_temphash,"hascrew",_hasCrew);
        HASH_SET(_temphash,"issimpleobj",_isSimpleObject);
    };
} forEach _nearObjects;

_hash;
