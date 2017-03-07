/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Unitslists
 *
 */
#define CBA_OFF
#include "script_component.hpp"
class GVAR(unitlists) {
    class base {
        class mission {
            weaponcache[] = {"Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"};
            pow[] = {"C_scientist_F","C_journalist_F"};
            intel[] = {"Land_File1_F","Land_File2_F","Land_FilePhotos_F","Land_SatellitePhone_F","Land_MobilePhone_smart_F"};
            case[] = {"Land_Suitcase_F"};
            tower[] = {"Land_TTowerBig_1_F","Land_TTowerBig_2_F"};
            radar[] = {"rhs_p37","rhs_prv13"};
            device[] = {"Land_Device_assembled_F"};
            emp[] = {"rhs_typhoon_vdv"};
            scarab[] = {"rhs_9k79"};
        };
        civ_cars[] = {"C_Offroad_01_F","C_Quadbike_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Offroad_01_F","C_Quadbike_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F","RHS_Civ_Truck_02_covered_F","RHS_Civ_Truck_02_transport_F","RHS_Ural_Civ_01","RHS_Ural_Open_Civ_01","RHS_Ural_Civ_02","RHS_Ural_Open_Civ_02","RHS_Ural_Civ_03","RHS_Ural_Open_Civ_03"};
        civ_smallcars[] = {"C_Offroad_01_F","C_Quadbike_01_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_SUV_01_F"};
    };
    class base_east : base {
        class mission: mission {
            prototype[] = {"B_MBT_01_TUSK_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F"};
            commander[] = {"rhs_vdv_officer"};
            hq_mobile[] = {"rhs_gaz66_r142_vdv"};
        };
        attack_uavs[] = {"O_UAV_02_F"};
        recon_uavs[] = {"rhs_pchela1t_vvs","O_UAV_01_F"};
        static[] = {"RHS_NSV_TriPod_VDV","RHS_AGS30_TriPod_VDV","rhs_Igla_AA_pod_vdv","rhs_KORD_high_VDV","rhs_KORD_VDV","rhs_Metis_9k115_2_vdv"};
        static_high[] = {"rhs_KORD_high_VDV"};
        static_aa[] = {"rhs_Igla_AA_pod_vdv"};
        art_mortar[] = {"rhs_2b14_82mm_vdv"};
        art_shells[] = {"rhs_2s3_tv","rhs_D30_vdv"};
        art_rocket[] = {"RHS_BM21_VDV_01"};

        trucks[] = {"RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01","rhs_gaz66_vdv","rhs_gaz66o_vdv"};
        ifv[] = {"rhs_btr80a_vdv","rhs_btr80_vdv"};
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
            helicopter_cas[] = {"RHS_Ka52_UPK23_vvs","rhs_ka60_grey"};
            helicopter_transport[] = {"rhs_Mi8mt_vdv","rhs_Mi8mt_Cargo_vdv","rhs_Mi8MTV3_vdv","rhs_Mi8MTV3_UPK23_vdv","rhs_Mi8MTV3_FAB_vdv","rhs_Mi8AMT_vdv"};

            planeAI[] = {"RHS_T50_vvs_054","RHS_T50_vvs_053","RHS_T50_vvs_052"};
            planeCAS[] = {"RHS_Su25SM_KH29_vvs","RHS_Su25SM_CAS_vvs","RHS_Su25SM_vvs"};

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
        class msv : base_east {
            static[] = {"RHS_NSV_TriPod_MSV","RHS_AGS30_TriPod_MSV","rhs_Igla_AA_pod_MSV","rhs_KORD_high_MSV","rhs_KORD_MSV","rhs_Metis_9k115_2_MSV"};
            static_high[] = {"rhs_KORD_high_MSV"};
            static_aa[] = {"rhs_Igla_AA_pod_MSV"};
            art_mortar[] = {"rhs_2b14_82mm_MSV"};
            art_shells[] = {"rhs_2s3_tv","rhs_D30_MSV"};
            art_rocket[] = {"RHS_BM21_MSV_01"};

            trucks[] = {"RHS_Ural_MSV_01","RHS_Ural_Open_MSV_01","rhs_gaz66_MSV","rhs_gaz66o_MSV"};
            cars[] = {"rhs_tigr_MSV","rhs_tigr_ffv_MSV","rhs_tigr_3camo_MSV","rhs_tigr_ffv_3camo_MSV"};
            tanks[] = {};
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
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry","rhs_group_rus_MSV_infantry_squad_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_recon","rhs_group_rus_MSV_infantry_recon_fireteam"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_recon","rhs_group_rus_MSV_infantry_recon_MANEUVER"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_recon","rhs_group_rus_MSV_infantry_recon_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_recon","rhs_group_rus_MSV_infantry_recon_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_recon","rhs_group_rus_MSV_infantry_recon_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_infantry_recon","rhs_group_rus_MSV_infantry_recon_squad_sniper"}
                };
                groups_attack[] = {
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_BTR80a","rhs_group_rus_MSV_BTR80a_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_BTR80a","rhs_group_rus_MSV_BTR80a_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_BTR80a","rhs_group_rus_MSV_BTR80a_squad_aa"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_BTR80a","rhs_group_rus_MSV_BTR80a_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_BTR80a","rhs_group_rus_MSV_BTR80a_squad_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_btr70","rhs_group_rus_MSV_btr70_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_btr70","rhs_group_rus_MSV_btr70_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_btr70","rhs_group_rus_MSV_btr70_squad_aa"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_btr70","rhs_group_rus_MSV_btr70_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_btr70","rhs_group_rus_MSV_btr70_squad_sniper"},
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
                        SOLDIER_1(rhs_btr80a_msv);
                        SOLDIERR_2(rhs_msv_junior_sergeant,CORPORAL);
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
            static[] = {"RHS_NSV_TriPod_VDV","RHS_AGS30_TriPod_VDV","rhs_Igla_AA_pod_VDV","rhs_KORD_high_VDV","rhs_KORD_VDV","rhs_Metis_9k115_2_VDV"};
            static_high[] = {"rhs_KORD_high_VDV"};
            static_aa[] = {"rhs_Igla_AA_pod_VDV"};
            art_mortar[] = {"rhs_2b14_82mm_VDV"};
            art_shells[] = {"rhs_2s3_tv","rhs_D30_VDV"};
            art_rocket[] = {"RHS_BM21_VDV_01"};

            trucks[] = {"RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01","rhs_gaz66_VDV","rhs_gaz66o_VDV"};
            cars[] = {"rhs_tigr_VDV","rhs_tigr_ffv_VDV","rhs_tigr_3camo_VDV","rhs_tigr_ffv_3camo_VDV"};
            tanks[] = {};
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
            };
            class groups : groups {
                groups_patrol[] = {
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_AT"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_marksman"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_section_mg"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry","rhs_group_rus_VDV_infantry_squad_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_recon","rhs_group_rus_VDV_infantry_recon_fireteam"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_recon","rhs_group_rus_VDV_infantry_recon_MANEUVER"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_recon","rhs_group_rus_VDV_infantry_recon_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_recon","rhs_group_rus_VDV_infantry_recon_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_recon","rhs_group_rus_VDV_infantry_recon_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_infantry_recon","rhs_group_rus_VDV_infantry_recon_squad_sniper"}
                };
                groups_attack[] = {
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_gaz66","rhs_group_rus_vdv_gaz66_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_gaz66","rhs_group_rus_vdv_gaz66_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_2s25","RHS_2S25Section"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_2s25","RHS_2S25Platoon_AA"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_2s25","RHS_2S25Platoon"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_bmd4m","rhs_group_rus_vdv_bmd4m_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_bmd4m","rhs_group_rus_vdv_bmd4m_squad_aa"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_bmd4m","rhs_group_rus_vdv_bmd4m_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_bmd4m","rhs_group_rus_vdv_bmd4m_squad_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_bmp1","rhs_group_rus_vdv_bmp1_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_bmp1","rhs_group_rus_vdv_bmp1_squad_aa"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_bmp1","rhs_group_rus_vdv_bmp1_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_bmp1","rhs_group_rus_vdv_bmp1_squad_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_Ural","rhs_group_rus_VDV_Ural_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_Ural","rhs_group_rus_VDV_Ural_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_Ural","rhs_group_rus_VDV_Ural_squad_aa"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_Ural","rhs_group_rus_VDV_Ural_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_vdv_Ural","rhs_group_rus_VDV_Ural_squad_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_btr70","rhs_group_rus_VDV_btr70_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_btr70","rhs_group_rus_VDV_btr70_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_btr70","rhs_group_rus_VDV_btr70_squad_aa"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_btr70","rhs_group_rus_VDV_btr70_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_VDV","rhs_group_rus_VDV_btr70","rhs_group_rus_VDV_btr70_squad_sniper"}
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
        class armored : msv {
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
            };
        };
        class infanterie : msv {
            soldiers[] = {
                "rhs_msv_rifleman","rhs_msv_LAT","rhs_msv_RShG2","rhs_msv_grenadier","rhs_msv_arifleman","rhs_msv_machinegunner",
                "rhs_msv_machinegunner_assistant","rhs_msv_grenadier_rpg","rhs_msv_strelok_rpg_assist","rhs_msv_marksman","rhs_msv_efreitor",
                "rhs_msv_sergeant","rhs_msv_junior_sergeant","rhs_msv_officer","rhs_msv_at","rhs_msv_aa","rhs_msv_engineer","rhs_msv_medic"
            };
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
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_msv_Ural","rhs_group_rus_msv_Ural_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_msv_Ural","rhs_group_rus_MSV_Ural_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_msv_Ural","rhs_group_rus_MSV_Ural_squad_aa"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_msv_Ural","rhs_group_rus_MSV_Ural_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_msv_Ural","rhs_group_rus_MSV_Ural_squad_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_btr70","rhs_group_rus_MSV_btr70_squad"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_btr70","rhs_group_rus_MSV_btr70_squad_2mg"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_btr70","rhs_group_rus_MSV_btr70_squad_aa"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_btr70","rhs_group_rus_MSV_btr70_squad_mg_sniper"},
                    {"configfile","CfgGroups","East","rhs_faction_MSV","rhs_group_rus_MSV_btr70","rhs_group_rus_MSV_btr70_squad_sniper"},

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
            static[] = {"RHS_NSV_TriPod_VDV","RHS_AGS30_TriPod_VDV","rhs_Igla_AA_pod_VDV","rhs_KORD_high_VDV","rhs_KORD_VDV","rhs_Metis_9k115_2_VDV"};
            static_high[] = {"rhs_KORD_high_VDV"};
            static_aa[] = {"rhs_Igla_AA_pod_VDV"};
            art_mortar[] = {"rhs_2b14_82mm_VDV"};
            art_shells[] = {"rhs_2s3_tv","rhs_D30_VDV"};
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
            class groups : groups {
                class patrol {};
                class strikeforce {};
                class defence {};
            };
        };
        class guards  : msv {};
    };
    class base_west : base {

    };
    class west {
        class regular : base_west {};
    };
};
