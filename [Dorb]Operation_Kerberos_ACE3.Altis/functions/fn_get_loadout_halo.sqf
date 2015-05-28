private ["_unit", "_allGear"];

_unit = _this select 0;

_allGear = [
  (headgear _unit),
  (backpack _unit),
  (backpackItems _unit)
];

_allGear