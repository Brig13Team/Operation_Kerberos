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
				//d_log("Neuer HC=2")
				//d_log(FORMAT_1("currentHC=%1",currentHC))
				//d_log(FORMAT_1("Kein HC - Abfrage = %1",currentHC))
			};
	}else{
		If (!isNil "HC3") then {
			If ((owner HC3) != 0) then {
				currentHC = HC3;
				//d_log("Neuer HC=3")
				//d_log(FORMAT_1("currentHC=%1",currentHC))
				//d_log(FORMAT_1("Kein HC - Abfrage = %1",currentHC))
			};
		};
	};	
};

If (currentHC == HC2) exitWith {
	If (!isNil "HC3") then {
			If ((owner HC3) != 0) then {
				currentHC = HC3;
				//d_log("Neuer HC=3")
				//d_log(FORMAT_1("currentHC=%1",currentHC))
				//d_log(FORMAT_1("Kein HC - Abfrage = %1",currentHC))
			};
	}else{
		If (!isNil "HC1") then {
			If ((owner HC1) != 0) then {
				currentHC = HC1;
				//d_log("Neuer HC=1")
				//d_log(FORMAT_1("currentHC=%1",currentHC))
				//d_log(FORMAT_1("Kein HC - Abfrage = %1",currentHC))
			};
		};
	};	
};

If (currentHC == HC3) exitWith {
	If (!isNil "HC1") then {
			If ((owner HC1) != 0) then {
				currentHC = HC1;
				//d_log("Neuer HC=1")
				//d_log(FORMAT_1("currentHC=%1",currentHC))
				//d_log(FORMAT_1("Kein HC - Abfrage = %1",currentHC))
			};
	}else{
		If (!isNil "HC2") then {
			If ((owner HC2) != 0) then {
				currentHC = HC2;
				//d_log("Neuer HC=2")
				//d_log(FORMAT_1("currentHC=%1",currentHC))
				//d_log(FORMAT_1("Kein HC - Abfrage = %1",currentHC))
			};
		};
	};	
};