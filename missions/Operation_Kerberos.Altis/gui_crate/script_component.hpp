#define COMPONENT gui_crate
#define COMPONENT_BEAUTIFIED GUI_Crate
#include "..\main\script_mission.hpp"

#define DEBUG_MODE_MINIMAL
// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_gui_crate
    #define DEBUG_MODE_FULL
#endif

#include "..\main\script_macros.hpp"
#include "..\gui\script_gui.hpp"


#define CHECK_RADIUS_MIN 5
#define CHECK_RADIUS_MAX 15

#define MASS_CORRECTION 0.5
#define DEFAULT_MASS 600
#define DEFAULT_BOXES ["box_nato_ammo_f","Box_NATO_Equip_F","CargoNet_01_box_F","b_slingload_01_cargo_f"]
#define DEFAULT_BOXES_MASS [600,1200,6000,25000]



#define ID_RIFLE 0
#define ID_AUTOMATIC 1
#define ID_SNIPER 2
#define ID_LAUNCHER 3
#define ID_HANDGUN 4
#define ID_OPTICS 5
#define ID_GRANADES 6
#define ID_MINES 7
#define ID_UNIFORM 8
#define ID_VEST 9
#define ID_HEADGEAR 10
#define ID_BACKPACK 11
#define ID_RADIO 12
#define ID_NAVIGATION 13
#define ID_MEDIC 14
#define ID_OTHER 15
