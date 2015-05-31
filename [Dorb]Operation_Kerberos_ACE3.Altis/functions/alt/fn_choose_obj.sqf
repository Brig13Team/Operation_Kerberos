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


If (_rand < 60) then {
		If (_rand < 40) then {
			LOG("Location = Stadt");
			[_aufgabe] call FM(obj_stadt_create);
		}else{
			LOG("Location = Sonstiges");
			[_aufgabe] call FM(obj_sonst_create);
		};
}else{
	If (_rand < 90) then {
		If (_rand < 75) then {
			LOG("Location = Militaer");
			[_aufgabe] call FM(obj_mil_create);
		}else{
			LOG("Location = Industrie");
			//[_aufgabe] call FM(obj_ind_create);
		};	
	}else{
			LOG("Location = Wasser");
			//[_aufgabe] call FM(obj_tauch_create);
	};
};