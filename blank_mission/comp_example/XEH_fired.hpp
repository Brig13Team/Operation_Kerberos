#include "script_component.hpp"
class B_Soldier_base_F {
	class ADDON {
		scope = 2;
		fired = QUOTE(_this call FUNC(EH_fired));
	};
};
