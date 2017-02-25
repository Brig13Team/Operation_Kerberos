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

params [
    ["_entity", objNull, [objNull, grpNull, "", locationNull, taskNull, [], 0]] // [] and 0 to handle position
];

switch (typeName _entity) do {
    case "OBJECT": {
        getPos _entity
    };
    case "GROUP": {
        getPos (leader _entity)
    };
    case "STRING": {
        getMarkerPos _entity
    };
    case "LOCATION": {
        position _entity
    };
    case "TASK": {
        taskDestination _entity
    };
    case "ARRAY": {
        + _entity
    };
    case "SCALAR": { // in case of position being passed not in array
        + _this
    };
};
