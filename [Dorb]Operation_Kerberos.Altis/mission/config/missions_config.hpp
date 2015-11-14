class missions_config {
	class side_base {
		locations[] = {"town","industrie","military","other"};
		location_distance = 500;
		delay_spawn = 600;
		delay_reveal = 300;
	};
	class main_base {
		location_distance = 1500;
		locations[] = {"town","industrie","military","other"};
	};
	class side_arty : side_base {
		locations[] = {"town","industrie","military","other"};
		location_distance = 2000;
		delay_spawn = 0;
		delay_reveal = 900; // delay until the mission is revealed
	};
	class side_ugv : side_base {
		locations[] = {"water"};
		location_distance = 500;
	};

	class scarab : main_base {
		name = CSTRING(scarab_task);
		description = CSTRING(scarab_desc);
		class sidemissions : {
			class artillery : side_arty {};
			class ugv : side_ugv{};
		};
	};
	class tower : main_base {
		name = CSTRING(tower_task);
		description = CSTRING(tower_desc);
		location_distance = 1500;
	};
	class device : main_base {
		name = CSTRING(device_task);
		description = CSTRING(device_desc);
		locations[] = {"industrie","military","other"};
	};
	class emp : main_base {
		name = CSTRING(emp_task);
		description = CSTRING(emp_desc);
		locations[] = {"industrie","military","other"};
	};
	class prototype : main_base {
		name = CSTRING(prototype_task);
		description = CSTRING(prototype_desc);
	};
	class clear : main_base {
		name = CSTRING(clear_task);
		description = CSTRING(clear_desc);
		locations[] = {"industrie","military","other"};
	};
	
	class hostage : main_base {
		name = CSTRING(hostage_task);
		description = CSTRING(hostage_desc);
		locations[] = {"town"};
	};
	class kill : main_base {
		name = CSTRING(kill_task);
		description = CSTRING(kill_desc);
		locations[] = {"town"};
	};
	class intel : main_base {
		name = CSTRING(intel_task);
		description = CSTRING(intel_desc);
		locations[] = {"town"};
	};
	class weaponcaches : main_base {
		name = CSTRING(weaponcaches_task);
		description = CSTRING(weaponcaches_desc);
		locations[] = {"town"};
	};
};