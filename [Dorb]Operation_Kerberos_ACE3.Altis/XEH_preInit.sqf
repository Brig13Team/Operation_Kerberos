#include "script_component.hpp"

ADDON = false;

TRIPLES(PREFIX,fnc,errorlog) = compileFinal "Private['_file','_line','_message'];_file=_this select 0;_line=_this select 1;_message=_this select 2;_time=[diag_tickTime, 'H:MM:SS.mmm'] call CBA_fnc_formatElapsedTime;_file=[_file,'\fnc_']call CBA_fnc_split;_file=_file select ((count _file)-1);diag_log text format ['%1 (%2) [%3:%4] -ERROR- %5', _time, time, 'fnc'+_file, _line + 1,_message];nil;";
TRIPLES(PREFIX,fnc,putinlog) = compileFinal "Private['_file','_line','_message','_lines'];_file=_this select 0;_line=_this select 1;_message=_this select 2;_time=[diag_tickTime, 'H:MM:SS.mmm'] call CBA_fnc_formatElapsedTime;_file=[_file,'\fnc_']call CBA_fnc_split;_file=_file select ((count _file)-1);diag_log text format ['%1 (%2) [%3:%4] -LOG- ', _time, time, 'fnc'+_file, _line + 1];_lines = [_message,'\n'] call CBA_fnc_split;{diag_log text format ['            %1', _x];} forEach _lines;nil;";

PREPMAIN(determineHC);
PREPMAIN(moveToHC);
PREPMAIN(list_groups);
PREPMAIN(random_pos);
PREPMAIN(playeraddaction);

PREPMAIN(grouptracker);
PREPMAIN(rescue_draw3D);


PREPMAIN(spawn_crew);
PREPMAIN(addNVG);
PREPMAIN(cleanup_big);
PREPMAIN(cleanup_small);


PREPMAIN(core);
PREPMAIN(taskhandler);
PREPMAIN(examine);
PREPMAIN(create_unitlists);


PREPMAIN(ui_teleport_addAction);
PREPMAIN(ui_teleport_draw3D);
PREPMAIN(ui_teleport_onLoad);
PREPMAIN(ui_teleporter_lead);

PREPMAIN(ui_tfr_onOpen);
PREPMAIN(ui_tfr_OpenMenu);
PREPMAIN(ui_tfr_setFreq);
PREPMAIN(ui_tfr_setGroup);


ADDON = true;
