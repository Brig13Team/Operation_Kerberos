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

params [["_display", displayNull, [displayNull]]];

private _tree = _display displayCtrl IDC_TFAR_TREE;
tvClear _tree;

private _fnc_getPlayergroups = {
    params ["_side"];
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


/*
    SIDE
    --GROUP [SR: | LR:]
    ----MEMBER1 [SR: | LR:]
    ----MEMBER2 [SR: | LR:]
*/

{
    // SIDE
    private _curside = _x;
    private _sideIndex = [(_tree tvAdd [[], str _curside])];
    private _playergroups = [_curside] call _fnc_getPlayergroups;
    _tree tvExpand _sideIndex;
    {
        // --GROUP
        private _curGroup = _x;
        private _groupIndex =+ _sideIndex;
        TRACEV_2(_groupIndex,_sideIndex);

        private _text = (groupId _curGroup) + "               ";

        private _curFrequencies = _curGroup getVariable [QGVAR(frequencies), ["", "", "", ""]];
        if (_curFrequencies isEqualTo ["", "", "", ""]) then {
            _curFrequencies = (leader _curGroup) getVariable [QGVAR(frequencies), ["", "", "", ""]];
        };

        if ((_curFrequencies select SR_INDEX) isEqualTo "") then {
            if !((_curFrequencies select SR_ADD_INDEX) isEqualTo "") then {
                _text = format ["%1    SR: %2", _text, _curFrequencies select SR_ADD_INDEX];
            };
        } else {
            if ((_curFrequencies select SR_ADD_INDEX) isEqualTo "") then {
                _text = format ["%1    SR: %2", _text, _curFrequencies select SR_INDEX];
            } else {
                _text = format ["%1    SR: %2 (%3)", _text, _curFrequencies select SR_INDEX, _curFrequencies select SR_ADD_INDEX];
            };
        };

        if ((_curFrequencies select LR_INDEX) isEqualTo "") then {
            if !((_curFrequencies select LR_ADD_INDEX) isEqualTo "") then {
                _text = format ["%1    LR: %2", _text, _curFrequencies select LR_ADD_INDEX];
            };
        } else {
            if ((_curFrequencies select LR_ADD_INDEX) isEqualTo "") then {
                _text = format ["%1    LR: %2", _text, _curFrequencies select LR_INDEX];
            } else {
                _text = format ["%1    LR: %2 (%3)", _text, _curFrequencies select LR_INDEX, _curFrequencies select LR_ADD_INDEX];
            };
        };
        _groupIndex pushBack (_tree tvAdd [_sideIndex, _text]);

        {
            // Player
            private _curPlayer = _x;
            private _text = (name _curPlayer) + "               ";
            private _curFrequencies = _curPlayer getVariable [QGVAR(frequencies_player), ["", "", "", ""]];

            If !(_curFrequencies isEqualTo ["", "", "", ""]) then {

                if ((_curFrequencies select SR_INDEX) isEqualTo "") then {
                    if !((_curFrequencies select SR_ADD_INDEX) isEqualTo "") then {
                        _text = format ["%1  SR: %2", _text, _curFrequencies select SR_ADD_INDEX];
                    };
                } else {
                    if ((_curFrequencies select SR_ADD_INDEX) isEqualTo "") then {
                        _text = format ["%1  SR: %2", _text, _curFrequencies select SR_INDEX];
                    } else {
                        _text = format ["%1  SR: %2 (%3)", _text, _curFrequencies select SR_INDEX, _curFrequencies select SR_ADD_INDEX];
                    };
                };

                if ((_curFrequencies select LR_INDEX) isEqualTo "") then {
                    if !((_curFrequencies select LR_ADD_INDEX) isEqualTo "") then {
                        _text = format ["%1  LR: %2", _text, _curFrequencies select LR_ADD_INDEX];
                    };
                } else {
                    if ((_curFrequencies select LR_ADD_INDEX) isEqualTo "") then {
                        _text = format ["%1  LR: %2", _text, _curFrequencies select LR_INDEX];
                    } else {
                        _text = format ["%1  LR: %2 (%3)", _text, _curFrequencies select LR_INDEX, _curFrequencies select LR_ADD_INDEX];
                    };
                };

                _tree tvAdd [_groupIndex, _text];
            };
        } forEach ((units _curGroup) select {isPlayer _x});
    } foreach _playergroups;
} forEach (missionNamespace getVariable [QGVAR(sides), [GVARMAIN(playerside)]]);
