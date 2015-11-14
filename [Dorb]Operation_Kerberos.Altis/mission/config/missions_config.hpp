class missions_config {
	class side_base {
		locations[] = {QGVAR(town),QGVAR(industrie),QGVAR(military),QGVAR(other)};
		location_distance = 500;
		delay_spawn = 600;
		delay_reveal = 300;
	};
	class main_base {
		probability = 1;
		location_distance = 1500;
		locations[] = {QGVAR(town),QGVAR(industrie),QGVAR(military),QGVAR(other)};
		armys[] = {{"regular",1},{"armored",1},{"infanterie",1},{"airborne",1},{"specops",1},{"specialoperations",1},{"guards",1}};
	};
	class side_arty : side_base {
		locations[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
		location_distance = 2000;
		delay_spawn = 0;
		delay_reveal = 900; // delay until the mission is revealed
	};
	class side_ugv : side_base {
		locations[] = {QGVAR(water)};
		location_distance = 500;
	};
	class main {
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
			locations[] = {QGVAR(industrie),QGVAR(military)QGVAR(other)};
		};
		class emp : main_base {
			name = CSTRING(emp_task);
			description = CSTRING(emp_desc);
			locations[] = {QGVAR(industrie),QGVAR(military)QGVAR(other)};
		};
		class prototype : main_base {
			name = CSTRING(prototype_task);
			description = CSTRING(prototype_desc);
		};
		class clear : main_base {
			name = CSTRING(clear_task);
			description = CSTRING(clear_desc);
			locations[] = {QGVAR(industrie),QGVAR(military)QGVAR(other)};
		};
		
		class hostage : main_base {
			name = CSTRING(hostage_task);
			description = CSTRING(hostage_desc);
			locations[] = {QGVAR(town)};
		};
		class kill : main_base {
			name = CSTRING(kill_task);
			description = CSTRING(kill_desc);
			locations[] = {QGVAR(town)};
		};
		class intel : main_base {
			name = CSTRING(intel_task);
			description = CSTRING(intel_desc);
			locations[] = {QGVAR(town)};
		};
		class weaponcaches : main_base {
			name = CSTRING(weaponcaches_task);
			description = CSTRING(weaponcaches_desc);
			locations[] = {QGVAR(town)};
		};
	};
};