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
			max_length = 1.85;
			max_height = 1.05;
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
			max_length = 1.1;
			max_height = 0.75;
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
			max_length = 5.48;
			max_height = 5;
			cargo_point[] = {0,1.48,0.26};
			load_point[] = {0,-6,-1.4};
		};
		class rhsusf_M977A2_usarmy_wd : rhsusf_HEMTT_A2_base {};
		class rhsusf_M977A2_CPK_usarmy_wd : rhsusf_M977A2_usarmy_wd {};
		
		class rhsusf_M1078A1P2_Base {
			max_width = 1.3;
			max_length = 4;
			max_height = 1.5;
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
			max_height = 2.5;
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
			max_length = 1.2;
			max_height = 0.9;
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
			max_length = 7.5;
			max_height = 1.5;
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
			max_length = 5.5;
			max_height = 1.25;
			cargo_point[] = {0,3.7,-2.2};
			load_point[] = {0,-7,-3.5};
			hatch_open = "this animateDoor ['CargoRamp_Open', 1]";
			hatch_close = "this animateDoor ['CargoRamp_Open', 0]";
			hatch_isopened = "_this doorPhase 'CargoRamp_Open' < 0.5 && alive _this &&((_this getVariable ['bis_disabled_Ramp',0]) != 1)";
			hatch_isclosed = "_this doorPhase 'CargoRamp_Open' > 0.5 && alive _this && ((_this getVariable ['bis_disabled_Ramp',0]) != 1)";
		};
		class B_Heli_Transport_03_F {
			max_width = 0.9;
			max_length = 4.5;
			max_height = 1.65;
			cargo_point[] = {0,3.2,-1.85};
			load_point[] = {0,-7.5,-2.9};
			hatch_open = "_this animateDoor ['Door_rear_source', 1]";
			hatch_close = "_this animateDoor ['Door_rear_source', 0]";
			hatch_isclosed = "_this doorPhase 'Door_rear_source' < 0.5 AND Alive(_this) && ((_this getVariable ['bis_disabled_Ramp',0]) != 1)";
			hatch_isopened = "_this doorPhase 'Door_rear_source' > 0.5 AND Alive(_this) && ((_this getVariable ['bis_disabled_Ramp',0]) != 1)";
		};
		class B_Heli_Transport_03_unarmed_base_F : B_Heli_Transport_03_F {};
		class B_Heli_Transport_03_unarmed_F : B_Heli_Transport_03_F {};
		class B_Heli_Transport_03_unarmed_green_F : B_Heli_Transport_03_F {};
		
		
		class rhs_gaz66_Base {
			max_width = 0.65;
			max_length = 3.1;
			max_height = 1.2;
			cargo_point[] = {0,-1.3,0};
			load_point[] = {0,-5.5,-1};
		};
		class rhs_gaz66_msv : rhs_gaz66_Base {};
		class rhs_gaz66_vdv : rhs_gaz66_msv {};
		class rhs_gaz66_vmf : rhs_gaz66_msv {};
		class rhs_gaz66_vv : rhs_gaz66_msv {};
		
		class rhs_gaz66_flat_msv : rhs_gaz66_Base {
			max_width = 1.9;
		};
		class rhs_gaz66_flat_vdv : rhs_gaz66_flat_msv {};
		class rhs_gaz66_flat_vmf : rhs_gaz66_flat_msv {};
		class rhs_gaz66_flat_vv : rhs_gaz66_flat_msv {};
		
		class rhs_gaz66o_msv : rhs_gaz66_Base {
			cargo_point[] = {0,-1.3,-0.15};
			max_height = 3;
		};
		class rhs_gaz66o_vdv : rhs_gaz66o_msv {};
		class rhs_gaz66o_vmf : rhs_gaz66o_msv {};
		class rhs_gaz66o_vv : rhs_gaz66o_msv {};
		
		
		class rhs_gaz66o_flat_msv : rhs_gaz66o_msv {
			max_width = 1.9;
			max_height = 3;
		};
		class rhs_gaz66o_flat_vdv : rhs_gaz66o_flat_msv {};
		class rhs_gaz66o_flat_vmf : rhs_gaz66o_flat_msv {};
		class rhs_gaz66o_flat_vv : rhs_gaz66o_flat_msv {};
		
		
		class RHS_Ural_Base {
			max_width = 0.65;
			max_length = 3.85;
			max_height = 1.2;
			cargo_point[] = {0,0.55,-0.50};
			load_point[] = {0,-4.8,-2};
		};
		class RHS_Ural_MSV_01 : RHS_Ural_Base {};
		class RHS_Ural_MSV_Base : RHS_Ural_MSV_01 {};
		class RHS_Ural_VDV_01 : RHS_Ural_MSV_01 {};
		class RHS_Ural_VMF_01 : RHS_Ural_MSV_01 {};
		class RHS_Ural_VV_01 : RHS_Ural_MSV_01 {};
		
		class RHS_Ural_Open_MSV_01 : RHS_Ural_Base {
			max_height = 3;
		};
		class RHS_Ural_Open_VDV_01 : RHS_Ural_Open_MSV_01 {};
		class RHS_Ural_Open_VMF_01 : RHS_Ural_Open_MSV_01 {};
		class RHS_Ural_Open_VV_01 : RHS_Ural_Open_MSV_01 {};

		class RHS_Ural_Flat_MSV_01 : RHS_Ural_Base {
			max_width = 2.2;
		};
		class RHS_Ural_Flat_VDV_01 : RHS_Ural_Flat_MSV_01 {};
		class RHS_Ural_Flat_VMF_01 : RHS_Ural_Flat_MSV_01 {};
		class RHS_Ural_Flat_VV_01 : RHS_Ural_Flat_MSV_01 {};
		
		class RHS_Ural_Open_Flat_MSV_01 : RHS_Ural_Flat_MSV_01 {
			max_height = 3;
		};
		class RHS_Ural_Open_Flat_VDV_01 : RHS_Ural_Open_Flat_MSV_01 {};
		class RHS_Ural_Open_Flat_VMF_01 : RHS_Ural_Open_Flat_MSV_01 {};
		class RHS_Ural_Open_Flat_VV_01 : RHS_Ural_Open_Flat_MSV_01 {};
		
		
		class RHS_Mi8mt_Cargo_vdv {
			max_width = 0.65;
			max_length = 4.5;
			max_height = 1.5;
			cargo_point[] = {0,4.5,-2.3};
			load_point[] = {0,-4.8,-2.6};
			hatch_open = "[_this,13,14] call rhs_fnc_mi8_checkDoor";
			hatch_close = "[_this,13,14] call rhs_fnc_mi8_checkDoor";
			hatch_isclosed = "_this doorPhase 'RearDoors' < 0.5 AND alive _this";
			hatch_isopened = "_this doorPhase 'RearDoors' > 0.5 AND alive _this";
		};
		class RHS_Mi8mt_Cargo_vv : RHS_Mi8mt_Cargo_vdv {};
		class RHS_Mi8mt_Cargo_vvs : RHS_Mi8mt_Cargo_vdv {};
		class RHS_Mi8mt_Cargo_vvsc : RHS_Mi8mt_Cargo_vdv {};
		
		class C_Van_01_transport_F {
			max_width = 0.65;
			max_length = 4.5;
			max_height = 1.5;
			cargo_point[] = {0,4.5,-2.3};
			load_point[] = {0,-4.8,-2.6};
		};
		class B_G_Van_01_transport_F : C_Van_01_transport_F {};
		class I_G_Van_01_transport_F : C_Van_01_transport_F {};
		class O_G_Van_01_transport_F : C_Van_01_transport_F {};
		class C_Van_01_transport_white_F : C_Van_01_transport_F {};
		class C_Van_01_transport_red_F : C_Van_01_transport_F {};
			
		class C_Offroad_01_F {
			max_width = 1;
			max_length = 2.1;
			max_height = 3;
			cargo_point[] = {0,-0.7,-0.68};
			load_point[] = {0,-4.5,-1.5};
		};
		class C_Offroad_01_repair_F : C_Offroad_01_F {};
		class B_G_Offroad_01_repair_F : C_Offroad_01_F {};
		class O_G_Offroad_01_repair_F : C_Offroad_01_F {};
		class I_G_Offroad_01_repair_F : C_Offroad_01_F {};
		class I_G_Offroad_01_F : C_Offroad_01_F {};
		class I_G_Offroad_01_armed_F : C_Offroad_01_F {};
		class B_G_Offroad_01_F : C_Offroad_01_F {};
		class O_G_Offroad_01_F : C_Offroad_01_F {};
		class B_G_Offroad_01_armed_F : C_Offroad_01_F {};
		class O_G_Offroad_01_armed_F : C_Offroad_01_F {};
		class C_Offroad_01_red_F : C_Offroad_01_F {};
		class C_Offroad_01_sand_F : C_Offroad_01_F {};
		class C_Offroad_01_white_F : C_Offroad_01_F {};
		class C_Offroad_01_blue_F : C_Offroad_01_F {};
		class C_Offroad_01_darkred_F : C_Offroad_01_F {};
		class C_Offroad_01_bluecustom_F : C_Offroad_01_F {};
		class C_Offroad_luxe_F : C_Offroad_01_F {};
		class C_Offroad_default_F : C_Offroad_01_F {};
		class C_Offroad_stripped_F : C_Offroad_01_F {};
		
		class C_Quadbike_01_F {
			max_width = 0.95;
			max_length = 0.5;
			max_height = 3;
			cargo_point[] = {0,-0.60,-0.46};
			load_point[] = {0,-2,-1.4};
		};
		class B_Quadbike_01_F : C_Quadbike_01_F {};
		class O_Quadbike_01_F : C_Quadbike_01_F {};
		class I_Quadbike_01_F : C_Quadbike_01_F {};
		class I_G_Quadbike_01_F : C_Quadbike_01_F {};
		class B_G_Quadbike_01_F : C_Quadbike_01_F {};
		class O_G_Quadbike_01_F : C_Quadbike_01_F {};
		class C_Quadbike_01_black_F : C_Quadbike_01_F {};
		class C_Quadbike_01_blue_F : C_Quadbike_01_F {};
		class C_Quadbike_01_red_F : C_Quadbike_01_F {};
		class C_Quadbike_01_white_F : C_Quadbike_01_F {};
		
		class B_Truck_01_transport_F {
			max_width = 0.95;
			max_length = 5.62;
			max_height = 3;
			cargo_point[] = {0,0.64,-0.46};
			load_point[] = {0,-6.5,-2};
		};
		class B_Truck_01_covered_F : B_Truck_01_transport_F {
			max_height = 1.5;
		};
		
		class I_Truck_02_transport_F {
			max_width = 0.95;
			max_length = 4.3;
			max_height = 3;
			cargo_point[] = {0,0.64,-0.8};
			load_point[] = {0,-6,-2.1};
		};
		class O_Truck_02_transport_F : I_Truck_02_transport_F {};
		class I_Truck_02_covered_F : I_Truck_02_transport_F {
			max_height = 1.5;
		};
		class O_Truck_02_covered_F : I_Truck_02_covered_F {};
		
		class O_Truck_03_transport_F {
			max_width = 0.95;
			max_length = 4.8;
			max_height = 3;
			cargo_point[] = {0,-0.15,-0.4};
			load_point[] = {0,-6.5,-2.2};
		};
		class O_Truck_03_covered_F : O_Truck_03_transport_F {
			max_height = 1.5;
		};
		
		class B_UGV_01_F {
			max_width = 1.2;
			max_length = 1.1;
			max_height = 1;
			cargo_point[] = {0.43,0.3,-0.7};
			load_point[] = {0,-3,-1.8};
		};
		class O_UGV_01_F : B_UGV_01_F {};
		class I_UGV_01_F : B_UGV_01_F {};
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
		class B_Slingload_01_Cargo_F {
			width = 2.4;
			length = 6.15;
			height = 2.73;
		};
		class B_Slingload_01_Ammo_F : B_Slingload_01_Cargo_F {};
		class B_Slingload_01_Medevac_F : B_Slingload_01_Cargo_F {
			width = 2.4;		
		};
		class B_Slingload_01_Repair_F : B_Slingload_01_Medevac_F {};
		class B_Slingload_01_Fuel_F : B_Slingload_01_Medevac_F {};
		class AmmoVeh_F {
			width = 1.54;
			length = 1.54;
			height = 1.54;
		};
		class Land_Cargo10_base {
			width = 2.5;
			length = 3.1;
			height = 1.25;
		};
		class Land_Cargo10_blue_F : Land_Cargo10_base {};
		class Land_Cargo10_brick_red_F : Land_Cargo10_base {};
		class Land_Cargo10_cyan_F : Land_Cargo10_base {};
		class Land_Cargo10_grey_F : Land_Cargo10_base {};
		class Land_Cargo10_light_blue_F : Land_Cargo10_base {};
		class Land_Cargo10_light_green_F : Land_Cargo10_base {};
		class Land_Cargo10_military_green_F : Land_Cargo10_base {};
		class Land_Cargo10_orange_F : Land_Cargo10_base {};
		class Land_Cargo10_red_F : Land_Cargo10_base {};
		class Land_Cargo10_sand_F : Land_Cargo10_base {};
		class Land_Cargo10_white_F : Land_Cargo10_base {};
		class Land_Cargo10_yellow_F : Land_Cargo10_base {};
		class Land_Cargo20_base {
			width = 6.2;
			length = 2.46;
			height = 2.64;
		};
		class Land_Cargo20_blue_F : Land_Cargo20_base {};
		class Land_Cargo20_brick_red_F : Land_Cargo20_base {};
		class Land_Cargo20_china_color_V1_ruins_F : Land_Cargo20_base {};
		class Land_Cargo20_china_color_V2_ruins_F : Land_Cargo20_base {};
		class Land_Cargo20_color_V1_ruins_F : Land_Cargo20_base {};
		class Land_Cargo20_color_V2_ruins_F : Land_Cargo20_base {};
		class Land_Cargo20_color_V3_ruins_F : Land_Cargo20_base {};
		class Land_Cargo20_cyan_F : Land_Cargo20_base {};
		class Land_Cargo20_grey_F : Land_Cargo20_base {};
		class Land_Cargo20_light_blue_F : Land_Cargo20_base {};
		class Land_Cargo20_light_green_F : Land_Cargo20_base {};
		class Land_Cargo20_military_green_F : Land_Cargo20_base {};
		class Land_Cargo20_military_ruins_F : Land_Cargo20_base {};
		class Land_Cargo20_orange_F : Land_Cargo20_base {};
		class Land_Cargo20_red_F : Land_Cargo20_base {};
		class Land_Cargo20_sand_F : Land_Cargo20_base {};
		class Land_Cargo20_vr_F : Land_Cargo20_base {};
		class Land_Cargo20_white_F : Land_Cargo20_base {};
		
		
		
		
		class CargoBox_V1_F {
			width = 1.54;
			length = 1.54;
			height = 1.54;
		};
		class CargoNet_01_ammo_F {
			width = 1.6;
			length = 1.6;
			height = 1.68;
		};
	};
};