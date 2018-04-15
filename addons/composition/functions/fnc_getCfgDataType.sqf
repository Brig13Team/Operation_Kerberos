#include "script_component.hpp"

/*
  Name: dorb_composition_fnc_getCfgDataType
  Author: Dorbedo
  returns a specific data type from a composition config

  Arguments:
    0: the config <CONFIG>
    1: the datatype <STRING>

  Return Value:
    array with configclasses <ARRAY>

  Public: No
*/

params [["_cfg", configNull, [configNull]], "_datatype"];

If (isNull _cfg) exitWith {
    ERROR_1("No Config provided: %1",_cfg);
    []
};

_dataType = toLower _datatype;

private _return = [];

{
    private _curDataType = toLower( getText(_x >> "dataType"));
    If (_curDataType == _datatype) then {
        _return pushBack _x;
    } else {
        If (_curDataType == "layer") then {
            //TRACEV_2(_curDataType,_x);
            private _temp = [_x >> "Entities", _datatype] call FUNC(getCfgDataType);
            _return append _temp;
        };
    };
    nil
} count (configProperties [_cfg, "(isClass _x)", true]);

_return
