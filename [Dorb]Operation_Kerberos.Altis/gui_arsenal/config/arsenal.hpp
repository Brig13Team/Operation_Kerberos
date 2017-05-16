#define CBA_OFF
#include "script_component.hpp"
class GVARMAIN(arsenal) {
    ItemsBlacklist[] = {
        "NVGogglesB_blk_F","NVGogglesB_grn_F","NVGogglesB_gry_F","O_NVGoggles_ghex_F","O_NVGoggles_hex_F","O_NVGoggles_urb_F",
        "optic_Nightstalker","optic_tws","optic_tws_mg",
        "ACE_bodyBag",
        "ACE_SpraypaintBlack","ACE_SpraypaintBlue","ACE_SpraypaintGreen","ACE_SpraypaintRed",
        "ACE_key_civ","ACE_key_east","ACE_key_indp","ACE_key_lockpick","ACE_key_master","ACE_key_west"
        };
    WeaponsBlacklist[] = {
        "launch_B_Titan_F","launch_B_Titan_short_F","launch_B_Titan_short_tna_F","launch_B_Titan_tna_F",
        "launch_I_Titan_F","launch_I_Titan_short_F","launch_Titan_F","launch_Titan_short_F",
        "launch_O_Titan_F","launch_O_Titan_ghex_F","launch_O_Titan_short_F","launch_O_Titan_short_ghex_F"
    };
    BackpackBlacklist[] = {
        "B_Respawn_Sleeping_bag_blue_F","B_Respawn_Sleeping_bag_brown_F","B_Respawn_Sleeping_bag_F","B_Respawn_TentA_F","B_Respawn_TentDome_F", //respawn Tents
        "ACRE_testBag"
    };
    MagazineBlackList[] = {
        "BWA3_10Rnd_127x99_G82_Raufoss","BWA3_10Rnd_127x99_G82_Raufoss_Tracer","BWA3_10Rnd_127x99_G82_Raufoss_Tracer_Dim"
    };
    ItemsWhitelist[] = {
        "ItemRadioAcreFlagged",
        "BWA3_acc_LLM01_flash","BWA3_acc_LLM01_flash_underbarrel","BWA3_acc_LLM01_laser","BWA3_acc_LLM01_laser_underbarrel"
    };
    WeaponsWhitelist[] = {
        "Laserdesignator","Laserdesignator_01_khk_F","Laserdesignator_02","Laserdesignator_02_ghex_F","Laserdesignator_02_ghex_F"
    };
    BackpackWhitelist[] = {

    };
    MagazineWhitelist[] = {
        "ACE_SpareBarrel"
    };

};
