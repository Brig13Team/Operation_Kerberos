/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Unitslists
 *
 */
#define CBA_OFF
#include "script_component.hpp"
class unitlists {
    class base {

        //// parts of max unitamount
        amount_patrols = 0.4;
        amount_strikeforce = 0.4;
        amount_defence = 0.2;

        skill_compensation = 1; /// reduce the amount of units - higher skill => less units

        crewmen[] = {};
        divers[] = {};
        soldiers[] = {};

        veh_transport[] = {};
        veh_mechanized[] = {};
        veh_armored[] = {};
        veh_antiair[] = {};

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
            class fortifications {
                amount = 0;
                units[] = {};
            };
            class drones {
                amount = 0;
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
        emp[] = {"rhs_typhoon_vdv"};

        group_patrol[] = {};
        group_strikeforce[] = {};
        group_defence[] = {};

        class groups {
            class patrol {
            };
            class strikeforce {
            };
            class defence {
            };
        };
    };

    class east {
        class regular : base {
            prototyp[] = {"B_MBT_01_TUSK_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F"};
            commander[] = {"rhs_vdv_officer"};
            hq_mobile[] = {"rhs_gaz66_r142_vdv"};
            weaponcache[] = {"Box_IND_Wps_F","Box_IND_WpsSpecial_F","Box_IND_WpsLaunch_F","Box_IND_Ammo_F","Box_IND_Grenades_F","Box_IND_Support_F"};

            attack_uavs[] = {"O_UAV_02_F"};
            recon_uavs[] = {"rhs_pchela1t_vvs","O_UAV_01_F"};

            static[] = {"RHS_NSV_TriPod_VDV","RHS_AGS30_TriPod_VDV","rhs_Igla_AA_pod_vdv","rhs_KORD_high_VDV","rhs_KORD_VDV","rhs_Metis_9k115_2_vdv"};
            static_high[] = {"rhs_KORD_high_VDV"};
            static_aa[] = {"rhs_Igla_AA_pod_vdv"};

            art_mortar[] = {"rhs_2b14_82mm_vdv"};
            art_shells[] = {"rhs_2s3_tv","rhs_D30_vdv"};
            art_rocket[] = {"RHS_BM21_VDV_01"};

            boat_patrol[] = {"O_Boat_Armed_01_hmg_F"};

            soldiers[] = {"rhs_vdv_aa","rhs_vdv_arifleman","rhs_vdv_at","rhs_vdv_efreitor","rhs_vdv_engineer",
                        "rhs_vdv_grenadier","rhs_vdv_grenadier_rpg","rhs_vdv_junior_sergeant","rhs_vdv_LAT",
                        "rhs_vdv_machinegunner","rhs_vdv_machinegunner_assistant","rhs_vdv_marksman",
                        "rhs_vdv_marksman_asval","rhs_vdv_medic","rhs_vdv_officer",    "rhs_vdv_recon_at",
                        "rhs_vdv_recon_marksman","rhs_vdv_recon_marksman_asval","rhs_vdv_recon_sergeant",
                        "rhs_vdv_rifleman","rhs_vdv_rifleman_asval","rhs_vdv_RShG2","rhs_vdv_sergeant","rhs_vdv_strelok_rpg_assist"};

            crewmen[] = {"rhs_vdv_officer_armored","rhs_vdv_combatcrew","rhs_vdv_crew","rhs_vdv_armoredcrew",
                        "rhs_vdv_crew_commander","rhs_vdv_driver","rhs_vdv_driver_armored"};

            divers[] = {"O_diver_f","O_diver_exp_f","O_diver_TL_f","O_diver_f","O_diver_exp_f","O_diver_f"};

            veh_transport[] = {"rhs_btr60_vdv","rhs_btr70_vdv","rhs_btr80_vdv","rhs_btr80a_vdv"};
            veh_mechanized[] = {"RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01","rhs_gaz66_vdv","rhs_gaz66o_vdv"};
            veh_armored[] = {"rhs_bmd1","rhs_bmd1k","rhs_bmd1p","rhs_bmd1pk","rhs_bmd1r","rhs_bmd2","rhs_bmd2m","rhs_bmd2k","rhs_bmp1_vdv","rhs_bmp1p_vdv","rhs_bmp1k_vdv","rhs_bmp1d_vdv","rhs_bmp2e_vdv","rhs_bmp2_vdv","rhs_bmp2k_vdv","rhs_bmp2d_vdv","rhs_brm1k_vdv","rhs_bmd4_vdv","rhs_bmd4m_vdv","rhs_bmd4ma_vdv","rhs_sprut_vdv"};
            veh_antiair[] = {"rhs_zsu234_aa"};

            class groups {
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
        class armored : regular {
        };
        class infanterie : regular {
        };
        class airborne : regular {
        };
        class specops : regular {
        };
        class droneoperations : regular {
        };
        class guards  : regular {
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

};
