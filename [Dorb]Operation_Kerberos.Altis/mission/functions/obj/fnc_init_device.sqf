/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_device",objNull,[[],objNull]]];

CHECK(isNull)

If (IS_ARRAY(_device)) exitWith {
    {
        _this call FUNC(obj_init_device);
    } forEach _device;
};
_device setVariable [QGVAR(isActive),true,true];
