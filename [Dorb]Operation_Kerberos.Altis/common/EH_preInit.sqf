#include "script_component.hpp"

ADDON = false;

PREP(arithmeticMean);

PREP(create_location);
PREP(convertAngleToRotMat);
PREP(convertRotMatToAngle);

PREP(debug_marker_clean);
PREP(debug_marker_create);
PREP(delete);

PREP(get_buildings);
PREP(get_cfg_subclasses);
PREP(get_cfglocations);
PREP(getRollPitchYaw);
PREP(getRotMat);

PREP(handledamage_C4);

PREP(list_groups);

PREP(players);
PREP(setOwner);
PREP(pos_between);
PREP(pos_flatempty);
PREP(pos_mean);
PREP(pos_random);
PREP(pos_relative);
PREP(pos_square);
PREP(pos_surrounding);
PREP(pos_randomFlatEmpty);

PREP(rotateVectorXY);

PREP(sel_array_weighted);
PREP(setRollPitchYaw);
PREP(setRotMat);
PREP(setCfgLocations);

PREPS(matrix,clear);
PREPS(matrix,create);
PREPS(matrix,find_peaks);
PREPS(matrix,value_add);
PREPS(matrix,value_get);
PREPS(matrix,value_set);

ADDON = true;
