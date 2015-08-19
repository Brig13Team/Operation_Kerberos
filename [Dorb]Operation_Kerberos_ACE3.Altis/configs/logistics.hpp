class logistics
{
	class vehicles
	{
		class rhsusf_m1025_base
		{
			max_width = 1.3;
			max_length = 1.05;
			max_height = 0.4;
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
	};

	class cargos
	{
		class Box_NATO_Wps_F
		{
			width = 1.1;
			length = 0.64;
			height = 0.38;
		};
	};
};