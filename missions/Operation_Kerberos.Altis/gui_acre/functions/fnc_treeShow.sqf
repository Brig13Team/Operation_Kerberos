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
disableSerialization;
// hide all other things
[] call FUNC(hideAll);

// get the tree and the propertiesList
private _display = uiNamespace getVariable QEGVAR(gui_main,dialog);
private _tree = _display displayCtrl IDC_ACRE_MENU_TREE;
private _list = _display displayCtrl IDC_ACRE_MENU_PROPERTIESLIST;
private _background = _display displayCtrl IDC_ACRE_MENU_BACK_1;

tvClear _tree;
lnbClear _list;

// move the tree and the propertieslist to their positions
_tree ctrlSetPosition [
    GUI_DISP_X+GUI_DISP_W*16,
    GUI_DISP_Y+GUI_DISP_H*9,
    GUI_DISP_W*70,
    GUI_DISP_H*80
];
_list ctrlSetPosition [
    GUI_DISP_X+GUI_DISP_W*87,
    GUI_DISP_Y+GUI_DISP_H*9,
    GUI_DISP_W*72,
    GUI_DISP_H*80
];
_background ctrlSetPosition [
    GUI_DISP_X+GUI_DISP_W*87,
    GUI_DISP_Y+GUI_DISP_H*9,
    GUI_DISP_W*72,
    GUI_DISP_H*80
];

_list lnbAddColumn 0.5;
_tree ctrlCommit 0;
_list ctrlCommit 0;
_background ctrlCommit 0;
TRACEV_1(_list);
// add the Events
_tree ctrladdEventHandler ["TreeSelChanged",LINKFUNC(TreeOnSelChanged)];


// functions
_fnc_getPlayergroups = {
    _this params ["_side"];
    private _groups = [];
    {
        If (
            (side _x == _side)
            &&{({isPlayer _x} count (units _x))>0}
            ) then {
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
If !(isNil QGVAR(curTree)) then {
    HASH_DELETE(GVAR(curTree));
};
GVAR(curTree) = LHASH_CREATE;
{
    // SIDE
    _curside = _x;
    private _sideIndex = [(_tree tvAdd [[], str _curside])];
    private _playergroups = [_curside] call _fnc_getPlayergroups;
    _tree tvExpand _sideIndex;
    {
        // --GROUP
        private _curGroup = _x;
        private _groupIndex =+ _sideIndex;
        TRACEV_2(_groupIndex,_sideIndex);
        _groupIndex pushBack (_tree tvAdd [_sideIndex, groupId _curGroup]);
        private _hashes = _curGroup getVariable [QGVAR(radios),[]];
        _hashes = _hashes - [objNull];
        // ----RADIO
        If (_hashes isEqualTo []) then {
            _tree tvAdd [_groupIndex, localize LSTRING(NOSQUADRADIOS)];
        }else{
            {
                private _radioHash = _x;
                private _radioIndex =+ _groupIndex;
                private _radioType = HASH_GET_DEF(_radioHash,"radioType","");
                If !(_radioType isEqualTo "") then {
                    private _typeHash = HASH_GET(GVAR(radioTypeList),_radioType);
                    private _radio = HASH_GET_DEF(_typeHash,"displayname","ERROR");
                    private _channel = HASH_GET_DEF(_radioHash,"channel",-1);
                    private _picture = HASH_GET_DEF(_typeHash,"picture","");
                    If ([_radioHash] call FUNC(isPreset)) then {
                        If (HASH_HASKEY(_radioHash,"channelName")) then {
                            _channel = HASH_GET(_radioHash,"channelName");
                        };
                        _radioIndex pushBack (_tree tvAdd [_groupIndex, format["%1         Channel: %2",_radio,_channel]]);
                    }else{
                        _radioIndex pushBack (_tree tvAdd [_groupIndex, _radio]);
                    };

                    if !(_picture isEqualTo "") then {
                        _tree tvSetPicture [_radioIndex, _picture];
                    };
                    _tree tvSetData [ _radioIndex,str _radioIndex];
                    HASH_SET(GVAR(curTree),str _radioIndex,_radioHash);
                };
            } forEach _hashes;
            _tree tvExpand _groupIndex;
        };

        {
            private _curPlayer = _x;
            private _hashes = _curPlayer getVariable [QGVAR(radios),[]];
            _hashes = _hashes - [objNull];
            If !(_hashes isEqualTo []) then {
                // ----MEMBER
                private _playerIndex =+ _groupIndex;
                _playerIndex pushBack (_tree tvAdd [_groupIndex, name _curPlayer]);
                {
                    // ------RADIO
                    private _radioHash = _x;
                    private _radioIndex =+ _playerIndex;
                    private _radioType = HASH_GET_DEF(_radioHash,"radioType","");
                    If !(_radioType isEqualTo "") then {
                        private _typeHash = HASH_GET(GVAR(radioTypeList),_radioType);
                        private _radio = HASH_GET_DEF(_typeHash,"displayname","ERROR");
                        private _channel = HASH_GET_DEF(_radioHash,"channel",-1);
                        private _picture = HASH_GET_DEF(_typeHash,"picture","");
                        If ([_radioHash] call FUNC(isPreset)) then {
                            If (HASH_HASKEY(_radioHash,"channelName")) then {
                                _channel = HASH_GET(_radioHash,"channelName");
                            };
                            _radioIndex pushBack (_tree tvAdd [_playerIndex, format["%1         Channel: %2",_radio,_channel]]);
                        }else{
                            _radioIndex pushBack (_tree tvAdd [_playerIndex, _radio]);
                        };

                        if !(_picture isEqualTo "") then {
                            _tree tvSetPicture [_radioIndex, _picture];
                        };
                        _tree tvSetData [ _radioIndex,str _radioIndex];
                        HASH_SET(GVAR(curTree),str _radioIndex,_radioHash);
                    };
                } forEach _hashes;
            };
        } forEach ((units _curGroup) select {isPlayer _x});
    } foreach _playergroups;
} forEach (missionNamespace getVariable [QGVAR(sides),[GVARMAIN(playerside)]]);
