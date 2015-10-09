#include "script_component.hpp"

ADDON = false;

PREP(cleanup_big);
PREP(cleanup_small);
PREP(determineHC);
PREP(get_buildings);
PREP(get_cfg_subclasses);
PREP(get_cfglocations);
PREP(handledamage_C4);
PREP(headless);
PREP(headless_move);
PREP(headless_determine);
PREP(list_groups);
PREP(moveToHC);
PREP(players);
PREP(pointBetween);
PREP(pos_flatempty);
PREP(pos_square);
PREP(pos_surrounding);
PREP(positionsMean);
PREP(random_pos);
PREP(rep);
//PREP(repairpoint);
//PREP(repairpoint_init);
PREP(sel_array_weighted);
PREP(setVarArray);
PREP(waitAndExec);

ADDON = true;


/// Setvariables
[
	{
		CHECK(GVAR(setVarSyncArray) isEqualTo [])
		private["_temp"];
		_temp = GVAR(setVarSyncArray);
		GVAR(setVarSyncArray) = [];
		{
			(_x select 2) setVariable [(_x select 0),(_x select 1),(_x select 3)];
		}forEach _temp;
	},
	1,
	[]
] call CBA_fnc_addPerFrameHandler;
