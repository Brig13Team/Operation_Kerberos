class logistics
{
	class vehicles {
		class rhsusf_m1025_base {
			max_width = 1.3;
			max_length = 1.05;
			max_height = 0.4;
			hatch_open = "_this animate ['ani_trunk_1', 1];";
			hatch_close = "_this animate ['ani_trunk_1', 0]";
			hatch_isopened = "_this animationPhase 'ani_trunk_1'==1";
			hatch_isclosed = "_this animationPhase 'ani_trunk_1'<0.5";
		};
		class rhsusf_m1025_w : rhsusf_m1025_base	{
			cargo_point[] = {-0.07,-1.8,-0.85};
			load_point[] = {-0.07,-3.3,-1.9};
		};
		class rhsusf_m1025_d : rhsusf_m1025_w {};
		class rhsusf_m1025_w_s : rhsusf_m1025_w {};
		class rhsusf_m1025_d_s : rhsusf_m1025_w {};

		class rhsusf_m1025_w_m2 : rhsusf_m1025_base {
			cargo_point[] = {0,-1.15,1};
			load_point[] = {0,-2.65,0};
		};
		class rhsusf_m1025_d_m2 : rhsusf_m1025_w_m2 {};
		class rhsusf_m1025_w_s_m2 : rhsusf_m1025_w_m2 {};
		class rhsusf_m1025_d_s_m2 : rhsusf_m1025_w_m2 {};
		
		class rhsusf_m1025_w_mk19 : rhsusf_m1025_base {
			cargo_point[] = {-0.07,-1.8,-0.9};
			load_point[] = {-0.07,-3.3,-2};
		};
		class rhsusf_m1025_d_Mk19 : rhsusf_m1025_w_mk19 {};
		class rhsusf_m1025_d_s_Mk19 : rhsusf_m1025_w_mk19 {};
		class rhsusf_m1025_w_s_Mk19 : rhsusf_m1025_w_mk19 {};
		
		class rhsusf_m1025_2dr_base {
			max_width = 0.7;
			max_length = 3.7;
			max_height = 2.1;
			cargo_point[] = {0,-0.9,-0.9};
			load_point[] = {0,-3.8,-1.9};
		};
		class rhsusf_m998_w_2dr_fulltop : rhsusf_m1025_base {};
		class rhsusf_m998_d_2dr_fulltop : rhsusf_m1025_base {};
		class rhsusf_m998_d_s_2dr_fulltop : rhsusf_m1025_base {};
		class rhsusf_m998_w_s_2dr_fulltop : rhsusf_m1025_base {};
		
		class rhsusf_m998_w_2dr_halftop : rhsusf_m1025_base {
			max_height = 4;
		};
		class rhsusf_m998_w_2dr : rhsusf_m998_w_2dr_halftop {};
		class rhsusf_m998_d_2dr : rhsusf_m998_w_2dr_halftop {};
		class rhsusf_m998_d_2dr_halftop : rhsusf_m998_w_2dr_halftop {};
		class rhsusf_m998_d_s_2dr : rhsusf_m998_w_2dr_halftop {};
		class rhsusf_m998_d_s_2dr_halftop : rhsusf_m998_w_2dr_halftop {};
		class rhsusf_m998_w_s_2dr : rhsusf_m998_w_2dr_halftop {};
		class rhsusf_m998_w_s_2dr_halftop : rhsusf_m998_w_2dr_halftop {};

		class rhsusf_m998_w_4dr_base {
			max_width = 0.7;
			max_length = 2.2;
			max_height = 1.5;
			cargo_point[] = {0,-1.15,0.92};
			load_point[] = {0,-3,0};
		};
		class rhsusf_m998_w_4dr_halftop : rhsusf_m998_w_4dr_base {};
		class rhsusf_m998_w_4dr : rhsusf_m998_w_4dr_base {};
		class rhsusf_m998_d_4dr : rhsusf_m998_w_4dr_base {};
		class rhsusf_m998_d_4dr_halftop : rhsusf_m998_w_4dr_base {};
		class rhsusf_m998_d_s_4dr_halftop : rhsusf_m998_w_4dr_base {};
		class rhsusf_m998_d_s_4dr : rhsusf_m998_w_4dr_base {};
		class rhsusf_m998_w_s_4dr : rhsusf_m998_w_4dr_base {};
		class rhsusf_m998_w_s_4dr_halftop : rhsusf_m998_w_4dr_base {};
		
		
		/// LKW
		
		
		class rhsusf_HEMTT_A2_base {
			max_width = 2;
			max_length = 10.96;
			max_height = 10;
			cargo_point[] = {0,1.48,0.26};
			load_point[] = {0,-6,-1.4};
		};
		class rhsusf_M977A2_usarmy_wd : rhsusf_HEMTT_A2_base {};
		class rhsusf_M977A2_CPK_usarmy_wd : rhsusf_M977A2_usarmy_wd {};
		
		class rhsusf_M1078A1P2_Base {
			max_width = 1.3;
			max_length = 8;
			max_height = 3;
			cargo_point[] = {0,0.9,-0.28};
			load_point[] = {0,-5.5,-1.8};
		};
		class rhsusf_M1078A1P2_wd_open_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1078A1P2_B_M2_d_open_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1078A1P2_B_M2_d_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1078A1P2_B_d_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1078A1P2_d_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1083A1P2_d_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1083A1P2_d_open_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1083A1P2_B_d_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1083A1P2_B_M2_d_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1083A1P2_B_M2_d_open_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1083A1P2_B_d_open_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1078A1P2_B_wd_open_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1078A1P2_B_M2_wd_open_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1078A1P2_B_M2_wd_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1078A1P2_B_wd_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1078A1P2_wd_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1083A1P2_wd_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1083A1P2_wd_open_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1083A1P2_B_wd_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1083A1P2_B_M2_wd_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1083A1P2_B_M2_wd_open_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		class rhsusf_M1083A1P2_B_wd_open_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
		
		
		
		
		/// offen
		class rhsusf_M1078A1P2_B_d_flatbed_fmtv_usarmy : rhsusf_M1078A1P2_B_wd_fmtv_usarmy {
			max_width = 2.3;
			max_height = 5;
		};
		class rhsusf_M1078A1P2_d_flatbed_fmtv_usarmy : rhsusf_M1078A1P2_B_d_flatbed_fmtv_usarmy {};
		class rhsusf_M1078A1P2_B_M2_d_flatbed_fmtv_usarmy : rhsusf_M1078A1P2_B_d_flatbed_fmtv_usarmy {};
		class rhsusf_M1083A1P2_d_flatbed_fmtv_usarmy : rhsusf_M1078A1P2_B_d_flatbed_fmtv_usarmy {};
		class rhsusf_M1083A1P2_B_d_flatbed_fmtv_usarmy : rhsusf_M1078A1P2_B_d_flatbed_fmtv_usarmy {};
		class rhsusf_M1083A1P2_B_M2_d_flatbed_fmtv_usarmy : rhsusf_M1078A1P2_B_d_flatbed_fmtv_usarmy {};
		class rhsusf_M1078A1P2_wd_flatbed_fmtv_usarmy : rhsusf_M1078A1P2_B_d_flatbed_fmtv_usarmy {};
		class rhsusf_M1078A1P2_B_wd_flatbed_fmtv_usarmy : rhsusf_M1078A1P2_B_d_flatbed_fmtv_usarmy {};
		class rhsusf_M1078A1P2_B_M2_wd_flatbed_fmtv_usarmy : rhsusf_M1078A1P2_B_d_flatbed_fmtv_usarmy {};
		class rhsusf_M1083A1P2_B_M2_wd_flatbed_fmtv_usarmy : rhsusf_M1078A1P2_B_d_flatbed_fmtv_usarmy {};
		class rhsusf_M1083A1P2_B_wd_flatbed_fmtv_usarmy : rhsusf_M1078A1P2_B_d_flatbed_fmtv_usarmy {};
		class rhsusf_M1083A1P2_wd_flatbed_fmtv_usarmy : rhsusf_M1078A1P2_B_d_flatbed_fmtv_usarmy {};
		
		
		/// HELI
		
		class RHS_UH60M_Base {
			max_width = 1.4;
			max_length = 2.4;
			max_height = 1.8;
			cargo_point[] = {1.4,2.4,1.8};
			load_point[] = {2.5,1.8,-2.3};
			hatch_open = "_this animateDoor ['doorRB', 1];_this animate ['doorHandler_R',1]";
			hatch_close = "_this animateDoor ['doorRB', 0];_this animate ['doorHandler_R',0];";
			hatch_isopened = "_this doorPhase 'doorRB' > 0 and (alive _this)";
			hatch_isclosed = "_this doorPhase 'doorRB' == 0 and (alive _this)";
		};
		class RHS_UH60M_MEV2_d : RHS_UH60M_Base {};
		class RHS_UH60M_MEV2 : RHS_UH60M_Base {};
		
		class RHS_CH_47_Base {
			max_width = 0.8;
			max_length = 15;
			max_height = 3;
			cargo_point[] = {0,3.7,-2.7};
			load_point[] = {0,-9,-3.5};
			hatch_open = "_this animateDoor ['ramp_anim', 1];";
			hatch_close = "_this animateDoor ['ramp_anim', 0];";
			hatch_isopened = "_this doorPhase 'ramp_anim' > 0 and (alive _this)";
			hatch_isclosed = "_this doorPhase 'ramp_anim' == 0 and (alive _this)";
		};
		class RHS_CH_47F_light : RHS_CH_47_Base {};
		class RHS_CH_47F_10 : RHS_CH_47_Base {};
		class RHS_CH_47F : RHS_CH_47_Base {};
		
		class I_Heli_Transport_02_F {
			max_width = 1;
			max_length = 11;
			max_height = 2.5;
			cargo_point[] = {0,3.7,-2.2};
			load_point[] = {0,-7,-3.5};
			hatch_open = "_this doorPhase 'ramp_anim' > 0 and (alive _this)";
			hatch_close = "_this doorPhase 'ramp_anim' == 0 and (alive _this)";
			hatch_isopened = "_this doorPhase 'CargoRamp_Open' < 0.5 && alive _this &&((_this getVariable ['bis_disabled_Ramp',0]) != 1)";
			hatch_isclosed = "_this doorPhase 'CargoRamp_Open' > 0.5 && alive _this && ((_this getVariable ['bis_disabled_Ramp',0]) != 1)";
		};
		
		class B_Heli_Transport_03_F {
			max_width = 0.9;
			max_length = 9;
			max_height = 3.3;
			cargo_point[] = {0,3.2,-1.85};
			load_point[] = {0,-7.5,-2.9};
			hatch_open = "_this doorPhase 'ramp_anim' > 0 and (alive _this)";
			hatch_close = "_this doorPhase 'ramp_anim' == 0 and (alive _this)";
			hatch_isopened = "_this doorPhase 'Door_rear_source' < 0.5 AND Alive(_this) && ((_this getVariable ['bis_disabled_Ramp',0]) != 1)";
			hatch_isclosed = "_this doorPhase 'Door_rear_source' > 0.5 AND Alive(_this) && ((_this getVariable ['bis_disabled_Ramp',0]) != 1)";
		};
		class B_Heli_Transport_03_unarmed_base_F : B_Heli_Transport_03_F {};
		class B_Heli_Transport_03_unarmed_F : B_Heli_Transport_03_F {};
		class B_Heli_Transport_03_unarmed_green_F : B_Heli_Transport_03_F {};
	};

	class cargos {
		class WpnsBox_F {
			width = 1.1;
			length = 0.64;
			height = 0.38;
		};
		class AmmoBox_F {
			width = 0.5;
			length = 0.78;
			height = 0.64;
		};
		class WpnsBox_large_F {
			width = 1.63;
			length = 0.73;
			height = 0.38;
		};
		class WpnsBox_long_F {
			width = 1.63;
			length = 0.34;
			height = 0.38;
		};
		class Supplydrop {
			width = 1.5;
			length = 0.98;
			height = 1.78;
		};
		class ace_medcrate {
			width = 1.16;
			length = 0.39;
			height = 0.38;
		};
		class bwa3_democracybox {
			width = 2.8;
			length = 5.8;
			height = 4.48;
			offset[] = {0,0,2.24};
		};
		
		class AmmoVeh_F {
			width = 1.54;
			length = 1.54;
			height = 1.54;
		};
		class Land_Cargo10_grey_F {
			width = 2.5;
			length = 3.1;
			height = 1.25;
		};
		class Land_Cargo20_grey_F {
			width = 6.2;
			length = 2.46;
			height = 2.64;
		};
		class CargoBox_V1_F {
			width = 1.54;
			length = 1.54;
			height = 1.54;
		};
	};
};