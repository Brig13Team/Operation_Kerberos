#include "script_component.hpp"
class B_Soldier_base_F {
	class ADDON {
		scope = 2;
		hit = QUOTE(_this call FUNC(XEH_hit));
	};
};