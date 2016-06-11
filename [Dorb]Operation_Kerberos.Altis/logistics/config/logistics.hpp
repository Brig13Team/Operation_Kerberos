class logistics
{
	class vehicles {
		class rhsusf_m1025_base {
			max_width = 1.37;
			max_length = 1.19;
			max_height = 0.4;
			hatch_open = "_this animate ['ani_trunk_1', 1];";
			hatch_close = "_this animate ['ani_trunk_1', 0]";
			hatch_isopened = "_this animationPhase 'ani_trunk_1'==1";
			hatch_isclosed = "_this animationPhase 'ani_trunk_1'<0.5";
		};
		class rhsusf_m1025_w : rhsusf_m1025_base	{
			cargo_point[] = {-0.07,-1.68,-0.88};
			load_point[] = {-0.07,-4,-1.88};
		};
		class rhsusf_m1025_d : rhsusf_m1025_w {};
		class rhsusf_m1025_w_s : rhsusf_m1025_w {};
		class rhsusf_m1025_d_s : rhsusf_m1025_w {};

		class rhsusf_m1025_w_m2 : rhsusf_m1025_base {
			cargo_point[] = {0,-1.09,0.97};
			load_point[] = {0,-3,0};
		};
		class rhsusf_m1025_d_m2 : rhsusf_m1025_w_m2 {};
		class rhsusf_m1025_w_s_m2 : rhsusf_m1025_w_m2 {};
		class rhsusf_m1025_d_s_m2 : rhsusf_m1025_w_m2 {};
		
		class rhsusf_m1025_w_mk19 : rhsusf_m1025_base {
			cargo_point[] = {-0.07,-1.68,-0.96};
			load_point[] = {0,-4,-1.9};
		};
		class rhsusf_m1025_d_Mk19 : rhsusf_m1025_w_mk19 {};
		class rhsusf_m1025_d_s_Mk19 : rhsusf_m1025_w_mk19 {};
		class rhsusf_m1025_w_s_Mk19 : rhsusf_m1025_w_mk19 {};
		
		class rhsusf_m1025_2dr_base {
			max_width = 1.28;
			max_length = 2.07;
			max_height = 1.15;
			cargo_point[] = {0,-0.7,-0.9};
			load_point[] = {0,-4,-1.88};
			cargo_pos[] = {{1,{0.708984,-1.67847,-0.334061}},{2,{-0.75293,-0.976318,-0.329685}},{3,{0.892578,-2.48169,-0.56284}},{4,{-0.768555,-1.71436,-0.329685}},{5,{0.699463,-1.01538,-0.334057}},{6,{-0.889404,-2.43628,-0.543262}}};
			
		};
		class rhsusf_m998_w_2dr_fulltop : rhsusf_m1025_2dr_base {};
		class rhsusf_m998_d_2dr_fulltop : rhsusf_m1025_2dr_base {};
		class rhsusf_m998_d_s_2dr_fulltop : rhsusf_m1025_2dr_base {};
		class rhsusf_m998_w_s_2dr_fulltop : rhsusf_m1025_2dr_base {};
		
		class rhsusf_m998_w_2dr_halftop : rhsusf_m1025_2dr_base {
			max_height = 2;
		};
		class rhsusf_m998_w_2dr : rhsusf_m998_w_2dr_halftop {};
		class rhsusf_m998_d_2dr : rhsusf_m998_w_2dr_halftop {};
		class rhsusf_m998_d_2dr_halftop : rhsusf_m998_w_2dr_halftop {};
		class rhsusf_m998_d_s_2dr : rhsusf_m998_w_2dr_halftop {};
		class rhsusf_m998_d_s_2dr_halftop : rhsusf_m998_w_2dr_halftop {};
		class rhsusf_m998_w_s_2dr : rhsusf_m998_w_2dr_halftop {};
		class rhsusf_m998_w_s_2dr_halftop : rhsusf_m998_w_2dr_halftop {};

		class rhsusf_m998_w_4dr_base {
			max_width = 1.18;
			max_length = 1.36;
			max_height = 1;
			cargo_point[] = {0,-1.1,0.91};
			load_point[] = {0,-3,0};
			cargo_pos[] = {{3,{0.895508,-1.92554,1.22625}},{4,{-0.886475,-1.88013,1.24583}}};
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
		
		
		class rhsusf_M977A4_usarmy_wd {
			max_width = 2.1;
			max_length = 5.48;
			max_height = 2;
			cargo_point[] = {0,-0.25,0.67};
			load_point[] = {0,-8.5,-1};
		};
		class rhsusf_M977A4_usarmy_d : rhsusf_M977A4_usarmy_wd {};
        class rhsusf_M977A4_BKIT_usarmy_d : rhsusf_M977A4_usarmy_wd {};
        class rhsusf_M977A4_BKIT_usarmy_wd : rhsusf_M977A4_usarmy_wd {};
		class rhsusf_M977A4_BKIT_M2_usarmy_wd : rhsusf_M977A4_usarmy_wd {
			cargo_point[] = {0,1.2,0.31};
			load_point[] = {0,-7,-1.5};
		};
		class rhsusf_M977A4_BKIT_M2_usarmy_d : rhsusf_M977A4_BKIT_M2_usarmy_wd {};
		
        
		class rhsusf_M1078A1P2_Base {
			max_width = 1.42;
			max_length = 4;
			max_height = 1.6;
			cargo_point[] = {0,0.9,-0.275};
			load_point[] = {0,-5,-1.8};
			cargo_pos[] = {{2,{0.976318,-0.276855,0.240028}},{3,{-0.911133,-0.111816,0.22155}},{4,{0.966553,-0.783203,0.216396}},{5,{-0.89502,-0.572998,0.222111}},{6,{0.945801,-1.34277,0.230221}},{7,{-0.870361,-1.23267,0.23098}},{8,{0.976563,-2.04443,0.258591}},{9,{-0.822998,-1.89551,0.267666}},{10,{1.09644,-2.82446,0.156582}},{11,{-1.00513,-2.56665,0.162479}},{12,{0.949707,0.561768,0.222698}},{13,{-0.934326,0.59375,0.221748}}};
		};
		class rhsusf_M1078A1P2_d_open_fmtv_usarmy : rhsusf_M1078A1P2_Base {};
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
		class rhsusf_M1078A1P2_B_d_flatbed_fmtv_usarmy : rhsusf_M1078A1P2_Base {
			max_width = 2.3;
			max_height = 3;
			cargo_pos[] = {};
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
			max_width = 1.75;
			max_length = 2.2;
			max_height = 1.2;
			cargo_point[] = {0,3,-1.97};
			load_point[] = {2.5,1.8,-2.6};
			cargo_pos[] = {{0,{-0.278809,0.646973,-1.41742}},{1,{0.256348,0.77832,-1.439}},{2,{0.506836,3.24902,-1.40997}},{5,{-0.0124512,2.23926,-1.80701}},{6,{0.651855,2.59814,-1.89564}},{7,{0.045166,3.26758,-1.80677}},{8,{-0.811768,0.431152,-1.56857}},{9,{0.722168,0.530762,-1.57194}}};
			hatch_open = "_this animateDoor ['doorRB', 1];_this animate ['doorHandler_R',1]";
			hatch_close = "_this animateDoor ['doorRB', 0];_this animate ['doorHandler_R',0];";
			hatch_isopened = "_this doorPhase 'doorRB' > 0 and (alive _this)";
			hatch_isclosed = "_this doorPhase 'doorRB' == 0 and (alive _this)";
		};
		class RHS_UH60M_MEV2_d : RHS_UH60M_Base {};
		class RHS_UH60M_MEV2 : RHS_UH60M_Base {};
		class RHS_UH60M_MEV : RHS_UH60M_Base {};
		class RHS_UH60M_MEV_d : RHS_UH60M_Base {};
		
		class RHS_MELB_MH6M {
			max_width = 1;
			max_length = 0.9;
			max_height = 0.8;
			cargo_point[] = {0,1,-1.25};
			load_point[] = {2,1,-1.9};
		};
		class RHS_MELB_H6M : RHS_MELB_MH6M {
			max_width = 0.5;
			max_length = 0.7;
			cargo_pos[] = {{0,{0.103516,0.730957,-1.11869}}};
		};
		
		
		class RHS_CH_47_Base {
			max_width = 1.14;
			max_length = 7.85;
			max_height = 1.6;
			cargo_point[] = {0,3.7,-2.705};
			load_point[] = {0,-9,-3.5};
			cargo_pos[] = {{0,{-0.792969,2.28027,-2.4}},{1,{0.810059,2.30029,-2.4}},{2,{0.810303,1.69971,-2.4}},{3,{0.810059,1.07764,-2.4}},{4,{0.810059,0.455078,-2.4}},{5,{0.810303,-0.162109,-2.4}},{6,{0.810303,-0.757813,-2.4}},{7,{0.810303,-1.35303,-2.4}},{8,{0.810303,-1.95459,-2.4}},{9,{0.810059,-2.55566,-2.4}},{10,{0.810303,-3.14502,-2.4}},{11,{0.937744,-3.73535,-2.4}},{12,{-0.792725,-3.16553,-2.4}},{13,{-0.792725,-2.56543,-2.4}},{14,{-0.792725,-1.94189,-2.4}},{15,{-0.792725,-1.31934,-2.4}},{16,{-0.792725,-0.70166,-2.4}},{17,{-0.792725,-0.106445,-2.4}},{18,{-0.792725,0.489258,-2.4}},{19,{-0.958252,-3.76416,-2.4}},{20,{-0.792725,1.08984,-2.4}},{21,{-0.792969,1.69043,-2.4}},{23,{-0.792725,2.87012,-2.4}}};
			hatch_open = "_this animateDoor ['ramp_anim', 1];";
			hatch_close = "_this animateDoor ['ramp_anim', 0];";
			hatch_isopened = "_this doorPhase 'ramp_anim' > 0 and (alive _this)";
			hatch_isclosed = "_this doorPhase 'ramp_anim' == 0 and (alive _this)";
            class cargo {
                max_width = 2.3;
                extend = "_this animate ['hide_cargo',1];_this lockCargo true;";
                isextended = "(_this animationPhase 'hide_cargo') > 0";
                reduce = "_this animate ['hide_cargo',0];_this lockCargo false;";
                isreduced = "(_this animationPhase 'hide_cargo') == 0";
            };
		};
		class RHS_CH_47F_light : RHS_CH_47_Base {};
		class RHS_CH_47F_10 : RHS_CH_47_Base {};
		class RHS_CH_47F : RHS_CH_47_Base {};
        
        class RHS_C130J {
            class cargo {
                extend = "_this animate ['hide_cargo',1];_this lockCargo true;";
                isextended = "(_this animationPhase 'hide_cargo') > 0";
                reduce = "_this animate ['hide_cargo',0];_this lockCargo false;";
                isreduced = "(_this animationPhase 'hide_cargo') == 0";
            };
        };
		class rhsusf_CH53E_USMC {
			max_width = 1.6;
			max_length = 8;
			max_height = 2.25;
			cargo_point[] = {0,3.7,-1.25};
			load_point[] = {0,-9,-2.05};
			cargo_pos[] = {{0,{-1.13281,1.36523,-1.6806}},{1,{1.11328,1.36523,-1.67838}},{2,{-1.13281,0.90625,-1.677}},{3,{1.11328,0.90625,-1.6748}},{4,{-1.13477,0.4375,-1.67331}},{5,{1.11328,0.4375,-1.67114}},{6,{-1.13477,-0.0351563,-1.66959}},{7,{1.11328,-0.0351563,-1.66742}},{8,{-1.13477,-0.494141,-1.66586}},{9,{1.11523,-0.494141,-1.66373}},{10,{-1.13281,-0.958984,-1.6622}},{11,{1.11523,-0.958984,-1.66006}},{12,{-1.13281,-1.42773,-1.65854}},{13,{1.11523,-1.42578,-1.65634}},{14,{-1.13281,-1.90039,-1.65482}},{15,{1.11328,-1.89844,-1.65259}},{16,{-1.13281,-2.36523,-1.65112}},{17,{1.11328,-2.36523,-1.64896}},{18,{-1.13281,-2.83984,-1.6474}},{19,{1.11328,-2.83984,-1.6452}},{20,{-1.13281,-3.32031,-1.64365}},{21,{1.11328,-3.32031,-1.64145}},{22,{-1.13086,-3.7793,-1.64319}},{23,{1.11523,-3.7793,-1.64099}},{24,{-1.13281,-4.26172,-1.64417}},{25,{1.11523,-4.25977,-1.6409}},{26,{-1.13281,-4.74414,-1.64648}},{27,{1.11719,-4.74414,-1.63882}},{28,{-1.13281,-5.19141,-1.64346}},{29,{1.11719,-5.19141,-1.63458}}};
			hatch_open = "this animate ['ramp_bottom',1]; this animate ['ramp_top',1];";
			hatch_close = "this animate ['ramp_bottom',0]; this animate ['ramp_top',0];";
			hatch_isopened = "(_this animationPhase 'ramp_bottom' > 0) and (_this animationPhase 'ramp_top' > 0) and (alive _this)";
			hatch_isclosed = "(_this animationPhase 'ramp_bottom' == 0) and (_this animationPhase 'ramp_top' == 0) and (alive _this)";
		};
		class rhsusf_CH53E_USMC_D : rhsusf_CH53E_USMC {};
		
		class I_Heli_Transport_02_F {
			max_width = 1.5;
			max_length = 7.2;
			max_height = 1.681;
			cargo_point[] = {0,5.15,-2.28};
			load_point[] = {0,-7,-3.5};
			cargo_pos[] = {{0,{1.03467,-0.620361,-1.84832}},{1,{-1.05518,-1.60986,-1.82812}},{2,{-1.09351,1.62793,-1.86387}},{3,{1.06567,4.25537,-1.89248}},{4,{-1.05249,-1.08252,-1.83032}},{5,{1.03955,1.03442,-1.84832}},{6,{1.03662,0.507324,-1.85052}},{7,{-1.05835,0.0449219,-1.82812}},{8,{1.03345,3.70508,-1.89028}},{9,{-1.0376,3.84424,-1.87839}},{10,{1.06885,4.78247,-1.89028}},{11,{1.02344,-0.0537109,-1.86718}},{12,{-1.05762,-0.521484,-1.84699}},{13,{-1.06909,1.09399,-1.86302}},{14,{-1.05151,0.570313,-1.84699}},{15,{-1.05908,3.19116,-1.8804}}};
			hatch_open = "this animateDoor ['CargoRamp_Open', 1]";
			hatch_close = "this animateDoor ['CargoRamp_Open', 0]";
			hatch_isopened = "_this doorPhase 'CargoRamp_Open' > 0.5 && alive _this &&((_this getVariable ['bis_disabled_Ramp',0]) != 1)";
			hatch_isclosed = "_this doorPhase 'CargoRamp_Open' < 0.5 && alive _this && ((_this getVariable ['bis_disabled_Ramp',0]) != 1)";
		};
		class B_Heli_Transport_03_F {
			max_width = 1.24;
			max_length = 4.9;
			max_height = 1.9;
			cargo_point[] = {0,3.5,-1.85};
			load_point[] = {0,-7.5,-2.9};
			cargo_pos[] = {{0,{0.900146,-1.27075,-1.41133}},{1,{-1.02368,-1.28198,-1.36913}},{2,{-0.96582,-0.805176,-1.27439}},{3,{-0.964355,2.74097,-1.32649}},{4,{-0.862549,1.52344,-1.33102}},{5,{-0.96582,0.929443,-1.27439}},{6,{-0.924316,0.343506,-1.29086}},{7,{-0.893066,-0.358398,-1.33393}},{8,{0.884766,2.76025,-1.20922}},{9,{0.831543,2.15332,-1.30203}},{10,{0.815186,1.58936,-1.27465}},{11,{-1.03101,2.15234,-1.24337}},{12,{0.883301,0.424561,-1.26928}},{13,{0.869873,-0.226563,-1.24822}},{14,{0.849854,0.976807,-1.21664}},{15,{0.911621,-0.733887,-1.28053}}};
			hatch_open = "_this animateDoor ['Door_rear_source', 1]";
			hatch_close = "_this animateDoor ['Door_rear_source', 0]";
			hatch_isclosed = "_this doorPhase 'Door_rear_source' < 0.5 AND Alive(_this) && ((_this getVariable ['bis_disabled_Ramp',0]) != 1)";
			hatch_isopened = "_this doorPhase 'Door_rear_source' > 0.5 AND Alive(_this) && ((_this getVariable ['bis_disabled_Ramp',0]) != 1)";
		};
		class B_Heli_Transport_03_unarmed_base_F : B_Heli_Transport_03_F {
			cargo_pos[] = {{2,{0.900146,-1.27075,-1.41132}},{3,{-1.02344,-1.28198,-1.36913}},{4,{-0.96582,-0.805176,-1.27439}},{5,{-0.964355,2.74097,-1.32649}},{6,{-0.862305,1.52344,-1.331}},{7,{-0.965576,0.929688,-1.27438}},{8,{-0.924316,0.34375,-1.29085}},{9,{-0.893066,-0.358398,-1.33393}},{10,{0.88501,2.76025,-1.20921}},{11,{0.831543,2.15308,-1.30202}},{12,{0.81543,1.5896,-1.27464}},{13,{-1.03076,2.1521,-1.24336}},{14,{0.883301,0.424805,-1.26928}},{15,{0.869873,-0.226807,-1.24821}},{16,{0.850098,0.976807,-1.21664}},{17,{0.911865,-0.733643,-1.28053}}};
		};
		class B_Heli_Transport_03_unarmed_F : B_Heli_Transport_03_unarmed_base_F {};
		class B_Heli_Transport_03_unarmed_green_F : B_Heli_Transport_03_unarmed_base_F {};
		
		
		class rhs_gaz66_Base {
			max_width = 1.2;
			max_length = 3.21;
			max_height = 1.3;
			cargo_point[] = {0,-1.18,-0.15};
			load_point[] = {0,-5.5,-1};
			cargo_pos[] = {{1,{0.729492,-1.89258,0.201985}},{2,{0.741211,-2.42676,0.20177}},{3,{-0.718506,-1.94897,0.189565}},{4,{0.727539,-2.9375,0.17837}},{5,{-0.735352,-2.49023,0.212108}},{6,{0.729736,-3.47314,0.220933}},{7,{-0.694092,-3.08911,0.202725}},{8,{0.846191,-4.04785,0.178417}},{9,{-0.71167,-3.64648,0.211024}},{10,{0.731201,-1.40088,0.139123}},{11,{-0.893799,-4.11328,0.172961}},{12,{-0.744629,-1.39771,0.161706}}};
		};
		class rhs_gaz66_msv : rhs_gaz66_Base {};
		class rhs_gaz66_vdv : rhs_gaz66_msv {};
		class rhs_gaz66_vmf : rhs_gaz66_msv {};
		class rhs_gaz66_vv : rhs_gaz66_msv {};
		
		class rhs_gaz66_flat_msv : rhs_gaz66_Base {
			cargo_pos = [];
			max_width = 2;
		};
		class rhs_gaz66_flat_vdv : rhs_gaz66_flat_msv {};
		class rhs_gaz66_flat_vmf : rhs_gaz66_flat_msv {};
		class rhs_gaz66_flat_vv : rhs_gaz66_flat_msv {};
		
		class rhs_gaz66o_msv : rhs_gaz66_Base {
			cargo_point[] = {0,-1.18,-0.155};
			max_height = 3;
		};
		class rhs_gaz66o_vdv : rhs_gaz66o_msv {};
		class rhs_gaz66o_vmf : rhs_gaz66o_msv {};
		class rhs_gaz66o_vv : rhs_gaz66o_msv {};
		
		
		class rhs_gaz66o_flat_msv : rhs_gaz66o_msv {
			cargo_pos = [];
			max_width = 2;
			max_height = 3;
		};
		class rhs_gaz66o_flat_vdv : rhs_gaz66o_flat_msv {};
		class rhs_gaz66o_flat_vmf : rhs_gaz66o_flat_msv {};
		class rhs_gaz66o_flat_vv : rhs_gaz66o_flat_msv {};
		
		
		class RHS_Ural_Base {
			max_width = 1.42;
			max_length = 3.91;
			max_height = 1.3;
			cargo_point[] = {0,0.58,-0.51};
			load_point[] = {0,-4.8,-2};
			cargo_pos[] = {{2,{0.928223,-0.481201,0.00296974}},{3,{-0.959229,-0.316406,-0.0155029}},{4,{0.918213,-1.14648,0.0031023}},{5,{-0.943115,-0.936035,0.00881863}},{6,{0.897705,-1.74829,0.0105124}},{7,{-0.918701,-1.63818,0.0112734}},{8,{0.928223,-2.43945,0.0029707}},{9,{-0.871094,-2.29053,0.0120487}},{10,{1.04834,-3.08179,-0.0778742}},{11,{-1.05322,-2.82373,-0.0719767}},{12,{0.901367,0.202881,0.0134029}},{13,{-0.982422,0.365723,0.00881863}}};
		};
		class RHS_Ural_MSV_01 : RHS_Ural_Base {};
		class RHS_Ural_MSV_Base : RHS_Ural_Base {};
		class RHS_Ural_VDV_01 : RHS_Ural_Base {};
		class RHS_Ural_VMF_01 : RHS_Ural_Base {};
		class RHS_Ural_VV_01 : RHS_Ural_Base {};
		class rhs_ural_chdkz : RHS_Ural_Base {};
		class rhs_ural_work_open_chdkz : RHS_Ural_Base {};
		class rhs_ural_work_chdkz : RHS_Ural_Base {};
		class RHS_Ural_Civ_01 : RHS_Ural_Base {};
		class RHS_Ural_Civ_02 : RHS_Ural_Base {};
		class RHS_Ural_Civ_03 : RHS_Ural_Base {};
		
		class RHS_Ural_Open_MSV_01 : RHS_Ural_Base {
			max_height = 3;
		};
		class RHS_Ural_Open_VDV_01 : RHS_Ural_Open_MSV_01 {};
		class RHS_Ural_Open_VMF_01 : RHS_Ural_Open_MSV_01 {};
		class RHS_Ural_Open_VV_01 : RHS_Ural_Open_MSV_01 {};

		class RHS_Ural_Flat_MSV_01 : RHS_Ural_Base {
			cargo_pos[] = {};
			max_width = 1.3;
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
		
		class rhs_ural_open_chdkz : RHS_Ural_Base {
			cargo_point[] = {0,0.36,1.51};
			load_point[] = {0,-5,-0.05};
			cargo_pos[] = {{2,{0.976318,-0.700195,2.0257}},{3,{-0.911133,-0.535156,2.00722}},{4,{0.966553,-1.36523,2.02583}},{5,{-0.89502,-1.15527,2.03154}},{6,{0.945801,-1.96753,2.03324}},{7,{-0.870361,-1.85742,2.034}},{8,{0.976318,-2.65845,2.0257}},{9,{-0.822998,-2.50952,2.03477}},{10,{1.09668,-3.30054,1.94485}},{11,{-1.00513,-3.04272,1.95075}},{12,{0.949463,-0.0161133,2.03613}},{13,{-0.934082,0.146729,2.03154}}};
		};
		class RHS_Ural_Open_Civ_01 : rhs_ural_open_chdkz {};
		class RHS_Ural_Open_Civ_02 : rhs_ural_open_chdkz {};
		class RHS_Ural_Open_Civ_03 : rhs_ural_open_chdkz {};
		
		
		
		class RHS_Mi8mt_Cargo_vdv {
			max_width = 1.3;
			max_length = 4.5;
			max_height = 1.7;
			cargo_point[] = {0.04,4.5,-2.3};
			load_point[] = {0.04,-4.2,-2.6};
			cargo_pos[] = {0.04,-4.2,-2.6};
			hatch_open = "[_this,13,14] call rhs_fnc_mi8_checkDoor";
			hatch_close = "[_this,13,14] call rhs_fnc_mi8_checkDoor";
			hatch_isclosed = "_this doorPhase 'RearDoors' < 0.5 AND alive _this";
			hatch_isopened = "_this doorPhase 'RearDoors' > 0.5 AND alive _this";
		};
		class RHS_Mi8mt_Cargo_vv : RHS_Mi8mt_Cargo_vdv {};
		class RHS_Mi8mt_Cargo_vvs : RHS_Mi8mt_Cargo_vdv {};
		class RHS_Mi8mt_Cargo_vvsc : RHS_Mi8mt_Cargo_vdv {};
		
		class C_Van_01_transport_F {
			max_width = 1.78;
			max_length = 3.5;
			max_height = 3;
			cargo_point[] = {0,-0.27,-0.61};
			load_point[] = {0,-4.5,-1.8};
			cargo_pos[] = {{2,{-0.29126,-0.64624,-0.340263}},{3,{0.244141,-0.482666,-0.333824}},{4,{-0.318848,-1.2644,-0.340263}},{5,{0.292969,-1.11646,-0.333824}},{6,{-0.227539,-1.85449,-0.340256}},{7,{0.136719,-1.69946,-0.333817}},{8,{-0.336914,-2.4624,-0.340248}},{9,{0.216309,-2.34131,-0.333832}},{10,{-0.219482,-2.81885,-0.34024}},{11,{0.245361,-2.89941,-0.333817}}};
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
			cargo_pos[] = {{1,{0.156494,-2.36548,-0.582111}},{2,{-0.401855,-2.30591,-0.539322}},{3,{0.225586,-1.03101,-0.562904}},{4,{-0.420898,-1.05713,-0.601166}}};
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
			cargo_pos[] = {{0,{-0.000488281,-0.72876,-0.561487}}};
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
			max_width = 1.35;
			max_length = 5.67;
			max_height = 3;
			cargo_point[] = {0.04,0.69,-0.52};
			load_point[] = {0,-6.5,-2};
			cargo_pos[] = {{1,{-0.845947,0.308105,-0.0460548}},{2,{-0.760986,-1.05225,-0.0816498}},{3,{-0.89917,-1.75024,-0.0369987}},{4,{-0.796875,-2.4458,-0.0179596}},{5,{-0.822021,-3.14771,-0.0730324}},{6,{-0.862305,-3.76904,-0.10585}},{7,{-0.794434,-4.53223,0.0289612}},{8,{0.914307,0.256836,-0.00505829}},{9,{0.952881,-0.389404,-0.1259}},{10,{0.930908,-1.06177,0.0975723}},{11,{1.00391,-1.72632,0.0622673}},{12,{0.941895,-2.50342,-0.0333099}},{13,{0.950439,-3.2124,0.0712204}},{14,{0.92334,-3.87109,0.10128}},{15,{0.906006,-4.50146,0.0572395}},{16,{-0.658936,-0.373779,-0.0366364}}};
		};
		class B_Truck_01_covered_F : B_Truck_01_transport_F {
			max_height = 1.5;
		};
		
		class I_Truck_02_transport_F {
			max_width = 1.44;
			max_length = 4.78;
			max_height = 3;
			cargo_point[] = {0.03,1.13,-0.78};
			load_point[] = {0,-5,-2.1};
			cargo_pos[] = {{2,{-0.853271,0.870605,-0.247144}},{3,{0.926758,0.834229,-0.186244}},{4,{-0.992432,0.197998,-0.275644}},{5,{0.94458,0.116943,-0.0925169}},{6,{-0.93042,-0.552734,-0.2266}},{7,{0.984131,-0.611816,-0.185123}},{8,{-0.901123,-1.21484,-0.321939}},{9,{0.832275,-1.18018,-0.210837}},{10,{-0.854736,-1.90991,-0.279305}},{11,{0.915039,-1.86792,-0.157696}},{12,{-0.976318,-2.50806,-0.234854}},{13,{0.881836,-2.52759,-0.14458}},{14,{-0.937256,-3.2251,-0.22392}},{15,{0.986816,-3.23999,-0.212337}}};
		};
		class O_Truck_02_transport_F : I_Truck_02_transport_F {};
		class I_Truck_02_covered_F : I_Truck_02_transport_F {
			max_height = 1.5;
			load_point[] = {0,-5,-2.3};
		};
		class O_Truck_02_covered_F : I_Truck_02_covered_F {};
		
		class O_Truck_03_transport_F {
			max_width = 1.3;
			max_length = 4.96;
			max_height = 1.3;
			cargo_point[] = {0.08,0,-0.4};
			load_point[] = {0,-6.4,-2.3};
			cargo_pos[] = {{1,{-0.855469,-0.567383,0.0992355}},{2,{-0.753418,-2.15259,0.0947189}},{3,{-0.856934,-2.90942,0.151344}},{4,{-0.815186,-3.64014,0.161163}},{5,{-0.860596,-4.49927,0.190483}},{6,{0.993896,-0.547852,0.216515}},{7,{0.940674,-1.39673,0.118469}},{8,{0.924316,-2.08667,0.151085}},{9,{-0.921875,-1.39771,0.177132}},{10,{0.992432,-3.55933,0.182732}},{11,{0.999512,-4.53369,0.198517}},{12,{0.958984,-2.8623,0.209091}}};
		};
		class O_Truck_03_covered_F : O_Truck_03_transport_F {
			max_height = 3;
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
		class ace_track {
			width = 0.54;
			length = 0.4;
			height = 0.15;
			offset[] = {0,-0.3,0};
		};
		class ace_wheel {
			width = 1;
			length = 1;
			height = 0.32;
			offset[] = {0,-0.5,-0.12};
		};
		class WpnsBox_F {
			width = 1.1;
			length = 0.73;
			height = 0.344;
			offset[] = {0,0,0.023};
		};
		class AmmoBox_F {
			width = 0.45;
			length = 0.72;
			height = 0.6;
			offset[] = {0,0,0.025};
		};
		class WpnsBox_large_F {
			width = 1.63;
			length = 0.73;
			height = 0.344;
			offset[] = {0,0,0.023};
		};
		class WpnsBox_long_F {
			width = 1.63;
			length = 0.34;
			height = 0.344;
			offset[] = {0,0,0.023};
		};
		class Supplydrop {
			width = 1.54;
			length = 1.05;
			height = 1.35;
			offset[] = {0,0,-0.215};
		};
		class ace_medcrate {
			width = 1.3;
			length = 0.4;
			height = 0.35;
		};
		
		class bwa3_democracybox {
			width = 2.55;
			length = 5.8;
			height = 2.3;
			offset[] = {0,0,1.15};
		};
		class B_Slingload_01_Cargo_F {
			width = 2.45;
			length = 6.25;
			height = 2.73;
		};
		class B_Slingload_01_Medevac_F : B_Slingload_01_Cargo_F {
			width = 2.7;		
		};
		class B_Slingload_01_Ammo_F : B_Slingload_01_Cargo_F {};
		class B_Slingload_01_Repair_F : B_Slingload_01_Cargo_F {};
		class B_Slingload_01_Fuel_F : B_Slingload_01_Cargo_F {};
		class AmmoVeh_F {
			width = 1.54;
			length = 1.54;
			height = 1.54;
			offset[] = {0,0,-0.05};
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
			offset[] = {0,0,-0.05};
		};
		class CargoNet_01_ammo_F {
			width = 1.6;
			length = 1.6;
			height = 1.68;
		};
		class M119 {
			width = 2;
			length = 5.1;
			height = 1.5;
			offset[] = {0,-1.3,0.9};
		};
		class D30 : M119 {
			offset[] = {0,0.6,-0.7};
		};
		
        class FIM92_static {
            width = 3;
			length = 3;
			height = 2;
			offset[] = {0,0,-0.5};
        };
        
        class TOW_static {
            width = 1.7;
			length = 1.7;
			height = 1.2;
			offset[] = {0,0.5,-0.5};
        };
        
        class m2_mg2 {
            width = 1.2;
			length = 2;
			height = 0.7;
			offset[] = {-0.35,0.6,-0.9};
        };
        
        class m2_mg {
            width = 1.2;
			length = 1.9;
			height = 1.5;
			offset[] = {-0.35,0.6,-1};
        };
        
        class mk19_stat {
            width = 1.2;
			length = 1.2;
			height = 0.7;
			offset[] = {0,0.8,-0.7};
        };
        
        class Quadbike_01_F {
            width = 1.2;
			length = 2.2;
			height = 1;
			offset[] = {0,-0.05,-0.9};
        };
        
        class SDV_01_F {
            width = 2;
			length = 6.2;
			height = 1.5;
			offset[] = {0,-1.1,-1.2};
        };
        
        class Boat_Transport_01_F {
            width = 2.1;
			length = 4.9;
			height = 1.5;
			offset[] = {0,0,-0.5};
        };
        
        class rhs_3Ya40_1 {
            width = 2.5;
			length = 0.9;
			height = 0.8;
			offset[] = {0,0,-0.05};
        };
        
        class rhs_7ya37_1 {
            width = 1.15;
			length = 0.45;
			height = 0.55;
			offset[] = {0,0,0};
        };
		class 81Mortar {
			width = 0.6;
			length = 1.2;
			height = 1.2;
			offset[] = {0,0.4,-0.2};
		};
	};
};