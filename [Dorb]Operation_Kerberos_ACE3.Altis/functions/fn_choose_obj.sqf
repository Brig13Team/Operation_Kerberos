/*
	Author: Dorbedo
	
	Description:
		Selects Mission Categorie
	
	Parameter(s):
		0 : STRING	- TASKNAME
	
*/
#include "script_component.hpp"

PARAMS_1(_aufgabe);
private ["_rand"];

[] call FM(create_unitlists);

_rand = floor(random 100);
d_log(FORMAT_1("Aufgabenrandom=%1",_rand))

If (_rand < 60) then {
		If (_rand < 40) then {
			d_log("Location = Stadt")
			[_aufgabe] call FM(obj_stadt_create);
		}else{
			d_log("Location = Sonstiges")
			[_aufgabe] call FM(obj_sonst_create);
		};
}else{
	If (_rand < 90) then {
		If (_rand < 75) then {
			d_log("Location = Militaer")
			[_aufgabe] call FM(obj_mil_create);
		}else{
			d_log("Location = Industrie")
			//[_aufgabe] call FM(obj_ind_create);
		};	
	}else{
			d_log("Location = Wasser")
			//[_aufgabe] call FM(obj_tauch_create);
	};
};