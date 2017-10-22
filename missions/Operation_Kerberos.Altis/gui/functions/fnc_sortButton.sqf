/**
 * Author: Dorbedo
 * animation of the sort Button
 *
 * Arguments:
 * 0: <STRING> dialog Event
 * 1: <ANY> parameter
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */

#include "script_component.hpp"

params ["_event", "_params"];

switch (toLower _event) do {
    case "switch" : {
        _params params ["_ctrl"];
        private _bool = !(_ctrl getVariable ["sortorder",true]);
        private _text = [
            "\a3\ui_f\data\igui\cfg\actions\arrow_down_gs.paa",
            "\a3\ui_f\data\igui\cfg\actions\arrow_up_gs.paa"
            ] select _bool;
        _ctrl ctrlSetText _text;
        _ctrl ctrlCommit 0;
        _ctrl setVariable ["sortorder",_bool];
    };
};
