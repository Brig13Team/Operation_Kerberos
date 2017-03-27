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

disableSerialization;
_this params ["_activate"];
private _state = GVAR(curArtillery) getVariable [QGVAR(state),0];
If (_activate) then {
    If (_state isEqualTo 0) then {
        TRACE("Enabling");

        ISNILS(GVAR(curArtilleryUnit),objNull);
        If (isNull GVAR(curArtilleryUnit)) then {
            private _group = createGroup (side player);
            GVAR(curArtilleryUnit) = _group createUnit["B_UAV_AI",[0,0,0],[],0,"NONE"];
            GVAR(curArtilleryUnit) addEventhandler ["firedman",LINKFUNC(onFired)];
        };
        GVAR(curArtilleryUnit) moveInGunner GVAR(curArtillery);
        GVAR(curArtilleryUnit) allowFleeing 0;

        GVAR(curArtillery) setVariable [QGVAR(fuelsave),fuel GVAR(curArtillery)];


        If !(isNil QGVAR(handleArtillery)) then {
            [GVAR(handleArtillery)] call CBA_fnc_removePerFrameHandler;
        };

        GVAR(handleArtillery) = [LINKFUNC(handleArtillery),0.2,[GVAR(curArtillery),player,GVAR(curArtilleryUnit)]] call CBA_fnc_addPerFrameHandler;

        GVAR(curArtillery) setVariable [QGVAR(state),1];
    };
}else{
    If (_state > 0) then {
        TRACE("Disabling");
        GVAR(curArtillery) setVariable [QGVAR(state),0];
    };
};
