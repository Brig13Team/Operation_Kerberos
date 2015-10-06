#include "script_component.hpp"

ADDON = false;

PREP(choose);
PREP(core);
PREP(dyn_difficulty);
PREP(examine);
PREP(rescue_draw3D);
PREP(reward);
PREP(rtb);
PREP(taskhandler);

PREPS(mil,area_clear);
PREPS(mil,area_defend);

PREPS(sideby,aircraft);
PREPS(sideby,chooseMission);
PREPS(sideby,conter);
PREPS(sideby,sdv);
PREPS(sideby,supplies);
PREPS(sideby,ueberlaeufer);
PREPS(sideby,ueberlaeuferVerhoeren);

PREPS(sonst,capture_prototype);
PREPS(sonst,destroy_device);
PREPS(sonst,destroy_tower);
PREPS(sonst,scarab);
PREPS(sonst,scarab_explode);
PREPS(sonst,scarab_launch);

PREPS(stadt,destroy_wpncache);
PREPS(stadt,find_intel);
PREPS(stadt,found_intel);
PREPS(stadt,kill_person);
PREPS(stadt,konvoi_destroy);
PREPS(stadt,konvoi_rescue);
PREPS(stadt,rescue_pow);

ADDON = true;