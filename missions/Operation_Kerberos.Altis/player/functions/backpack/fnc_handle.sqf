/*
    Author: Dorbedo

    Description:
        Backpack on Chest
        handle

*/
#include "script_component.hpp"
SCRIPT(change);
private ["_backpack","_isHalo"];

[player, "forceWalk", QGVAR(backpack), true] call ace_common_fnc_statusEffect_set;

private _backpack = player getVariable [QGVAR(backpack_pack),objNull];
If (isNull _backpack) exitwith {
    [_this select 1] call CBA_fnc_removePerFrameHandler;
    [player, "forceWalk", QGVAR(backpack), false] call ace_common_fnc_statusEffect_set;
};

if ((player != (vehicle player))&&(!((player getVariable [QGVAR(backpack_anim),""])isEqualTo(animationState player)))) exitwith {
    player setVariable [QGVAR(backpack_anim),(animationState player)];
    _isParachute = ((vehicle player) isKindOf "ParachuteBase");
    if (_isParachute) then {
        _backpack attachTo [(vehicle player),[-0.08,0.55,-0.42]];
        _backpack setVectorDirAndUp [[0,-0.2,-1],[0,1,0]];
    } else {
        detach _backpack;
        _backpack setPos [random 50,random 50,(10000 + (random 50))];
    };
};


IF (!((player getVariable [QGVAR(backpack_anim),""])isEqualTo(animationState player))) then {
    player setVariable [QGVAR(backpack_anim),(animationState player)];
    _isHalo = (("halofreefall" in ((animationState player) splitString "_"))||((stance player) isEqualTo "PRONE"));
    if ((_isHalo)) then {
        _backpack attachTo [player,[-0.1,-0.4,-0.75],"pelvis"];
        _backpack setVectorDirandup [[0,-1,0],[0,0,-1]];
    }else{
        _backpack attachTo [player,[-0.1,0.75,-0.4],"pelvis"];
        _backpack setVectorDirAndUp [[0,0,-1],[0,1,0]];
    };
};

true
