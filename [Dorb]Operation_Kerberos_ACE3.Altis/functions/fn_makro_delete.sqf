/*
	Author: Dorbedo

	Description:
	Deletes

	Parameter(s):
		0 :	ARRAY 
	Returns:
	Random array pos
*/
#include "makros.hpp"

//CHECK(isNull _this)

switch(true) do {
	case (IS_GROUP(_this))	: {deletegroup _this;};
	case (IS_OBJECT(_this))	: {{_this deleteVehicleCrew _x} forEach crew _this; deleteVehicle _this;};
	case (IS_STRING(_this))	: {deleteMarker _this};
	case (IS_ARRAY(_this))	: {{_x TILGE;}forEach _this;};
	default {d_error_p(FORMAT_1("Nicht unterstuetzt: %1",_this))};
};