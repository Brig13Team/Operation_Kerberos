/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Creates a libary with all house-positions
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
private _mainHash = HASH_CREATE;
GVAR(exportHash) = _mainHash;

private _allPossibleBuildings = configProperties [(configFile >> "CfgVehicles"),"((configName _x) isKindOf 'House') && (getNumber (_x >> 'scope') > 0)",true];
private _buildingsarray = [];
private _helper = createVehicle ["Sign_Arrow_Large_F",[0,0,0],[],0,"CAN_COLLIDE"];

{
    private _curCfg = _x;
    private _curClass = toLower (configName _curCfg);
    private _nameArray = _curClass splitString "_";
    // ignore the damaged buildings
    If !(("dam" in _nameArray)||("ruins" in _nameArray)) then {
        private _house = createVehicle [_curClass,[0,0,0],[],0,"CAN_COLLIDE"];
        private _soldierpos = [];
        private _doorpos = [];
        _house setPosWorld [0,0,0];
        _house setVectorUp [0,0,1];
        _house setDir 0;
        // get the door positions
        for "_i" from 0 to 20 do {
            private _tempTriggerPos = _house selectionPosition format["door_%1_trigger",_i+1];
            If !(_tempTriggerPos isEqualTo [0,0,0]) then {
                private _tempPosHelper = _house modeltoworld _tempTriggerPos;
                private _tempAxisPos = _house modeltoworld (_house selectionPosition format["door_%1_axis",_i+1]);
                private _tempDir = [_tempAxisPos,_tempPosHelper]call BIS_fnc_dirTo;
                private _tempDoorPos = [_tempPosHelper select 0,_tempPosHelper select 1,(_tempPosHelper select 2) -1,_tempDir];
                _doorpos pushBack _tempDoorPos;
            };
        };

        private _allSoldierPositions = [];
        private _allWindows = [];
        for "_i" from 0 to 100 do {
            private _temp = (_house selectionPosition format["glass_%1_effects",_i]);
            If (_temp isEqualTo [0,0,0]) exitWith {};
            _temp = _house modeltoworld _temp;
            _allWindows pushBack _temp;
        };
        {
            _allSoldierPositions pushBack (AGLToASL _x);
        } forEach (_house buildingPos -1);
        {
            private _buildPosASL = _x;
            private _wpnrad = 1.5;
            private _isObstructedZ = lineIntersects [_buildPosASL, [(_buildPosASL select 0), (_buildPosASL select 1), (_buildPosASL select 2) + 20]];
            private _hasSurfaceBelowXa = lineIntersects [[(_buildPosASL select 0) - _wpnrad, (_buildPosASL select 1), (_buildPosASL select 2)], [(_buildPosASL select 0) - _wpnrad, (_buildPosASL select 1), (_buildPosASL select 2) - 0.5]];
            private _hasSurfaceBelowXb = lineIntersects [[(_buildPosASL select 0) + _wpnrad, (_buildPosASL select 1), (_buildPosASL select 2)], [(_buildPosASL select 0) + _wpnrad, (_buildPosASL select 1), (_buildPosASL select 2) - 0.5]];
            private _hasSurfaceBelowYa = lineIntersects [[(_buildPosASL select 0), (_buildPosASL select 1) - _wpnrad, (_buildPosASL select 2)], [(_buildPosASL select 0), (_buildPosASL select 1) - _wpnrad, (_buildPosASL select 2) - 0.5]];
            private _hasSurfaceBelowYb = lineIntersects [[(_buildPosASL select 0), (_buildPosASL select 1) + _wpnrad, (_buildPosASL select 2)], [(_buildPosASL select 0), (_buildPosASL select 1) + _wpnrad, (_buildPosASL select 2) - 0.5]];
            private _level = 0;
            If (!_isObstructedZ) then {_level = _level + 2;};
            If (_hasSurfaceBelowXa and _hasSurfaceBelowXb and _hasSurfaceBelowYa and _hasSurfaceBelowYb) then {_level = _level + 1;};
            private _dir1 = -1;
            private _dir2 = -1;
            If (_level < 2) then {
                private _nextwindow = [0,0,-4];
                for "_k" from 0 to ((count _allWindows)-1) do {
                    If ((_nextwindow distance _buildPosASL) >((_allWindows select _k) distance _buildPosASL)) then {
                        _nextwindow = (_allWindows select _k);
                    };
                };
                private _dir = [_buildPosASL,_nextwindow] call BIS_fnc_dirTo;
                private _atan = (_nextwindow distance _buildPosASL) atan2 (0.5);
                _dir1 = _dir - _atan;
                _dir2 = _dir + _atan;

            }else{
                _dir1 = [[0,0,0],_buildPosASL] call BIS_fnc_dirTo;
                _dir2 = -1;
            };
            _buildPosASL append [_dir1,_dir2,_level];
            _soldierpos pushback _buildPosASL;
        } forEach _allSoldierPositions;

        private _tempHash = HASH_CREATE;
        HASH_SET(_mainHash,_curClass,_tempHash);
        HASH_SET(_tempHash,"soldierpos",_soldierpos);
        HASH_SET(_tempHash,"doorpos",_doorpos);
        deleteVehicle _house;
    };
} forEach _allPossibleBuildings;


// merge entries
private _allKeys = HASH_KEYS(_mainHash);

{
    private _nameArray = _x splitString "_";
    private _copy = "";
    If (
            (count _nameArray > 2)&&
            {(_nameArray select (count _nameArray -2)) in ["V1","V2","V3","V4","V5"]}) then {
        If ((_nameArray select 1) in ["i","u"]) then {
            _nameArray set [1,"i"];
            _nameArray set [(count _nameArray)-2,"V1"];
            private _searchKey = _nameArray joinString "_";
            If (_searchKey in _allKeys) then {
                _copy = _searchKey;
            };
        }else{
            _nameArray set [(count _nameArray)-2,"V1"];
            private _searchKey = _nameArray joinString "_";
            If (_searchKey in _allKeys) then {
                _copy = _searchKey;
            };
        };
    };
    // search for different colors
    If (_copy isEqualTo "") then {
        Private _parent = configName (inheritsFrom (configFile >> "CfgVehicles" >> _x));
        If (_parent in _allKeys) then {
            _copy = _parent;
        };
    };

    If !(_copy isEqualTo "") then {
        private _oldHash = HASH_GET(_mainHash,_copy);
        private _newHash = HASH_COPY(_oldHash);
        HASH_SET(_mainHash,_x,_newHash);
        HASH_DELETE(_oldHash);
    };

} forEach _allKeys;


{
    private _tempHash = HASH_GET(_mainHash,_x);
    private _tempDoor = HASH_GET(_tempHash,"doorpos");
    private _tempSoldier = HASH_GET(_tempHash,"soldierpos");
    If ((_tempSoldier isEqualTo [])&&(_tempDoor isEqualTo [])) then {
        HASH_DELETE(_tempHash);
        HASH_REM(_mainHash,_x);
    };
} forEach _allKeys;












[_mainHash,"housepositions"] call FUNC(composition_exportToHpp);
