/*
Add to ACE - Selfinteraction / Team Management the possibility to change your Color without the ACE Team Managment system.

scripted by the mighty shithead Gangolf
*/
#include "script_component.hpp"
//Menu
private _action = [QGVAR(setgroupmain), localize LSTRING(COLOR_MAINMENU), "\z\ace\addons\interaction\UI\team\team_management_ca.paa", {true}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

//White
_action = [QGVAR(setgroupwhite), localize LSTRING(COLOR_WHITE), "\z\ace\addons\interaction\UI\team\team_white_ca.paa", {[_target,'MAIN'] call ace_interaction_fnc_joinTeam}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", QGVAR(setgroupmain)], _action] call ace_interact_menu_fnc_addActionToObject;

// Green
_action = ["setgroupgreen", localize LSTRING(COLOR_GREEN), "\z\ace\addons\interaction\UI\team\team_green_ca.paa", {[_target,'GREEN'] call ace_interaction_fnc_joinTeam}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", QGVAR(setgroupmain)], _action] call ace_interact_menu_fnc_addActionToObject;

//Red
_action = ["setgroupred", localize LSTRING(COLOR_RED), "\z\ace\addons\interaction\UI\team\team_red_ca.paa", {[_target,'RED'] call ace_interaction_fnc_joinTeam}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", QGVAR(setgroupmain)], _action] call ace_interact_menu_fnc_addActionToObject;

//Blue
_action = ["setgroupblue", localize LSTRING(COLOR_BLUE), "\z\ace\addons\interaction\UI\team\team_blue_ca.paa", {[_target,'BLUE'] call ace_interaction_fnc_joinTeam}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", QGVAR(setgroupmain)], _action] call ace_interact_menu_fnc_addActionToObject;

//Yellow
_action = [QGVAR(setgroupyellow), localize LSTRING(COLOR_YELLOW), "\z\ace\addons\interaction\UI\team\team_yellow_ca.paa", {[_target,'YELLOW'] call ace_interaction_fnc_joinTeam}, {true}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", QGVAR(setgroupmain)], _action] call ace_interact_menu_fnc_addActionToObject;
