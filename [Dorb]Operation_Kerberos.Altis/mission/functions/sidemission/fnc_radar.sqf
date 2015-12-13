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
_einheit = ["rhs_p37","rhs_prv13"] SELRND;
_spawnpos = _position findEmptyPosition [1,50,_einheit];
if (!((_spawnpos isEqualTo []))) then {_position = _spawnpos;};
_dir = floor(random 360);
_return = [_position,GVARMAIN(side),_einheit,_dir] call BIS_fnc_spawnVehicle;
_return params ["_veh"];
_radars = GETMVAR(EGVAR(headquater,radars),[]);
_radars pushBack _veh;
SETMVAR(GVAR(radars),_radars);

/********************
    create defence
********************/

[_position,["missionConfigFile","defence_positions","mission","radar"],_dir] EFUNC(spawn,macro_exec3d);
[_position,200,1] call EFUNC(spawn,defence_create);

/********************
    taskhandler
********************/

[
    /*Disabled -> no Task will be created*/
]