/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"

class sideby_config {
	class conter {
		class small {
			vehicle = "rhs_tigr_msv";
			inf[] = {"rhs_msv_sergeant","rhs_msv_marksman","rhs_msv_medic","rhs_msv_rifleman","rhs_msv_grenadier"};
			infc[] = {1,1,1,1,1};
		};
		class medium {
			vehicle = "rhs_gaz66_msv";
			inf[] = {"rhs_msv_sergeant","rhs_msv_marksman","rhs_msv_medic","rhs_msv_rifleman","rhs_msv_grenadier","rhs_msv_at","rhs_msv_machinegunner","rhs_msv_machinegunner_assistant"};
			infc[] = {1,1,1,2,1,1,1,1};
		};
		class big {
			vehicle = "rhs_btr80a_msv";
			inf[] = {"rhs_msv_sergeant","rhs_msv_marksman","rhs_msv_medic","rhs_msv_rifleman","rhs_msv_grenadier","rhs_msv_aa"};
			infc[] = {1,1,1,3,2,2};
		};
		class air {
			vehicle = "RHS_Mi24P_vvsc";
			inf[] = {"rhs_msv_sergeant","rhs_msv_medic","rhs_msv_rifleman","rhs_msv_grenadier"};
			infc[] = {1,1,3,3};
		};
	};

	class deserter {
		weapon = "hgun_PDW2000_F";
		mag = "30Rnd_9x21_Mag";
		magc = 2;
		googles = "G_Squares";
		headgear = "H_MilCap_dgtl";
		uniform = "U_I_OfficerUniform";
	};

	class supplies {
		civs[] = {"C_man_polo_1_F_euro","C_man_polo_2_F_euro","C_man_polo_3_F_euro","C_man_polo_4_F_euro","C_man_polo_5_F_euro","C_man_polo_6_F_euro"};
		inf[] = {"rhs_vdv_rifleman","rhs_vdv_grenadier","rhs_vdv_machinegunner","rhs_vdv_medic","rhs_vdv_LAT","rhs_vdv_marksman"};
		infw[] = {1,0.8,0.5,0.4,0.4,0.2};
	};
};
