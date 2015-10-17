#include "script_component.hpp"

PREP(cleanup_big);
PREP(cleanup_small);
PREP(determineHC);
PREP(EventExec);
PREP(EventGlobal);
PREP(EventLocal);
PREP(EventExecLocal);
PREP(get_buildings);
PREP(get_cfg_subclasses);
PREP(get_cfglocations);
PREP(handledamage_C4);
PREP(headless);
PREP(headless_move);
PREP(headless_determine);
PREP(list_groups);
PREP(moveToHC);
PREP(pointBetween);
PREP(pos_flatempty);
PREP(pos_surrounding);
PREP(positionsMean);
PREP(random_pos);
PREP(rep);
//PREP(repairpoint);
//PREP(repairpoint_init);
PREP(sel_array_weighted);


if (!hasInterface) then {
	GVARMAIN(EVENTLOCAL) addpublicVariableEventHandler {(_this select 1) call FUNC(EventLocal);};
	GVARMAIN(EVENTEXEC) addpublicVariableEventHandler {(_this select 1) call FUNC(EventExec);};
}else{
	[] spawn {
		waitUntil {alive player};
		GVARMAIN(EVENTLOCAL) addpublicVariableEventHandler {(_this select 1) call FUNC(EventLocal);};
		GVARMAIN(EVENTEXEC) addpublicVariableEventHandler {(_this select 1) call FUNC(EventExec);};
	};
};
