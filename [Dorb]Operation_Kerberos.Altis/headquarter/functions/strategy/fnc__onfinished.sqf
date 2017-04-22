/*
 *  Author: Dorbedo
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

_this params ["_strategy"];

private _type = HASH_GET_DEF(_strategy,"strategytype","");

If (_type isEqualTo "groundattack") then {
    {
        private _groupStrat = HASH_GET_DEF(_x,"strategy",locationNull);
        If (_groupStrat isEqualTo _strategy) then {
            [HASH_GET_DEF(_x,"group",grpNull)] call FUNC(strategy__onFinishSAD);
        };
    } forEach HASH_GET_DEF(GVAR(groups),"attackGroups",[]);
};

If !(isNull _strategy) then {
    HASH_DELETE(_strategy);
};
