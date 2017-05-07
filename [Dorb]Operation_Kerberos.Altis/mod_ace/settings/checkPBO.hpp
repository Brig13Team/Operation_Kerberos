
#define MOD_CBA 'cba_diagnostic_enable_perf_loop','cba_diagnostic_logging','cba_cache_disable','cba_diagnostic_disable_xeh_logging','Disable_XEH_Logging','cba_diagnostic_enable_logging'
#define MOD_BWA3 'BWA3_EnablePIPOptics'
#define MOD_STHUD 'st_sthud','st_sthud_usermenu'
#define MOD_EXTDB3 'extdb3'
#define MOD_ASRAI 'asr_ai3_bwa3_c','asr_ai3_bwa3_camo_c','asr_ai3_cfgammo','asr_ai3_cfgcamouflage','asr_ai3_cfgvehicles','asr_ai3_cfgweapons','asr_ai3_greenrico','asr_ai3_main','asr_ai3_niarms_c','asr_ai3_rhs_gr_c','asr_ai3_rhs_gr_camo_c','asr_ai3_rhs_ru_c','asr_ai3_rhs_ru_camo_c','asr_ai3_rhs_us_c','asr_ai3_rhs_us_camo_c'
#define MOD_3DENENHANCED '3denenhanced'
#define MOD_ARES 'ares_zeusextensions','ares'
#define MOD_ACHILLES 'achilles_data_f_achilles','achilles_data_f_ares','achilles_language_f','achilles_functions_f_ares','achilles_functions_f_achilles','achilles_modules_f_achilles','achilles_modules_f_ares','achilles_ui_f','achilles_settings_f'


class ace_common_checkPBOsWhitelist {
    value = QUOTE([ARR_8(MOD_CBA,MOD_BWA3,MOD_STHUD,MOD_EXTDB3,MOD_ASRAI)]);
    typeName = "STRING";
    force = 1;
};
class ace_common_checkPBOsAction SET_VAL(2);
class ace_common_checkPBOsCheckAll TURN_ON;
