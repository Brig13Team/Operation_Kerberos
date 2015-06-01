
_this spawn {
	If(!(isPlayer (_this select 1)))exitWith{};
	If((_this select 0)==(_this select 1))exitWith{};
	[0,{diag_log text format["Teambeschuss: %1 / %2 beschossen von %3 / %4   Damage=%5",(_this select 0),name(_this select 0),(_this select 1),name(_this select 1),(_this select 2)];},_this] call CBA_fnc_globalExecute;
};