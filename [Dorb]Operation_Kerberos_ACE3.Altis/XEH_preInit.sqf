#include "script_component.hpp"

ADDON = false;
//Debug (von Makro aufgerufen)
TRIPLES(dorb,makro,errorlog) = compileFinal "Private['_file','_line','_message'];_file=_this select 0;_line=_this select 1;_message=_this select 2;_time=[diag_tickTime, 'H:MM:SS.mmm'] call CBA_fnc_formatElapsedTime;_file=[_file,'\fnc_']call CBA_fnc_split;_file=_file select ((count _file)-1);diag_log text format ['%1 (%2) [%3:%4] -ERROR- %5', _time, time, 'fnc_'+_file, _line + 1,_message];nil;";
TRIPLES(dorb,makro,putinlog) = compileFinal "Private['_file','_line','_message','_lines'];_file=_this select 0;_line=_this select 1;_message=_this select 2;_time=[diag_tickTime, 'H:MM:SS.mmm'] call CBA_fnc_formatElapsedTime;_file=[_file,'\fnc_']call CBA_fnc_split;_file=_file select ((count _file)-1);diag_log text format ['%1 (%2) [%3:%4] -LOG- ', _time, time, 'fnc_'+_file, _line + 1];_lines = [_message,'\n'] call CBA_fnc_split;{diag_log text format ['            %1', _x];} forEach _lines;nil;";
TRIPLES(dorb,makro,selectrandom) = compileFinal "If(count _this < 1) exitwith {[]};(_this) select floor random count (_this);";
TRIPLES(dorb,makro,delete) = compileFinal "If(if (isNil {_this}) then { false } else { (typeName _this) == 'ARRAY' })exitWith{{_x call dorb_makro_delete;}forEach _this;};If(if (isNil {_this}) then { false } else { (typeName _this) == 'GROUP' })exitWith{deletegroup _this;};If(if (isNil {_this}) then { false } else { (typeName _this) == 'OBJECT' })exitWith{{_this deleteVehicleCrew _x} forEach crew _this; deleteVehicle _this;};If(if (isNil {_this}) then { false } else { (typeName _this) == 'STRING' })exitWith{deleteMarker _this};diag_log text format['TILGE: Nicht unterstuetzt | %1',_this];";


//Allgemeines
PREPMAIN(determineHC);
PREPMAIN(get_buildings);
PREPMAIN(get_cfglocations);
PREPMAIN(list_groups);
PREPMAIN(local);
PREPMAIN(local_check);
PREPMAIN(moveToHC);
PREPMAIN(random_pos);

//Spielerbezogen
PREPMAIN(addbriefing);
PREPMAIN(disp_blur);
PREPMAIN(disp_info);
PREPMAIN(disp_localization);
PREPMAIN(disp_message);
PREPMAIN(disp_progressbar);
PREPMAIN(grouptracker);
PREPMAIN(halo);
PREPMAIN(halo_addaction);
PREPMAIN(halo_get_loadout);
PREPMAIN(halo_set_loadout);
PREPMAIN(nurpiloten);
PREPMAIN(playeraddaction);
PREPMAIN(rep);
PREPMAIN(rescue_draw3D);

//Einheiten
PREPMAIN(addNVG);
PREPMAIN(cleanup_big);
PREPMAIN(cleanup_small);
PREPMAIN(spawn_artypos);
PREPMAIN(spawn_attack_airdrop);
PREPMAIN(spawn_attack_inf);
PREPMAIN(spawn_attack_veh);
PREPMAIN(spawn_attack_waves);
PREPMAIN(spawn_crew);
PREPMAIN(spawn_defence);
PREPMAIN(spawn_in_building);
PREPMAIN(spawn_mortarpos);
PREPMAIN(spawn_obj_mil);
PREPMAIN(spawn_obj_sonstiges);
PREPMAIN(spawn_obj_stadt);
PREPMAIN(spawn_patrol_air);
PREPMAIN(spawn_patrol_inf);
PREPMAIN(spawn_patrol_veh);
PREPMAIN(spawn_rooftop);
PREPMAIN(spawn_tower);
PREPMAIN(spawn_unit);

//Comandofahrzeuge
PREPMAIN(spawn_commandveh);
PREPMAIN(spawn_commandveh_airdrop);
PREPMAIN(spawn_commandveh_antiair);
PREPMAIN(spawn_commandveh_artillery);
PREPMAIN(spawn_commandveh_check);
PREPMAIN(spawn_commandveh_mech);
PREPMAIN(spawn_commandveh_sniper);
PREPMAIN(spawn_commandveh_tanks);

//Eventhandler
PREPMAIN(handledamage_C4);

//Aufgaben
PREPMAIN(core);
PREPMAIN(dyn_difficulty);
PREPMAIN(create_unitlists);
PREPMAIN(examine);
PREPMAIN(obj_choose);
PREPMAIN(obj_mil_area_clear);
PREPMAIN(obj_mil_area_defend);
PREPMAIN(obj_mil_create);
PREPMAIN(obj_rtb);
PREPMAIN(obj_sonst_capture_prototype);
PREPMAIN(obj_sonst_create);
PREPMAIN(obj_sonst_destroy_device);
PREPMAIN(obj_sonst_destroy_tower);
PREPMAIN(obj_sonst_Scarab);
PREPMAIN(obj_sonst_Scarab_explode);
PREPMAIN(obj_sonst_Scarab_launch);
PREPMAIN(obj_stadt_create);
PREPMAIN(obj_stadt_destroy_wpncache);
PREPMAIN(obj_stadt_find_intel);
PREPMAIN(obj_stadt_found_intel);
PREPMAIN(obj_stadt_kill_person);
PREPMAIN(obj_stadt_konvoi_destroy);
PREPMAIN(obj_stadt_konvoi_rescue);
PREPMAIN(obj_stadt_rescue_pow);
PREPMAIN(taskhandler);

//Interface
PREPMAIN(ui_crate_add);
PREPMAIN(ui_crate_addAction);
PREPMAIN(ui_crate_createlists);
PREPMAIN(ui_crate_draw3D);
PREPMAIN(ui_crate_filter);
PREPMAIN(ui_crate_getMod);
PREPMAIN(ui_crate_mass);
PREPMAIN(ui_crate_OnLoad);
PREPMAIN(ui_crate_OpenMenu);
PREPMAIN(ui_crate_spawn);

PREPMAIN(ui_spawn_addaction);
PREPMAIN(ui_spawn_create);
PREPMAIN(ui_spawn_createlist);
PREPMAIN(ui_spawn_draw3D);
PREPMAIN(ui_spawn_Open);
PREPMAIN(ui_spawn_select);

PREPMAIN(ui_teleport_addAction);
PREPMAIN(ui_teleport_draw3D);
PREPMAIN(ui_teleport_onLoad);
PREPMAIN(ui_teleporter_lead);

PREPMAIN(ui_tfr_onOpen);
PREPMAIN(ui_tfr_OpenMenu);
PREPMAIN(ui_tfr_setFreq);
PREPMAIN(ui_tfr_setGroup);

ADDON = true;