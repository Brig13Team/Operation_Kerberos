/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Unitslists
 *
 */
#define SOLDIER_SYS(VAR1,VAR2,VAR3,POS_X,POS_Y,POS_Z) class VAR1 { \
                            vehicle = QUOTE(VAR2); \
                            rank = QUOTE(VAR3); \
                            position[] = {POS_X,POS_Y,POS_Z}; \
                        }
#define SOLDIERR_1(TYPE,RANK) SOLDIER_SYS(soldier_1,TYPE,RANK,0,0,0)
#define SOLDIER_1(TYPE) SOLDIERR_1(TYPE,PRIVATE)
#define SOLDIERR_2(TYPE,RANK) SOLDIER_SYS(soldier_2,TYPE,RANK,-1,-1,0)
#define SOLDIER_2(TYPE) SOLDIERR_2(TYPE,PRIVATE)
#define SOLDIERR_3(TYPE,RANK) SOLDIER_SYS(soldier_3,TYPE,RANK,1,-1,0)
#define SOLDIER_3(TYPE) SOLDIERR_3(TYPE,PRIVATE)
#define SOLDIERR_4(TYPE,RANK) SOLDIER_SYS(soldier_4,TYPE,RANK,-2,-2,0)
#define SOLDIER_4(TYPE) SOLDIERR_4(TYPE,PRIVATE)
#define SOLDIERR_5(TYPE,RANK) SOLDIER_SYS(soldier_5,TYPE,RANK,2,-2,0)
#define SOLDIER_5(TYPE) SOLDIERR_5(TYPE,PRIVATE)
#define SOLDIERR_6(TYPE,RANK) SOLDIER_SYS(soldier_6,TYPE,RANK,-3,-3,0)
#define SOLDIER_6(TYPE) SOLDIERR_6(TYPE,PRIVATE)
#define SOLDIERR_7(TYPE,RANK) SOLDIER_SYS(soldier_7,TYPE,RANK,3,-3,0)
#define SOLDIER_7(TYPE) SOLDIERR_7(TYPE,PRIVATE)
#define SOLDIERR_8(TYPE,RANK) SOLDIER_SYS(soldier_8,TYPE,RANK,-4,-4,0)
#define SOLDIER_8(TYPE) SOLDIERR_8(TYPE,PRIVATE)
#define SOLDIERR_9(TYPE,RANK) SOLDIER_SYS(soldier_9,TYPE,RANK,4,-4,0)
#define SOLDIER_9(TYPE) SOLDIERR_9(TYPE,PRIVATE)
#define SOLDIERR_10(TYPE,RANK) SOLDIER_SYS(soldier_10,TYPE,RANK,-5,-5,0)
#define SOLDIER_10(TYPE) SOLDIERR_10(TYPE,PRIVATE)
#define SOLDIERR_11(TYPE,RANK) SOLDIER_SYS(soldier_11,TYPE,RANK,5,-5,0)
#define SOLDIER_11(TYPE) SOLDIERR_11(TYPE,PRIVATE)
#define SOLDIERR_12(TYPE,RANK) SOLDIER_SYS(soldier_12,TYPE,RANK,-6,-6,0)
#define SOLDIER_12(TYPE) SOLDIERR_12(TYPE,PRIVATE)
#define SOLDIERR_13(TYPE,RANK) SOLDIER_SYS(soldier_13,TYPE,RANK,6,-6,0)
#define SOLDIER_13(TYPE) SOLDIERR_13(TYPE,PRIVATE)
#define SOLDIERR_14(TYPE,RANK) SOLDIER_SYS(soldier_14,TYPE,RANK,-7,-7,0)
#define SOLDIER_14(TYPE) SOLDIERR_14(TYPE,PRIVATE)
#define SOLDIERR_15(TYPE,RANK) SOLDIER_SYS(soldier_15,TYPE,RANK,7,-7,0)
#define SOLDIER_15(TYPE) SOLDIERR_15(TYPE,PRIVATE)

class GVAR(unitlists) {
    class base {
        /*
         * usually only one armytype should be defined.
         * If you don't want to specify an armytype, just make
         * sure, that the type is used in some army
         */
        armytypes[] = {
            "guards", // mainly infanterie with some light vehicles
            "infanterie", // infanterie with some medium vehicles
            "armored", // tanks,
            "airborne", // infanterie with heavy airsupport
            "specops" // skilled infanterie with some specials
        };
        /*
         * possibility to define the camo: 0=all, 1=woodland, 2=desert
         * used in CfgWorlds
         */
        camouflage = 0;
        /*
         * possibility to make armys modspecific so that they won't be loaded if the mod is missing
         */
        cfgPatches[] = {"rhs_main"};

        class mission {
            weaponcache[] = {"Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"};
            pow[] = {"C_scientist_F","C_journalist_F"};
            intel[] = {"Land_File1_F","Land_File2_F","Land_FilePhotos_F","Land_SatellitePhone_F","Land_MobilePhone_smart_F"};
            laptop_open[] = {"Land_Laptop_unfolded_F", "Land_Laptop_device_F"};
            laptop_closed[] = {"Land_Laptop_F"};
            laptop[] = {"Land_Laptop_F", "Land_Laptop_unfolded_F", "Land_Laptop_device_F"};
            case[] = {"Land_Suitcase_F"};
            tower[] = {"Land_TTowerBig_1_F","Land_TTowerBig_2_F"};
            //radar[] = {"rhs_p37","rhs_prv13"};
            radar[] = {"Land_Radar_Small_F"};
            device[] = {"Land_Device_assembled_F","Land_Device_disassembled_F"};
            emp[] = {"rhs_typhoon_vdv"};
            scarab[] = {"rhs_9k79"};
        };
        civ_cars[] = {"C_Offroad_01_F","C_Quadbike_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Offroad_01_F","C_Quadbike_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F","RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_03"};
        civ_smallcars[] = {"C_Offroad_01_F","C_Quadbike_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F"};
    };
    class base_east : base {
        cfgPatches[] = {"rhs_main"};
        class mission: mission {
            prototype[] = {"B_MBT_01_TUSK_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F"};
            commander[] = {"rhs_vdv_officer"};
            hq_mobile[] = {"rhs_gaz66_r142_vdv"};
            wreck_air[] = {"rhs_Mi8mt_vdv","rhs_Mi8mt_Cargo_vdv","rhs_Mi8MTV3_vdv","rhs_Mi8MTV3_UPK23_vdv","rhs_Mi8MTV3_FAB_vdv","rhs_Mi8AMT_vdv"};
            konvoi[] = {"rhs_t72ba_tv","rhs_gaz66_vdv","rhs_btr80a_vdv","rhs_zsu234_aa"};
            supplys[] = {"B_Slingload_01_Cargo_F","B_Slingload_01_Fuel_F","B_Slingload_01_Medevac_F","B_Slingload_01_Repair_F"};
            chopper[] = {"rhs_mi28n_vvsc"};
        };
        attack_uavs[] = {"O_UAV_02_F","O_T_UAV_04_CAS_F"};
        recon_uavs[] = {"rhs_pchela1t_vvs","O_UAV_01_F"};
        static[] = {"RHS_NSV_TriPod_VDV","RHS_AGS30_TriPod_VDV","rhs_Igla_AA_pod_vdv","rhs_KORD_high_VDV","rhs_KORD_VDV","rhs_Metis_9k115_2_vdv"};
        static_high[] = {"rhs_KORD_high_VDV"};
        static_aa[] = {"rhs_Igla_AA_pod_vdv"};
        art_mortar[] = {"rhs_2b14_82mm_vdv"};
        art_shells[] = {"rhs_D30_vdv"};
        art_rocket[] = {"RHS_BM21_VDV_01"};

        trucks[] = {"RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01","rhs_gaz66_vdv","rhs_gaz66o_vdv"};
        ifv[] = {"rhs_bmp2k_msv","rhs_bmp2_msv"};
        cars[] = {"rhs_tigr_VDV","rhs_tigr_ffv_vdv","rhs_tigr_3camo_vdv","rhs_tigr_ffv_3camo_vdv"};
        tanks[] = {"rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv"};
        divers[] = {"O_diver_f","O_diver_exp_f","O_diver_TL_f","O_diver_f","O_diver_exp_f","O_diver_f"};
        boats[] = {"O_Boat_Armed_01_hmg_F"};

        soldiers[] = {"rhs_vdv_aa","rhs_vdv_arifleman","rhs_vdv_at","rhs_vdv_efreitor","rhs_vdv_engineer",
                    "rhs_vdv_grenadier","rhs_vdv_grenadier_rpg","rhs_vdv_junior_sergeant","rhs_vdv_LAT",
                    "rhs_vdv_machinegunner","rhs_vdv_machinegunner_assistant","rhs_vdv_marksman",
                    "rhs_vdv_marksman_asval","rhs_vdv_medic","rhs_vdv_officer","rhs_vdv_recon_at",
                    "rhs_vdv_recon_marksman","rhs_vdv_recon_marksman_asval","rhs_vdv_recon_sergeant",
                    "rhs_vdv_rifleman","rhs_vdv_rifleman_asval","rhs_vdv_RShG2","rhs_vdv_sergeant","rhs_vdv_strelok_rpg_assist"};

        crewmen[] = {"rhs_vdv_officer_armored","rhs_vdv_combatcrew","rhs_vdv_crew","rhs_vdv_armoredcrew",
                    "rhs_vdv_crew_commander","rhs_vdv_driver","rhs_vdv_driver_armored"};

        class callIn {

            supply_infanterie = 1;
            supply_mounted = 1;
            supply_tanks = 1;
            supply_sniper = 1;
            supply_mechanized = 1;

            supply_airdrop = 0;
            supply_airdrop_types[] = {"rhs_Mi8mt_vdv","rhs_Mi8mt_Cargo_vdv","rhs_Mi8MTV3_vdv","rhs_Mi8MTV3_UPK23_vdv","rhs_Mi8MTV3_FAB_vdv","rhs_Mi8AMT_vdv"};
            supply_airdrop_typesGroup[] = {
                "configfile", "CfgGroups", "East", "rhs_faction_vdv", "rhs_group_rus_vdv_infantry", "rhs_group_rus_vdv_infantry_squad_sniper",
                "configfile", "CfgGroups", "East", "rhs_faction_vdv", "rhs_group_rus_vdv_infantry", "rhs_group_rus_vdv_infantry_squad_mg_sniper",
                "configfile", "CfgGroups", "East", "rhs_faction_vdv", "rhs_group_rus_vdv_infantry", "rhs_group_rus_vdv_infantry_squad_2mg",
                "configfile", "CfgGroups", "East", "rhs_faction_vdv", "rhs_group_rus_vdv_infantry", "rhs_group_rus_vdv_infantry_squad"
            };
            supply_tankdrop = 0;

            cas_types[] = {"RHS_Su25SM_vvs","RHS_Su25SM_vvsc"};
            //cas_types[] = {"O_Plane_CAS_02_dynamicLoadout_F"};
            cas_cluster = 1;
            cas_cluster_types[] = {"O_Plane_CAS_02_dynamicLoadout_F"};
            cas_gun = 1;
            cas_missiles = 1;
            cas_drones = 0;
            cas_drones_types[] = {"O_T_UAV_04_CAS_F","B_UAV_02_F"};


            cas_helicopter = 1;
            cas_helicopter_types[] = {"rhs_mi28n_vvsc"};

            ai = 1;
            ai_types[] = {"RHS_T50_vvs_054","RHS_T50_vvs_053","RHS_T50_vvs_052"};
            //ai_types[] = {"O_Plane_Fighter_02_Stealth_F"};

            group_infantry[] = {
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_fireteam"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_MANEUVER"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_section_AA"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_section_AT"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_section_mg"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_squad"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_squad_2mg"}
            };
        };


        class groups {
            groups_patrol[] = {
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_section_AA"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_section_AT"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_section_marksman"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_section_mg"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_squad"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_squad_2mg"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_squad_mg_sniper"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_squad_sniper"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_fireteam"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_MANEUVER"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad_2mg"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad_mg_sniper"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad_sniper"}
            };
            groups_attack[] = {
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_BTR80a","rhs_group_rus_vdv_BTR80a_squad"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_BTR80a","rhs_group_rus_vdv_BTR80a_squad_2mg"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_BTR80a","rhs_group_rus_vdv_BTR80a_squad_aa"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_BTR80a","rhs_group_rus_vdv_BTR80a_squad_mg_sniper"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_BTR80a","rhs_group_rus_vdv_BTR80a_squad_sniper"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_btr70","rhs_group_rus_vdv_btr70_squad"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_btr70","rhs_group_rus_vdv_btr70_squad_2mg"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_btr70","rhs_group_rus_vdv_btr70_squad_aa"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_btr70","rhs_group_rus_vdv_btr70_squad_mg_sniper"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_btr70","rhs_group_rus_vdv_btr70_squad_sniper"},
                {"configfile","CfgGroups","East","rhs_faction_tv","rhs_group_rus_tv_72","RHS_T72BDSection"},
                {"configfile","CfgGroups","East","rhs_faction_tv","rhs_group_rus_tv_72","RHS_T72BCSection"},
                {"configfile","CfgGroups","East","rhs_faction_tv","rhs_group_rus_tv_72","RHS_T72BBSection"},
                {"configfile","CfgGroups","East","rhs_faction_tv","rhs_group_rus_tv_72","RHS_T72BASection"},
                {"configfile","CfgGroups","East","rhs_faction_tv","rhs_group_rus_tv_80","RHS_T80ASection"},
                {"configfile","CfgGroups","East","rhs_faction_tv","rhs_group_rus_tv_80","RHS_T80BSection"},
                {"configfile","CfgGroups","East","rhs_faction_tv","rhs_group_rus_tv_80","RHS_T80BVSection"},
                {"configfile","CfgGroups","East","rhs_faction_tv","rhs_group_rus_tv_80","RHS_T80Section"},
                {"configfile","CfgGroups","East","rhs_faction_tv","rhs_group_rus_tv_80","rhs_t80u45mSection"},
                {"configfile","CfgGroups","East","rhs_faction_tv","rhs_group_rus_tv_80","rhs_t80ue1Section"},
                {"configfile","CfgGroups","East","rhs_faction_tv","rhs_group_rus_tv_80","RHS_T80USection"}
            };
            groups_defence[] = {
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_fireteam"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_MANEUVER"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_section_AA"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_section_AT"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_section_marksman"},
                {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry","rhs_group_rus_vdv_infantry_section_mg"}
            };
            groups_mechanized[] = {
                {"configfile","CfgGroups","East","rhs_faction_vmf","rhs_group_rus_vmf_BTR80","rhs_group_rus_vmf_BTR80_squad"},
                {"configfile","CfgGroups","East","rhs_faction_vmf","rhs_group_rus_vmf_BTR80","rhs_group_rus_vmf_BTR80_squad_2mg"},
                {"configfile","CfgGroups","East","rhs_faction_vmf","rhs_group_rus_vmf_BTR80","rhs_group_rus_vmf_BTR80_squad_aa"},
                {"configfile","CfgGroups","East","rhs_faction_vmf","rhs_group_rus_vmf_BTR80","rhs_group_rus_vmf_BTR80_squad_mg_sniper"},
                {"configfile","CfgGroups","East","rhs_faction_vmf","rhs_group_rus_vmf_BTR80","rhs_group_rus_vmf_BTR80_squad_sniper"}
            };
            groups_sniper[] = {};
            // own groups
            class patrol {
                class E_Reg_Pat_01 {
                    SOLDIERR_1(rhs_vdv_sergeant,SERGEANT);
                    SOLDIERR_2(rhs_vdv_junior_sergeant,CORPORAL);
                    SOLDIER_3(rhs_vdv_rifleman);
                    SOLDIER_4(rhs_vdv_rifleman);
                    SOLDIER_5(rhs_vdv_grenadier_rpg);
                    SOLDIER_6(rhs_vdv_grenadier);
                };
                class E_Reg_Pat_02 {
                    SOLDIERR_1(rhs_vdv_sergeant,SERGEANT);
                    SOLDIERR_2(rhs_vdv_junior_sergeant,CORPORAL);
                    SOLDIER_3(rhs_vdv_marksman);
                    SOLDIER_4(rhs_vdv_marksman);
                    SOLDIER_5(rhs_vdv_medic);
                };
                class E_Reg_Pat_03 {
                    SOLDIERR_1(rhs_vdv_junior_sergeant,CORPORAL);
                    SOLDIER_2(rhs_vdv_medic);
                    SOLDIER_3(rhs_vdv_machinegunner);
                    SOLDIER_4(rhs_vdv_machinegunner_assistant);
                    SOLDIER_5(rhs_vdv_grenadier_rpg);
                    SOLDIER_6(rhs_vdv_aa);
                };
                class E_Reg_Pat_04 {
                    SOLDIERR_1(rhs_vdv_sergeant,SERGEANT);
                    SOLDIERR_2(rhs_vdv_junior_sergeant,CORPORAL);
                    SOLDIER_3(rhs_vdv_LAT);
                    SOLDIER_4(rhs_vdv_LAT);
                    SOLDIER_5(rhs_vdv_medic);
                    SOLDIER_6(rhs_vdv_grenadier);
                };
            };
            class strikeforce {
                class E_Reg_Att_01 {
                    SOLDIERR_1(rhs_vdv_sergeant,SERGEANT);
                    SOLDIERR_2(rhs_vdv_junior_sergeant,CORPORAL);
                    SOLDIER_3(rhs_vdv_LAT);
                    SOLDIER_4(rhs_vdv_LAT);
                    SOLDIER_5(rhs_vdv_medic);
                    SOLDIER_6(rhs_vdv_grenadier);
                    SOLDIER_7(rhs_vdv_grenadier);
                };
                class E_Reg_Att_02 {
                    SOLDIERR_1(rhs_vdv_junior_sergeant,CORPORAL);
                    SOLDIER_2(rhs_vdv_medic);
                    SOLDIER_3(rhs_vdv_machinegunner);
                    SOLDIER_4(rhs_vdv_machinegunner_assistant);
                    SOLDIER_5(rhs_vdv_grenadier_rpg);
                    SOLDIER_6(rhs_vdv_grenadier_rpg);
                    SOLDIER_7(rhs_vdv_aa);
                };
                class E_Reg_Att_03 {
                    SOLDIER_1(rhs_btr80a_vdv);
                    SOLDIERR_2(rhs_vdv_junior_sergeant,CORPORAL);
                    SOLDIER_3(rhs_vdv_rifleman);
                    SOLDIER_4(rhs_vdv_rifleman);
                    SOLDIER_5(rhs_vdv_rifleman);
                    SOLDIER_6(rhs_vdv_grenadier);
                    SOLDIER_7(rhs_vdv_grenadier);
                    SOLDIER_8(rhs_vdv_grenadier_rpg);
                    SOLDIER_9(rhs_vdv_grenadier_rpg);
                    SOLDIER_10(rhs_vdv_medic);
                    SOLDIER_11(rhs_vdv_medic);
                    SOLDIER_12(rhs_vdv_rifleman);
                    SOLDIER_13(rhs_vdv_rifleman);
                };
                class E_Reg_Att_04 {
                    SOLDIER_1(rhs_t90a_tv);
                };
            };
            class defence {
                class E_Reg_def_01 {
                    SOLDIERR_1(rhs_vdv_junior_sergeant,CORPORAL);
                    SOLDIER_2(rhs_vdv_medic);
                    SOLDIER_3(rhs_vdv_machinegunner);
                    SOLDIER_4(rhs_vdv_machinegunner_assistant);
                    SOLDIER_5(rhs_vdv_grenadier_rpg);
                };
                class E_Reg_def_02 {
                    SOLDIERR_1(rhs_vdv_sergeant,SERGEANT);
                    SOLDIERR_2(rhs_vdv_junior_sergeant,CORPORAL);
                    SOLDIER_3(rhs_vdv_at);
                    SOLDIER_4(rhs_vdv_at);
                    SOLDIER_5(rhs_vdv_LAT);
                    SOLDIER_6(rhs_vdv_rifleman);
                };
                class E_Reg_def_03 {
                    SOLDIERR_1(rhs_vdv_junior_sergeant,CORPORAL);
                    SOLDIER_2(rhs_vdv_medic);
                    SOLDIER_3(rhs_vdv_aa);
                    SOLDIER_4(rhs_vdv_aa);
                    SOLDIER_5(rhs_vdv_strelok_rpg_assist);
                    SOLDIER_6(rhs_vdv_strelok_rpg_assist);
                };
            };
            class sniper {
                class E_Snip_01 {
                    SOLDIERR_1(O_ghillie_ard_F,CORPORAL);
                    SOLDIER_2(O_ghillie_ard_F);
                    SOLDIER_3(O_ghillie_ard_F);

                };
            };
        };
    };
    class east {
        class vanilla : base_east {
            camouflage = 0;
            cfgPatches[] = {};
            armytypes[] = {"guards","infanterie","armored","airborne","specops"};
            class mission : mission {
                radar[] = {"Land_Radar_Small_F"};
                emp[] = {"O_Truck_03_device_F"};
                scarab[] = {};
                commander[] = {"O_Officer_F"};
                hq_mobile[] = {"O_Truck_03_covered_F"};
                wreck_air[] = {"Land_Wrack_Heli_Attack_01_F"};
                konvoi[] = {"O_MBT_02_cannon_F","O_APC_Tracked_02_AA_F","O_APC_Tracked_02_cannon_F","O_MBT_02_cannon_F"};
                chopper[] = {"O_Heli_Attack_02_dynamicLoadout_F"};
            };
            attack_uavs[] = {"O_UAV_02_F","O_T_UAV_04_CAS_F"};
            recon_uavs[] = {"O_UAV_01_F"};
            static[] = {"O_HMG_01_F","O_static_AA_F","O_static_AT_F","O_GMG_01_F","O_GMG_01_high_F","O_HMG_01_high_F"};
            static_high[] = {"O_GMG_01_high_F","O_HMG_01_high_F"};
            static_aa[] = {"O_static_AA_F"};
            art_mortar[] = {"O_Mortar_01_F"};
            art_shells[] = {"O_MBT_02_arty_F"};
            art_rocket[] = {"O_MBT_02_arty_F"};
            trucks[] = {"O_Truck_02_covered_F","O_Truck_02_transport_F"};
            ifv[] = {"O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F"};
            cars[] = {"O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_MRAP_02_F"};
            tanks[] = {"O_MBT_02_cannon_F"};
            divers[] = {"O_diver_f","O_diver_exp_f","O_diver_TL_f","O_diver_f","O_diver_exp_f","O_diver_f"};
            boats[] = {"O_Boat_Armed_01_hmg_F"};
            soldiers[] = {"O_Soldier_02_F","O_Soldier_A_F","O_Soldier_AA_F","O_Soldier_AAA_F","O_Soldier_AAR_F",
                        "O_Soldier_AAT_F","O_Soldier_AR_F","O_Soldier_AT_F","O_soldier_exp_F",
                        "O_Soldier_GL_F","O_Soldier_LAT_F","O_Soldier_lite_F",
                        "O_soldier_M_F","O_soldier_PG_F","O_soldier_repair_F","O_Soldier_SL_F",
                        "O_Soldier_TL_F","O_soldier_UAV_F","O_Soldier_universal_F"};
            crewmen[] = {"O_crew_F"};
            class callIn : callIn {
                supplyarray[] = {{"infanterie",1},{"airdrop",1},{"mounted",1},{"sniper",1},{"tanks",1},{"mechanized",1}};
                helicopter_transport[] = {"O_Heli_Transport_04_bench_F"};
                cas_helicopter_types[] = {"O_Heli_Attack_02_dynamicLoadout_F"};
                ai_types[] = {"O_Plane_Fighter_02_Stealth_F"};
                cas_types[] = {"O_Plane_CAS_02_dynamicLoadout_F"};
                amountHeli = 1;
                amountAI = 1;
                amountCAS = 1;
                group_infantry[] = {
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfSquad"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfSquad_Weapons"}
                };
            };


            class groups {
                groups_patrol[] = {
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OI_reconPatrol"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OI_reconTeam"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_ReconSquad"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfTeam_AA"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfTeam_AT"}

                };
                groups_attack[] = {
                    {"configfile","CfgGroups","East","OPF_F","Motorized_MTP","OIA_MotInf_AA"},
                    {"configfile","CfgGroups","East","OPF_F","Motorized_MTP","OIA_MotInf_AT"},
                    {"configfile","CfgGroups","East","OPF_F","Motorized_MTP","OIA_MotInf_Reinforce"},
                    {"configfile","CfgGroups","East","OPF_F","Motorized_MTP","OIA_MotInf_Team"},

                    {"configfile","CfgGroups","East","OPF_F","Armored","OIA_TankSection"},
                    {"configfile","CfgGroups","East","OPF_F","Armored","OIA_TankPlatoon"},
                    {"configfile","CfgGroups","East","OPF_F","Armored","OIA_TankPlatoon_AA"},

                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfAssault"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfSentry"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfSquad"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfTeam_AA"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfTeam"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfTeam_AA"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfTeam_AT"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfTeam_AA"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OI_recon_EOD"},

                    {"configfile","CfgGroups","East","OPF_F","Mechanized","OIA_MechInf_AA"},
                    {"configfile","CfgGroups","East","OPF_F","Mechanized","OIA_MechInf_AA"},
                    {"configfile","CfgGroups","East","OPF_F","Mechanized","OIA_MechInf_AA"}
                };
                groups_defence[] = {
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfTeam"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfTeam_AA"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfTeam_AT"},
                    {"configfile","CfgGroups","East","OPF_F","Infantry","OIA_InfTeam_AA"}
                };
                groups_mechanized[] = {
                    {"configfile","CfgGroups","East","OPF_F","Mechanized","OIA_MechInf_AA"},
                    {"configfile","CfgGroups","East","OPF_F","Mechanized","OIA_MechInf_AT"},
                    {"configfile","CfgGroups","East","OPF_F","Mechanized","OIA_MechInf_Support"},
                    {"configfile","CfgGroups","East","OPF_F","Mechanized","OIA_MechInfSquad"}
                };
                groups_sniper[] = {};
                class patrol {};
                class strikeforce {};
                class defence {};
                class sniper {
                    class E_Snip_01 {
                        SOLDIERR_1(O_ghillie_ard_F,CORPORAL);
                        SOLDIER_2(O_ghillie_ard_F);
                        SOLDIER_3(O_ghillie_ard_F);
                    };
                };
            };
        };
        class msv : base_east {
            armytypes[] = {"infanterie"};
            static[] = {"RHS_NSV_TriPod_MSV","RHS_AGS30_TriPod_MSV","rhs_Igla_AA_pod_MSV","rhs_KORD_high_MSV","rhs_KORD_MSV","rhs_Metis_9k115_2_MSV"};
            static_high[] = {"rhs_KORD_high_MSV"};
            static_aa[] = {"rhs_Igla_AA_pod_MSV"};
            art_mortar[] = {"rhs_2b14_82mm_MSV"};
            art_shells[] = {"rhs_2s3_tv"};
            art_rocket[] = {"RHS_BM21_MSV_01"};

            trucks[] = {"RHS_Ural_MSV_01","RHS_Ural_Open_MSV_01","rhs_gaz66_MSV","rhs_gaz66o_MSV"};
            cars[] = {"rhs_tigr_MSV","rhs_tigr_ffv_MSV","rhs_tigr_3camo_MSV","rhs_tigr_ffv_3camo_MSV"};
            ifv[] = {"rhs_bmp2k_msv","rhs_bmp2_msv"};
            tanks[] = {"rhs_Ob_681_2"};
            soldiers[] = {
                "rhs_msv_emr_rifleman","rhs_msv_emr_LAT","rhs_msv_emr_RShG2","rhs_msv_emr_grenadier","rhs_msv_emr_arifleman","rhs_msv_emr_machinegunner",
                "rhs_msv_emr_machinegunner_assistant","rhs_msv_emr_grenadier_rpg","rhs_msv_emr_strelok_rpg_assist","rhs_msv_emr_marksman","rhs_msv_emr_efreitor",
                "rhs_msv_emr_sergeant","rhs_msv_emr_junior_sergeant","rhs_msv_emr_officer","rhs_msv_emr_at","rhs_msv_emr_aa","rhs_msv_emr_engineer","rhs_msv_emr_medic"
            };
            crewmen[] = {"rhs_msv_emr_driver_armored","rhs_msv_emr_driver","rhs_msv_emr_crew","rhs_msv_emr_armoredcrew","rhs_msv_emr_combatcrew","rhs_msv_emr_crew_commander"};
            class callIn : callIn {
                group_infantry[] = {
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_emr","rhs_group_rus_MSV_infantry_emr_fireteam"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_emr","rhs_group_rus_MSV_infantry_emr_MANEUVER"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_emr","rhs_group_rus_MSV_infantry_emr_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_emr","rhs_group_rus_MSV_infantry_emr_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_emr","rhs_group_rus_MSV_infantry_emr_section_mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_emr","rhs_group_rus_MSV_infantry_emr_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_emr","rhs_group_rus_MSV_infantry_emr_squad_2mg"}
                };
                supply_infanterie = 1;
                supply_mounted = 1;
                supply_tanks = 0.2;
                supply_sniper = 0.5;
                supply_mechanized = 0.5;

                supply_airdrop = 0;
                supply_tankdrop = 0;

                cas_cluster = 0;
                cas_gun = 0;
                cas_missiles = 0;
                cas_drones = 0;

                cas_helicopter = 1;
                ai = 1;

            };
            class groups : groups {
                groups_patrol[] = {
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_recon","rhs_group_rus_MSV_infantry_recon_fireteam"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_recon","rhs_group_rus_MSV_infantry_recon_MANEUVER"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_recon","rhs_group_rus_MSV_infantry_recon_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_recon","rhs_group_rus_MSV_infantry_recon_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_recon","rhs_group_rus_MSV_infantry_recon_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_recon","rhs_group_rus_MSV_infantry_recon_squad_sniper"}
                };
                groups_attack[] = {
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_marksman"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_marksman"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_sniper"}
                };
                groups_defence[] = {
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_fireteam"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_MANEUVER"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_marksman"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_mg"}
                };

                // own groups
                class patrol {
                    class E_Reg_Pat_01 {
                        SOLDIERR_1(rhs_msv_sergeant,SERGEANT);
                        SOLDIERR_2(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_msv_rifleman);
                        SOLDIER_4(rhs_msv_rifleman);
                        SOLDIER_5(rhs_msv_grenadier_rpg);
                        SOLDIER_6(rhs_msv_grenadier);
                    };
                    class E_Reg_Pat_02 {
                        SOLDIERR_1(rhs_msv_sergeant,SERGEANT);
                        SOLDIERR_2(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_msv_marksman);
                        SOLDIER_4(rhs_msv_marksman);
                        SOLDIER_5(rhs_msv_medic);
                    };
                    class E_Reg_Pat_03 {
                        SOLDIERR_1(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_2(rhs_msv_medic);
                        SOLDIER_3(rhs_msv_machinegunner);
                        SOLDIER_4(rhs_msv_machinegunner_assistant);
                        SOLDIER_5(rhs_msv_grenadier_rpg);
                        SOLDIER_6(rhs_msv_aa);
                    };
                    class E_Reg_Pat_04 {
                        SOLDIERR_1(rhs_msv_sergeant,SERGEANT);
                        SOLDIERR_2(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_msv_LAT);
                        SOLDIER_4(rhs_msv_LAT);
                        SOLDIER_5(rhs_msv_medic);
                        SOLDIER_6(rhs_msv_grenadier);
                    };
                };
                class strikeforce {
                    class E_Reg_Att_01 {
                        SOLDIERR_1(rhs_msv_sergeant,SERGEANT);
                        SOLDIERR_2(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_msv_LAT);
                        SOLDIER_4(rhs_msv_LAT);
                        SOLDIER_5(rhs_msv_medic);
                        SOLDIER_6(rhs_msv_grenadier);
                        SOLDIER_7(rhs_msv_grenadier);
                    };
                    class E_Reg_Att_02 {
                        SOLDIERR_1(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_2(rhs_msv_medic);
                        SOLDIER_3(rhs_msv_machinegunner);
                        SOLDIER_4(rhs_msv_machinegunner_assistant);
                        SOLDIER_5(rhs_msv_grenadier_rpg);
                        SOLDIER_6(rhs_msv_grenadier_rpg);
                        SOLDIER_7(rhs_msv_aa);
                    };
                    class E_Reg_Att_03 {
                        SOLDIERR_1(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_2(rhs_msv_rifleman);
                        SOLDIER_3(rhs_msv_rifleman);
                        SOLDIER_4(rhs_msv_rifleman);
                        SOLDIER_5(rhs_msv_rifleman);
                        SOLDIER_6(rhs_msv_grenadier);
                        SOLDIER_7(rhs_msv_grenadier);
                        SOLDIER_8(rhs_msv_grenadier_rpg);
                        SOLDIER_9(rhs_msv_grenadier_rpg);
                        SOLDIER_10(rhs_msv_medic);
                        SOLDIER_11(rhs_msv_medic);
                        SOLDIER_12(rhs_msv_rifleman);
                        SOLDIER_13(rhs_msv_rifleman);
                    };
                    class E_Reg_Att_04 {
                        SOLDIER_1(rhs_t90a_tv);
                    };
                    class E_Reg_Att_05 {
                        SOLDIER_1(rhs_t72ba_tv);
                        SOLDIER_6(rhs_t72bc_tv);
                    };
                    class E_Reg_Att_06 {
                        SOLDIER_1(rhs_t72bb_tv);
                        SOLDIER_6(rhs_t72bd_tv);
                    };
                    class E_Reg_Att_07 {
                        SOLDIER_1(rhs_t80u45m);
                    };
                    class E_Reg_Att_08 {
                        SOLDIER_1(rhs_t80uk);
                    };
                    class E_Reg_Att_09 {
                        SOLDIER_1(RHS_ZU23_MSV);
                    };
                    class E_Reg_Att_10 {
                        SOLDIER_1(rhs_zsu234_aa);
                    };
                    class E_Reg_Att_11 {
                        SOLDIER_1(rhs_btr70_msv);
                    };
                    class E_Reg_Att_12 {
                        SOLDIER_1(rhs_btr80a_msv);
                    };
                    class E_Reg_Att_13 {
                        SOLDIER_1(rhs_bmp2e_msv);
                    };
                    class E_Reg_Att_14 {
                        SOLDIER_1(rhs_bmp2d_msv);
                    };
                    class E_Reg_Att_15 {
                        SOLDIER_1(rhs_bmp1d_msv);
                    };
                };
                class defence {
                    class E_Reg_def_01 {
                        SOLDIERR_1(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_2(rhs_msv_medic);
                        SOLDIER_3(rhs_msv_machinegunner);
                        SOLDIER_4(rhs_msv_machinegunner_assistant);
                        SOLDIER_5(rhs_msv_grenadier_rpg);
                    };
                    class E_Reg_def_02 {
                        SOLDIERR_1(rhs_msv_sergeant,SERGEANT);
                        SOLDIERR_2(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_msv_at);
                        SOLDIER_4(rhs_msv_at);
                        SOLDIER_5(rhs_msv_LAT);
                        SOLDIER_6(rhs_msv_rifleman);
                    };
                    class E_Reg_def_03 {
                        SOLDIERR_1(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_2(rhs_msv_medic);
                        SOLDIER_3(rhs_msv_aa);
                        SOLDIER_4(rhs_msv_aa);
                        SOLDIER_5(rhs_msv_strelok_rpg_assist);
                        SOLDIER_6(rhs_msv_strelok_rpg_assist);
                    };
                };
            };
        };
        class vdv : base_east {
            armytypes[] = {"airborne"};
            static[] = {"RHS_NSV_TriPod_VDV","RHS_AGS30_TriPod_VDV","rhs_Igla_AA_pod_VDV","rhs_KORD_high_VDV","rhs_KORD_VDV","rhs_Metis_9k115_2_VDV"};
            static_high[] = {"rhs_KORD_high_VDV"};
            static_aa[] = {"rhs_Igla_AA_pod_VDV"};
            art_mortar[] = {"rhs_2b14_82mm_VDV"};
            art_shells[] = {"rhs_D30_VDV"};
            art_rocket[] = {"RHS_BM21_VDV_01"};

            trucks[] = {"RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01","rhs_gaz66_VDV","rhs_gaz66o_VDV"};
            cars[] = {"rhs_tigr_VDV","rhs_tigr_ffv_VDV","rhs_tigr_3camo_VDV","rhs_tigr_ffv_3camo_VDV"};
            tanks[] = {"rhs_sprut_vdv"};
            soldiers[] = {
                "rhs_VDV_rifleman","rhs_VDV_LAT","rhs_VDV_RShG2","rhs_VDV_grenadier","rhs_VDV_arifleman","rhs_VDV_machinegunner",
                "rhs_VDV_machinegunner_assistant","rhs_VDV_grenadier_rpg","rhs_VDV_strelok_rpg_assist","rhs_VDV_marksman","rhs_VDV_efreitor",
                "rhs_VDV_sergeant","rhs_VDV_junior_sergeant","rhs_VDV_officer","rhs_VDV_at","rhs_VDV_aa","rhs_VDV_engineer","rhs_VDV_medic"
            };
            crewmen[] = {"rhs_VDV_driver_armored","rhs_VDV_driver","rhs_VDV_crew","rhs_VDV_armoredcrew","rhs_VDV_combatcrew","rhs_VDV_crew_commander"};
            class callIn : callIn {
                group_infantry[] = {
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_emr","rhs_group_rus_VDV_infantry_emr_fireteam"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_emr","rhs_group_rus_VDV_infantry_emr_MANEUVER"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_emr","rhs_group_rus_VDV_infantry_emr_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_emr","rhs_group_rus_VDV_infantry_emr_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_emr","rhs_group_rus_VDV_infantry_emr_section_mg"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_emr","rhs_group_rus_VDV_infantry_emr_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_emr","rhs_group_rus_VDV_infantry_emr_squad_2mg"}
                };

                supply_infanterie = 0;
                supply_mounted = 0;
                supply_tanks = 0;
                supply_sniper = 0;
                supply_mechanized = 0;

                supply_airdrop = 1;
                supply_tankdrop = 1;

                cas_cluster = 1;
                cas_gun = 1;
                cas_missiles = 1;
                cas_drones = 0;

                cas_helicopter = 1;
                ai = 1;
            };
            class groups : groups {
                groups_patrol[] = {
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_recon","rhs_group_rus_VDV_infantry_recon_fireteam"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_recon","rhs_group_rus_VDV_infantry_recon_MANEUVER"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_recon","rhs_group_rus_VDV_infantry_recon_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_recon","rhs_group_rus_VDV_infantry_recon_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_recon","rhs_group_rus_VDV_infantry_recon_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_recon","rhs_group_rus_VDV_infantry_recon_squad_sniper"}
                };
                groups_attack[] = {
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_marksman"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_mg"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_squad_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_marksman"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_mg"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_squad_sniper"}
                };
                groups_defence[] = {
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_fireteam"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_MANEUVER"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_marksman"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_mg"}
                };

                // own groups
                class patrol {
                    class E_Reg_Pat_01 {
                        SOLDIERR_1(rhs_vdv_sergeant,SERGEANT);
                        SOLDIERR_2(rhs_vdv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_vdv_rifleman);
                        SOLDIER_4(rhs_vdv_rifleman);
                        SOLDIER_5(rhs_vdv_grenadier_rpg);
                        SOLDIER_6(rhs_vdv_grenadier);
                    };
                    class E_Reg_Pat_02 {
                        SOLDIERR_1(rhs_vdv_sergeant,SERGEANT);
                        SOLDIERR_2(rhs_vdv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_vdv_marksman);
                        SOLDIER_4(rhs_vdv_marksman);
                        SOLDIER_5(rhs_vdv_medic);
                    };
                    class E_Reg_Pat_03 {
                        SOLDIERR_1(rhs_vdv_junior_sergeant,CORPORAL);
                        SOLDIER_2(rhs_vdv_medic);
                        SOLDIER_3(rhs_vdv_machinegunner);
                        SOLDIER_4(rhs_vdv_machinegunner_assistant);
                        SOLDIER_5(rhs_vdv_grenadier_rpg);
                        SOLDIER_6(rhs_vdv_aa);
                    };
                    class E_Reg_Pat_04 {
                        SOLDIERR_1(rhs_vdv_sergeant,SERGEANT);
                        SOLDIERR_2(rhs_vdv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_vdv_LAT);
                        SOLDIER_4(rhs_vdv_LAT);
                        SOLDIER_5(rhs_vdv_medic);
                        SOLDIER_6(rhs_vdv_grenadier);
                    };
                };
                class strikeforce {
                    class E_Reg_Att_01 {
                        SOLDIERR_1(rhs_vdv_sergeant,SERGEANT);
                        SOLDIERR_2(rhs_vdv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_vdv_LAT);
                        SOLDIER_4(rhs_vdv_LAT);
                        SOLDIER_5(rhs_vdv_medic);
                        SOLDIER_6(rhs_vdv_grenadier);
                        SOLDIER_7(rhs_vdv_grenadier);
                    };
                    class E_Reg_Att_02 {
                        SOLDIERR_1(rhs_vdv_junior_sergeant,CORPORAL);
                        SOLDIER_2(rhs_vdv_medic);
                        SOLDIER_3(rhs_vdv_machinegunner);
                        SOLDIER_4(rhs_vdv_machinegunner_assistant);
                        SOLDIER_5(rhs_vdv_grenadier_rpg);
                        SOLDIER_6(rhs_vdv_grenadier_rpg);
                        SOLDIER_7(rhs_vdv_aa);
                    };
                    class E_Reg_Att_03 {
                        SOLDIER_1(rhs_btr80a_vdv);
                        SOLDIERR_2(rhs_vdv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_vdv_rifleman);
                        SOLDIER_4(rhs_vdv_rifleman);
                        SOLDIER_5(rhs_vdv_rifleman);
                        SOLDIER_6(rhs_vdv_grenadier);
                        SOLDIER_7(rhs_vdv_grenadier);
                        SOLDIER_8(rhs_vdv_grenadier_rpg);
                        SOLDIER_9(rhs_vdv_grenadier_rpg);
                        SOLDIER_10(rhs_vdv_medic);
                        SOLDIER_11(rhs_vdv_medic);
                        SOLDIER_12(rhs_vdv_rifleman);
                        SOLDIER_13(rhs_vdv_rifleman);
                    };
                    class E_Reg_Att_04 {
                        SOLDIER_1(rhs_sprut_vdv);
                    };
                    class E_Reg_Att_05 {
                        SOLDIER_1(rhs_sprut_vdv);
                    };
                    class E_Reg_Att_06 {
                        SOLDIER_1(rhs_bmd4ma_vdv);
                    };
                    class E_Reg_Att_07 {
                        SOLDIER_1(rhs_bmp2d_vdv);
                    };
                    class E_Reg_Att_08 {
                        SOLDIER_1(rhs_bmp1p_vdv);
                    };
                    class E_Reg_Att_09 {
                        SOLDIER_1(rhs_brm1k_vdv);
                    };
                    class E_Reg_Att_10 {
                        SOLDIER_1(rhs_btr60_vdv);
                    };
                    class E_Reg_Att_11 {
                        SOLDIER_1(rhs_btr80a_vdv);
                    };
                };
                class defence {
                    class E_Reg_def_01 {
                        SOLDIERR_1(rhs_vdv_junior_sergeant,CORPORAL);
                        SOLDIER_2(rhs_vdv_medic);
                        SOLDIER_3(rhs_vdv_machinegunner);
                        SOLDIER_4(rhs_vdv_machinegunner_assistant);
                        SOLDIER_5(rhs_vdv_grenadier_rpg);
                    };
                    class E_Reg_def_02 {
                        SOLDIERR_1(rhs_vdv_sergeant,SERGEANT);
                        SOLDIERR_2(rhs_vdv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_vdv_at);
                        SOLDIER_4(rhs_vdv_at);
                        SOLDIER_5(rhs_vdv_LAT);
                        SOLDIER_6(rhs_vdv_rifleman);
                    };
                    class E_Reg_def_03 {
                        SOLDIERR_1(rhs_vdv_junior_sergeant,CORPORAL);
                        SOLDIER_2(rhs_vdv_medic);
                        SOLDIER_3(rhs_vdv_aa);
                        SOLDIER_4(rhs_vdv_aa);
                        SOLDIER_5(rhs_vdv_strelok_rpg_assist);
                        SOLDIER_6(rhs_vdv_strelok_rpg_assist);
                    };
                };
            };

        };
        class tv : msv {
            armytypes[] = {"armored"};
            art_shells[] = {"rhs_2s3_tv"};
            trucks[] = {"rhs_kamaz5350_msv","rhs_kamaz5350_msv_open"};
            cars[] = {"rhs_tigr_3camo_msv","rhs_tigr_ffv_3camo_msv","rhs_tigr_ffv_msv","rhs_tigr_m_3camo_msv"};
            tanks[] = {"rhs_bmp1d_tv","rhs_bmp1_tv","rhs_bmp1k_tv","rhs_bmp1p_tv","rhs_bmp2_tv","rhs_bmp2d_tv","rhs_bmp2e_tv","rhs_bmp2k_tv","rhs_brm1k_tv","rhs_prp3_tv",
                        "rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv",
                        "rhs_t80","rhs_t80a","rhs_t80b","rhs_t80bk","rhs_t80bv","rhs_t80bvk","rhs_t80u","rhs_t80u45m","rhs_t80ue1","rhs_t80uk","rhs_t80um",
                        "rhs_t90_tv","rhs_t90a_tv"};
            soldiers[] = {"rhs_msv_rifleman","rhs_msv_LAT","rhs_msv_RShG2","rhs_msv_grenadier","rhs_msv_arifleman","rhs_msv_machinegunner","rhs_msv_machinegunner_assistant",
                            "rhs_msv_grenadier_rpg","rhs_msv_strelok_rpg_assist","rhs_msv_marksman","rhs_msv_efreitor","rhs_msv_sergeant","rhs_msv_junior_sergeant",
                            "rhs_msv_at","rhs_msv_aa","rhs_msv_engineer","rhs_msv_medic"};
            crewmen[] = {"rhs_msv_driver_armored","rhs_msv_driver","rhs_msv_crew","rhs_msv_armoredcrew","rhs_msv_combatcrew","rhs_msv_crew_commander"};
            class callIn : callIn {
                group_infantry[] = {
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_fireteam"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_MANEUVER"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_2mg"}
                };

                supply_infanterie = 0;
                supply_mounted = 0;
                supply_tanks = 1;
                supply_sniper = 0.2;
                supply_mechanized = 1;

                supply_airdrop = 0;
                supply_tankdrop = 0;

                cas_cluster = 0;
                cas_gun = 1;
                cas_missiles = 0;
                cas_drones = 0;

                cas_helicopter = 0;
                ai = 1;
            };
        };
        class light_infanterie : msv {
            armytypes[] = {"guards"};
            art_shells[] = {"rhs_D30_MSV"};
            soldiers[] = {
                "rhs_msv_rifleman","rhs_msv_LAT","rhs_msv_RShG2","rhs_msv_grenadier","rhs_msv_arifleman","rhs_msv_machinegunner",
                "rhs_msv_machinegunner_assistant","rhs_msv_grenadier_rpg","rhs_msv_strelok_rpg_assist","rhs_msv_marksman","rhs_msv_efreitor",
                "rhs_msv_sergeant","rhs_msv_junior_sergeant","rhs_msv_officer","rhs_msv_at","rhs_msv_aa","rhs_msv_engineer","rhs_msv_medic"
            };
            crewmen[] = {"rhs_msv_driver_armored","rhs_msv_driver","rhs_msv_crew","rhs_msv_armoredcrew","rhs_msv_combatcrew","rhs_msv_crew_commander"};
            ifv[] = {"rhs_tigr_sts_vdv"};
            class callIn : callIn {
                group_infantry[] = {
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_fireteam"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_MANEUVER"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_2mg"}
                };

                supply_infanterie = 1;
                supply_mounted = 1;
                supply_tanks = 0;
                supply_sniper = 0.2;
                supply_mechanized = 0;

                supply_airdrop = 0;
                supply_tankdrop = 0;

                cas_cluster = 0;
                cas_gun = 0;
                cas_missiles = 0;
                cas_drones = 1;

                cas_helicopter = 0;
                ai = 1;
            };
            class groups : groups {
                groups_patrol[] = {
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_marksman"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_sniper"}
                };
                groups_attack[] = {
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_marksman"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_marksman"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_marksman"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_sniper"}
                };
                groups_defence[] = {
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_fireteam"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_MANEUVER"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_marksman"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_section_mg"}
                };

                // own groups
                class patrol {
                    class E_Reg_Pat_01 {
                        SOLDIERR_1(rhs_msv_sergeant,SERGEANT);
                        SOLDIERR_2(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_msv_rifleman);
                        SOLDIER_4(rhs_msv_rifleman);
                        SOLDIER_5(rhs_msv_grenadier_rpg);
                        SOLDIER_6(rhs_msv_grenadier);
                    };
                    class E_Reg_Pat_02 {
                        SOLDIERR_1(rhs_msv_sergeant,SERGEANT);
                        SOLDIERR_2(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_msv_marksman);
                        SOLDIER_4(rhs_msv_marksman);
                        SOLDIER_5(rhs_msv_medic);
                    };
                    class E_Reg_Pat_03 {
                        SOLDIERR_1(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_2(rhs_msv_medic);
                        SOLDIER_3(rhs_msv_machinegunner);
                        SOLDIER_4(rhs_msv_machinegunner_assistant);
                        SOLDIER_5(rhs_msv_grenadier_rpg);
                        SOLDIER_6(rhs_msv_aa);
                    };
                    class E_Reg_Pat_04 {
                        SOLDIERR_1(rhs_msv_sergeant,SERGEANT);
                        SOLDIERR_2(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_msv_LAT);
                        SOLDIER_4(rhs_msv_LAT);
                        SOLDIER_5(rhs_msv_medic);
                        SOLDIER_6(rhs_msv_grenadier);
                    };
                };
                class strikeforce {
                    class E_Reg_Att_01 {
                        SOLDIERR_1(rhs_msv_sergeant,SERGEANT);
                        SOLDIERR_2(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_msv_LAT);
                        SOLDIER_4(rhs_msv_LAT);
                        SOLDIER_5(rhs_msv_medic);
                        SOLDIER_6(rhs_msv_grenadier);
                        SOLDIER_7(rhs_msv_grenadier);
                    };
                    class E_Reg_Att_02 {
                        SOLDIERR_1(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_2(rhs_msv_medic);
                        SOLDIER_3(rhs_msv_machinegunner);
                        SOLDIER_4(rhs_msv_machinegunner_assistant);
                        SOLDIER_5(rhs_msv_grenadier_rpg);
                        SOLDIER_6(rhs_msv_grenadier_rpg);
                        SOLDIER_7(rhs_msv_aa);
                    };
                    class E_Reg_Att_03 {
                        SOLDIER_1(rhs_brm1k_vdv);
                    };
                    class E_Reg_Att_04 {
                        SOLDIER_1(rhs_btr60_vdv);
                    };
                    class E_Reg_Att_05 {
                        SOLDIER_1(rhs_tigr_sts_vdv);
                    };
                };
                class defence {
                    class E_Reg_def_01 {
                        SOLDIERR_1(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_2(rhs_msv_medic);
                        SOLDIER_3(rhs_msv_machinegunner);
                        SOLDIER_4(rhs_msv_machinegunner_assistant);
                        SOLDIER_5(rhs_msv_grenadier_rpg);
                    };
                    class E_Reg_def_02 {
                        SOLDIERR_1(rhs_msv_sergeant,SERGEANT);
                        SOLDIERR_2(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_3(rhs_msv_at);
                        SOLDIER_4(rhs_msv_at);
                        SOLDIER_5(rhs_msv_LAT);
                        SOLDIER_6(rhs_msv_rifleman);
                    };
                    class E_Reg_def_03 {
                        SOLDIERR_1(rhs_msv_junior_sergeant,CORPORAL);
                        SOLDIER_2(rhs_msv_medic);
                        SOLDIER_3(rhs_msv_aa);
                        SOLDIER_4(rhs_msv_aa);
                        SOLDIER_5(rhs_msv_strelok_rpg_assist);
                        SOLDIER_6(rhs_msv_strelok_rpg_assist);
                    };
                };
            };
        };
        class specops : msv {
            armytypes[] = {"specops"};
            static[] = {"RHS_NSV_TriPod_VDV","RHS_AGS30_TriPod_VDV","rhs_Igla_AA_pod_VDV","rhs_KORD_high_VDV","rhs_KORD_VDV","rhs_Metis_9k115_2_VDV"};
            static_high[] = {"rhs_KORD_high_VDV"};
            static_aa[] = {"rhs_Igla_AA_pod_VDV"};
            art_mortar[] = {"rhs_2b14_82mm_VDV"};
            art_shells[] = {"rhs_D30_VDV"};
            art_rocket[] = {"RHS_BM21_VDV_01"};

            trucks[] = {"RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01","rhs_gaz66_VDV","rhs_gaz66o_VDV"};
            cars[] = {"rhs_tigr_VDV","rhs_tigr_ffv_VDV","rhs_tigr_3camo_VDV","rhs_tigr_ffv_3camo_VDV"};
            tanks[] = {};
            soldiers[] = {
                "rhs_vdv_recon_arifleman","rhs_vdv_recon_arifleman_scout","rhs_vdv_recon_efreitor","rhs_vdv_recon_grenadier","rhs_vdv_recon_grenadier_scout",
                "rhs_vdv_recon_machinegunner_assistant","rhs_vdv_recon_marksman","rhs_vdv_recon_marksman_asval","rhs_vdv_recon_marksman_vss","rhs_vdv_recon_medic",
                "rhs_vdv_recon_officer","rhs_vdv_recon_officer_armored","rhs_vdv_recon_rifleman","rhs_vdv_recon_rifleman_ak103","rhs_vdv_recon_rifleman_akms","rhs_vdv_recon_rifleman_asval",
                "rhs_vdv_recon_rifleman_l","rhs_vdv_recon_rifleman_lat","rhs_vdv_recon_rifleman_scout","rhs_vdv_recon_rifleman_scout_akm","rhs_vdv_recon_sergeant"
            };
            crewmen[] = {"rhs_VDV_driver_armored","rhs_VDV_driver","rhs_VDV_crew","rhs_VDV_armoredcrew","rhs_VDV_combatcrew","rhs_VDV_crew_commander"};
            class callIn : callIn {
                group_infantry[] = {
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_fireteam"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_MANEUVER"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad_sniper"}
                };

                supply_infanterie = 1;
                supply_mounted = 0;
                supply_tanks = 0;
                supply_sniper = 1;
                supply_mechanized = 0;

                supply_airdrop = 0;
                supply_tankdrop = 0;

                cas_cluster = 1;
                cas_gun = 1;
                cas_missiles = 1;
                cas_drones = 0;

                cas_helicopter = 0;
                ai = 1;
            };
            class groups : groups {
                groups_patrol[] = {
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_fireteam"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_MANEUVER"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad_sniper"}
                };
                groups_attack[] = {
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_fireteam"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_MANEUVER"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad_sniper"}
                };
                groups_defence[] = {
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_fireteam"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_MANEUVER"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_vdv","rhs_group_rus_vdv_infantry_recon","rhs_group_rus_vdv_infantry_recon_squad_sniper"}
                };

                // own groups
                class patrol {

                };
                class strikeforce {
                    class E_Reg_Att_03 {
                        SOLDIER_1(rhs_t90a_tv);
                    };
                    class E_Reg_Att_04 {
                        SOLDIER_1(rhs_t90_tv);
                        SOLDIER_5(rhs_t90_tv);
                    };
                };
                class defence {

                };
            };
        };
        class droneoperations : specops {
            armytypes[] = {"specops"};
            ifv[] = {"rhs_tigr_sts_vdv"};
            class callIn : callIn {

                supply_infanterie = 1;
                supply_mounted = 1;
                supply_tanks = 0;
                supply_sniper = 0.2;
                supply_mechanized = 0;

                supply_airdrop = 0;
                supply_tankdrop = 0;

                cas_cluster = 0;
                cas_gun = 0;
                cas_missiles = 0;
                cas_drones = 1;

                cas_helicopter = 0;
                ai = 1;
            };
            /*
            class groups : groups {
                class patrol {};
                class strikeforce {};
                class defence {};
            };
            */
        };
    };
    class base_west : base {
        cfgPatches[] = {"rhsusf_main"};
        armytypes[] = {"guards","infanterie","armored","airborne","specops"};
        class mission: mission {
            prototype[] = {"O_MBT_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F"};
            commander[] = {"rhsusf_army_ocp_officer"};
            hq_mobile[] = {"rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"};
            wreck_air[] = {"RHS_AH64D_GS", "RHS_AH64D"};
        };
        attack_uavs[] = {"B_UAV_02_F"};
        recon_uavs[] = {"B_UAV_01_F"};
        static[] = {"RHS_M2StaticMG_MiniTripod_D","RHS_TOW_TriPod_D"};
        static_high[] = {"RHS_M2StaticMG_D"};
        static_aa[] = {"RHS_Stinger_AA_pod_D"};
        art_mortar[] = {"RHS_M252_D"};
        art_shells[] = {"RHS_M119_D"};
        art_rocket[] = {"B_MBT_01_mlrs_F"};

        trucks[] = {"rhsusf_M1078A1P2_B_d_fmtv_usarmy","rhsusf_M1078A1P2_B_d_open_fmtv_usarmy","rhsusf_M1078A1P2_B_d_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_d_fmtv_usarmy","rhsusf_M1078A1P2_d_open_fmtv_usarmy","rhsusf_M1078A1P2_d_flatbed_fmtv_usarmy","rhsusf_M1083A1P2_B_d_fmtv_usarmy","rhsusf_M1083A1P2_B_d_open_fmtv_usarmy","rhsusf_M1083A1P2_B_d_flatbed_fmtv_usarmy","rhsusf_M1083A1P2_d_fmtv_usarmy","rhsusf_M1083A1P2_d_open_fmtv_usarmy",
                    "rhsusf_M1083A1P2_d_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_d_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_d_open_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_d_flatbed_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_d_open_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_d_flatbed_fmtv_usarmy"};
        ifv[] = {"rhsusf_m113d_usarmy","rhsusf_m113d_usarmy_supply","rhsusf_m113d_usarmy_unarmed","rhsusf_m113d_usarmy_medical","rhsusf_m113d_usarmy_M240","rhsusf_m113d_usarmy_MK19","RHS_M2A2","RHS_M2A2_BUSKI","RHS_M2A3","RHS_M2A3_BUSKI","RHS_M2A3_BUSKIII","RHS_M6"};
        cars[] = {"rhsusf_m998_d_2dr","rhsusf_m998_d_2dr_halftop","rhsusf_m998_d_2dr_fulltop","rhsusf_m998_d_4dr","rhsusf_m998_d_4dr_halftop","rhsusf_m998_d_4dr_fulltop","rhsusf_m1025_d","rhsusf_m1025_d_m2","rhsusf_m1025_d_Mk19"};
        tanks[] = {"rhsusf_m1a1aimd_usarmy","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","rhsusf_m1a2sep1tuskiid_usarmy"};
        divers[] = {"B_diver_f","B_diver_exp_f","B_diver_TL_f"};
        boats[] = {"rhsusf_mkvsoc"};

        soldiers[] = {"rhsusf_army_ocp_rifleman_1stcav","rhsusf_army_ocp_rifleman_10th","rhsusf_army_ocp_rifleman","rhsusf_army_ocp_rifleman_m4","rhsusf_army_ocp_rifleman_m16","rhsusf_army_ocp_rifleman_m590","rhsusf_army_ocp_riflemanl","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_grenadier","rhsusf_army_ocp_autorifleman","rhsusf_army_ocp_autoriflemana","rhsusf_army_ocp_machinegunner","rhsusf_army_ocp_machinegunnera","rhsusf_army_ocp_marksman","rhsusf_army_ocp_squadleader",
                    "rhsusf_army_ocp_teamleader","rhsusf_army_ocp_jfo","rhsusf_army_ocp_fso","rhsusf_army_ocp_javelin","rhsusf_army_ocp_javelin_assistant","rhsusf_army_ocp_aa","rhsusf_army_ocp_uav","rhsusf_army_ocp_medic","rhsusf_army_ocp_engineer","rhsusf_army_ocp_explosives"};
        crewmen[] = {"rhsusf_army_ocp_crewman","rhsusf_army_ocp_combatcrewman","rhsusf_army_ocp_driver","rhsusf_army_ocp_driver_armored"};

        class callIn {
            supplyarray[] = {{"infanterie",1},{"airdrop",1},{"mounted",1},{"sniper",1},{"tanks",1},{"mechanized",1}};
            helicopter_transport[] = {"RHS_CH_47F_10","RHS_CH_47F_light"};
            cas_helicopter_types[] = {"RHS_AH64D_GS","RHS_AH64D_CS"};

            //ai_types[] = {"rhsusf_f22"};
            //cas_types[] = {"RHS_A10","RHS_A10_AT"};
            ai_types[] = {"B_Plane_Fighter_01_Stealth_F"};
            cas_types[] = {"B_Plane_CAS_01_dynamicLoadout_F"};
            amountHeli = 1;
            amountAI = 1;
            amountCAS = 1;

            group_infantry[] = {
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_squad"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_squad_sniper"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AA"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AT"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_MG"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_support"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_weaponsquad"}
            };
        };


        class groups {
            groups_patrol[] = {
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_squad_sniper"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AA"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AT"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_MG"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_support"}
            };
            groups_attack[] = {
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_squad"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_squad_sniper"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AA"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AA"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AT"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AT"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AT"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_MG"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_support"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_weaponsquad"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_squad"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_squad_sniper"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AA"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AA"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AT"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AT"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AT"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_MG"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_support"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_weaponsquad"}
            };
            groups_defence[] = {
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AA"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_AT"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_MG"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_infantry","rhs_group_nato_usarmy_d_infantry_team_support"}
            };
            groups_mechanized[] = {
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_bradley","rhs_group_nato_usarmy_d_bradley_aa"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_bradley","rhs_group_nato_usarmy_d_bradley_squad"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_bradley","rhs_group_nato_usarmy_d_bradley_squad_2mg"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_bradley","rhs_group_nato_usarmy_d_bradley_squad_mg_sniper"},
                {"configfile","CfgGroups","West","rhs_faction_usarmy_d","rhs_group_nato_usarmy_d_bradley","rhs_group_nato_usarmy_d_bradley_squad_sniper"}
            };
            groups_sniper[] = {};
            // own groups
            class patrol {
            };
            class strikeforce {
                class E_Reg_Att_01 {
                    SOLDIER_1(rhsusf_m1a2sep1tuskiid_usarmy);
                };
                class E_Reg_Att_02 {
                    SOLDIER_1(rhsusf_m1a1aim_tuski_d);
                };
                class E_Reg_Att_03 {
                    SOLDIER_1(RHS_M2A3_BUSKIII);
                };
                class E_Reg_Att_04 {
                    SOLDIER_1(RHS_M6);
                };
            };
            class defence {};
            class sniper {
                class E_Snip_01 {
                    SOLDIERR_1(rhsusf_army_ocp_sniper,CORPORAL);
                    SOLDIER_2(rhsusf_army_ocp_sniper);
                    SOLDIER_3(rhsusf_army_ocp_sniper);
                };
                class E_Snip_02 {
                    SOLDIERR_1(rhsusf_army_ocp_sniper_m24sws,CORPORAL);
                    SOLDIER_2(rhsusf_army_ocp_sniper_m24sws);
                    SOLDIER_3(rhsusf_army_ocp_sniper_m24sws);
                };
                class E_Snip_03 {
                    SOLDIERR_1(rhsusf_army_ocp_sniper_m107,CORPORAL);
                    SOLDIER_2(rhsusf_army_ocp_sniper_m107);
                    SOLDIER_3(rhsusf_army_ocp_sniper_m107);
                };
            };
        };
    };
    class west {
        class us_army : base_west {
            camouflage = 2;
        };
        class us_army_wd : base_west {
            camouflage = 1;
            trucks[] = {"rhsusf_M1078A1P2_B_wd_fmtv_usarmy","rhsusf_M1078A1P2_B_wd_open_fmtv_usarmy","rhsusf_M1078A1P2_B_wd_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_wd_fmtv_usarmy","rhsusf_M1078A1P2_wd_open_fmtv_usarmy","rhsusf_M1078A1P2_wd_flatbed_fmtv_usarmy","rhsusf_M1083A1P2_B_d_fmtv_usarmy","rhsusf_M1083A1P2_B_wd_open_fmtv_usarmy","rhsusf_M1083A1P2_B_wd_flatbed_fmtv_usarmy","rhsusf_M1083A1P2_wd_fmtv_usarmy","rhsusf_M1083A1P2_wd_open_fmtv_usarmy",
                        "rhsusf_M1083A1P2_wd_flatbed_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_wd_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_wd_open_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_wd_flatbed_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_wd_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_wd_open_fmtv_usarmy","rhsusf_M1083A1P2_B_M2_wd_flatbed_fmtv_usarmy"};
            ifv[] = {"rhsusf_m113_usarmy","rhsusf_m113_usarmy_supply","rhsusf_m113_usarmy_unarmed","rhsusf_m113_usarmy_medical","rhsusf_m113_usarmy_M240","rhsusf_m113_usarmy_MK19","RHS_M2A2_wd","RHS_M2A2_BUSKI_wd","RHS_M2A3_wd","RHS_M2A3_BUSKI_wd","RHS_M2A3_BUSKIII_wd","RHS_M6_wd"};
            cars[] = {"rhsusf_m998_w_2dr","rhsusf_m998_w_2dr_halftop","rhsusf_m998_w_2dr_fulltop","rhsusf_m998_w_4dr","rhsusf_m998_w_4dr_halftop","rhsusf_m998_w_4dr_fulltop","rhsusf_m1025_w","rhsusf_m1025_w_m2","rhsusf_m1025_w_Mk19"};
            tanks[] = {"rhsusf_m1a1aiwd_usarmy","rhsusf_m1a1aim_tuski_wd","rhsusf_m1a2sep1wd_usarmy","rhsusf_m1a2sep1tuskiwd_usarmy","rhsusf_m1a2sep1tuskiiwd_usarmy"};
            groups_mechanized[] = {
                {"configfile","CfgGroups","West","rhs_group_nato_usarmy","rhs_group_nato_usarmy_wd_bradley","rhs_group_nato_usarmy_d_bradley_aa"},
                {"configfile","CfgGroups","West","rhs_group_nato_usarmy","rhs_group_nato_usarmy_wd_bradley","rhs_group_nato_usarmy_wd_bradley_squad"},
                {"configfile","CfgGroups","West","rhs_group_nato_usarmy","rhs_group_nato_usarmy_wd_bradley","rhs_group_nato_usarmy_wd_bradley_squad_2mg"},
                {"configfile","CfgGroups","West","rhs_group_nato_usarmy","rhs_group_nato_usarmy_wd_bradley","rhs_group_nato_usarmy_wd_bradley_squad_mg_sniper"},
                {"configfile","CfgGroups","West","rhs_group_nato_usarmy","rhs_group_nato_usarmy_wd_bradley","rhs_group_nato_usarmy_wd_bradley_squad_sniper"}
            };
            class strikeforce {
                class E_Reg_Att_01 {
                    SOLDIER_1(rhsusf_m1a2sep1tuskiiwd_usarmy);
                };
                class E_Reg_Att_02 {
                    SOLDIER_1(rhsusf_m1a1aim_tuski_wd);
                };
                class E_Reg_Att_03 {
                    SOLDIER_1(RHS_M2A3_BUSKIII_wd);
                };
                class E_Reg_Att_04 {
                    SOLDIER_1(RHS_M6_wd);
                };
            };
        };
        class us_marine : base_west {
            camouflage = 2;
            trucks[] = {"rhsusf_rg33_usmc_d"};
            ifv[] = {"rhsusf_rg33_m2_usmc_d","rhsusf_m1025_d_s_m2","rhsusf_m1025_d_s_Mk19"};
            cars[] = {"rhsusf_m998_d_s_2dr","rhsusf_m998_d_s_2dr_halftop","rhsusf_m998_d_s_2dr_fulltop","rhsusf_m998_d_s_4dr","rhsusf_m998_d_s_4dr_halftop","rhsusf_m998_d_s_4dr_fulltop"};
            tanks[] = {"rhsusf_m1a1fep_d"};
            boats[] = {"rhsusf_mkvsoc"};

            soldiers[] = {"rhsusf_usmc_marpat_d_rifleman","rhsusf_usmc_marpat_d_rifleman_light","rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_riflemanat","rhsusf_usmc_marpat_d_rifleman_law","rhsusf_usmc_marpat_d_rifleman_m590","rhsusf_usmc_marpat_d_grenadier","rhsusf_usmc_marpat_d_grenadier_m32","rhsusf_usmc_marpat_d_autorifleman","rhsusf_usmc_marpat_d_autorifleman_m249",
                        "rhsusf_usmc_marpat_d_autorifleman_m249_ass","rhsusf_usmc_marpat_d_machinegunner","rhsusf_usmc_marpat_d_machinegunner_ass","rhsusf_usmc_marpat_d_squadleader","rhsusf_usmc_marpat_d_teamleader","rhsusf_usmc_marpat_d_fso","rhsusf_usmc_marpat_d_jfo","rhsusf_usmc_marpat_d_engineer","rhsusf_usmc_marpat_d_explosives","rhsusf_usmc_marpat_d_uav","rhsusf_usmc_marpat_d_smaw",
                        "rhsusf_usmc_marpat_d_javelin","rhsusf_usmc_marpat_d_javelin_assistant","rhsusf_usmc_marpat_d_stinger","rhsusf_usmc_marpat_d_marksman"};
            crewmen[] = {"rhsusf_usmc_marpat_d_crewman","rhsusf_usmc_marpat_d_combatcrewman","rhsusf_usmc_marpat_d_driver","rhsusf_usmc_marpat_d_gunner"};

            class callIn : callIn {
                helicopter_transport[] = {"RHS_UH1Y_d","RHS_UH1Y_FFAR_d","RHS_UH1Y_d_GS","rhsusf_CH53E_USMC_D"};
                cas_helicopter_types[] = {"RHS_AH1Z_GS","RHS_AH1Z_CS"};
                amountHeli = 0;
                amountAI = 1;
                amountCAS = 1;

                group_infantry[] = {
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_squad"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_squad_sniper"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_AA"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_heavy_AT"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_MG"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_support"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_weaponsquad"}
                };
            };


            class groups {
                groups_patrol[] = {
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_squad_sniper"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_AA"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_heavy_AT"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_MG"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_support"}
                };
                groups_attack[] = {
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_squad"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_squad_sniper"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_AA"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_AA"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_heavy_AT"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_heavy_AT"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_heavy_AT"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_MG"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_support"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_weaponsquad"}
                };
                groups_defence[] = {
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_AA"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_heavy_AT"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_MG"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_support"}
                };
                groups_mechanized[] = {
                    {"configfile","CfgGroups","East","rhs_faction_vmf","rhs_group_nato_usmc_d_RG33","rhs_group_nato_usmc_d_RG33_m2_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_vmf","rhs_group_nato_usmc_d_RG33","rhs_group_nato_usmc_d_RG33_m2_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_vmf","rhs_group_nato_usmc_d_RG33","rhs_group_nato_usmc_d_RG33_m2_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_vmf","rhs_group_nato_usmc_d_RG33","rhs_group_nato_usmc_d_RG33_m2_squad_sniper"}
                };
                groups_sniper[] = {};
                // own groups
                class patrol {};
                class strikeforce {
                    class E_Reg_Att_01 {
                        SOLDIER_1(rhsusf_m1a1fep_d);
                    };
                };
                class defence {};
                class sniper {
                    class E_Snip_01 {
                        SOLDIERR_1(rhsusf_usmc_marpat_d_spotter,CORPORAL);
                        SOLDIER_2(rhsusf_usmc_marpat_d_sniper);
                        SOLDIER_3(rhsusf_usmc_marpat_d_sniper);
                    };
                    class E_Snip_02 {
                        SOLDIERR_1(rhsusf_usmc_marpat_d_spotter,CORPORAL);
                        SOLDIER_2(rhsusf_usmc_marpat_d_sniper_m110);
                        SOLDIER_3(rhsusf_usmc_marpat_d_sniper_m110);
                    };
                    class E_Snip_03 {
                        SOLDIERR_1(rhsusf_usmc_marpat_d_spotter,CORPORAL);
                        SOLDIER_2(rhsusf_usmc_marpat_d_sniper_m107);
                        SOLDIER_3(rhsusf_usmc_marpat_d_sniper_m107);
                    };
                };
            };
        };
        class us_marine_wd : base_west {
            camouflage = 1;
            trucks[] = {"rhsusf_rg33_usmc_wd"};
            ifv[] = {"rhsusf_rg33_m2_usmc_wd","rhsusf_m1025_wd_s_m2","rhsusf_m1025_wd_s_Mk19"};
            cars[] = {"rhsusf_m998_wd_s_2dr","rhsusf_m998_wd_s_2dr_halftop","rhsusf_m998_wd_s_2dr_fulltop","rhsusf_m998_wd_s_4dr","rhsusf_m998_wd_s_4dr_halftop","rhsusf_m998_wd_s_4dr_fulltop"};
            tanks[] = {"rhsusf_m1a1fep_wd"};
            boats[] = {"rhsusf_mkvsoc"};

            soldiers[] = {"rhsusf_usmc_marpat_wd_rifleman","rhsusf_usmc_marpat_wd_rifleman_light","rhsusf_usmc_marpat_wd_rifleman_m4","rhsusf_usmc_marpat_wd_riflemanat","rhsusf_usmc_marpat_wd_rifleman_law","rhsusf_usmc_marpat_wd_rifleman_m590","rhsusf_usmc_marpat_wd_grenadier","rhsusf_usmc_marpat_wd_grenadier_m32","rhsusf_usmc_marpat_wd_autorifleman","rhsusf_usmc_marpat_wd_autorifleman_m249",
                        "rhsusf_usmc_marpat_wd_autorifleman_m249_ass","rhsusf_usmc_marpat_wd_machinegunner","rhsusf_usmc_marpat_wd_machinegunner_ass","rhsusf_usmc_marpat_wd_squadleader","rhsusf_usmc_marpat_wd_teamleader","rhsusf_usmc_marpat_wd_fso","rhsusf_usmc_marpat_wd_jfo","rhsusf_usmc_marpat_wd_engineer","rhsusf_usmc_marpat_wd_explosives","rhsusf_usmc_marpat_wd_uav","rhsusf_usmc_marpat_wd_smaw",
                        "rhsusf_usmc_marpat_wd_javelin","rhsusf_usmc_marpat_wd_javelin_assistant","rhsusf_usmc_marpat_wd_stinger","rhsusf_usmc_marpat_wd_marksman"};
            crewmen[] = {"rhsusf_usmc_marpat_wd_crewman","rhsusf_usmc_marpat_wd_combatcrewman","rhsusf_usmc_marpat_wd_driver","rhsusf_usmc_marpat_wd_gunner"};

            class callIn : callIn {
                helicopter_transport[] = {"RHS_UH1Y","RHS_UH1Y_FFAR","RHS_UH1Y_GS","rhsusf_CH53E_USMC"};
                cas_helicopter_types[] = {"RHS_AH1Z_wd_GS","RHS_AH1Z_wd_CS"};
                amountHeli = 0;
                amountAI = 1;
                amountCAS = 1;

                group_infantry[] = {
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_squad"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_squad_sniper"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_AA"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_heavy_AT"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_MG"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_support"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_weaponsquad"}
                };
            };

            class groups {
                groups_patrol[] = {
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_squad_sniper"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_AA"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_heavy_AT"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_MG"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_support"}
                };
                groups_attack[] = {
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_squad"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_squad_sniper"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_AA"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_AA"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_heavy_AT"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_heavy_AT"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_heavy_AT"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_MG"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_support"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_weaponsquad"}
                };
                groups_defence[] = {
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_AA"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_heavy_AT"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_MG"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_wd","rhs_group_nato_usmc_wd_infantry","rhs_group_nato_usmc_wd_infantry_team_support"}
                };
                groups_mechanized[] = {
                    {"configfile","CfgGroups","west","rhs_faction_vmf","rhs_group_nato_usmc_wd_RG33","rhs_group_nato_usmc_wd_RG33_m2_squad"},
                    {"configfile","CfgGroups","west","rhs_faction_vmf","rhs_group_nato_usmc_wd_RG33","rhs_group_nato_usmc_wd_RG33_m2_squad_2mg"},
                    {"configfile","CfgGroups","west","rhs_faction_vmf","rhs_group_nato_usmc_wd_RG33","rhs_group_nato_usmc_wd_RG33_m2_squad_mg_sniper"},
                    {"configfile","CfgGroups","west","rhs_faction_vmf","rhs_group_nato_usmc_wd_RG33","rhs_group_nato_usmc_wd_RG33_m2_squad_sniper"}
                };
                groups_sniper[] = {};
                // own groups
                class patrol {};
                class strikeforce {
                    class E_Reg_Att_01 {
                        SOLDIER_1(rhsusf_m1a1fep_wd);
                    };
                };
                class defence {};
                class sniper {
                    class E_Snip_01 {
                        SOLDIERR_1(rhsusf_usmc_marpat_wd_spotter,CORPORAL);
                        SOLDIER_2(rhsusf_usmc_marpat_wd_sniper);
                        SOLDIER_3(rhsusf_usmc_marpat_wd_sniper);
                    };
                    class E_Snip_02 {
                        SOLDIERR_1(rhsusf_usmc_marpat_wd_spotter,CORPORAL);
                        SOLDIER_2(rhsusf_usmc_marpat_wd_sniper_m110);
                        SOLDIER_3(rhsusf_usmc_marpat_wd_sniper_m110);
                    };
                    class E_Snip_03 {
                        SOLDIERR_1(rhsusf_usmc_marpat_wd_spotter,CORPORAL);
                        SOLDIER_2(rhsusf_usmc_marpat_wd_sniper_m107);
                        SOLDIER_3(rhsusf_usmc_marpat_wd_sniper_m107);
                    };
                };
            };
        };
        class specops : us_marine {
            camouflage = 2;
            tanks[] = {};
            class callIn : callIn {
                amountHeli = 0;
                amountAI = 1;
                amountCAS = 2;
                group_infantry[] = {
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_squad"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_squad_sniper"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_AA"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_heavy_AT"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_MG"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_team_support"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_d_infantry","rhs_group_nato_usmc_d_infantry_weaponsquad"}
                };
            };

            class groups {
                groups_patrol[] = {
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_recon_d_infantry","rhs_group_nato_usmc_recon_d_infantry_team"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_recon_d_infantry","rhs_group_nato_usmc_recon_d_infantry_team_fast"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_recon_d_infantry","rhs_group_nato_usmc_recon_d_infantry_team_lite"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_recon_d_infantry","rhs_group_nato_usmc_recon_d_infantry_team_MG"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_recon_d_infantry","rhs_group_nato_usmc_recon_d_infantry_team_support"}
                };
                groups_attack[] = {
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_recon_d_infantry","rhs_group_nato_usmc_recon_d_infantry_team"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_recon_d_infantry","rhs_group_nato_usmc_recon_d_infantry_team_fast"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_recon_d_infantry","rhs_group_nato_usmc_recon_d_infantry_team_lite"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_recon_d_infantry","rhs_group_nato_usmc_recon_d_infantry_team_MG"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_recon_d_infantry","rhs_group_nato_usmc_recon_d_infantry_team_support"}
                };
                groups_defence[] = {
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_recon_d_infantry","rhs_group_nato_usmc_recon_d_infantry_team"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_recon_d_infantry","rhs_group_nato_usmc_recon_d_infantry_team_fast"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_recon_d_infantry","rhs_group_nato_usmc_recon_d_infantry_team_lite"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_recon_d_infantry","rhs_group_nato_usmc_recon_d_infantry_team_MG"},
                    {"configfile","CfgGroups","West","rhs_faction_usmc_d","rhs_group_nato_usmc_recon_d_infantry","rhs_group_nato_usmc_recon_d_infantry_team_support"}
                };
                class strikeforce {};
            };
        };

        class bundeswehr_fleck : base_west {
            cfgPatches[] = {"bwa3_units","rhsusf_main"};
            camouflage = 2;
            class mission: mission {
                commander[] = {"BWA3_Officer_Fleck"};
                wreck_air[] = {"BWA3_Tiger_Gunpod_Heavy", "BWA3_Tiger_Gunpod_PARS"};
            };
            trucks[] = {"rhsusf_M1078A1P2_B_d_fmtv_usarmy","rhsusf_M1078A1P2_B_d_open_fmtv_usarmy","rhsusf_M1078A1P2_B_d_flatbed_fmtv_usarmy"};
            ifv[] = {"BWA3_Puma_Fleck"};
            cars[] = {"BWA3_Eagle_FLW100_Fleck"};
            tanks[] = {"BWA3_Leopard2A6M_Fleck","BWA3_Puma_Fleck"};

            soldiers[] = {"BWA3_Rifleman_Fleck","BWA3_Rifleman_lite_Fleck","BWA3_RiflemanG27_Fleck","BWA3_RiflemanG28_Fleck","BWA3_Grenadier_Fleck","BWA3_GrenadierG27_Fleck","BWA3_Autorifleman_Fleck","BWA3_AutoriflemanMG5_Fleck",
                        "BWA3_CombatLifeSaver_Fleck","BWA3_Marksman_Fleck","BWA3_RiflemanAT_RGW90_Fleck","BWA3_RiflemanAT_Pzf3_Fleck","BWA3_RiflemanAT_CG_Fleck","BWA3_RiflemanAA_Fliegerfaust_Fleck","BWA3_Engineer_Fleck"};
            crewmen[] = {"BWA3_Crew_Fleck","BWA3_Tank_Commander_Fleck"};

            class callIn : callIn {
                helicopter_transport[] = {"RHS_UH1Y","RHS_UH1Y_FFAR"};
                cas_helicopter_types[] = {"BWA3_Tiger_RMK_FZ","BWA3_Tiger_RMK_Heavy","BWA3_Tiger_RMK_PARS","BWA3_Tiger_RMK_Universal"};

                amountHeli = 1;
                amountAI = 1;
                amountCAS = 0;

                group_infantry[] = {
                    {"configfile","CfgGroups","West","Bundeswehr","Infantry_Fleck","Jaegertrupp"},
                    {"configfile","CfgGroups","West","Bundeswehr","Infantry_Fleck","Panzerabwehrtrupp"},
                    {"configfile","CfgGroups","West","Bundeswehr","SpecOps_Fleck","Fernspaeher"}
                };
            };


            class groups {
                groups_patrol[] = {
                    {"configfile","CfgGroups","West","Bundeswehr","Infantry_Fleck","Jaegertrupp"},
                    {"configfile","CfgGroups","West","Bundeswehr","Infantry_Fleck","Panzerabwehrtrupp"},
                    {"configfile","CfgGroups","West","Bundeswehr","SpecOps_Fleck","Fernspaeher"}
                };
                groups_attack[] = {
                    {"configfile","CfgGroups","West","Bundeswehr","Infantry_Fleck","Jaegertrupp"},
                    {"configfile","CfgGroups","West","Bundeswehr","Infantry_Fleck","Panzerabwehrtrupp"},
                    {"configfile","CfgGroups","West","Bundeswehr","SpecOps_Fleck","Fernspaeher"}
                };
                groups_defence[] = {
                    {"configfile","CfgGroups","West","Bundeswehr","Infantry_Fleck","Panzerabwehrtrupp"},
                    {"configfile","CfgGroups","West","Bundeswehr","SpecOps_Fleck","Fernspaeher"}
                };
                groups_mechanized[] = {
                    {"configfile","CfgGroups","East","Bundeswehr","Mechanized_Fleck","Panzergrenadiergruppe"}
                };
                groups_sniper[] = {};
                // own groups
                class patrol {
                };
                class strikeforce {
                    class E_Reg_Att_01 {
                        SOLDIER_1(BWA3_Eagle_FLW100_Fleck);
                    };
                    class E_Reg_Att_02 {
                        SOLDIER_1(BWA3_Puma_Fleck);
                    };
                    class E_Reg_Att_03 {
                        SOLDIER_1(BWA3_Leopard2A6M_Fleck);
                    };
                    class E_Reg_Att_04 {
                        SOLDIERR_1(BWA3_SL_Fleck,SERGEANT);
                        SOLDIERR_2(BWA3_TL_Fleck,CORPORAL);
                        SOLDIER_3(BWA3_Autorifleman_Fleck);
                        SOLDIER_4(BWA3_AutoriflemanMG5_Fleck);
                        SOLDIER_5(BWA3_RiflemanAT_Pzf3_Fleck);
                        SOLDIER_6(BWA3_RiflemanAT_RGW90_Fleck);
                        SOLDIER_7(BWA3_CombatLifeSaver_Fleck);
                    };
                    class E_Reg_Att_05 {
                        SOLDIERR_1(BWA3_SL_Fleck,SERGEANT);
                        SOLDIERR_2(BWA3_TL_Fleck,CORPORAL);
                        SOLDIER_3(BWA3_Rifleman_Fleck);
                        SOLDIER_4(BWA3_AutoriflemanMG5_Fleck);
                        SOLDIER_5(BWA3_RiflemanAT_Pzf3_Fleck);
                        SOLDIER_6(BWA3_AutoriflemanMG5_Fleck);
                        SOLDIER_7(BWA3_CombatLifeSaver_Fleck);
                        SOLDIER_8(BWA3_Rifleman_Fleck);
                    };
                    class E_Reg_Att_06 {
                        SOLDIERR_1(BWA3_TL_Fleck,CORPORAL);
                        SOLDIER_2(BWA3_RiflemanG27_Fleck);
                        SOLDIER_3(BWA3_RiflemanG27_Fleck);
                        SOLDIER_4(BWA3_RiflemanG27_Fleck);
                        SOLDIER_5(BWA3_RiflemanAT_Pzf3_Fleck);
                        SOLDIER_6(BWA3_RiflemanAT_Pzf3_Fleck);
                        SOLDIER_7(BWA3_CombatLifeSaver_Fleck);
                    };
                    class E_Reg_Att_07 {
                        SOLDIERR_1(BWA3_TL_Fleck,CORPORAL);
                        SOLDIER_2(BWA3_Rifleman_Fleck);
                        SOLDIER_3(BWA3_RiflemanAA_Fliegerfaust_Fleck);
                        SOLDIER_4(BWA3_RiflemanAA_Fliegerfaust_Fleck);
                        SOLDIER_5(BWA3_CombatLifeSaver_Fleck);
                    };

                };
                class defence {};
                class sniper {
                    class E_Snip_01 {
                        SOLDIERR_1(BWA3_Spotter_Fleck,CORPORAL);
                        SOLDIER_2(BWA3_SniperG82_Fleck);
                        SOLDIER_3(BWA3_SniperG82_Fleck);
                    };
                };
            };
        };
    };
};
