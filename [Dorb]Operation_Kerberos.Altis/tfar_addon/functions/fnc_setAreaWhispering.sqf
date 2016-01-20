/*
    Author: Dorbedo

    Description:
       sets all players in an area to whispering

    Parameter(s):
        0 : ARRAY - position of center
		1 : SCALAR - radius
    Returns:
        nothing

*/
#include "script_component.hpp"
SCRIPT(disableTFR);
_this params [
    ["_position",[],[[]],[]],
	["_radius",50,[0]]
    ];
CHECK(_position isEqualTo [])

private _setWhispering = "
	TF_speak_volume_level = 'whispering';
	TF_speak_volume_meters = 5;
	['OnSpeakVolume_', TFAR_currentUnit, [TFAR_currentUnit, TF_speak_volume_meters]] call TFAR_fnc_fireEventHandlers; ";


{
	If ((_x distance2D _position)<= _radius) then {
		[_x,_setWhispering] call EFUNC(common,NetEventLocalExec);
	};
}forEach allPlayers;