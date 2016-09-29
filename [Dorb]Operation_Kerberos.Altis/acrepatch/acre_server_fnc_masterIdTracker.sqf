/*
 * Author: ACRE2Team
 * Searches all containers periodically to keep track of ACRE items with unique IDs.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call acre_server_fnc_masterIdTracker
 *
 * Public: No
 */
#include "script_component.hpp"


if(diag_tickTime > acre_sys_server_nextSearchTime) then {
    acre_sys_server_doFullSearch = true;
};

// Short-scan checks that radios are with their last associated object.
if (!acre_sys_server_doFullSearch) then {
    //private _start = diag_tickTime;
    private _shortSearchList = (acre_sys_server_masterIdTable call acre_lib_fnc_fastHashKeys)-acre_sys_server_unacknowledgedIds;
    {
        private _uniqueId = _x;
        private _mainObject = (acre_sys_server_masterIdTable getVariable _uniqueId) select 0;
        // diag_log text format["main object: %1", _mainObject];
        if(isNil "_mainObject") exitWith { acre_sys_server_doFullSearch = true; };
        private _objects = [_mainObject];
        private _allContainers = (everyContainer _mainObject);
        {
            _objects pushBack (_x select 1);
        } forEach _allContainers;

        private _found = false;
        {
            private _object = _x;
            private _items = [];
            if(_object isKindOf "Man") then {
                _items = [_object] call acre_lib_fnc_getGear;
            } else {
                _items = itemCargo _object;
                _items = _items select {(_x select [0, 4]) == "ACRE" || _x == "ItemRadio" || _x == "ItemRadioAcreFlagged"};
            };

            {
                if (_uniqueId == _x) exitWith {_found = true};
            } forEach _items;
            if (_found) exitWith {};
        } forEach _objects;
        if(!_found) exitWith { acre_sys_server_doFullSearch = true; };
    } forEach _shortSearchList;
};

//TRACE_2("Enter masterIdTracker", acre_sys_server_doFullSearch, acre_sys_server_nextSearchTime );
//LOG_3("Enter masterIDTracker",acre_sys_server_doFullSearch,acre_sys_server_nextSeachTime);
if(acre_sys_server_doFullSearch) then {

    acre_sys_server_doFullSearch = false;

    LOG("Spawned master container search");

    private _idTable = (call acre_lib_fnc_fastHashCreate);
    private _idList = [];
    private _duplicateIdTable = (call acre_lib_fnc_fastHashCreate);
    private _searchObjects = allPlayers + allUnits + allDead + vehicles + (allMissionObjects "WeaponHolder"); // search players first

    private _searchedObjects = [];
    private _cfgWeapons = configFile >> "CfgWeapons";
    {
        private _mainObject = _x;
        if(_searchedObjects pushBackUnique _mainObject != -1) then { // If not already searched
            private _objects = [_mainObject];
            private _allContainers = (everyContainer _mainObject);
            {
                _objects pushBack (_x select 1);
            } forEach _allContainers;
            {
                private _object = _x;
                private _items = [];
                if(_object isKindOf "Man") then {
                    _items = [_object] call acre_lib_getGear;
                } else {
                    _items = itemCargo _object;
                    _items = _items select {(_x select [0, 4]) == "ACRE"}; /* || _x == "ItemRadio" || _x == "ItemRadioAcreFlagged" // Only interested in unique IDs*/
                };

                {
                    private _item = _x;
                    if(getNumber(_cfgWeapons >> _item >> "acre_isUnique") == 1) then {
                        if (_idList pushBackUnique _item != -1) then { // Add to ID list and this condition returns true if it was not present in the _idList.
                            _idTable setVariable [_item, [_mainObject, _object]];
                        } else { // Already present in _idList
                            private _duplicateIdList = [];
                            if(!(!(isNil {_duplicateIdTable getVariable _item}))) then {
                                _duplicateIdTable setVariable [_item, _duplicateIdList];
                            } else {
                                (_duplicateIdTable getVariable _item);
                            };
                            _duplicateIdList pushBack [_mainObject, _object];
                        };
                    };
                } forEach _items;
            } forEach _objects;
        };
    } forEach _searchObjects;
    {
        private _key = _x;
        if((!(isNil {acre_sys_server_masterIdTable getVariable _key}))) then {
            _idTable setVariable [_key, (acre_sys_server_masterIdTable getVariable _key)];
        } else {
            #ifdef DEBUG_MODE_FULL
                acre_player sideChat format["%1 ACRE WARNING: Unacknowledged key not found in masterIdTable (%2)", diag_tickTime, _key];
            #endif
            diag_log text format["%1 ACRE WARNING: Unacknowledged key not found in masterIdTable (%2)", diag_tickTime, _key];
        };
    } forEach acre_sys_server_unacknowledgedIds;

    {
        private _key = _x;
        private _duplicates = (_duplicateIdTable getVariable _key);
        private _firstFound = (_idTable getVariable _key);

        private _players = allPlayers;
        // firstFound is always a player if a player has the item.
        if((_firstFound select 0) in _players) then {
            private _baseRadio = configName (inheritsFrom (_cfgWeapons >> _key));
            //Only collect firstFound if there are non-player objects with IDs as well.
            if ({!((_x select 0) in _players)} count _duplicates > 0) then {
                [(_firstFound select 0), _baseRadio, "acre_sys_radio_returnRadioId", _key] call acre_sys_server_fnc_onGetRadioId;
            };

            // Replace all duplicates that other players have.
            {
               private _data = _x;
               if((_data select 0) in _players) then {
                   [(_data select 0), _baseRadio, "acre_sys_radio_returnRadioId", _key] call acre_sys_server_fnc_onGetRadioId;
               };
           } forEach _duplicates;
        };
    } forEach (_duplicateIdTable call acre_lib_fnc_fastHashKeys);
    private _unaccountedForIds = (acre_sys_server_masterIdTable call acre_lib_fnc_fastHashKeys) - (_idTable call acre_lib_fnc_fastHashKeys) - acre_sys_server_unacknowledgedIds;
    {
        LOG("Collecting");
        [_x] call acre_sys_server_fnc_collect;
    } forEach _unaccountedForIds;
    private _toUpdate = [];
    {
        private _key = _x;
        if(!(_key in acre_sys_server_unacknowledgedIds)) then {
            private _value = (_idTable getVariable _key);

            if((!(isNil {acre_sys_server_masterIdTable getVariable _key}))) then {
                private _currentEntry = (acre_sys_server_masterIdTable getVariable _key);
                if(!(_value isEqualTo _currentEntry)) then {
                    _toUpdate pushBack [_key, _value];
                };
            } else {
                #ifdef DEBUG_MODE_FULL
                    acre_player sideChat format["%1 ACRE WARNING: Id object relation created independently of unique ID creation process (%2)", diag_tickTime, _key];
                #endif
                diag_log text format["%1 ACRE WARNING: Id object relation created independently of unique ID creation process (%2)", diag_tickTime, _key];
                _toUpdate pushBack [_key, _value];
            };
        };
    } forEach (_idTable call acre_lib_fnc_fastHashKeys);
    if((count _toUpdate) > 0) then {
        ["acre_updateIdObjects", _toUpdate] call CBA_fnc_globalEvent;
    };
    acre_sys_server_masterIdTable = _idTable;
    acre_sys_server_nextSearchTime = diag_tickTime + 10;
    private _msg = "COMPLETE crate search";
    LOG_2(_msg, acre_sys_server_nextSearchTime);

};
//private _end = diag_tickTime;
