/*
	Author: Dorbedo

	Description:

	
*/
#include "makros.hpp"


[] call FM(crate_createlists);

if (isnil "DORB_CRATE_CURRENT") then {
	DORB_CRATE_CURRENT = [[],[],[],[],[],[]];
};

if (isnil "DORB_CRATE_CURRENT_BOXID") then {
	DORB_CRATE_CURRENT_BOXID = 0;
};

createDialog "dorb_crate";