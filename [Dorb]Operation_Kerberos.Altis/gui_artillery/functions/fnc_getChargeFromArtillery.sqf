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


_this params [["_artilleryType","",[""]]];

switch (_artilleryType) do {
    default {
        [
            0,  // 1xXM231
            1,  // 2xXM231
            2,  // 3xXM232
            3,  // 4xXM232
            4   // 5xXM232
        ]
    };
};
