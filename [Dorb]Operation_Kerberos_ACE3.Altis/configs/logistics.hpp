class logistics
{
	class vehicles
	{
		class rhsusf_m1025_base
		{
			max_width = 1.3;
			max_length = 1.05;
			max_height = 0.4;
			hatch_open = "_this animate ['ani_trunk_1', 1];";
			hatch_close = "_this animate ['ani_trunk_1', 0]";
			hatch_isopened = "_this animationPhase 'ani_trunk_1'==1";
			hatch_isclosed = "_this animationPhase 'ani_trunk_1'<0.5";
		};

		class rhsusf_m1025_w : rhsusf_m1025_base
		{
			cargo_point[] = {-0.07,-1.8,-0.85};
			load_point[] = {-0.07,-3.3,-1.9};
		};
		class rhsusf_m1025_d : rhsusf_m1025_w {};

		class rhsusf_m1025_w_m2 : rhsusf_m1025_base
		{
			cargo_point[] = {0,-1.15,1};
			load_point[] = {0,-2.65,0};
		};
		class rhsusf_m1025_d_m2 : rhsusf_m1025_w_m2 {};

		class rhsusf_m1025_w_s_m2 : rhsusf_m1025_w_m2 {};
		class rhsusf_m1025_d_s_m2 : rhsusf_m1025_w_m2 {};
		
		class rhsusf_HEMTT_A2_base {
			max_width = 2;
			max_length = 10.96;
			max_height = 10;
			cargo_point[] = {0,1.48,0.26};
			load_point[] = {0,-6,-1.4};
		};
		class rhsusf_M977A2_usarmy_wd : rhsusf_HEMTT_A2_base {};
		class rhsusf_M977A2_CPK_usarmy_wd : rhsusf_M977A2_usarmy_wd {};
		
		class rhsusf_M1078A1P2_wd_open_fmtv_usarmy {
			max_width = 1.3;
			max_length = 8;
			max_height = 3;
			cargo_point[] = {0,0.9,-0.26};
			load_point[] = {0,-4.5,-1.8};
		};
		
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