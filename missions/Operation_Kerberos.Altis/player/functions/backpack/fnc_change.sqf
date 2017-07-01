/*
    Author: Dorbedo

    Description:
        Backpack on Chest
        Init

    Parameter(s):
        0 : BOOL     - Move to Chest

*/
#include "script_component.hpp"
SCRIPT(change);
params[["_movetoChest",false,[true]]];
CHECK((_movetoChest)&&((backpack player) isEqualTo ""))

If (_movetoChest) then {
    private ["_backpackarray","_backpack"];
    _backpackarray = [(backpack player),(backpackItems player)];
    player setVariable [QGVAR(backpack),_backpackarray];
    _backpack = createVehicle ["groundWeaponHolder", (getPos player) , [], 0, "can_collide"];
    _backpack addBackpackCargoGlobal [(backpack player), 1];
    _backpack attachTo [player,[-0.1,0.75,-0.4],"pelvis"];
    _backpack setVectorDirAndUp [[0,0,-1],[0,1,0]];
    _backpack setVariable [QGVARMAIN(canDelete),false,true];
    player setVariable [QGVAR(backpack_pack),_backpack];
    player setVariable [QGVAR(backpack_anim),(animationState player)];
    removebackpackglobal player;
    [FUNC(backpack_handle) , 2, [] ] call CBA_fnc_addPerFrameHandler;
}else{
    private["_backpackarray","_backpack"];
    _backpackarray = player getVariable [QGVAR(backpack),[]];
    If (!(_backpackarray isEqualTo [])) then {
        player addBackpackGlobal (_backpackarray select 0);
        {
            player addItemToBackpack _x;
        }forEach (_backpackarray select 1);
        player setVariable [QGVAR(backpack),[]];
    };
    _backpack = player getVariable [QGVAR(backpack_pack),objNull];
    If (!(isNull _backpack)) then {
        clearBackpackCargoGlobal _backpack;
        detach _backpack;
        deleteVehicle _backpack;
        player setVariable [QGVAR(backpack_pack),objNull];
        player forceWalk false;
    };
};
