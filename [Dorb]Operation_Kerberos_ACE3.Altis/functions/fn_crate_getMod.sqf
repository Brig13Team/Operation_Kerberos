/*
	Author: Dorbedo

	Description:

*/
#include "script_component.hpp"


PARAMS_1(_config);

_namearray=[configname _config,"_"] call BIS_fnc_splitString;

If ("ACE" in _namearray) exitwith {"ACE"};
If ("BWA3" in _namearray) exitwith {"BWA3"};
If ("tf" in _namearray) exitwith {"TFR"};
If (("rhs" in _namearray)||("rhsusf" in _namearray)) exitwith {"RHS"};


""