/*
    Author: Dorbedo

    Description:
    Sets custom gear

    Parameter(s):
        0 : OBJECT     - unit
        
    Returns:
    None
*/
#include "script_component.hpp"
_this params[["_unit",objNull,[objNull]]];

CHECK((isPlayer _unit)||(!(local _unit)))
If (_unit isKindOf "Man") then {
    switch (side _unit) do {
        case "east" : {_unit linkItem "NVGoggles_OPFOR";};
        case "resistance" : {_unit linkItem "NVGoggles_INDEP";};
        case "west" : {_unit linkItem "NVGoggles";};
    };
};
CHECK(!(isClass (missionconfigFile>>"gear">>str GVARMAIN(side)>>QGVARMAIN(side_type)>>(typeOf _unit))))

private _uniform = gettext(missionconfigFile>>"gear">>str GVARMAIN(side)>>QGVARMAIN(side_type)>>(typeOf _unit)>>"uniform");
private _uniformitems = getArray(missionconfigFile>>"gear">>str GVARMAIN(side)>>QGVARMAIN(side_type)>>(typeOf _unit)>>"uniformitems");
if !(_uniform isEqualTo "") then {
    if (_uniformitems isEqualTo []) then {
        _uniformitems = uniformitems _unit;
    };
    _unit forceAddUniform _uniform;
    {_unit addItemToUniform _x;}forEach _uniformitems;
}else{
    If (_uniformitems isEqualTo []) then {
        {_unit removeItemFromUniform _x;}forEach (uniformitems _unit);
        {_unit addItemToUniform _x;}forEach _uniformitems;
    };
};

private _vest = gettext(missionconfigFile>>"gear">>str GVARMAIN(side)>>QGVARMAIN(side_type)>>(typeOf _unit)>>"vest");
private _vestitems = getArray(missionconfigFile>>"gear">>str GVARMAIN(side)>>QGVARMAIN(side_type)>>(typeOf _unit)>>"vestitems");
if !(_uniform isEqualTo "") then {
    if (_vestitems isEqualTo []) then {
        _vestitems = vestitems _unit;
    };
    removeVest _unit;
    _unit addVest _vest;
    {_unit addItemToUniform _x;}forEach _vestitems;
}else{
    If (_vestitems isEqualTo []) then {
        {_unit removeItemFromVest _x;}forEach (vestitems _unit);
        {_unit addItemToVest _x;}forEach _vestitems;
    };
};

private _backpack = gettext(missionconfigFile>>"gear">>str GVARMAIN(side)>>QGVARMAIN(side_type)>>(typeOf _unit)>>"backpack");
private _backpackitems = getArray(missionconfigFile>>"gear">>str GVARMAIN(side)>>QGVARMAIN(side_type)>>(typeOf _unit)>>"backpackitems");
if !(_uniform isEqualTo "") then {
    if (_backpackitems isEqualTo []) then {
        _backpackitems = backpackitems _unit;
    };
    removeBackpack _unit;
    _unit addBackpack _backpack;
    {_unit addItemToBackpack _x;}forEach _backpackitems;
}else{
    If (_backpackitems isEqualTo []) then {
        {_unit removeItemFromBackpack _x;}forEach (backpackitems _unit);
        {_unit addItemToBackpack _x;}forEach _backpackitems;
    };
};

private _primaryweapon = gettext(missionconfigFile>>"gear">>str GVARMAIN(side)>>QGVARMAIN(side_type)>>(typeOf _unit)>>"primaryweapon");
If !(_primaryweapon isEqualTo []) then {
    _unit removeWeapon (primaryweapon _unit);
    _unit addWeapon _primaryweapon;
    _unit addMagazine (primaryWeaponMagazine _unit);
};
private _primaryweaponattachments = getarray(missionconfigFile>>"gear">>str GVARMAIN(side)>>QGVARMAIN(side_type)>>(typeOf _unit)>>"primaryweaponattach");
If !(_primaryweaponattachments isEqualTo "") then {
    removeAllPrimaryWeaponItems _unit;
    {_unit addPrimaryWeaponItem _x;}forEach _primaryweaponattachments;
};

private _secondaryweapon = gettext(missionconfigFile>>"gear">>str GVARMAIN(side)>>QGVARMAIN(side_type)>>(typeOf _unit)>>"secondaryweapon");
If !(_secondaryweapon isEqualTo []) then {
    _unit removeWeapon (secondaryweapon _unit);
    _unit addWeapon _secondaryweapon;
    _unit addMagazine (secondaryWeaponMagazine _unit);
};
private _secondaryweaponattachments = getarray(missionconfigFile>>"gear">>str GVARMAIN(side)>>QGVARMAIN(side_type)>>(typeOf _unit)>>"secondaryweaponattach");
If !(_secondaryweaponattachments isEqualTo "") then {
    _unit removeSecondaryWeaponItem (secondaryWeaponItems _unit);
    {_unit addSecondaryWeaponItem _x;}forEach _secondaryweaponattachments;
};

private _handgun = gettext(missionconfigFile>>"gear">>str GVARMAIN(side)>>QGVARMAIN(side_type)>>(typeOf _unit)>>"handgun");
If !(_handgun isEqualTo "") then {
    _unit removeWeapon (handgunweapon _unit);
    _unit addWeapon _handgun;
    _unit addMagazine (handgunMagazine _unit);
};
private _handgunattachments = getarray(missionconfigFile>>"gear">>str GVARMAIN(side)>>QGVARMAIN(side_type)>>(typeOf _unit)>>"handgunattach");
If !(_handgunattachments isEqualTo []) then {
    removeAllHandgunItems _unit;
    {_unit addHandgunItem _x;}forEach _handgunattachments;
};

private _linkeditems = getarray(missionconfigFile>>"gear">>str GVARMAIN(side)>>QGVARMAIN(side_type)>>(typeOf _unit)>>"linkeditems");
If !(_linkeditems isEqualTo []) then {
    {_unit linkItem _x;}forEach _linkeditems;
};

private _headgear = gettext(missionconfigFile>>"gear">>str GVARMAIN(side)>>QGVARMAIN(side_type)>>(typeOf _unit)>>"headgear");
If !(_headgear isEqualTo "") then {
    removeHeadgear _unit;
    _unit addHeadgear _headgear;
};