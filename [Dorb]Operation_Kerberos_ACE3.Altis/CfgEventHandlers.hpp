
/*
class Extended_PreInit_EventHandlers {
    class dorb {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};
*/
class Extended_Init_Eventhandlers {
	class rhs_infantry_msv_base {
		class Dorb_init {
			init = "_this call dorb_fnc_addNVG;";
		};
	};
};
class Extended_Respawn_EventHandlers {
	class CAManBase {
		class Dorb_Respawn {
			scope = 2;
			respawn = "call compile preProcessFileLineNumbers 'XEH_respawn.sqf'";
		};
	};
};
class Extended_killed_EventHandlers {
	class CAManBase {
		class Dorb_killed {
			scope = 2;
			killed = "call compile preProcessFileLineNumbers 'XEH_killed.sqf'";
		};
	};
};
class Extended_fired_Eventhandlers {
	class CAManBase {
		class Dorb_Fired {
			scope = 2;
			fired = "call compile preProcessFileLineNumbers 'XEH_fired.sqf'";
		};
	};
};
class Extended_Hit_EventHandlers {
	class CAManBase {
		class Dorb_Hit {
			scope = 2;
			hit = "call compile preProcessFileLineNumbers 'XEH_hit.sqf'";
		};
	};
};