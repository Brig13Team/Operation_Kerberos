/*
	Author: Dorbedo
	
	Description:
		creates the unitslists
	
	Parameter(s):
		0 : SCALAR (opt)	- Number
	
*/
#include "script_component.hpp"

private ["_rand"];

_rand = [_this,0,0,[0]] call BIS_fnc_param;
//_rand = (floor(random 7));

If (_rand < 1) then {_rand = ((floor(random 5))+ 3);};

//_rand = 2;
If (worldName == "pja305") then {_rand = 8;};

dorb_side_nr = _rand;
dorb_pow = ["C_scientist_F","C_journalist_F"];
dorb_intel = ["Land_Suitcase_F","Land_SatellitePhone_F","Land_Laptop_device_F"];
dorb_tower = ["Land_TTowerBig_1_F","Land_TTowerBig_2_F"]; //"Land_TTowerSmall_1_F"

dorb_prototyp = ["B_MBT_01_TUSK_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","B_Heli_Attack_01_F"];
/// city defence
dorb_civ_cars = ["C_Offroad_01_F","C_Quadbike_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F"];
dorb_civ_cars_garage = ["C_Offroad_01_F","C_Quadbike_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F"];
dorb_staticlist_high = ["B_HMG_01_high_F"];

dorb_sniper = ["O_ghillie_ard_F","O_ghillie_lsh_F","O_ghillie_sard_F"];

If (DORB_PLAYERSIDE == east) then {
	dorb_prototyp = ["O_MBT_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F","O_Heli_Attack_02_black_F"];
	dorb_sniper = ["B_ghillie_ard_F","B_ghillie_lsh_F","B_ghillie_sard_F"];
	_rand = [_this,0,0,[0]] call BIS_fnc_param;
	If (_rand < 1) then {
		ISNILS(DORB_MODS_BWA,false);
		If (DORB_MODS_BWA) then {
			_rand = ((floor(random 6))+ 21);
		}else{
			_rand = ((floor(random 4))+ 21);
		};
	};
	dorb_side_nr = _rand;
};


switch (_rand) do {
	case 1: {
	
		dorb_side = east;
		
		dorb_device = ["Land_Device_assembled_F","Land_Device_disassembled_F","O_Truck_03_device_F"];

		dorb_menlist = ["O_Urban_HeavyGunner_F","O_Urban_Sharpshooter_F","O_Sharpshooter_F","O_HeavyGunner_F","O_soldier_F","O_Soldier_lite_F","O_soldier_AT_F","O_soldier_GL_F","O_soldier_LAT_F","O_soldier_exp_F","O_soldier_F","O_soldier_AR_F","O_soldier_repair_F","O_soldier_LAT_F","O_soldier_AR_F","O_soldier_M_F","O_soldier_AT_F","O_soldier_AA_F","O_soldier_F","O_soldier_TL_F","O_medic_F","O_soldier_GL_F","O_soldier_F"];
		dorb_diverlist = ["O_diver_f","O_diver_exp_f","O_diver_TL_f","O_diver_f","O_diver_exp_f","O_diver_f"];
		dorb_crewmenlist = ["O_crew_F"];
		
		dorb_grouplist_inf = [configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconPatrol",configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconTeam",configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad",configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad_Weapons",configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam",configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA",configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AT",configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfAssault",configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_ReconSquad"];
		dorb_grouplist_sf = [configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_AttackTeam_UGV",configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_SmallTeam_UAV",configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_SniperTeam",configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_SmallTeam_UAV",configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_SniperTeam"];
		
		dorb_veh_armored 	= ["O_MBT_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F"];
		dorb_veh_unarmored 	= ["O_MRAP_02_gmg_F","O_MRAP_02_hmg_F"];
		dorb_veh_aa 		= ["O_APC_Tracked_02_AA_F"];
		dorb_veh_truck		= ["O_Truck_03_transport_F","O_Truck_03_covered_F","O_Truck_02_transport_F","O_Truck_02_covered_F"];
		dorb_veh_arty		= ["O_MBT_02_arty_F"];
		dorb_veh_mortar		= ["O_Mortar_01_F"];
		
		dorb_staticlist = ["O_HMG_01_high_F","O_GMG_01_high_F","O_static_AT_F","O_static_AA_F"];
		dorb_staticlist_art = ["O_HMG_01_high_F","O_GMG_01_high_F","O_static_AT_F","O_static_AA_F"];
	
		dorb_patrolboatlist = ["O_Boat_Armed_01_hmg_F"];
	
		dorb_transport_heli_list = ["O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_covered_F"];
		dorb_attack_heli_list = ["O_Heli_Attack_02_black_F"];
		dorb_patrol_air_list = ["O_Plane_CAS_02_F"];

		dorb_commanderlist = ["O_Story_Colonel_F","O_Story_CEO_F","O_officer_F"];
	
		dorb_wpncache_list = ["Box_East_Wps_F","Box_East_WpsSpecial_F","Box_East_WpsLaunch_F","Box_East_Ammo_F","Box_East_Grenades_F","Box_East_Support_F"];
	};
	
	case 2: {
	
		dorb_side = independent;
		
		dorb_device = ["Land_Device_assembled_F","Land_Device_disassembled_F","O_Truck_03_device_F"];

		dorb_menlist = ["I_soldier_F","I_Soldier_lite_F","I_soldier_AT_F","I_soldier_GL_F","I_soldier_LAT_F","I_soldier_exp_F","I_soldier_F","I_soldier_AR_F","I_soldier_repair_F","I_soldier_LAT_F","I_soldier_AR_F","I_soldier_M_F","I_soldier_AT_F","I_soldier_AA_F","I_soldier_F","I_soldier_TL_F","I_medic_F","I_soldier_GL_F","I_soldier_F"];
		dorb_diverlist = ["I_diver_f","I_diver_exp_f","I_diver_TL_f","I_diver_f","I_diver_exp_f","I_diver_f"];
		dorb_specopslist = ["I_ghillie_Ish_F","I_ghillie_sard_F","I_ghillie_ard_F","I_soldier_F","I_Soldier_lite_F","I_soldier_GL_F","I_soldier_LAT_F","I_soldier_TL_F","I_medic_F","I_soldier_AR_F"];
		dorb_crewmenlist = ["I_crew_F"];
	
		dorb_grouplist_inf = [configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad",configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad_Weapons",configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam",configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam_AA",configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam_AT"];
		dorb_grouplist_sf = [configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "SpecOps" >> "HAF_AttackTeam_UGV",configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "SpecOps" >> "HAF_SmallTeam_UAV",configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_SniperTeam",configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "SpecOps" >> "HAF_SmallTeam_UAV",configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_SniperTeam"];
	
		dorb_veh_armored 	= ["I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F","I_APC_Wheeled_03_cannon_F"];
		dorb_veh_unarmored	= ["I_MRAP_03_gmg_F","I_MRAP_03_hmg_F"];
		dorb_veh_aa			= ["O_APC_Tracked_02_AA_F"];
		dorb_veh_truck		= ["I_Truck_02_transport_F","I_Truck_02_covered_F"];
		dorb_veh_arty		= ["O_MBT_02_arty_F"];
		dorb_veh_mortar		= ["I_Mortar_01_F"];
		
		dorb_staticlist = ["I_HMG_01_high_F","I_GMG_01_high_F","I_static_AT_F","I_static_AA_F"];
	
		dorb_patrolboatlist = ["I_Boat_Armed_01_minigun_F"];
	
		dorb_transport_heli_list = ["I_Heli_Transport_02_F","I_Heli_light_03_unarmed_F"];
		dorb_attack_heli_list = ["I_Heli_light_03_F"];
		dorb_patrol_air_list = ["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F"];
		
		dorb_commanderlist = ["I_officer_F","I_Story_Colonel_F"];
	
		dorb_wpncache_list = ["Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"];
	};
	
	case 3: {
		///VDV
		dorb_side = east;
		dorb_commandveh_radio = ["rhs_gaz66_r142_vdv"];
		dorb_commandveh_arty = ["rhs_prp3_tv"];
		dorb_commandveh_side = east;
		dorb_radar = ["rhs_p37","rhs_prv13"];
		dorb_device = ["Land_Device_assembled_F"];
		dorb_commanderlist = ["rhs_vdv_officer_armored","rhs_vdv_officer"];
		dorb_civ_cars = dorb_civ_cars + dorb_civ_cars + ["RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_03"];
		dorb_menlist = ["rhs_vdv_rifleman",
						"rhs_vdv_efreitor",
						"rhs_vdv_grenadier",
						"rhs_vdv_grenadier_rpg",
						"rhs_vdv_machinegunner",
						"rhs_vdv_machinegunner_assistant",
						"rhs_vdv_at",
						"rhs_vdv_aa",
						"rhs_vdv_strelok_rpg_assist",
						"rhs_vdv_marksman",
						"rhs_vdv_sergeant",
						"rhs_vdv_junior_sergeant",
						"rhs_vdv_engineer",
						"rhs_vdv_medic",
						"rhs_vdv_LAT",
						"rhs_vdv_RShG2"
						];
		dorb_diverlist = ["O_diver_f","O_diver_exp_f","O_diver_TL_f","O_diver_f","O_diver_exp_f","O_diver_f"];
		dorb_crewmenlist = ["rhs_vdv_officer_armored","rhs_vdv_driver_armored","rhs_vdv_armoredcrew","rhs_vdv_driver","rhs_vdv_crew","rhs_vdv_crew_commander","rhs_vdv_combatcrew"];
	
		dorb_grouplist_inf = [
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry" >> "rhs_group_rus_vdv_infantry_fireteam",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry" >> "rhs_group_rus_vdv_infantry_MANEUVER",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry" >> "rhs_group_rus_vdv_infantry_section_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry" >> "rhs_group_rus_vdv_infantry_section_AT",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry" >> "rhs_group_rus_vdv_infantry_section_mg",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry" >> "rhs_group_rus_vdv_infantry_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry" >> "rhs_group_rus_vdv_infantry_squad_2mg"
								];
			
		dorb_grouplist_sf = [
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry" >> "rhs_group_rus_vdv_infantry_section_marksman",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry" >> "rhs_group_rus_vdv_infantry_squad_mg_sniper",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry" >> "rhs_group_rus_vdv_infantry_squad_sniper"
								];
		
		dorb_grouplist_mech = [	
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp1" >> "rhs_group_rus_msv_bmp1_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp2" >> "rhs_group_rus_msv_bmp2_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_MSV_BMP3" >> "rhs_group_rus_MSV_BMP3_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_btr70" >> "rhs_group_rus_msv_btr70_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80" >> "rhs_group_rus_msv_BTR80_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80a" >> "rhs_group_rus_msv_BTR80a_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad_2mg",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad_mg_sniper",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_Ural" >> "rhs_group_rus_msv_Ural_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_Ural" >> "rhs_group_rus_msv_Ural_squad_2mg",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_Ural" >> "rhs_group_rus_msv_Ural_squad_mg_sniper"
								];
		
		dorb_grouplist_panz = [	
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BAPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BAPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BASection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BBPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BBPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BBSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BCPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BCPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BCSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDSection",
								
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80APlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80APlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80ASection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BVPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BVPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BVSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80Platoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80Platoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80Section",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80UPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80UPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80USection"
								];
		
		dorb_veh_armored 	= [	"rhs_bmd1","rhs_bmd1k","rhs_bmd1p","rhs_bmd1pk","rhs_bmd1r",
								"rhs_bmd2","rhs_bmd2m","rhs_bmd2k",
								"rhs_bmp1_vdv","rhs_bmp1p_vdv","rhs_bmp1k_vdv","rhs_bmp1d_vdv",
								"rhs_bmp2e_vdv","rhs_bmp2_vdv","rhs_bmp2k_vdv","rhs_bmp2d_vdv","rhs_brm1k_vdv",
								"rhs_bmd4_vdv","rhs_bmd4m_vdv","rhs_bmd4ma_vdv","rhs_sprut_vdv"
								];
		dorb_veh_unarmored	= [	"rhs_btr60_vdv",
								"rhs_btr70_vdv",
								"rhs_btr80_vdv",
								"rhs_btr80a_vdv"
								];
		dorb_veh_aa			= ["rhs_zsu234_aa"];
		
		dorb_veh_truck		= [	"RHS_Ural_VDV_01",
								"RHS_Ural_Open_VDV_01",
								"rhs_gaz66_vdv",
								"rhs_gaz66o_vdv"
								];
		dorb_veh_car		= [	"rhs_tigr_VDV",
								"rhs_tigr_ffv_vdv",
								"rhs_tigr_3camo_vdv",
								"rhs_tigr_ffv_3camo_vdv"
								];
		dorb_veh_arty		= ["rhs_2s3_tv"];
		dorb_veh_mortar		= ["O_Mortar_01_F"];
		
		dorb_staticlist = ["rhs_NSV_TriPod_MSV","O_static_AT_F","O_static_AA_F"];

		dorb_patrolboatlist = ["O_Boat_Armed_01_hmg_F"];
	
		dorb_transport_heli_list = ["rhs_Mi8mt_vdv","rhs_Mi8mt_Cargo_vdv","rhs_Mi8MTV3_vdv","rhs_Mi8MTV3_UPK23_vdv","rhs_Mi8MTV3_FAB_vdv","rhs_Mi8AMT_vdv"];
		dorb_attack_heli_list = ["RHS_Ka52_UPK23_vvsc","rhs_ka60_c"];
		dorb_patrol_air_list = ["rhs_Su25SM_vvsc"];
		dorb_attack_air_list = ["rhs_Su25SM_KH29_vvsc"];
		
	
		dorb_wpncache_list = ["Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"];

	};
	case 4: {
		//VDV_FLORA
		dorb_side = east;
		dorb_commandveh_radio = ["rhs_gaz66_r142_vdv"];
		dorb_commandveh_arty = ["rhs_prp3_tv"];
		dorb_commandveh_side = east;
		dorb_radar = ["rhs_p37","rhs_prv13"];
		dorb_device = ["Land_Device_assembled_F"];
		dorb_commanderlist = ["rhs_vdv_flora_officer_armored","rhs_vdv_flora_officer"];
		dorb_civ_cars = dorb_civ_cars + dorb_civ_cars + ["RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_03"];
		dorb_menlist = [						
						"rhs_vdv_flora_rifleman",
						"rhs_vdv_flora_efreitor",
						"rhs_vdv_flora_grenadier",
						"rhs_vdv_flora_grenadier_rpg",
						"rhs_vdv_flora_machinegunner",
						"rhs_vdv_flora_machinegunner_assistant",
						"rhs_vdv_flora_at",
						"rhs_vdv_flora_aa",
						"rhs_vdv_flora_strelok_rpg_assist",
						"rhs_vdv_flora_marksman",
						"rhs_vdv_flora_sergeant",
						"rhs_vdv_flora_junior_sergeant",
						"rhs_vdv_flora_engineer",
						"rhs_vdv_flora_medic",
						"rhs_vdv_flora_LAT",
						"rhs_vdv_flora_RShG2"
						];
		dorb_diverlist = ["O_diver_f","O_diver_exp_f","O_diver_TL_f","O_diver_f","O_diver_exp_f","O_diver_f"];
		dorb_crewmenlist = ["rhs_vdv_flora_officer_armored","rhs_vdv_flora_driver_armored","rhs_vdv_flora_driver","rhs_vdv_flora_crew","rhs_vdv_flora_crew_commander","rhs_vdv_flora_armoredcrew","rhs_vdv_flora_combatcrew"];
	
		dorb_grouplist_inf = [	configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_fireteam",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_MANEUVER",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_section_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_section_AT",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_section_mg",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_squad_2mg"
								];
			
		dorb_grouplist_sf = [
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_section_marksman",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_squad_mg_sniper",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_squad_sniper"
								];
		
		dorb_grouplist_mech = [	
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp1" >> "rhs_group_rus_msv_bmp1_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp2" >> "rhs_group_rus_msv_bmp2_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_MSV_BMP3" >> "rhs_group_rus_MSV_BMP3_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_btr70" >> "rhs_group_rus_msv_btr70_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80" >> "rhs_group_rus_msv_BTR80_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80a" >> "rhs_group_rus_msv_BTR80a_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad_2mg",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad_mg_sniper",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_Ural" >> "rhs_group_rus_msv_Ural_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_Ural" >> "rhs_group_rus_msv_Ural_squad_2mg",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_Ural" >> "rhs_group_rus_msv_Ural_squad_mg_sniper"
								];
		
		dorb_grouplist_panz = [	
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BAPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BAPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BASection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BBPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BBPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BBSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BCPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BCPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BCSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDSection",
								
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80APlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80APlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80ASection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BVPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BVPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BVSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80Platoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80Platoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80Section",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80UPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80UPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80USection"
								];
	
	
		dorb_veh_armored 	= [	"rhs_bmd1","rhs_bmd1k","rhs_bmd1p","rhs_bmd1pk","rhs_bmd1r",
								"rhs_bmd2","rhs_bmd2m","rhs_bmd2k",
								"rhs_bmp1_vdv","rhs_bmp1p_vdv","rhs_bmp1k_vdv","rhs_bmp1d_vdv",
								"rhs_bmp2e_vdv","rhs_bmp2_vdv","rhs_bmp2k_vdv","rhs_bmp2d_vdv","rhs_brm1k_vdv",
								"rhs_bmd4_vdv","rhs_bmd4m_vdv","rhs_bmd4ma_vdv","rhs_sprut_vdv"
								];
		dorb_veh_unarmored	= [	"rhs_btr60_vdv",
								"rhs_btr70_vdv",
								"rhs_btr80_vdv",
								"rhs_btr80a_vdv"
								];
		dorb_veh_aa			= ["rhs_zsu234_aa"];
		
		dorb_veh_truck		= [	"RHS_Ural_VDV_01",
								"RHS_Ural_Open_VDV_01",
								"rhs_gaz66_vdv",
								"rhs_gaz66o_vdv"
								];
		dorb_veh_car		= [	"rhs_tigr_VDV",
								"rhs_tigr_ffv_vdv",
								"rhs_tigr_3camo_vdv",
								"rhs_tigr_ffv_3camo_vdv"
								];
		dorb_veh_arty		= ["rhs_2s3_tv"];
		dorb_veh_mortar		= ["O_Mortar_01_F"];
		
		dorb_staticlist = ["rhs_NSV_TriPod_MSV","O_static_AT_F","O_static_AA_F"];

		dorb_patrolboatlist = ["O_Boat_Armed_01_hmg_F"];
	
		dorb_transport_heli_list = ["rhs_Mi8mt_vdv","rhs_Mi8mt_Cargo_vdv","rhs_Mi8MTV3_vdv","rhs_Mi8MTV3_UPK23_vdv","rhs_Mi8MTV3_FAB_vdv","rhs_Mi8AMT_vdv"];
		dorb_attack_heli_list = ["RHS_Ka52_UPK23_vvsc","rhs_ka60_c"];
		dorb_patrol_air_list = ["rhs_Su25SM_vvsc"];
		dorb_attack_air_list = ["rhs_Su25SM_KH29_vvsc"];
		
		
	
		dorb_wpncache_list = ["Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"];

	};
	case 5: {
		//VDV_MFLORA
		dorb_side = east;
		dorb_commandveh_radio = ["rhs_gaz66_r142_vdv"];
		dorb_commandveh_arty = ["rhs_prp3_tv"];
		dorb_commandveh_side = east;
		dorb_radar = ["rhs_p37","rhs_prv13"];
		dorb_device = ["Land_Device_assembled_F"];
		dorb_commanderlist = ["rhs_vdv_mflora_officer_armored","rhs_vdv_mflora_officer"];
		dorb_civ_cars = dorb_civ_cars + dorb_civ_cars + ["RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_03"];
		dorb_menlist = [						
						"rhs_vdv_mflora_rifleman",
						"rhs_vdv_mflora_efreitor",
						"rhs_vdv_mflora_grenadier",
						"rhs_vdv_mflora_grenadier_rpg",
						"rhs_vdv_mflora_machinegunner",
						"rhs_vdv_mflora_machinegunner_assistant",
						"rhs_vdv_mflora_at",
						"rhs_vdv_mflora_aa",
						"rhs_vdv_mflora_strelok_rpg_assist",
						"rhs_vdv_mflora_marksman",
						"rhs_vdv_mflora_sergeant",
						"rhs_vdv_mflora_junior_sergeant",
						"rhs_vdv_mflora_engineer",
						"rhs_vdv_mflora_medic",
						"rhs_vdv_mflora_LAT",
						"rhs_vdv_mflora_RShG2"
						];
		dorb_diverlist = ["O_diver_f","O_diver_exp_f","O_diver_TL_f","O_diver_f","O_diver_exp_f","O_diver_f"];
		dorb_crewmenlist = ["rhs_vdv_mflora_officer_armored","rhs_vdv_mflora_driver_armored","rhs_vdv_mflora_driver","rhs_vdv_mflora_crew","rhs_vdv_mflora_crew_commander","rhs_vdv_mflora_armoredcrew","rhs_vdv_mflora_combatcrew"];
	
		dorb_grouplist_inf = [
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_mflora" >> "rhs_group_rus_vdv_infantry_mflora_fireteam",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_mflora" >> "rhs_group_rus_vdv_infantry_mflora_MANEUVER",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_mflora" >> "rhs_group_rus_vdv_infantry_mflora_section_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_mflora" >> "rhs_group_rus_vdv_infantry_mflora_section_AT",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_mflora" >> "rhs_group_rus_vdv_infantry_mflora_section_mg",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_mflora" >> "rhs_group_rus_vdv_infantry_mflora_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_mflora" >> "rhs_group_rus_vdv_infantry_mflora_squad_2mg"
								];
			
		dorb_grouplist_sf = [
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_mflora_section_marksman",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_mflora_squad_mg_sniper",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_mflora_squad_sniper"
								];
		
		dorb_grouplist_mech = [	
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp1" >> "rhs_group_rus_msv_bmp1_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp2" >> "rhs_group_rus_msv_bmp2_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_MSV_BMP3" >> "rhs_group_rus_MSV_BMP3_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_btr70" >> "rhs_group_rus_msv_btr70_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80" >> "rhs_group_rus_msv_BTR80_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80a" >> "rhs_group_rus_msv_BTR80a_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad_2mg",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad_mg_sniper",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_Ural" >> "rhs_group_rus_msv_Ural_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_Ural" >> "rhs_group_rus_msv_Ural_squad_2mg",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_Ural" >> "rhs_group_rus_msv_Ural_squad_mg_sniper"
								];
		
		dorb_grouplist_panz = [	
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BAPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BAPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BASection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BBPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BBPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BBSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BCPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BCPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BCSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDSection",
								
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80APlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80APlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80ASection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BVPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BVPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BVSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80Platoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80Platoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80Section",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80UPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80UPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80USection"
								];
		
		
		dorb_veh_armored 	= [	"rhs_bmd1","rhs_bmd1k","rhs_bmd1p","rhs_bmd1pk","rhs_bmd1r",
								"rhs_bmd2","rhs_bmd2m","rhs_bmd2k",
								"rhs_bmp1_vdv","rhs_bmp1p_vdv","rhs_bmp1k_vdv","rhs_bmp1d_vdv",
								"rhs_bmp2e_vdv","rhs_bmp2_vdv","rhs_bmp2k_vdv","rhs_bmp2d_vdv","rhs_brm1k_vdv",
								"rhs_bmd4_vdv","rhs_bmd4m_vdv","rhs_bmd4ma_vdv","rhs_sprut_vdv"
								];
		dorb_veh_unarmored	= [	"rhs_btr60_vdv",
								"rhs_btr70_vdv",
								"rhs_btr80_vdv",
								"rhs_btr80a_vdv"
								];
		dorb_veh_aa			= ["rhs_zsu234_aa"];
		
		dorb_veh_truck		= [	"RHS_Ural_VDV_01",
								"RHS_Ural_Open_VDV_01",
								"rhs_gaz66_vdv",
								"rhs_gaz66o_vdv"
								];
		dorb_veh_car		= [	"rhs_tigr_VDV",
								"rhs_tigr_ffv_vdv",
								"rhs_tigr_3camo_vdv",
								"rhs_tigr_ffv_3camo_vdv"
								];
		dorb_veh_arty		= ["rhs_2s3_tv"];
		dorb_veh_mortar		= ["O_Mortar_01_F"];
		
		dorb_staticlist = ["rhs_NSV_TriPod_MSV","O_static_AT_F","O_static_AA_F"];

		dorb_patrolboatlist = ["O_Boat_Armed_01_hmg_F"];
	
		dorb_transport_heli_list = ["rhs_Mi8mt_vdv","rhs_Mi8mt_Cargo_vdv","rhs_Mi8MTV3_vdv","rhs_Mi8MTV3_UPK23_vdv","rhs_Mi8MTV3_FAB_vdv","rhs_Mi8AMT_vdv"];
		dorb_attack_heli_list = ["RHS_Ka52_UPK23_vvsc","rhs_ka60_c"];
		dorb_patrol_air_list = ["rhs_Su25SM_vvsc"];
		dorb_attack_air_list = ["rhs_Su25SM_KH29_vvsc"];
		
		
	
		dorb_wpncache_list = ["Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"];

	};
	case 6: {
		//MSV
		dorb_side = east;
		dorb_commandveh_radio = ["rhs_gaz66_r142_vv"];
		dorb_commandveh_arty = ["rhs_prp3_tv"];
		dorb_commandveh_side = east;
		dorb_radar = ["rhs_p37","rhs_prv13"];
		dorb_device = ["Land_Device_assembled_F"];
		dorb_commanderlist = ["rhs_msv_officer_armored","rhs_msv_officer"];
		dorb_civ_cars = dorb_civ_cars + dorb_civ_cars + ["RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_03"];
		dorb_menlist = ["rhs_msv_rifleman",
						"rhs_msv_efreitor",
						"rhs_msv_grenadier",
						"rhs_msv_grenadier_rpg",
						"rhs_msv_machinegunner",
						"rhs_msv_machinegunner_assistant",
						"rhs_msv_at",
						"rhs_msv_aa",
						"rhs_msv_strelok_rpg_assist",
						"rhs_msv_marksman",
						"rhs_msv_sergeant",
						"rhs_msv_junior_sergeant",
						"rhs_msv_engineer",
						"rhs_msv_medic",
						"rhs_msv_LAT",
						"rhs_msv_RShG2"];
		dorb_diverlist = ["O_diver_f","O_diver_exp_f","O_diver_TL_f","O_diver_f","O_diver_exp_f","O_diver_f"];
		dorb_crewmenlist = ["rhs_msv_officer_armored","rhs_msv_driver_armored","rhs_msv_driver","rhs_msv_crew","rhs_msv_crew_commander","rhs_msv_armoredcrew","rhs_msv_combatcrew"];
	
		dorb_grouplist_inf = [
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_fireteam",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_MANEUVER",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_section_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_section_AT",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_section_mg",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_squad_2mg"
								];
			
		dorb_grouplist_sf = [
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_section_marksman",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_squad_mg_sniper",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_squad_sniper"
								];
		
		dorb_grouplist_mech = [	
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp1" >> "rhs_group_rus_msv_bmp1_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp2" >> "rhs_group_rus_msv_bmp2_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_MSV_BMP3" >> "rhs_group_rus_MSV_BMP3_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_btr70" >> "rhs_group_rus_msv_btr70_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80" >> "rhs_group_rus_msv_BTR80_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80a" >> "rhs_group_rus_msv_BTR80a_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad_2mg",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad_mg_sniper",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_Ural" >> "rhs_group_rus_msv_Ural_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_Ural" >> "rhs_group_rus_msv_Ural_squad_2mg",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_Ural" >> "rhs_group_rus_msv_Ural_squad_mg_sniper"
								];
		
		dorb_grouplist_panz = [	
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BAPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BAPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BASection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BBPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BBPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BBSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BCPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BCPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BCSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDSection",
								
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80APlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80APlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80ASection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BVPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BVPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BVSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80Platoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80Platoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80Section",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80UPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80UPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80USection"
								];
	
	
		dorb_veh_armored 	= [	"rhs_bmp1_msv","rhs_bmp1p_msv","rhs_bmp1k_msv","rhs_bmp1d_msv",
								"rhs_bmp2e_msv","rhs_bmp2_msv","rhs_bmp2k_msv","rhs_bmp2d_msv",
								"rhs_brm1k_msv",
								"rhs_bmp3m_msv","rhs_bmp3mera_msv","rhs_bmp3_msv","rhs_bmp3_late_msv",
								"rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv",
								"rhs_t80b","rhs_t80bk","rhs_t80bv","rhs_t80bvk","rhs_t80","rhs_t80a","rhs_t80u","rhs_t80u45m","rhs_t80ue1","rhs_t80um",
								"rhs_t90_tv"
								];
								
		dorb_veh_unarmored	= [	"rhs_btr60_msv",
								"rhs_btr70_msv",
								"rhs_btr80_msv",
								"rhs_btr80a_msv"
								];
		dorb_veh_aa			= [	"rhs_zsu234_aa"];
		
		dorb_veh_truck		= [	"RHS_Ural_MSV_01",
								"RHS_Ural_Open_MSV_01",
								"rhs_gaz66_msv",
								"rhs_gaz66o_msv"
								];
		dorb_veh_car		= [	"rhs_tigr_msv",
								"rhs_tigr_ffv_msv",
								"rhs_tigr_3camo_msv",
								"rhs_tigr_ffv_3camo_msv"
								];
		dorb_veh_arty		= ["rhs_2s3_tv"];
		dorb_veh_mortar		= ["O_Mortar_01_F"];
		
		dorb_staticlist = ["rhs_NSV_TriPod_MSV","O_static_AT_F","O_static_AA_F"];

		dorb_patrolboatlist = ["O_Boat_Armed_01_hmg_F"];
	
		dorb_transport_heli_list = ["rhs_Mi8mt_vdv","rhs_Mi8mt_Cargo_vdv","rhs_Mi8MTV3_vdv","rhs_Mi8MTV3_UPK23_vdv","rhs_Mi8MTV3_FAB_vdv","rhs_Mi8AMT_vdv"];
		dorb_attack_heli_list = ["RHS_Ka52_UPK23_vvs","rhs_ka60_grey"];
		dorb_patrol_air_list = ["rhs_Su25SM_vvs"];
		dorb_attack_air_list = ["rhs_Su25SM_KH29_vvs"];
		
		
	
		dorb_wpncache_list = ["Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"];

	};
	case 7: {
		///MSV_EMR
		dorb_side = east;
		dorb_commandveh_radio = ["rhs_gaz66_r142_vv"];
		dorb_commandveh_arty = ["rhs_prp3_tv"];
		dorb_commandveh_side = east;
		dorb_radar = ["rhs_p37","rhs_prv13"];
		dorb_device = ["Land_Device_assembled_F"];
		dorb_commanderlist = ["rhs_msv_officer_armored","rhs_msv_officer"];
		dorb_civ_cars = dorb_civ_cars + dorb_civ_cars + ["RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_03"];
		dorb_menlist = ["rhs_msv_emr_rifleman",
						"rhs_msv_emr_efreitor",
						"rhs_msv_emr_grenadier",
						"rhs_msv_emr_grenadier_rpg",
						"rhs_msv_emr_machinegunner",
						"rhs_msv_emr_machinegunner_assistant",
						"rhs_msv_emr_at",
						"rhs_msv_emr_aa",
						"rhs_msv_emr_strelok_rpg_assist",
						"rhs_msv_emr_marksman",
						"rhs_msv_emr_sergeant",
						"rhs_msv_emr_junior_sergeant",
						"rhs_msv_emr_engineer",
						"rhs_msv_emr_medic",
						"rhs_msv_emr_LAT",
						"rhs_msv_emr_RShG2"];
		dorb_diverlist = ["O_diver_f","O_diver_exp_f","O_diver_TL_f","O_diver_f","O_diver_exp_f","O_diver_f"];
		dorb_crewmenlist = ["rhs_msv_emr_officer_armored","rhs_msv_emr_driver_armored","rhs_msv_emr_driver","rhs_msv_emr_crew","rhs_msv_emr_crew_commander","rhs_msv_emr_armoredcrew","rhs_msv_emr_combatcrew"];
	
		dorb_grouplist_inf = [																									
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_fireteam",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_MANEUVER",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_section_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_section_AT",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_section_mg",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_squad_2mg"
								];
			
		dorb_grouplist_sf = [
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_section_marksman",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_squad_mg_sniper",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_squad_sniper"
								];
		
		dorb_grouplist_mech = [	
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp1" >> "rhs_group_rus_msv_bmp1_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp2" >> "rhs_group_rus_msv_bmp2_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_MSV_BMP3" >> "rhs_group_rus_MSV_BMP3_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_btr70" >> "rhs_group_rus_msv_btr70_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80" >> "rhs_group_rus_msv_BTR80_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80a" >> "rhs_group_rus_msv_BTR80a_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad_2mg",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_gaz66" >> "rhs_group_rus_msv_gaz66_squad_mg_sniper",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_Ural" >> "rhs_group_rus_msv_Ural_squad",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_Ural" >> "rhs_group_rus_msv_Ural_squad_2mg",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_Ural" >> "rhs_group_rus_msv_Ural_squad_mg_sniper"
								];
		
		dorb_grouplist_panz = [	
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BAPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BAPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BASection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BBPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BBPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BBSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BCPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BCPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BCSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDSection",
								
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80APlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80APlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80ASection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BVPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BVPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80BVSection",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80Platoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80Platoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80Section",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80UPlatoon",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80UPlatoon_AA",
								configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80USection"
								];
	
		dorb_veh_armored 	= [	"rhs_bmp1_msv","rhs_bmp1p_msv","rhs_bmp1k_msv","rhs_bmp1d_msv",
								"rhs_bmp2e_msv","rhs_bmp2_msv","rhs_bmp2k_msv","rhs_bmp2d_msv",
								"rhs_brm1k_msv",
								"rhs_bmp3m_msv","rhs_bmp3mera_msv","rhs_bmp3_msv","rhs_bmp3_late_msv",
								"rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv",
								"rhs_t80b","rhs_t80bk","rhs_t80bv","rhs_t80bvk","rhs_t80","rhs_t80a","rhs_t80u","rhs_t80u45m","rhs_t80ue1","rhs_t80um",
								"rhs_t90_tv"
								];
		dorb_veh_unarmored	= [	"rhs_btr60_msv",
								"rhs_btr70_msv",
								"rhs_btr80_msv",
								"rhs_btr80a_msv"
								];
		dorb_veh_aa			= [	"rhs_zsu234_aa"];
		
		dorb_veh_truck		= [	"RHS_Ural_MSV_01",
								"RHS_Ural_Open_MSV_01",
								"rhs_gaz66_msv",
								"rhs_gaz66o_msv"
								];
		dorb_veh_car		= [	"rhs_tigr_msv",
								"rhs_tigr_ffv_msv",
								"rhs_tigr_3camo_msv",
								"rhs_tigr_ffv_3camo_msv"
								];
		dorb_veh_arty		= ["rhs_2s3_tv"];
		dorb_veh_mortar		= ["O_Mortar_01_F"];
		
		dorb_staticlist = ["rhs_NSV_TriPod_MSV","O_static_AT_F","O_static_AA_F"];

		dorb_patrolboatlist = ["O_Boat_Armed_01_hmg_F"];
	
		dorb_transport_heli_list = ["RHS_Mi8mt_vvs","RHS_Mi8mt_Cargo_vvs","RHS_Mi8MTV3_vvs","RHS_Mi8MTV3_UPK23_vvs","RHS_Mi8MTV3_FAB_vvs","RHS_Mi8AMT_vvs"];
		dorb_attack_heli_list = ["RHS_Ka52_UPK23_vvs","rhs_ka60_grey"];
		dorb_patrol_air_list = ["rhs_Su25SM_vvs"];
		dorb_attack_air_list = ["rhs_Su25SM_KH29_vvs"];

	
		dorb_wpncache_list = ["Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"];

	};
	case 8: {
	
		dorb_side = resistance;
		dorb_commandveh_radio = ["rhs_gaz66_r142_vv"];
		dorb_commandveh_arty = ["rhs_prp3_tv"];
		dorb_commandveh_side = east;
		dorb_radar = ["rhs_p37","rhs_prv13"];
		dorb_device = ["Land_Device_assembled_F"];
		dorb_commanderlist = ["rhs_msv_officer_armored","rhs_msv_officer"];
		dorb_civ_cars = dorb_civ_cars + dorb_civ_cars + ["RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_03"];
		dorb_menlist = ["LOP_AFR_Infantry",
						"LOP_AFR_Infantry_AR",
						"LOP_AFR_Infantry_AT",
						"LOP_AFR_Infantry_Corpsman",
						"LOP_AFR_Infantry_GL",
						"LOP_AFR_Infantry_IED",
						"LOP_AFR_Infantry_Marksman",
						"LOP_AFR_Infantry_SL",
						"LOP_AFR_Infantry_TL"];
		dorb_diverlist = ["O_diver_f","O_diver_exp_f","O_diver_TL_f","O_diver_f","O_diver_exp_f","O_diver_f"];
		dorb_crewmenlist = ["LOP_AFR_Driver"];
	
		dorb_grouplist_inf = [																									
								configfile >> "CfgGroups" >> "Indep" >> "LOP_AFR" >> "Infantry" >> "LOP_AFR_AT_section",
								configfile >> "CfgGroups" >> "Indep" >> "LOP_AFR" >> "Infantry" >> "LOP_AFR_Patrol_section",
								configfile >> "CfgGroups" >> "Indep" >> "LOP_AFR" >> "Infantry" >> "LOP_AFR_Rifle_squad",
								configfile >> "CfgGroups" >> "Indep" >> "LOP_AFR" >> "Infantry" >> "LOP_AFR_Support_section"
								];
			
		dorb_grouplist_sf = [
								configfile >> "CfgGroups" >> "Indep" >> "LOP_AFR" >> "Infantry" >> "LOP_AFR_AT_section",
								configfile >> "CfgGroups" >> "Indep" >> "LOP_AFR" >> "Infantry" >> "LOP_AFR_Patrol_section",
								configfile >> "CfgGroups" >> "Indep" >> "LOP_AFR" >> "Infantry" >> "LOP_AFR_Rifle_squad",
								configfile >> "CfgGroups" >> "Indep" >> "LOP_AFR" >> "Infantry" >> "LOP_AFR_Support_section"
								];
		
		dorb_grouplist_mech = [	
								configfile >> "CfgGroups" >> "Indep" >> "LOP_AFR" >> "Mechanized" >> "LOP_AFR_Mech_squad_LR"
								];
		
		dorb_grouplist_panz = [	
								configfile >> "CfgGroups" >> "Indep" >> "LOP_AFR" >> "Armored" >> "LOP_AFR_T72_Platoon"
								];
	
		dorb_veh_armored 	= [	"LOP_AFR_T72BA"];
		dorb_veh_unarmored	= [	"LOP_AFR_BTR60","LOP_AFR_Offroad_M2","LOP_AFR_Landrover_M2"];
		dorb_veh_aa			= [	"rhs_zsu234_aa"];
		
		dorb_veh_truck		= ["LOP_AFR_Civ_Ural","LOP_AFR_Civ_Ural_open"];
		dorb_veh_car		= ["LOP_AFR_Landrover","LOP_AFR_Offroad"];
		dorb_veh_arty		= ["rhs_2s3_tv"];
		dorb_veh_mortar		= ["O_Mortar_01_F"];
		
		dorb_staticlist 	= [
								"rhs_NSV_TriPod_MSV"
								];
	
		dorb_patrolboatlist = ["O_Boat_Armed_01_hmg_F"];
	
		dorb_transport_heli_list = ["RHS_Mi8mt_vvs","RHS_Mi8mt_Cargo_vvs","RHS_Mi8MTV3_vvs","RHS_Mi8MTV3_UPK23_vvs","RHS_Mi8MTV3_FAB_vvs","RHS_Mi8AMT_vvs"];
		dorb_attack_heli_list = ["rhs_Ka52_vvsc","rhs_Ka52_vvs","rhs_Ka52_UPK23_vvs","rhs_Ka52_UPK23_vvsc"];
		dorb_patrol_air_list = ["rhs_Su25SM_vvs","rhs_Su25SM_vvsc"];
		dorb_attack_air_list = ["rhs_Su25SM_KH29_vvs","rhs_Su25SM_KH29_vvsc"];

	
		dorb_wpncache_list = ["Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"];
		dorb_prototyp = ["B_APC_Wheeled_01_cannon_F"];
	};
	
	case 21: {
	
		dorb_side = west;
		dorb_commandveh_radio = ["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"];
		dorb_commandveh_arty = ["rhsusf_m113d_usarmy"];
		dorb_commandveh_side = west;
		dorb_radar = ["rhs_p37","rhs_prv13"];
		dorb_device = ["Land_Device_assembled_F"];
		dorb_commanderlist = ["rhsusf_army_ocp_officer"];
		dorb_civ_cars = dorb_civ_cars + dorb_civ_cars + ["RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_03"];
		dorb_menlist = [	"rhsusf_army_ucp_rifleman","rhsusf_army_ucp_rifleman_m16","rhsusf_army_ucp_rifleman_m590","rhsusf_army_ucp_riflemanl",
						"rhsusf_army_ucp_riflemanat","rhsusf_army_ucp_grenadier","rhsusf_army_ucp_autorifleman","rhsusf_army_ucp_autoriflemana",
						"rhsusf_army_ucp_machinegunner","rhsusf_army_ucp_machinegunnera","rhsusf_army_ucp_squadleader","rhsusf_army_ucp_teamleader",
						"rhsusf_army_ucp_javelin","rhsusf_army_ucp_aa","rhsusf_army_ucp_jfo","rhsusf_army_ucp_fso","rhsusf_army_ucp_engineer","rhsusf_army_ucp_marksman",
						"rhsusf_army_ucp_medic","rhsusf_army_ucp_uav","rhsusf_army_ucp_sniper","rhsusf_army_ucp_crewman","rhsusf_army_ucp_combatcrewman",
						"rhsusf_army_ucp_driver","rhsusf_army_ucp_helipilot","rhsusf_army_ucp_helicrew",
						"rhsusf_army_ocp_rifleman_1stcav","rhsusf_army_ocp_rifleman_82nd","rhsusf_army_ocp_rifleman_101st","rhsusf_army_ocp_rifleman_10th",
						"rhsusf_army_ocp_rifleman_m4", "rhsusf_army_ocp_officer", "rhsusf_army_ocp_explosives"
						];
		dorb_diverlist = ["B_diver_f","B_diver_exp_f","B_diver_TL_f","B_diver_f","B_diver_exp_f","B_diver_f"];
		dorb_crewmenlist = ["rhsusf_army_ucp_crewman"];
	
		dorb_grouplist_inf = [																									
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_infantry" >> "rhs_group_nato_usarmy_d_infantry_squad",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_infantry" >> "rhs_group_nato_usarmy_d_infantry_squad_sniper",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_infantry" >> "rhs_group_nato_usarmy_d_infantry_team",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_infantry" >> "rhs_group_nato_usarmy_d_infantry_team_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_infantry" >> "rhs_group_nato_usarmy_d_infantry_team_AT",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_infantry" >> "rhs_group_nato_usarmy_d_infantry_team_MG",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_infantry" >> "rhs_group_nato_usarmy_d_infantry_team_support",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_infantry" >> "rhs_group_nato_usarmy_d_infantry_weaponsquad"
								];
			
		dorb_grouplist_sf = [
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_socom_marsoc" >> "rhs_group_nato_marsoc_infantry" >> "rhs_group_nato_marsoc_infantry_squad",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_socom_marsoc" >> "rhs_group_nato_marsoc_infantry" >> "rhs_group_nato_marsoc_infantry_squad_sniper",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_socom_marsoc" >> "rhs_group_nato_marsoc_infantry" >> "rhs_group_nato_marsoc_infantry_team"
								];
		
		dorb_grouplist_mech = [];
		
		dorb_grouplist_panz = [	
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_m1a1" >> "RHS_M1A1AIM_Platoon",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_m1a1" >> "RHS_M1A1AIM_Platoon_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_m1a1" >> "RHS_M1A1AIM_Section",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_m1a1" >> "RHS_M1A1AIM_TUSK_Platoon",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_m1a1" >> "RHS_M1A1AIM_TUSK_Platoon_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_m1a1" >> "RHS_M1A1AIM_TUSK_Section",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_M1A2" >> "RHS_M1A2SEP_Platoon",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_M1A2" >> "RHS_M1A2SEP_Platoon_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_M1A2" >> "RHS_M1A2SEP_Section",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_M1A2" >> "RHS_M1A2SEP_TUSK_Platoon",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_M1A2" >> "RHS_M1A2SEP_TUSK_Platoon_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_M1A2" >> "RHS_M1A2SEP_TUSK_Section"
								];
	
		dorb_veh_armored 		= [	"rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy","rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","RHS_M2A2","RHS_M2A2_BUSKI","RHS_M2A3","RHS_M2A3_BUSKI","RHS_M2A3_BUSKIII"];
		dorb_veh_unarmored	= [	"rhsusf_m1025_d_m2","rhsusf_m1025_d_Mk19","rhsusf_rg33_m2_d","rhsusf_rg33_m2_d","rhsusf_rg33_m2_d"];
		dorb_veh_aa			= [	"RHS_M6"];
		
		dorb_veh_truck		= ["rhsusf_M1078A1P2_B_d_fmtv_usarmy","rhsusf_M1078A1P2_B_d_open_fmtv_usarmy","rhsusf_M1078A1P2_d_fmtv_usarmy","rhsusf_M1078A1P2_d_open_fmtv_usarmy","rhsusf_M1083A1P2_B_d_fmtv_usarmy","rhsusf_M1083A1P2_B_d_open_fmtv_usarmy","rhsusf_M1083A1P2_d_fmtv_usarmy","rhsusf_M1083A1P2_d_open_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_d_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_d_open_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_d_open_fmtv_usarmy"];
		dorb_veh_car			= ["rhsusf_rg33_d"];
		dorb_veh_arty			= ["rhsusf_m109d_usarmy"];
		dorb_veh_mortar		= ["B_Mortar_01_F"];
		
		dorb_staticlist 		= ["RHS_M2StaticMG_D","B_static_AT_F","B_static_AA_F","RHS_M2StaticMG_MiniTripod_D","RHS_MK19_TriPod_D"];
	
		dorb_patrolboatlist 	= ["B_Boat_Armed_01_hmg_F"];
	
		dorb_transport_heli_list = ["RHS_UH60M_d","RHS_UH60M_MEV_d","RHS_UH60M_MEV2_d","RHS_CH_47F_10","RHS_CH_47F_light"];
		dorb_attack_heli_list 	= ["RHS_AH64D","RHS_AH64D_GS","RHS_AH64D_CS","RHS_AH64D_AA","RHS_AH64DGrey"];
		dorb_patrol_air_list 	= ["RHS_A10"];
		dorb_attack_air_list 	= ["RHS_A10"];
		dorb_transport_list 	= ["RHS_C130J"];

	
		dorb_wpncache_list 	= ["Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"];
	};
	case 22: {
	
		dorb_side = west;
		dorb_commandveh_radio = ["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"];
		dorb_commandveh_arty = ["rhsusf_m113_usarmy"];
		dorb_commandveh_side = west;
		dorb_radar = ["rhs_p37","rhs_prv13"];
		dorb_device = ["Land_Device_assembled_F"];
		dorb_commanderlist = ["rhsusf_army_ucp_officer"];
		dorb_civ_cars = dorb_civ_cars + dorb_civ_cars + ["RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_03"];
		dorb_menlist = ["rhsusf_army_ocp_rifleman","rhsusf_army_ocp_rifleman_m16","rhsusf_army_ocp_rifleman_m590","rhsusf_army_ocp_riflemanl",
						"rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_grenadier","rhsusf_army_ocp_autorifleman","rhsusf_army_ocp_autoriflemana",
						"rhsusf_army_ocp_machinegunner", "rhsusf_army_ocp_machinegunnera", "rhsusf_army_ocp_squadleader", "rhsusf_army_ocp_teamleader",
						"rhsusf_army_ocp_javelin", "rhsusf_army_ocp_aa", "rhsusf_army_ocp_jfo", "rhsusf_army_ocp_fso", "rhsusf_army_ocp_engineer",
						"rhsusf_army_ocp_marksman", "rhsusf_army_ocp_medic", "rhsusf_army_ocp_uav", "rhsusf_army_ocp_sniper", "rhsusf_army_ocp_crewman",
						"rhsusf_army_ocp_combatcrewman", "rhsusf_army_ocp_driver", "rhsusf_army_ocp_helipilot", "rhsusf_army_ocp_helicrew",
						"rhsusf_army_ucp_rifleman_1stcav","rhsusf_army_ucp_rifleman_82nd", "rhsusf_army_ucp_rifleman_101st", "rhsusf_army_ucp_rifleman_10th",
						"rhsusf_army_ucp_rifleman_m4","rhsusf_army_ucp_officer", "rhsusf_army_ucp_explosives"];
		dorb_diverlist = ["B_diver_f","B_diver_exp_f","B_diver_TL_f","B_diver_f","B_diver_exp_f","B_diver_f"];
		dorb_crewmenlist = ["rhsusf_army_ocp_crewman"];
	
		dorb_grouplist_inf = [																									
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_infantry" >> "rhs_group_nato_usarmy_wd_infantry_squad",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_infantry" >> "rhs_group_nato_usarmy_wd_infantry_squad_sniper",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_infantry" >> "rhs_group_nato_usarmy_wd_infantry_team",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_infantry" >> "rhs_group_nato_usarmy_wd_infantry_team_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_infantry" >> "rhs_group_nato_usarmy_wd_infantry_team_AT",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_infantry" >> "rhs_group_nato_usarmy_wd_infantry_team_MG",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_infantry" >> "rhs_group_nato_usarmy_wd_infantry_team_support",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_infantry" >> "rhs_group_nato_usarmy_wd_infantry_weaponsquad"
								];
			
		dorb_grouplist_sf = [
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_socom_marsoc" >> "rhs_group_nato_marsoc_infantry" >> "rhs_group_nato_marsoc_infantry_squad",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_socom_marsoc" >> "rhs_group_nato_marsoc_infantry" >> "rhs_group_nato_marsoc_infantry_squad_sniper",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_socom_marsoc" >> "rhs_group_nato_marsoc_infantry" >> "rhs_group_nato_marsoc_infantry_team"
								];
		
		dorb_grouplist_mech = [];
		
		dorb_grouplist_panz = [	
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_m1a1" >> "RHS_M1A1AIM_wd_Platoon",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_m1a1" >> "RHS_M1A1AIM_wd_Platoon_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_m1a1" >> "RHS_M1A1AIM_wd_Section",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_m1a1" >> "RHS_M1A1AIM_wd_TUSK_Platoon",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_m1a1" >> "RHS_M1A1AIM_wd_TUSK_Platoon_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_m1a1" >> "RHS_M1A1AIM_wd_TUSK_Section",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_m1a1" >> "RHS_M1A2SEP_wd_Platoon",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_m1a1" >> "RHS_M1A2SEP_wd_Platoon_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_m1a1" >> "RHS_M1A2SEP_wd_Section",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_m1a1" >> "RHS_M1A2SEP_wd_TUSK_Platoon",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_m1a1" >> "RHS_M1A2SEP_wd_TUSK_Platoon_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_wd_m1a1" >> "RHS_M1A2SEP_wd_TUSK_Section"
								];
	
		dorb_veh_armored 		= [	"rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy","rhsusf_m1a1aimwd_usarmy","rhsusf_m1a1aim_tuski_wd","RHS_M2A2_wd","RHS_M2A2_BUSKI_WD","RHS_M2A3_wd","RHS_M2A3_BUSKI_wd","RHS_M2A3_BUSKIII_wd"];
		dorb_veh_unarmored	= [	"rhsusf_m1025_w_m2","rhsusf_m1025_w_mk19","rhsusf_rg33_m2_wd","rhsusf_rg33_m2_wd","rhsusf_rg33_m2_wd"];
		dorb_veh_aa			= [	"RHS_M6_wd"];
		
		dorb_veh_truck		= ["rhsusf_M1078A1P2_B_wd_fmtv_usarmy","rhsusf_M1078A1P2_B_wd_open_fmtv_usarmy","rhsusf_M1078A1P2_wd_fmtv_usarmy","rhsusf_M1078A1P2_wd_open_fmtv_usarmy","rhsusf_M1083A1P2_B_wd_fmtv_usarmy","rhsusf_M1083A1P2_B_wd_open_fmtv_usarmy","rhsusf_M1083A1P2_wd_fmtv_usarmy","rhsusf_M1083A1P2_wd_open_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_wd_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_wd_open_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_wd_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_wd_open_fmtv_usarmy"];
		dorb_veh_car			= ["rhsusf_rg33_wd"];
		dorb_veh_arty			= ["rhsusf_m109_usarmy"];
		dorb_veh_mortar		= ["B_Mortar_01_F"];
		
		dorb_staticlist 		= ["B_static_AT_F","B_static_AA_F","RHS_MK19_TriPod_WD","RHS_M2StaticMG_WD","RHS_M2StaticMG_MiniTripod_WD"];
	
		dorb_patrolboatlist 	= ["B_Boat_Armed_01_hmg_F"];
	
		dorb_transport_heli_list = ["RHS_UH60M","RHS_UH60M_MEV","RHS_UH60M_MEV2","RHS_CH_47F"];
		dorb_attack_heli_list 	= ["RHS_AH64D_wd","RHS_AH64D_wd_GS","RHS_AH64D_wd_CS","RHS_AH64D_wd_AA"];
		dorb_patrol_air_list 	= ["RHS_A10"];
		dorb_attack_air_list 	= ["RHS_A10"];
		dorb_transport_list 	= ["RHS_C130J"];

	
		dorb_wpncache_list 	= ["Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"];
	};
	
////////////////////	
	
	case 23: {
	
		dorb_side = west;
		dorb_commandveh_radio = ["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"];
		dorb_commandveh_arty = ["rhsusf_m113d_usarmy"];
		dorb_commandveh_side = west;
		dorb_radar = ["rhs_p37","rhs_prv13"];
		dorb_device = ["Land_Device_assembled_F"];
		dorb_commanderlist = ["rhsusf_usmc_marpat_d_officer"];
		dorb_civ_cars = dorb_civ_cars + dorb_civ_cars + ["RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_03"];
		dorb_menlist = [	"rhsusf_usmc_marpat_d_rifleman", "rhsusf_usmc_marpat_d_rifleman_m4", "rhsusf_usmc_marpat_d_grenadier", "rhsusf_usmc_marpat_d_riflemanat",
						"rhsusf_usmc_marpat_d_rifleman_m590", "rhsusf_usmc_marpat_d_autorifleman", "rhsusf_usmc_marpat_d_autorifleman_m249", "rhsusf_usmc_marpat_d_autorifleman_m249_ass",
						"rhsusf_usmc_marpat_d_machinegunner", "rhsusf_usmc_marpat_d_machinegunner_ass", "rhsusf_usmc_marpat_d_officer", "rhsusf_usmc_marpat_d_squadleader",
						"rhsusf_usmc_marpat_d_teamleader", "rhsusf_usmc_marpat_d_engineer", "rhsusf_usmc_marpat_d_uav", "rhsusf_usmc_marpat_d_javelin", "rhsusf_usmc_marpat_d_stinger",
						"rhsusf_usmc_marpat_d_spotter", "rhsusf_usmc_marpat_d_marksman", "rhsusf_usmc_marpat_d_sniper", "rhsusf_usmc_marpat_d_crewman", "rhsusf_usmc_marpat_d_combatcrewman",
						"rhsusf_usmc_marpat_d_driver", "rhsusf_usmc_marpat_d_helipilot", "rhsusf_usmc_marpat_d_helicrew",
						"rhsusf_usmc_marpat_d_rifleman_light", "rhsusf_usmc_marpat_d_fso","rhsusf_usmc_marpat_d_jfo", "rhsusf_usmc_marpat_d_explosives"
						];
		dorb_diverlist = ["B_diver_f","B_diver_exp_f","B_diver_TL_f","B_diver_f","B_diver_exp_f","B_diver_f"];
		dorb_crewmenlist = ["rhsusf_usmc_marpat_d_crewman"];
	
		dorb_grouplist_inf = [																									
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_d_infantry" >> "rhs_group_nato_usmc_d_infantry_squad",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_d_infantry" >> "rhs_group_nato_usmc_d_infantry_squad_sniper",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_d_infantry" >> "rhs_group_nato_usmc_d_infantry_team",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_d_infantry" >> "rhs_group_nato_usmc_d_infantry_team_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_d_infantry" >> "rhs_group_nato_usmc_d_infantry_team_heavy_AT",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_d_infantry" >> "rhs_group_nato_usmc_d_infantry_team_MG",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_d_infantry" >> "rhs_group_nato_usmc_d_infantry_team_support",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_d" >> "rhs_group_nato_usmc_d_infantry" >> "rhs_group_nato_usmc_d_infantry_weaponsquad"
								];
			
		dorb_grouplist_sf = [
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_socom_marsoc" >> "rhs_group_nato_marsoc_infantry" >> "rhs_group_nato_marsoc_infantry_squad",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_socom_marsoc" >> "rhs_group_nato_marsoc_infantry" >> "rhs_group_nato_marsoc_infantry_squad_sniper",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_socom_marsoc" >> "rhs_group_nato_marsoc_infantry" >> "rhs_group_nato_marsoc_infantry_team"
								];
		
		dorb_grouplist_mech = [];
		
		dorb_grouplist_panz = [	
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_m1a1" >> "RHS_M1A1AIM_Platoon",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_m1a1" >> "RHS_M1A1AIM_Platoon_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_m1a1" >> "RHS_M1A1AIM_Section",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_m1a1" >> "RHS_M1A1AIM_TUSK_Platoon",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_m1a1" >> "RHS_M1A1AIM_TUSK_Platoon_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_m1a1" >> "RHS_M1A1AIM_TUSK_Section",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_M1A2" >> "RHS_M1A2SEP_Platoon",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_M1A2" >> "RHS_M1A2SEP_Platoon_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_M1A2" >> "RHS_M1A2SEP_Section",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_M1A2" >> "RHS_M1A2SEP_TUSK_Platoon",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_M1A2" >> "RHS_M1A2SEP_TUSK_Platoon_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_M1A2" >> "RHS_M1A2SEP_TUSK_Section"
								];
	
		dorb_veh_armored 		= [	"rhsusf_m1a1fep_d"];
		dorb_veh_unarmored	= [	"rhsusf_m1025_d_s_m2","rhsusf_m1025_d_s_Mk19","rhsusf_rg33_m2_usmc_d","rhsusf_rg33_m2_usmc_d","rhsusf_rg33_m2_usmc_d"];
		dorb_veh_aa			= [	"RHS_M6"];
		
		dorb_veh_truck		= ["B_Truck_01_covered_F","B_Truck_01_transport_F"];
		dorb_veh_car			= ["rhsusf_rg33_usmc_d"];
		dorb_veh_arty			= ["rhsusf_m109d_usarmy"];
		dorb_veh_mortar		= ["B_Mortar_01_F"];
		
		dorb_staticlist 		= ["RHS_M2StaticMG_D","B_static_AT_F","B_static_AA_F","RHS_M2StaticMG_MiniTripod_D","RHS_MK19_TriPod_D"];
	
		dorb_patrolboatlist 	= ["B_Boat_Armed_01_hmg_F"];
	
		dorb_transport_heli_list = ["RHS_UH1Y_d","RHS_UH1Y_FFAR_d","RHS_UH1Y_UNARMED_d"];
		dorb_attack_heli_list 	= ["RHS_AH1Z","RHS_AH1Z_GS","RHS_AH1Z_CS"];
		dorb_patrol_air_list 	= ["RHS_A10"];
		dorb_attack_air_list 	= ["RHS_A10"];
		dorb_transport_list 	= ["RHS_C130J"];

	
		dorb_wpncache_list 	= ["Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"];
	};
	case 24: {
	
		dorb_side = west;
		dorb_commandveh_radio = ["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"];
		dorb_commandveh_arty = ["rhsusf_m113_usarmy"];
		dorb_commandveh_side = west;
		dorb_radar = ["rhs_p37","rhs_prv13"];
		dorb_device = ["Land_Device_assembled_F"];
		dorb_commanderlist = ["rhsusf_usmc_marpat_wd_officer"];
		dorb_civ_cars = dorb_civ_cars + dorb_civ_cars + ["RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_03"];
		dorb_menlist = [		"rhsusf_usmc_marpat_wd_rifleman", "rhsusf_usmc_marpat_wd_rifleman_m4", "rhsusf_usmc_marpat_wd_grenadier", "rhsusf_usmc_marpat_wd_riflemanat",
							"rhsusf_usmc_marpat_wd_rifleman_m590", "rhsusf_usmc_marpat_wd_autorifleman", "rhsusf_usmc_marpat_wd_autorifleman_m249", "rhsusf_usmc_marpat_wd_autorifleman_m249_ass",
							"rhsusf_usmc_marpat_wd_machinegunner", "rhsusf_usmc_marpat_wd_machinegunner_ass", "rhsusf_usmc_marpat_wd_officer", "rhsusf_usmc_marpat_wd_squadleader",
							"rhsusf_usmc_marpat_wd_teamleader", "rhsusf_usmc_marpat_wd_engineer", "rhsusf_usmc_marpat_wd_uav", "rhsusf_usmc_marpat_wd_javelin", "rhsusf_usmc_marpat_wd_stinger",
							"rhsusf_usmc_marpat_wd_marksman", "rhsusf_usmc_marpat_wd_spotter", "rhsusf_usmc_marpat_wd_sniper", "rhsusf_usmc_marpat_wd_crewman", "rhsusf_usmc_marpat_wd_combatcrewman",
							"rhsusf_usmc_marpat_wd_driver", "rhsusf_usmc_marpat_wd_helipilot", "rhsusf_usmc_marpat_wd_helicrew",
							"rhsusf_usmc_marpat_wd_rifleman_light", "rhsusf_usmc_marpat_wd_jfo","rhsusf_usmc_marpat_wd_fso", "rhsusf_usmc_marpat_wd_explosives"];
		dorb_diverlist = ["B_diver_f","B_diver_exp_f","B_diver_TL_f","B_diver_f","B_diver_exp_f","B_diver_f"];
		dorb_crewmenlist = ["rhsusf_usmc_marpat_wd_crewman"];
	
		dorb_grouplist_inf = [																									
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_wd" >> "rhs_group_nato_usmc_wd_infantry" >> "rhs_group_nato_usmc_wd_infantry_squad",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_wd" >> "rhs_group_nato_usmc_wd_infantry" >> "rhs_group_nato_usmc_wd_infantry_squad_sniper",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_wd" >> "rhs_group_nato_usmc_wd_infantry" >> "rhs_group_nato_usmc_wd_infantry_team",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_wd" >> "rhs_group_nato_usmc_wd_infantry" >> "rhs_group_nato_usmc_wd_infantry_team_AA",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_wd" >> "rhs_group_nato_usmc_wd_infantry" >> "rhs_group_nato_usmc_wd_infantry_team_heavy_AT",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_wd" >> "rhs_group_nato_usmc_wd_infantry" >> "rhs_group_nato_usmc_wd_infantry_team_MG",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_wd" >> "rhs_group_nato_usmc_wd_infantry" >> "rhs_group_nato_usmc_wd_infantry_team_support",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_wd" >> "rhs_group_nato_usmc_wd_infantry" >> "rhs_group_nato_usmc_wd_infantry_weaponsquad"
								];
			
		dorb_grouplist_sf = [
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_socom_marsoc" >> "rhs_group_nato_marsoc_infantry" >> "rhs_group_nato_marsoc_infantry_squad",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_socom_marsoc" >> "rhs_group_nato_marsoc_infantry" >> "rhs_group_nato_marsoc_infantry_squad_sniper",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_socom_marsoc" >> "rhs_group_nato_marsoc_infantry" >> "rhs_group_nato_marsoc_infantry_team",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_socom_marsoc" >> "rhs_group_nato_marsoc_infantry" >> "LOP_AFR_Support_section"
								];
		
		dorb_grouplist_mech = [];
		
		dorb_grouplist_panz = [	
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_wd" >> "rhs_group_nato_usmc_wd_m1a1" >> "RHS_M1A1AIM_wd_Platoon",
								configfile >> "CfgGroups" >> "West" >> "rhs_faction_usmc_wd" >> "rhs_group_nato_usmc_wd_m1a1" >> "RHS_M1A1FEP_wd_Section"
								];
	
		dorb_veh_armored 		= [	"rhsusf_m1a1fep_wd","rhsusf_m1a1fep_od"];
		dorb_veh_unarmored	= [	"rhsusf_m1025_w_s_m2","rhsusf_m1025_w_s_Mk19","rhsusf_rg33_m2_usmc_wd","rhsusf_rg33_m2_usmc_wd","rhsusf_rg33_m2_usmc_wd"];
		dorb_veh_aa			= [	"RHS_M6_wd"];
		
		dorb_veh_truck		= ["B_Truck_01_covered_F","B_Truck_01_transport_F"];
		dorb_veh_car			= ["rhsusf_rg33_usmc_wd"];
		dorb_veh_arty			= ["rhsusf_m109_usarmy"];
		dorb_veh_mortar		= ["B_Mortar_01_F"];
		
		dorb_staticlist 		= ["B_static_AT_F","B_static_AA_F","RHS_MK19_TriPod_WD","RHS_M2StaticMG_WD","RHS_M2StaticMG_MiniTripod_WD"];
	
		dorb_patrolboatlist 	= ["B_Boat_Armed_01_hmg_F"];
	
		dorb_transport_heli_list = ["RHS_UH1Y","RHS_UH1Y_FFAR","RHS_UH1Y_UNARMED"];
		dorb_attack_heli_list 	= ["RHS_AH1Z_wd","RHS_AH1Z_wd_GS","RHS_AH1Z_wd_CS"];
		dorb_patrol_air_list 	= ["RHS_A10"];
		dorb_attack_air_list 	= ["RHS_A10"];
		dorb_transport_list 	= ["RHS_C130J"];

	
		dorb_wpncache_list 	= ["Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"];
	};
	case 25: {
	
		dorb_side = west;
		dorb_commandveh_radio = ["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"];
		dorb_commandveh_arty = ["rhsusf_m113d_usarmy"];
		dorb_commandveh_side = west;
		dorb_radar = ["rhs_p37","rhs_prv13"];
		dorb_device = ["Land_Device_assembled_F"];
		dorb_commanderlist = ["BWA3_SL_Tropen"];
		dorb_civ_cars = dorb_civ_cars + dorb_civ_cars + ["RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_03"];
		dorb_menlist = [		"BWA3_Rifleman_Tropen",
							"BWA3_RiflemanG27_Tropen",
							"BWA3_Grenadier_Tropen",
							"BWA3_GrenadierG27_Tropen",
							"BWA3_Autorifleman_Tropen",
							"BWA3_AutoriflemanMG5_Tropen",
							"BWA3_CombatLifeSaver_Tropen",
							"BWA3_Marksman_Tropen",
							"BWA3_RiflemanG28_Tropen",
							"BWA3_SniperG82_Tropen",
							"BWA3_Spotter_Tropen",
							"BWA3_RiflemanAT_RGW90_Tropen",
							"BWA3_RiflemanAT_Pzf3_Tropen",
							"BWA3_RiflemanAA_Fliegerfaust_Tropen",
							"BWA3_Engineer_Tropen",
							"BWA3_TL_Tropen",
							"BWA3_SL_Tropen",
							"BWA3_Crew_Tropen"];
		dorb_diverlist = ["B_diver_f","B_diver_exp_f","B_diver_TL_f","B_diver_f","B_diver_exp_f","B_diver_f"];
		dorb_crewmenlist = ["BWA3_Crew_Tropen"];
	
		dorb_grouplist_inf = [																									
								configfile >> "CfgGroups" >> "West" >> "Bundeswehr" >> "Infantry_Tropen" >> "Jaegertrupp",
								configfile >> "CfgGroups" >> "West" >> "Bundeswehr" >> "Infantry_Tropen" >> "Panzerabwehrtrupp"
								];
			
		dorb_grouplist_sf = [
								configfile >> "CfgGroups" >> "West" >> "Bundeswehr" >> "Infantry_Tropen" >> "Jaegertrupp"
								];
		
		dorb_grouplist_mech = [];
		
		dorb_grouplist_panz = [	
								configfile >> "CfgGroups" >> "West" >> "Bundeswehr" >> "Mechanized_Tropen" >> "Panzerzug"
								];
	
		dorb_veh_armored 		= [	"BWA3_Leopard2A6M_Tropen","BWA3_Puma_Tropen"];
		dorb_veh_unarmored	= [	"B_MRAP_01_hmg_F","B_MRAP_01_gmg_F"];
		dorb_veh_aa			= [	"B_APC_Tracked_01_AA_F"];
		
		dorb_veh_truck		= ["B_Truck_01_covered_F","B_Truck_01_transport_F"];
		dorb_veh_car			= ["B_MRAP_01_F"];
		dorb_veh_arty			= ["B_MBT_01_arty_F"];
		dorb_veh_mortar		= ["B_Mortar_01_F"];
		
		dorb_staticlist 		= ["B_static_AT_F","B_static_AA_F","B_HMG_01_F","B_HMG_01_high_F","B_GMG_01_F","B_GMG_01_high_F"];
	
		dorb_patrolboatlist 	= ["B_Boat_Armed_01_hmg_F"];
	
		dorb_transport_heli_list = ["B_Heli_Transport_01_F","B_Heli_Transport_03_F"];
		dorb_attack_heli_list 	= ["B_Heli_Attack_01_F"];
		dorb_patrol_air_list 	= ["B_Plane_CAS_01_F"];
		dorb_attack_air_list 	= ["B_Plane_CAS_01_F"];
		dorb_transport_list = [];
	
		dorb_wpncache_list 	= ["Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"];
	};
	case 26: {
	
		dorb_side = west;
		dorb_commandveh_radio = ["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"];
		dorb_commandveh_arty = ["rhsusf_m113_usarmy"];
		dorb_commandveh_side = west;
		dorb_radar = ["rhs_p37","rhs_prv13"];
		dorb_device = ["Land_Device_assembled_F"];
		dorb_commanderlist = ["BWA3_SL_Fleck"];
		dorb_civ_cars = dorb_civ_cars + dorb_civ_cars + ["RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_03"];
		dorb_menlist = [		"BWA3_Rifleman_Fleck",
							"BWA3_RiflemanG27_Fleck", 
							"BWA3_Grenadier_Fleck",
							"BWA3_GrenadierG27_Fleck", 
							"BWA3_Autorifleman_Fleck",
							"BWA3_AutoriflemanMG5_Fleck",
							"BWA3_CombatLifeSaver_Fleck",
							"BWA3_Marksman_Fleck",
							"BWA3_RiflemanG28_Fleck",
							"BWA3_SniperG82_Fleck",
							"BWA3_Spotter_Fleck",
							"BWA3_RiflemanAT_RGW90_Fleck",
							"BWA3_RiflemanAT_Pzf3_Fleck",
							"BWA3_RiflemanAA_Fliegerfaust_Fleck",
							"BWA3_Engineer_Fleck",
							"BWA3_TL_Fleck",
							"BWA3_SL_Fleck",
							"BWA3_Crew_Fleck"];
		dorb_diverlist = ["B_diver_f","B_diver_exp_f","B_diver_TL_f","B_diver_f","B_diver_exp_f","B_diver_f"];
		dorb_crewmenlist = ["BWA3_Crew_Fleck"];
	
		dorb_grouplist_inf = [																									
								configfile >> "CfgGroups" >> "West" >> "Bundeswehr" >> "Infantry_Fleck" >> "Jaegertrupp",
								configfile >> "CfgGroups" >> "West" >> "Bundeswehr" >> "Infantry_Fleck" >> "Panzerabwehrtrupp"
								];
			
		dorb_grouplist_sf = [
								configfile >> "CfgGroups" >> "West" >> "Bundeswehr" >> "Infantry_Fleck" >> "Jaegertrupp"
								];
		
		dorb_grouplist_mech = [];
		
		dorb_grouplist_panz = [	
								configfile >> "CfgGroups" >> "West" >> "Bundeswehr" >> "Mechanized_Fleck" >> "Panzerzug"
								];
	
		dorb_veh_armored 		= [	"BWA3_Leopard2A6M_Fleck","BWA3_Puma_Fleck"];
		dorb_veh_unarmored	= [	"B_MRAP_01_hmg_F","B_MRAP_01_gmg_F"];
		dorb_veh_aa			= [	"B_APC_Tracked_01_AA_F"];
		
		dorb_veh_truck		= ["B_Truck_01_covered_F","B_Truck_01_transport_F"];
		dorb_veh_car			= ["B_MRAP_01_F"];
		dorb_veh_arty			= ["B_MBT_01_arty_F"];
		dorb_veh_mortar		= ["B_Mortar_01_F"];
		
		dorb_staticlist 		= ["B_static_AT_F","B_static_AA_F","B_HMG_01_F","B_HMG_01_high_F","B_GMG_01_F","B_GMG_01_high_F"];
	
		dorb_patrolboatlist 	= ["B_Boat_Armed_01_hmg_F"];
	
		dorb_transport_heli_list = ["B_Heli_Transport_01_F","B_Heli_Transport_03_F"];
		dorb_attack_heli_list 	= ["B_Heli_Attack_01_F"];
		dorb_patrol_air_list 	= ["B_Plane_CAS_01_F"];
		dorb_attack_air_list 	= ["B_Plane_CAS_01_F"];
		dorb_transport_list = [];
	
		dorb_wpncache_list 	= ["Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"];
	};
};

If (DORB_MODS_RDS) then {
	dorb_staticlist_aa	= [
								"RDS_Igla_AA_pod_AAF",
								"RDS_ZU23_AAF"
							];
	dorb_staticlist append [
								"RDS_AGS_AAF",
								"RDS_DSHKM_AAF",
								//"RDS_DSHkM_Mini_TriPod",
								"RDS_KORD_AAF",
								"RDS_KORD_high_AAF",
								"RDS_AGS_AAF",
								"RDS_M2StaticMG_AAF",
								//"RDS_M2StaticMG_MiniTripod_AAF",
								"RDS_Metis_AAF",
								"RDS_MK19_TriPod_AAF",
								"RDS_SPG9_AAF",
								"RDS_TOW_TriPod_AAF"
							];
	dorb_veh_arty		= 	["RDS_D30_AAF","RDS_M119_AAF"];
	dorb_veh_mortar		= 	["RDS_2b14_82mm_AAF","RDS_M252_AAF"];
};

LOG_2(_rand,dorb_side);