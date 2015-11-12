class unitlists {
	class base {
		
		crewmen[] = {};
		divers[] = {};
		soldiers[] = {};
		
		veh_transport[] = {};
		veh_mechanized[] = {};
		veh_armored[] = {};
		
		boat_patrol[] = {};
		
		hq_mobile[] = {};
		
		static[] = {};
		static_high[] = {};
		static_aa[] = {};
		
		art_mortar[] = {};
		art_shells[] = {};
		art_rocket[] = {};
		
		class callIn {
			class airinterception {
				amount = 0;
				units[] = {};
			};
			class cas {
				amount = 0;
				units[] = {};
			};
			class motorized {
				amount = 0;
				units[] = {};
			};
			class armored {
				amount = 0;
				units[] = {};
			};
			class airborne {
				amount = 0;
				units[] = {};
				transport[] = {};
			};
		};
		
		class groups {
			class patrol_1 {
				class soldier_1 {
					vehicle = "C_scientist_F"
					rank = "LIEUTENANT"
					position[] = {0,0,0}
				};
				class soldier_2 {
					vehicle = "C_scientist_F"
					rank = "PRIVATE"
					position[] = {1,-1,0}
				};
			};
		};
		
		
		civ_cars[] = {"C_Offroad_01_F","C_Quadbike_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Offroad_01_F","C_Quadbike_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F","RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_03"};
		civ_smallcars[] = {"C_Offroad_01_F","C_Quadbike_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F"};
		
		pow[] = {"C_scientist_F","C_journalist_F"};
		intel[] = {"Land_Suitcase_F","Land_SatellitePhone_F","Land_Laptop_device_F"};
		tower[] = {"Land_TTowerBig_1_F","Land_TTowerBig_2_F"};
		prototyp[] = {};
		weaponcache[] = {};
		commander[] = {};
		radar[] = {"rhs_p37","rhs_prv13"};
		device[] = {"Land_Device_assembled_F"};
		
		group_patrol[] = {};
		group_armored[] = {};
		group_infaterie[] = {};
	};
	
	class east {
		
		/// Base class
		class infanterie : base {
			prototyp[] = {"B_MBT_01_TUSK_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F"};
			hq_mobile[] = {"rhs_gaz66_r142_vdv"};
			weaponcache[] = {"Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"};
			
			attack_uavs[] = {"O_UAV_02_F"};
			recon_uavs[] = {"rhs_pchela1t_vvs","O_UAV_01_F"};
		
			group_patrol[] = {
				{"missionconfigfile","East","infanterie","groups","patrol_1"}
			};
		
		};
		
	};
	
	class resistance {
		
		class infanterie : base {
			prototyp[] = {"B_MBT_01_TUSK_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F"};
			
			commandoveh[] = {"rhs_gaz66_r142_vdv"};
			commandoveh_arty[] = {"rhs_prp3_tv"};
			commandoveh_side = 0;
			weaponcache[] = {"Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"};
			
			sniper[] = {"I_ghillie_ard_F","I_ghillie_lsh_F","I_ghillie_sard_F"};
			diver[] = {"I_diver_f","I_diver_exp_f","I_diver_TL_f","I_diver_f","I_diver_exp_f","I_diver_f"};
			static[] = {"rhs_NSV_TriPod_MSV","I_static_AT_F","I_static_AA_F"};
			boat[] = {"I_Boat_Armed_01_hmg_F"};
			veh_aa[] = {"rhs_zsu234_aa"};
			veh_arty[] = {"rhs_2s3_tv"};
			veh_mortar[] = {"I_Mortar_01_F"};
		};

	};
	
	class west {
		class infanterie : base {
			boat[] = {"B_Boat_Armed_01_hmg_F"};
			commandoveh[] = {"rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"};
			commandoveh_arty[] = {"rhsusf_m113d_usarmy"};
			commandoveh_side = 1;
			diver[] = {"B_diver_f","B_diver_exp_f","B_diver_TL_f","B_diver_f","B_diver_exp_f","B_diver_f"};
			prototyp[] = {"O_MBT_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F","O_Heli_Attack_02_black_F"};
			sniper[] = {"B_ghillie_ard_F","B_ghillie_lsh_F","B_ghillie_sard_F"};
			static[] = {"RHS_M2StaticMG_D","B_static_AT_F","B_static_AA_F","RHS_M2StaticMG_MiniTripod_D","RHS_MK19_TriPod_D"};
			veh_mortar[] = {"O_Mortar_01_F"};
			weaponcache[] = {"Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"};
			plane_transport[] = {"RHS_C130J"};
		};
	};
	
	class mods {
		class rds {
			class rds_resistance {
				static[] = {"RDS_AGS_AAF","RDS_DSHKM_AAF","RDS_KORD_AAF","RDS_KORD_high_AAF","RDS_AGS_AAF","RDS_M2StaticMG_AAF","RDS_Metis_AAF","RDS_MK19_TriPod_AAF","RDS_SPG9_AAF","RDS_TOW_TriPod_AAF"};
				static_aa[] = {"RDS_Igla_AA_pod_AAF","RDS_ZU23_AAF"};
				static_arty[] = {"RDS_D30_AAF","RDS_M119_AAF"};
				veh_mortar[] = {"RDS_2b14_82mm_AAF","RDS_M252_AAF"};			
			};
			class rds_east : rds_resistance {};
			class rds_west : rds_resistance {};
		};
	};
	
};