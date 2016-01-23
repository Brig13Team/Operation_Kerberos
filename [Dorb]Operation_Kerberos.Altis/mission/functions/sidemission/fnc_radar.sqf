    /*
    Author: Dorbedo

    Description:
        Creates Side-Mission "Radar".

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
    create radar
********************/

_spawnpos = [_position,15,200,15,0.3] call EFUNC(common,pos_flatempty);
if (_spawnpos isEqualTo []) then {ERROR("No radar spawnpos");_spawnpos = _position;};

private _cfg = missionConfigFile >> "defence_positions" >> "radar"
private _macroarray = [];
for "_i" from 0 to count _cfg do {
    _macroarray pushBack ["missionConfigFile","defence_positions","radar",configname (_cfg select _i)];
};
_macro = _macroarray SELRND;
_dir = random 360;
[_spawnpos,_macro,_dir] call FUNC(macro_exec3d);

_radars = _spawnpos nearEntities [["rhs_p37","rhs_prv13"],45];
EGVAR(headquarter,radars) append _radars;


/********************
    taskhandler
********************/

[
    /*Disabled -> no Task will be created*/
]