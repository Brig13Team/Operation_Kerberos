/*
 *  Author: Dorbedo
 *
 *  Description:
 *      gets a random group
 *
 *  Parameter(s):
 *      0 : STRING - Grouptype
 *
 *  Returns:
 *      CONFIG - Groupconfig
 *
 */
#include "script_component.hpp"

_this params [["_grouptype","",[""]]];
CHECK(_grouptype isEqualTo "")

switch _grouptype do {
    case "defence" : {

    };
    case "attack" : {

    };
    case "patrol" : {

    };
};
