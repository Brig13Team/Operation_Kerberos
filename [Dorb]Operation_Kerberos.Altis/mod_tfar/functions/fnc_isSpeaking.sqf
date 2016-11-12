/*
    Author: Dorbedo

    Description:
        alerts the AI

    Parameter(s):
        0 : OBJECT - player who is chatting
    Returns:
        nothing

*/
#include "script_component.hpp"
SCRIPT(disableTFR);
_this params [
    ["_unit",objNull,[objNull]],
    ["_isSpeaking",false,[true]]
    ];
If (GETMVAR(GVAR(isSpeaking),false)) exitWith {};
SETMVAR(GVAR(isSpeaking),true);

private _nearUnits = (getPos _player) nearEntities ["CAManBase",35];
{
    private _distance = _x distance player;
    private _random = random(10);
    switch (true) do {
        case (distance < 10) : {_x reveal player;};
        case ((distance < 15)&&(_random < 7)) : {_x reveal player;};
        case ((distance < 15)&&(_random < 5)) : {_x reveal player;};
        case (_random < 3) : {_x reveal player;};
    };
} forEach _nearUnits;


[{SETMVAR(GVAR(isSpeaking),false);},[],25] call CBA_fnc_waitAndExecute;
