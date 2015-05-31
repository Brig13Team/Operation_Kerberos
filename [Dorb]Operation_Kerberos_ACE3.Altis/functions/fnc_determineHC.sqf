/*
	Author: Dorbedo

	Description:
		changes the HC
	
*/
#include "script_component.hpp"

CHECK(!isServer)

If (currentHC == HC1) exitWith {
	If (!isNil "HC2") then {
			If ((owner HC2) != 0) then {
				currentHC = HC2;
			};
	}else{
		If (!isNil "HC3") then {
			If ((owner HC3) != 0) then {
				currentHC = HC3;
			};
		};
	};	
};

If (currentHC == HC2) exitWith {
	If (!isNil "HC3") then {
			If ((owner HC3) != 0) then {
				currentHC = HC3;
			};
	}else{
		If (!isNil "HC1") then {
			If ((owner HC1) != 0) then {
				currentHC = HC1;
			};
		};
	};	
};

If (currentHC == HC3) exitWith {
	If (!isNil "HC1") then {
			If ((owner HC1) != 0) then {
				currentHC = HC1;
			};
	}else{
		If (!isNil "HC2") then {
			If ((owner HC2) != 0) then {
				currentHC = HC2;
			};
		};
	};	
};