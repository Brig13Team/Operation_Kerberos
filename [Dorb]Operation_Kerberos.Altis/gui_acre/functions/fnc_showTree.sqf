/*
 *  Author: Dorbedo
 *
 *  Description:
 *      shows the tree-View
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

// hide all other things
[] call FUNC(hideAll);

// get the tree and the propertiesList
private _display = uiNamespace getVariable QGVAR(dialog);
private _tree = _display displayCtrl IDC_ACRE_MENU_TREE;
private _list = _display displayCtrl IDC_ACRE_MENU_PROPERTIESLIST;

// move the tree and the propertieslist to their positions

// TODO - addEvents



// functions
_fnc_getPlayergroups = {
    _this params ["_side"];
    private _groups = [];
    {
        If ((side _x == _side)&&
            {({isPlayer _x} count (units _x))>0}) then {
            _groups pushBack _x;
        };
    } forEach allGroups;
    _groups;
};


// display the tree
/*

    SIDE
    --GROUP
    ----(P)RADIO1 - CUSTOM
    ----MEMBER1
    ------(P)RADIO1 - CHAN1
    ------(P)RADIO1 - CUST

*/
GVAR(curTree) = HASH_CREATE;
{
    // SIDE
    _curside = _x;
    private _sideIndex = [] pushBack (_tree tvAdd [[], str _curside])
    private _playergroups = [_curside] call _fnc_getPlayergroups;
    {
        // --GROUP
        private _curGroup = _x;
        private _groupIndex =+ _sideIndex;
        _groupIndex pushBack (_tree tvAdd [_sideIndex, groupId _curGroup]);
        private _hashes = _curGroup getVariable [GVAR(radios),[]];
        // ----RADIO
        If (_hashes isEqualTo []) then {
            _tree tvAdd [_groupIndex, localize LSTRING(NOSQUADRADIOS)];
        }else{
            {
                private _radioHash = _x;
                private _radioIndex =+ _groupIndex;
                private _radio = HASH_GET_DEF(_radioHash,"radioName","ERROR");
                private _preset = HASH_GET_DEF(_radioHash,"presetname","custom");
                private _picture = HASH_GET_DEF(_radioHash,"picture","");
                private _radioIndex = _x;
                _radioIndex pushBack (_tree tvAdd [_groupIndex, format["%1 - %2",_radio,_preset]]);
                if !(_picture isEqualTo "") then {
                    _tree tvSetPicture [_radioIndex, _picture];
                };
                _tree tvSetData [ _radioIndex,str _radioIndex];
                HASH_SET(GVAR(curTree),str _radioIndex);
            } forEach _hashes;
        };

        {
            private _curPlayer = _x;
            private _hashes = _curPlayer getVariable [GVAR(radios),[]];
            If !(_hashes isEqualTo []) then {
                // ----MEMBER
                private _playerIndex =+ _groupIndex;
                _playerIndex pushBack (_tree tvAdd [_groupIndex, name _curPlayer]);
                {
                    // ------RADIO
                    private _radioHash = _x;
                    private _radioIndex =+ _playerIndex;
                    private _radio = HASH_GET_DEF(_radioHash,"radioName","ERROR");
                    private _preset = HASH_GET_DEF(_radioHash,"presetname","custom");
                    private _picture = HASH_GET_DEF(_radioHash,"picture","");
                    private _radioIndex = _x;
                    _radioIndex pushBack (_tree tvAdd [_playerIndex, format["%1 - %2",_radio,_preset]]);
                    if !(_picture isEqualTo "") then {
                        _tree tvSetPicture [_radioIndex, _picture];
                    };
                    _tree tvSetData [ _radioIndex,str _radioIndex];
                    HASH_SET(GVAR(curTree),str _radioIndex);
                } forEach _hashes;
            };
        } forEach ((units _curGroup) select {isPlayer _x});
    } foreach _playergroups;
} forEach (missionNamespace getVariable [QGVAR(sides),GVARMAIN(playerside)]);
