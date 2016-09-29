/*
	Author: Dorbedo

	Description:
		returns all Keys of a hash

	Parameter(s):
		0: HASH <LOCALTION>

	Return
		<ARRAY> Keys
*/
#include "script_component.hpp"

_this params [["_hash",locationNull,[locationNull]]];

If !(IS_HASH(_hash)) exitWith {[]};

((allVariables _hash) select {!isNil{_hash getVariable _x}});
