
_this spawn {
	scriptname "dorb\player\XEH_hit";
	If(!(isPlayer (_this select 0)))exitWith{};
	If(!(isPlayer (_this select 1)))exitWith{};
	If((_this select 0)==(_this select 1))exitWith{};
	_text = format["Teambeschuss: %1 / %2 beschossen von %3 / %4   Damage=%5",(_this select 0),name(_this select 0),(_this select 1),name(_this select 1),(_this select 2)];
	[-2,{diag_log str _this;},_text] call CBA_fnc_globalExecute;
};