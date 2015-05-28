private ["_unit", "_allGear", "_headgear", "_backpack", "_backpackitems", "_backpa"];

_unit = _this select 0;
_allGear = _this select 1;


removeHeadgear _unit;
clearAllItemsFromBackpack _unit;
removeBackpack _unit;

_headgear = _allGear select 0;
_backpack = _allGear select 1;
_backpackitems = _allGear select 2;


if (_headgear != "") then {
  _unit addHeadgear _headgear;
};
if(format["%1", _backpack] != "") then {
  _unit addBackpack _backpack;

  _backpa = unitBackpack _unit;
  clearMagazineCargoGlobal _backpa;
  clearWeaponCargoGlobal _backpa;
  clearItemCargoGlobal _backpa;
  {
    _unit addItemToBackpack _x;
  } forEach _backpackitems;
};