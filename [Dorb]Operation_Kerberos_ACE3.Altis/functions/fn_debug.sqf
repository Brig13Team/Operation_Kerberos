
if (!(isServer)) exitWith {true};
private ["_scriptName","_log","_input","_level"];
_input = [_this, 0, "ERROR - LOGAUFRUF"] call BIS_fnc_Param;
_level = [_this, 1, 5] call BIS_fnc_Param;


_prefix = switch (_level) do {
	case 0 : 	{"DORB_STATUS"};
	case 1 :	{"DORB_ERROR "};
	case 2 :	{"DORB_MP    "};
	default 	{"DORB_INFO  "};
};

_scriptName = if (isnil "_fnc_scriptNameParent") then {
	""
} else {
	_fnc_scriptNameParent
};

_scriptName = if (_scriptName != "") then {" [" + _scriptName + "] "} else {" "};

_log = _prefix + _scriptName + str _input;

diag_log _log;

