#include "script_component.hpp"

ADDON = false;

TRIPLES(PREFIX,makro,errorlog) = compileFinal "Private['_file','_line','_message'];_file=_this select 0;_line=_this select 1;_message=_this select 2;_time=[diag_tickTime, 'H:MM:SS.mmm'] call CBA_fnc_formatElapsedTime;_file=_file splitString '\';_file=_file select ((count _file)-1);diag_log text format ['%1 (%2) [%3:%4] -ERROR- %5', _time, time, _file, _line + 1,_message];nil;";
TRIPLES(PREFIX,makro,putinlog) = compileFinal "Private['_file','_line','_message','_lines'];_file=_this select 0;_line=_this select 1;_message=_this select 2;_time=[diag_tickTime, 'H:MM:SS.mmm'] call CBA_fnc_formatElapsedTime;_file=_file splitString '\';_file=_file select ((count _file)-1);diag_log text format ['%1 (%2) [%3:%4] -LOG- ', _time, time, _file, _line + 1];_lines = [_message,'\n'] call CBA_fnc_split;{diag_log text format ['            %1', _x];} forEach _lines;nil;";
TRIPLES(PREFIX,makro,selectrandom) = compileFinal "If(count _this < 1) exitwith {[]};(_this) select floor random count (_this);";
TRIPLES(PREFIX,makro,delete) = compileFinal "If(if (isNil {_this}) then { false } else { (typeName _this) == 'ARRAY' })exitWith{{_x call dorb_makro_delete;}forEach _this;};If(if (isNil {_this}) then { false } else { (typeName _this) == 'GROUP' })exitWith{deletegroup _this;};If(if (isNil {_this}) then { false } else { (typeName _this) == 'OBJECT' })exitWith{{_this deleteVehicleCrew _x} forEach crew _this; deleteVehicle _this;};If(if (isNil {_this}) then { false } else { (typeName _this) == 'STRING' })exitWith{deleteMarker _this};diag_log text format['TILGE: Nicht unterstuetzt | %1',_this];";
TRIPLES(PREFIX,makro,map) = compileFinal "params[['_code','',[{},'']],['_array',[],[[]]]]; if (typeName _code == 'STRING') then { _code = compile _code; }; { _array set [_forEachIndex, (_array select _forEachIndex) call _code]; } forEach _array; _array";
TRIPLES(PREFIX,makro,iscasvehicle) = compileFinal "params['_class',['_whitelist',[],[[]]],['_blacklist',[],[[]]]]; if (({_class isKindOf _x} count _whitelist) > 0) exitWith { false }; if (({_class isKindOf _x} count _blacklist) > 0) exitWith { true }; if ((isClass(configFile >> 'CfgVehicles' >> _class)) && {('CAS_Heli' in getArray(configFile >> 'CfgVehicles' >> _class >> 'availableForSupportTypes'))}) exitWith { true }; if ((isClass(configFile >> 'CfgVehicles' >> _class)) && {'CAS_Bombing' in getArray(configFile >> 'CfgVehicles' >> _class >> 'availableForSupportTypes')}) exitWith { true }; false";

PREP(debug_performance);
PREP(userconfig);
PREP(init);
PREPS(debug,putinlog);
PREPS(debug,show);
PREPS(debug,write);

ADDON = true;
