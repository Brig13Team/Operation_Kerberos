#define CBA_OFF
#include "script_component.hpp"

class CfgRemoteExec {
	class Functions {
		mode = 1;
		class EGVAR(player,onlypilots) {
			allowedTargets = 0;
		};
	};
};