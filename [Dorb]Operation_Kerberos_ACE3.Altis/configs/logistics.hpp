class logistics
{
	class vehicles
	{
		/*
		class B_Truck_01_transport_F
		{
			x_axis = 0;
			max_with = 1;
			max_height = -1;
		};

		class B_Truck_01_covered_F
		{
			x_axis = 0;
			max_with = 1;
			max_height = -1;
		};
		*/
		class rhsusf_m1025_base
		{
			point[] = {0,-1.8,-0.85};
			max_width = 1.4;
			max_length = 1.05;
			max_height = 0.4;
		};

		class rhsusf_m1025_w : rhsusf_m1025_base {};
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