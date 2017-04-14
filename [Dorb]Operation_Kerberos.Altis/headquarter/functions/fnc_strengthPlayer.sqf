/**
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the strength of a player or a group of players
 *
 *  Parameter(s):
 *      0 : GROUP/OBJECT - Group of a player or a player himself
 *
 *  Returns:
 *      ARRAY - [type of group, value of group, threat of group]
 *
 */
#include "script_component.hpp"

_this params[["_group",grpNull,[grpNull,[],objNull]]];
if (isNull _group) exitWith {
    [0,[0,0,0],[0,0,0]]
};

private _soldiers = [];
If (IS_GROUP(_group)) then {
    _soldiers = (units _group) select {alive _x};
}else{
    If (IS_OBJECT(_group)) then {
        _soldiers = [_group];
    }else{
        _soldiers = _group;
    };
};

private _vehicles = [];

private _Allvalues = [0];
private _AllStrenght = [[0,0,0]];
private _AllDefence = [[0,0,0]];
private _AllTypes = [0];

{
    If ((vehicle _x != _x)&&{(toLower(_x call CBA_fnc_vehicleRole)) in ["driver","gunner","commander","Turret"]}) then {
        _vehicles pushBackUnique (vehicle _x);
    };
    private _primaryweapon = ((primaryWeapon _x) call BIS_fnc_itemType) select 1;
    private _secondaryWeapon = ((secondaryWeapon _x) call BIS_fnc_itemType) select 1;
    _Allvalues pushBack (["B_soldier_F"] call FUNC(getCost));
    _AllStrenght pushBack (["B_soldier_F"] call FUNC(getStrenght));
    _AllDefence pushBack (["B_soldier_F"] call FUNC(getDefence));


    If (_primaryweapon == "SniperRifle") then {
        _Allvalues pushBack (["B_sniper_F"] call FUNC(getCost) - ["B_soldier_F"] call FUNC(getCost));
        _AllStrenght pushBack (["B_sniper_F"] call FUNC(getStrenght));
        _AllDefence pushBack (["B_sniper_F"] call FUNC(getDefence));
    };

    If ((_x getVariable ["ace_medical_medicClass",0])>1) then {
        _Allvalues pushBack (["B_Medic_F"] call FUNC(getCost) - ["B_soldier_F"] call FUNC(getCost));
        _AllStrenght pushBack (["B_Medic_F"] call FUNC(getStrenght));
        _AllDefence pushBack (["B_Medic_F"] call FUNC(getDefence));
    };

    If (_secondaryWeapon == "Launcher") then {
        private _mag = (getArray(configFile >> "CfgVehicles" >> (secondaryWeapon _x))select 0);
        private _ammo = getText(configFile >> "CfgVehicles" >> _mag >> "ammo");
        If (getNumber(configFile >> "CfgVehicles" >> _ammo >> "airlock")>1) then {
            _Allvalues pushBack (["B_soldier_AA_F"] call FUNC(getCost) - ["B_soldier_F"] call FUNC(getCost));
            _AllStrenght pushBack (["B_soldier_AA_F"] call FUNC(getStrenght));
            _AllDefence pushBack (["B_soldier_AA_F"] call FUNC(getDefence));
        }else{
            _Allvalues pushBack (["B_soldier_AT_F"] call FUNC(getCost) - ["B_soldier_F"] call FUNC(getCost));
            _AllStrenght pushBack (["B_soldier_AT_F"] call FUNC(getStrenght));
            _AllDefence pushBack (["B_soldier_AT_F"] call FUNC(getDefence));
        };
    };
}forEach _soldiers;

{
    private _curType = typeOf _x;
    _Allvalues pushBack ([_curType] call FUNC(getCost));
    _AllStrenght pushBack ([_curType] call FUNC(getStrenght));
    _AllDefence pushBack ([_curType] call FUNC(getDefence));
    _AllTypes pushBack ([_curType] call FUNC(getType));
}forEach _vehicles;


[
    ([_Allvalues] call EFUNC(common,arraySum)) * ([_x] call FUNC(getPlayerCoeff));,
    [_AllStrenght] call EFUNC(common,arraysGetMax),
    [_AllDefence] call EFUNC(common,arraysGetMax)
    selectMax _AllTypes;
]
