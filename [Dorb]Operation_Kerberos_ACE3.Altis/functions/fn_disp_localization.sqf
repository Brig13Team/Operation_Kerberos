/*
	Author: Dorbedo

	Description:
	Removes the localization Issues

*/
#include "makros.hpp"
CHECK(!hasinterface)
_this spawn {
	PARAMS_3(_categorie,_messageid,_paramarray);
	
	switch(_categorie) do {
		case "rtb": {
						switch(_messageid) do {
							case 1 : {[localize "STR_DORB_RTB",[localize "STR_DORB_RTB_START_1"],"data\icon\icon_base.paa",false] call FM(disp_info);};
							case 2 : {[localize "STR_DORB_RTB",[localize "STR_DORB_RTB_FINISHED",localize "STR_DORB_RTB_FINISHED2"],"data\icon\icon_base.paa",false] call FM(disp_info);};
						};
					};
		case "mildef": {
						switch(_messageid) do {
							case 1 : {[localize "STR_DORB_DEFEND",[format [localize "STR_DORB_DEF_TASK",_paramarray select 0]],"data\icon\icon_defend.paa",true] call FM(disp_info);};
							case 2 : {[localize "STR_DORB_DEF",[localize "STR_DORB_DEF_ATT1",localize "STR_DORB_DEF_ATT2"]] call FM(disp_info);};
							case 3 : {[localize "STR_DORB_DEF",format[localize "STR_DORB_DEF_ATT_IN",[_paramarray select 0]]] call FM(disp_info);};
							case 4 : {[localize "STR_DORB_DEFEND",[localize "STR_DORB_FAILED"],"data\icon\icon_defend.paa",true] call FM(disp_info);};
							case 5 : {[localize "STR_DORB_DEFEND",[localize "STR_DORB_FINISHED"],"data\icon\icon_defend.paa",true] call FM(disp_info);};
							case 6 : {[localize "STR_DORB_DEF",localize "STR_DORB_DEF_ATT_INB"] call FM(disp_message);};
							case 7 : {[localize "STR_DORB_DEF",localize "STR_DORB_DEF_WAVE_DEFENDED"] call FM(disp_message);};
							case 8 : {[localize "STR_DORB_DEF",localize "STR_DORB_DEF_WAVE_NEW"] call FM(disp_message);};
						};
					};
		case "milclear": {
						switch(_messageid) do {
							case 1 : {[localize "STR_DORB_CLEAR",[format [localize "STR_DORB_CLEAR_TASK",_paramarray select 0]],"data\icon\icon_file.paa",true] call FM(disp_info);};
							case 2 : {[localize "STR_DORB_CLEAR",[localize "STR_DORB_FINISHED"],"data\icon\icon_file.paa",true] call FM(disp_info);};
						};
					};
		case "sonstproto": {
						switch(_messageid) do {
							case 1 : {[localize "STR_DORB_CAPTURE",[localize "STR_DORB_PROTO_TASK"],"data\icon\icon_capture.paa",true] call FM(disp_info);};
							case 2 : {[localize "STR_DORB_CAPTURE",[localize "STR_DORB_FINISHED"],"data\icon\icon_capture.paa",true] call FM(disp_info);};
							case 3 : {[localize "STR_DORB_CAPTURE",[localize "STR_DORB_FAILED"],"data\icon\icon_capture.paa",true] call FM(disp_info);};
						};
					};
		case "sonstdevice": {
						switch(_messageid) do {
							case 1 : {[localize "STR_DORB_DESTROY",[localize "STR_DORB_DEST_DEV_TASK"],"data\icon\icon_destroy.paa",true] call FM(disp_info);};
							case 2 : {[localize "STR_DORB_DESTROY",[localize "STR_DORB_FINISHED"],"data\icon\icon_destroy.paa",true] call FM(disp_info);};
						};
					};
		case "sonsttower": {
						switch(_messageid) do {
							case 1 : {[localize "STR_DORB_DESTROY",[localize "STR_DORB_DEST_KOM_TASK"],"data\icon\icon_destroy.paa",true] call FM(disp_info);};
							case 2 : {[localize "STR_DORB_DESTROY",[localize "STR_DORB_FINISHED"],"data\icon\icon_destroy.paa",true] call FM(disp_info);};
						};
					};
		case "sonstscarab": {
						switch(_messageid) do {
							case 1 : {[localize "STR_DORB_DESTROY",[format [localize "STR_DORB_DEST_SCARAB_TASK",_paramarray select 0]],"data\icon\icon_destroy.paa",true] call FM(disp_info);};
							case 2 : {[localize "STR_DORB_DESTROY",[localize "STR_DORB_FINISHED"],"data\icon\icon_destroy.paa",true] call FM(disp_info);};
							case 3 : {[localize "STR_DORB_DESTROY",[localize "STR_DORB_FAILED"],"data\icon\icon_destroy.paa",true]call FM(disp_info);};
						};
					};
		case "stadtwpn": {
						switch(_messageid) do {
							case 1 : {[localize "STR_DORB_DESTROY",[localize "STR_DORB_DEST_WPN_TASK"],"data\icon\icon_search.paa",true] call FM(disp_info);};
							case 2 : {[localize "STR_DORB_DESTROY",[localize "STR_DORB_FINISHED"],"data\icon\icon_search.paa",true] call FM(disp_info);};
						};
					};
		case "stadtintel": {
						switch(_messageid) do {
							case 1 : {[localize "STR_DORB_FIND",[localize "STR_DORB_INTEL_TASK"],"data\icon\icon_search.paa",true] call FM(disp_info);};
							case 2 : {[localize "STR_DORB_FIND",[localize "STR_DORB_FINISHED"],"data\icon\icon_search.paa",true] call FM(disp_info);};
						};
					};
		case "stadtcommander": {
						switch(_messageid) do {
							case 1 : {[localize "STR_DORB_KILL",[localize "STR_DORB_KILL_TASK"],"data\icon\icon_target.paa",true] call FM(disp_info);};
							case 2 : {[localize "STR_DORB_KILL",[localize "STR_DORB_FINISHED"],"data\icon\icon_target.paa",true] call FM(disp_info);};
						};
					};
		case "stadtconvkill": {
						switch(_messageid) do {
							case 1 : {[localize "STR_DORB_DESTROY",[localize "STR_DORB_KILL_CONV_TASK"],"data\icon\icon_destroy.paa",true] call FM(disp_info);};
							case 2 : {[localize "STR_DORB_DESTROY",[localize "STR_DORB_FINISHED"],"data\icon\icon_destroy.paa",true] call FM(disp_info);};
							case 3 : {[localize "STR_DORB_DESTROY",[localize "STR_DORB_FAILED"],"data\icon\icon_destroy.paa",true] call FM(disp_info);};
						};
					};
		case "stadtconvcapt": {
						switch(_messageid) do {
							case 1 : {[localize "STR_DORB_RESCUE",[localize "STR_DORB_RESC_CONV_TASK"],"data\icon\icon_rescue.paa",true] call FM(disp_info);};
							case 2 : {[localize "STR_DORB_RESCUE",[localize "STR_DORB_FINISHED"],"data\icon\icon_rescue.paa",true] call FM(disp_info);};
							case 3 : {[localize "STR_DORB_RESCUE",[localize "STR_DORB_FAILED"],"data\icon\icon_rescue.paa",true] call FM(disp_info);};
						};
					};
		case "stadtpow": {
						switch(_messageid) do {
							case 1 : {[localize "STR_DORB_RESCUE",[localize "STR_DORB_RESC_TASK"],"data\icon\icon_rescue.paa",true] call FM(disp_info);};
							case 2 : {[localize "STR_DORB_RESCUE",[localize "STR_DORB_FINISHED"],"data\icon\icon_rescue.paa",true] call FM(disp_info);};
							case 3 : {[localize "STR_DORB_RESCUE",[localize "STR_DORB_FAILED"],"data\icon\icon_defend.paa",true] call FM(disp_info);};
						};
					};
	};
};