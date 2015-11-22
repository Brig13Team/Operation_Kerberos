#define CBA_OFF
#include "script_component.hpp"
class missions_config {
	class side_base {
		class task {
			name = "";
			description = "";
			tasktype = "";
			taskmarker = "";
		};
		class location {
			areas[] = {QGVAR(town),QGVAR(industrie),QGVAR(military),QGVAR(other)};
			distance = 500;
		};
		delay_spawn = 600;
		delay_reveal = 300;
		probability = 1;
	};
	class main_base {
		class task {
			name = "";
			description = "";
			tasktype = "";
			taskmarker = "";
		};
		class location {
			areas[] = {QGVAR(town),QGVAR(industrie),QGVAR(military),QGVAR(other)};
			distance = 1500;
		};
		probability = 1;
		armys[] = {{"regular",1},{"armored",1},{"infanterie",1},{"airborne",1},{"specops",1},{"droneoperations",1},{"guards",1}};
	};
	class side_arty : side_base {
		class location : location {
			areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
			distance = 2000;
		};
		delay_spawn = 0;
		delay_reveal = 900; // delay until the mission is revealed
	};
	class side_ugv : side_base {
		class location : location {
			areas[] = {QGVAR(water),QGVAR(military),QGVAR(other)};
			distance = 500;
		};
	};
	class main {
		class scarab : main_base {
			class task {
				name = CSTRING(scarab_task);
				description = CSTRING(scarab_desc);
			};
			class sidemissions : side_base {
				class artillery : side_arty {};
				class ugv : side_ugv{};
			};
		};
		class tower : main_base {
			class task {
				name = CSTRING(tower_task);
				description = CSTRING(tower_desc);
			};
			class location : location {
				distance = 1500;
			};
		};
		class device : main_base {
			class task {
				name = CSTRING(device_task);
				description = CSTRING(device_desc);
			};
			class location : location {
				areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
			};
		};
		class emp : main_base {
			class task {
				name = CSTRING(emp_task);
				description = CSTRING(emp_desc);
			};
			class location : location {
				areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
			};
		};
		class prototype : main_base {
			class task {
				name = CSTRING(prototype_task);
				description = CSTRING(prototype_desc);
			};
		};
		class clear : main_base {
			class task {
				name = CSTRING(clear_task);
				description = CSTRING(clear_desc);
			};
			class location : location {
				areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
			};
		};
		
		class hostage : main_base {
			class task {
				name = CSTRING(hostage_task);
				description = CSTRING(hostage_desc);
			};
			class location : location {
				areas[] = {QGVAR(town)};
			};
		};
		class kill : main_base {
			class task {
				name = CSTRING(kill_task);
				description = CSTRING(kill_desc);
			};
			class location : location {
				areas[] = {QGVAR(town)};
			};
		};
		class intel : main_base {
			class task {
				name = CSTRING(intel_task);
				description = CSTRING(intel_desc);
			};
			class location : location {
				areas[] = {QGVAR(town)};
			};
		};
		class weaponcaches : main_base {
			class task {
				name = CSTRING(weaponcaches_task);
				description = CSTRING(weaponcaches_desc);
			};
			class location : location {
				areas[] = {QGVAR(town)};
			};
		};
		class dronecommando : main_base {
			class task {
				name = CSTRING(dronecommando_task);
				description = CSTRING(dronecommando_desc);
			};
			armys[] = {{"specops",1},{"droneoperations",1},{"guards",1}};
		};
		class specops : main_base {
			class task {
				name = CSTRING(specops_task);
				description = CSTRING(specops_desc);
			};
			armys[] = {{"specops",1}};
		};
		class outpost : main_base {
			class task {
				name = CSTRING(outpost_task);
				description = CSTRING(outpost_desc);
			};
			class location : location {
				areas[] = {QGVAR(military)};
			};
		};
		class radarsetup : main_base {
			class task {
				name = CSTRING(radarsetup_task);
				description = CSTRING(radarsetup_desc);
			};
			class location : location {
				areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
			};
		};
	};
};