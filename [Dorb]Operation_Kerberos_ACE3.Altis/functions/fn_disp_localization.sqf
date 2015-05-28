/*
	Author: Dorbedo

	Description:
	Removes the localization Issues

*/
#include "makros.hpp"
CHECK(!hasinterface)
_this spawn {
	PARAMS_2(_categorie,_messageid);
	
	switch(_categorie) do {
		case "rtb": {
						switch(_messageid) do {
							case 1 : {[localize "STR_DORB_RTB",[localize "STR_DORB_RTB_START_1"],"data\icon\icon_base.paa",false] call FM(disp_info);};
							case 2 : {[localize "STR_DORB_RTB",[localize "STR_DORB_RTB_FINISHED",localize "STR_DORB_RTB_FINISHED2"],"data\icon\icon_base.paa",false] call FM(disp_info);};
						};
					};
		case "rtb": {
						switch(_messageid) do {
							case 1 : {[localize "STR_DORB_RTB",[localize "STR_DORB_RTB_START_1"],"data\icon\icon_base.paa",false] call FM(disp_info);};
							case 2 : {[localize "STR_DORB_RTB",[localize "STR_DORB_RTB_FINISHED",localize "STR_DORB_RTB_FINISHED2"],"data\icon\icon_base.paa",false] call FM(disp_info);};
						};
					};



	};
};