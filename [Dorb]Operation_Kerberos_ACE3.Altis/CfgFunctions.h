class dorb
{
	tag = "dorb";
	file = "functions";
	class basis {
		class get_loadout_halo {};
		class nurpiloten {};
		class playeraddaction {};
		class rep {};
		class reservedslots {};
		class set_loadout_halo {};
		class teleporter_lead {};
	};
	class core {
		class cleanup_big {};
		class cleanup_small {};
		class debug {};
		class debug_format {};
		class disp_blur {};
		class disp_info {};
		class disp_message {};
		class disp_progressbar {};
		class disp_localization {};
		class get_buildings {};
		class get_cfglocations {};
		class makro_log {};
		class makro_selrandom {};
		class makro_delete {};
		class random_pos {};
	};
	class eventhandler {

		
		
		class handledamage_C4 {};
		
	};
	class missionen {
		class core {};
		class create_unitlists {};
		class difficulty {};
		class obj_rtb {};
		class examine {};
		class obj_choose {};
		class obj_mil_create {};
		class obj_mil_area_clear {};
		class obj_mil_area_defend {};
		class obj_sonst_create {};		
		class obj_sonst_destroy_device {};
		class obj_sonst_destroy_tower {};
		class obj_sonst_capture_prototype {};
		class obj_sonst_Scarab {};
		class obj_sonst_Scarab_launch {};
		class obj_sonst_Scarab_explode {};
		class obj_stadt_create {};		
		class obj_stadt_destroy_wpncache {};
		class obj_stadt_rescue_pow {};
		class obj_stadt_find_intel {};
		class obj_stadt_found_intel {};
		class obj_stadt_kill_person {};
		class obj_stadt_konvoi_rescue {};
		class obj_stadt_konvoi_destroy {};
	};
	class spawn {
		class spawn_attack_airdrop {};
		class spawn_attack_inf {};
		class spawn_attack_veh {};
		class spawn_attack_waves {};
		class spawn_commandveh {};
		class spawn_commandveh_airdrop {};
		class spawn_commandveh_antiair {};
		class spawn_commandveh_artillery {};
		class spawn_commandveh_check {};
		class spawn_commandveh_mech {};
		class spawn_commandveh_sniper {};
		class spawn_commandveh_tanks {};
		class spawn_obj_mil {};
		class spawn_obj_stadt {};
		class spawn_obj_sonstiges {};		
		class spawn_patrol_air {};
		class spawn_patrol_veh {};
		class spawn_patrol_inf {};
		class spawn_defence {};
		class spawn_in_building {};
		class spawn_rooftop {};
		class spawn_unit {};
		class spawn_mortarpos {};
		class spawn_artypos {};
		class spawn_tower {};
	};
	class ui {

		class teleport_onLoad {};
		class teleport_addaction {};
		class teleport_draw3D {};
		class spawn_ui_Open {};
		class spawn_ui_select {};
		class spawn_ui_create {};
		class spawn_ui_createlist {};
		class spawn_ui_draw3D {};
		class spawn_ui_addaction {};
		class halo {};
		class halo_addaction {postinit = 1;};
		class crate_OnLoad {};
		class crate_createlists {};
		class crate_filter {};
		class crate_getMod {};
		class crate_OpenMenu {};
		class crate_add {};
		class crate_mass {};
		class crate_addaction {};
		class crate_draw3D {};
		class crate_spawn {};
		class rescue_draw3D {};
	};
	class sonstiges {
		class addbriefing {};
	};
};
