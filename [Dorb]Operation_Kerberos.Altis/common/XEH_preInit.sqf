#include "script_component.hpp"
ADDON = false;

PREP(arithmeticMean);

PREP(debug_marker_clean);
PREP(debug_marker_create);
PREP(determineHC);

PREP(get_buildings);
PREP(get_cfg_subclasses);
PREP(get_cfglocations);

PREP(handledamage_C4);
PREP(headless);
PREP(headless_determine);
PREP(headless_move);

PREP(setRotMat);
PREP(setRollPitchYaw);
PREP(getRotMat);
PREP(getRollPitchYaw);
PREP(convertRotMatToAngle);
PREP(rotateVectorXY);

PREP(list_groups);

PREP(moveToHC);

PREP(players);
PREP(pos_between);
PREP(pos_flatempty);
PREP(pos_random);
PREP(pos_relative);
PREP(pos_square);
PREP(pos_surrounding);
PREP(positionsMean);

PREP(rep);
//PREP(repairpoint);
//PREP(repairpoint_init);

PREP(sel_array_weighted);
PREP(setVarArray);

PREP(waitAndExec);

PREPS(matrix,clear);
PREPS(matrix,create);
PREPS(matrix,find_peaks);
PREPS(matrix,value_add);
PREPS(matrix,value_get);
PREPS(matrix,value_set);

ADDON = true;

/// Setvariables

GVAR(waitAndExecArray) = [];

[
    {
        CHECK(GVAR(setVarSyncArray) isEqualTo [])
        private _temp = GVAR(setVarSyncArray);
        GVAR(setVarSyncArray) = [];
        {
            (_x select 2) setVariable [(_x select 0),(_x select 1),(_x select 3)];
        }forEach _temp;
    },
    1,
    []
] call CBA_fnc_addPerFrameHandler;
