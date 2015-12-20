    /*
    Author: Dorbedo

    Description:
        Creates Side-Mission "artillery".

    Parameter(s):
        0 :    ARRAY - Position

    Returns:
    BOOL
*/
#include "script_component.hpp"
SCRIPT(convoi);
_this params [["_position",[],[[]],[2,3]],["_positionMain",[],[[]]],[2,3]];
TRACEV_1(_position);
private ["_einheit",,"_spawnpos","_dir","_return","_radars"];
/********************
    create artillery
********************/

private _spawnpos = [_position,40,500,15,0.5] call EFUNC(common,pos_flatempty);
if (_spawnpos isEqualTo []) then {
	ERROR("No artillery spawnpos -> 2dn try");
	private _spawnpos = [_position,20,500,15,0.7] call EFUNC(common,pos_flatempty);
	if (_spawnpos isEqualTo []) then {
		ERROR(FORMAT_1("No artillery spawnpos - no free position at %1",_position));
		_spawnpos = _position;
	};
};

private _cfg = missionConfigFile >> "defence_positions" >> "artillery"
private _macroarray = [];
for "_i" from 0 to count _cfg do {
	_macroarray pushBack ["missionConfigFile","defence_positions","artillery",configname (_cfg select _i)];
};
_macro = _macroarray SELRND;
_dir = random 360;
[_spawnpos,_macro,_dir] call FUNC(macro_exec3d);


/********************
    taskhandler
********************/

[
    QUOTE(If ((GVARMAIN(side) countSide (_this nearEntities [ARR_2("CAManBase",600)]))>0) then {false} else {false};),
	[_spawnpos]
]