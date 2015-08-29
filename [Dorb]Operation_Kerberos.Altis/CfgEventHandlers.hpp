class Extended_PreInit_EventHandlers {
    class dorb_main {
        init = "call compile preProcessFileLineNumbers 'XEH_PreInit.sqf'";
    };
};

class Extended_Init_Eventhandlers {
	class Man {
		class dorb_spawn {
			init = "_this call dorb_spawn_fnc_addNVG;";
		};
	};
	class rhsusf_M1083A1P2_B_M2_d_Medical_fmtv_usarmy {
		class dorb_spawn {
			init = "_this call dorb_spawn_fnc_addACEMedicalItems;";
		};
	};
	class rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy {
		class dorb_spawn {
			init = "(_this select 0) setVariable ['tf_hasRadio',true,true];";
		};
	};
	class rhs_gaz66_ap2_base {
		class dorb_spawn {
			init = "_this call dorb_spawn_fnc_addACEMedicalItems;";
		};
	};
};

class Extended_Respawn_EventHandlers {
	class B_Soldier_base_F {
		class dorb_player {
			scope = 2;
			respawn = "_this call dorb_player_XEH_respawn;";
		};
	};
};

class Extended_fired_Eventhandlers {
	class B_Soldier_base_F {
		class dorb_player {
			scope = 2;
			fired = "If (hasinterface) then {If (!local (_this select 0)) exitwith {};_this call dorb_player_fnc_XEH_fired;};";
		};
	};
};

class Extended_Hit_EventHandlers {
	class B_Soldier_base_F {
		class dorb_player {
			scope = 2;
			hit = "_this call dorb_player_XEH_hit;";
		};
	};
};

class Extended_GetIn_Eventhandlers {
	class Air {
		class dorb_player {
			getin = "_this remoteExec ['dorb_player_fnc_onlypilots',(_this select 2)];";
		};
	};
};
