/**
 * Author: Dorbedo
 * returns specific datatype from a compositionconfig
 *
 * Arguments:
 * 0: <CONFIG> the config
 * 1: <STRING> the datatype
 *
 * Return Value:
 * <ARRAY> array with all cfgclasses
 *
 */

#include "script_component.hpp"

params ["_cfg","_datatype"];
//TRACEV_2(_cfg,_datatype);
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
