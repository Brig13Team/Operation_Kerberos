
#define CBA_OFF
#include "script_component.hpp"

class dorb_tfr {
	idd = 700200;
	name = "Task Force Tool";
	// createDialog "dorb_tfr";
	movingEnable = 0;
	enableSimulation = 1;
	fadein = 0;
	fadeout = 0;
	duration = 1000000;
	objects[] = {};
	onLoad = "uiNamespace setVariable ['dorb_tfrMenu', _this select 0]; ['dorb_tfrMenu', true] call dorb_interface_fnc_disp_blur;";
	onUnload = " ['dorb_tfrMenu', false] call dorb_interface_fnc_disp_blur; ['DORB_TFR_onOpenEH', 'onEachFrame'] call BIS_fnc_removeStackedEventHandler;";
	
	controlsBackground[] = 
	{
		dorb_tfr_body,
		dorb_tfr_body2,
		dorb_tfr_body3,
		dorb_tfr_header,
		dorb_tfr_frequenzen,
		dorb_tfr_SR_name,
		dorb_tfr_LR_name,
		//dorb_tfr_DD_name
		dorb_tfr_SR_name2,
		dorb_tfr_LR_name2,
		//dorb_tfr_DD_name2
		dorb_tfr_frequenzen_neu,
		dorb_tfr_bodyLB
	};
	
	controls[] =
	{
		dorb_tfr_list,
		dorb_tfr_SR_edit,
		dorb_tfr_LR_edit,
		//dorb_tfr_DD_edit,
		dorb_tfr_SR_disp,
		dorb_tfr_LR_disp,
		//dorb_tfr_DD_disp,
		dorb_tfr_take,
		dorb_tfr_set
	};
	class dorb_tfr_body : dorb_gui_backgroundBase {
		x = _get_screen_x(0)+_get_screen_w(0.1);	
		y = _get_screen_x(0)+_get_screen_h(0.2);
		w = _get_screen_w(0.5);
		h = _get_screen_h(0.52);
		text = "";
		colorBackground[] = UI_CL_BODY;	
		colorText[] = UI_CL_BODY_TEXT;
	};
	class dorb_tfr_body2 : dorb_tfr_body {
		x = _get_screen_x(0)+_get_screen_w(0.605);	
		y = _get_screen_x(0)+_get_screen_h(0.2625);
		w = _get_screen_w(0.295);
		h = _get_screen_h(0.1975);
	};
	class dorb_tfr_body3 : dorb_tfr_body2 {
		y = _get_screen_x(0)+_get_screen_h(0.5275);
		h = _get_screen_h(0.1925);
	};
	class dorb_tfr_bodyLB : dorb_tfr_body {
		x = _get_screen_x(0)+_get_screen_w(0.12);	
		y = _get_screen_x(0)+_get_screen_h(0.22);
		w = _get_screen_w(0.46);
		h = _get_screen_h(0.48);
		colorBackground[] = UI_CL_CTRL_GRAU1; 
	};
	class dorb_tfr_header : dorb_tfr_body {
		idc = -1;
		y = _get_screen_y(0)+_get_screen_h(0.1);
		h = _get_screen_h(0.09);
		w = _get_screen_w(0.8);
		text = ECSTRING(INTERFACE,TFR_HEADER);
		colorText[] = UI_CL_HEADER_TEXT;
		colorBackground[] = UI_CL_HEADER;
	};
	class dorb_tfr_frequenzen : dorb_tfr_body {
		x = _get_screen_x(0)+_get_screen_w(0.605);
		y = _get_screen_x(0)+_get_screen_h(0.2);
		w = _get_screen_w(0.295);
		h = _get_screen_h(0.06);
		sizeEx = _get_screen_h(0.035);
		text = ECSTRING(INTERFACE,TFR_FREQ_SQUAD);
		colorBackground[]=UI_CL_HEADER2;
	};
	class dorb_tfr_frequenzen_neu : dorb_tfr_frequenzen {
		y = _get_screen_x(0)+_get_screen_h(0.465);
		text = ECSTRING(INTERFACE,TFR_FREQ_NEW);
	};
	class dorb_tfr_SR_name : dorb_tfr_body {
		x = _get_screen_x(0)+_get_screen_w(0.62);	
		y = _get_screen_x(0)+_get_screen_h(0.28);
		w = _get_screen_w(0.03);
		h = _get_screen_h(0.04);
		sizeEx = _get_screen_h(0.035);
		text = "SR:";
	};
	class dorb_tfr_LR_name : dorb_tfr_SR_name {
		y = _get_screen_x(0)+_get_screen_h(0.34125);
		text = "LR:";
	};
	class dorb_tfr_DD_name : dorb_tfr_SR_name {
		y = _get_screen_x(0)+_get_screen_h(0.4025);
		text = "DD";
	};
	class dorb_tfr_SR_name2 : dorb_tfr_SR_name {
		y = _get_screen_x(0)+_get_screen_h(0.545);
		text = "SR";
	};
	class dorb_tfr_LR_name2 : dorb_tfr_SR_name {
		y = _get_screen_x(0)+_get_screen_h(0.60375);
		text = "LR:";
	};
	class dorb_tfr_DD_name2 : dorb_tfr_SR_name {
		y = _get_screen_x(0)+_get_screen_h(0.6625);
		text = "DD";
	};
	class dorb_tfr_SR_disp : dorb_tfr_body {
		idc = 700202;
		x = _get_screen_x(0)+_get_screen_w(0.66);	
		y = _get_screen_x(0)+_get_screen_h(0.28);
		w = _get_screen_w(0.07);
		h = _get_screen_h(0.04);
		sizeEx = _get_screen_h(0.035);
		text = "";
	};
	class dorb_tfr_LR_disp : dorb_tfr_SR_disp {
		idc = 700203;
		y = _get_screen_x(0)+_get_screen_h(0.34125);
		text = "";
	};
	class dorb_tfr_DD_disp : dorb_tfr_SR_disp {
		idc = 700204;
		y = _get_screen_x(0)+_get_screen_h(0.4025);
		text = "";
	};
	class dorb_tfr_SR_edit : dorb_gui_editBase {
		idc = 700205;
		x = _get_screen_x(0)+_get_screen_w(0.66);	
		y = _get_screen_x(0)+_get_screen_h(0.545);
		w = _get_screen_w(0.07);
		h = _get_screen_h(0.038);
		sizeEx = _get_screen_h(0.035);
		textcolor[] = UI_CL_BODY_TEXT;
		text = "";
	};
	class dorb_tfr_LR_edit : dorb_tfr_SR_edit {
		idc = 700206;
		y = _get_screen_x(0)+_get_screen_h(0.60375);
		text = "";
	};
	class dorb_tfr_DD_edit : dorb_tfr_SR_edit {
		idc = 700207;
		y = _get_screen_x(0)+_get_screen_h(0.6625);
		text = "";
	};
	class dorb_tfr_list : dorb_gui_listboxN {
		idc = 700201;
		access = 2;
		x = _get_screen_x(0)+_get_screen_w(0.12);	
		y = _get_screen_x(0)+_get_screen_h(0.22);
		w = _get_screen_w(0.46);
		h = _get_screen_h(0.48);
		rowHeight = _get_screen_h(0.035);
		sizeEx = _get_screen_h(0.025);
		columns[] = {0.0,_get_screen_w(0.42),_get_screen_w(0.5)};
	};
	class dorb_tfr_take : dorb_gui_button {
		idc = 700208;
		x = _get_screen_x(0)+_get_screen_w(0.77);	
		y = _get_screen_x(0)+_get_screen_h(0.32125);
		w = _get_screen_w(0.11);
		h = _get_screen_h(0.08);
		text = ECSTRING(INTERFACE,TFR_TAKE);
		toolTip = ECSTRING(INTERFACE,TFR_TAKE_TOOLTIP);
		sizeEx = _get_screen_h(0.03);
		colorBackground[] = UI_CL_CTRL_WEINROT1;
		colorBackgroundActive[] = UI_CL_CTRL_WEINROT2;
		colorFocused[] = UI_CL_CTRL_WEINROT1;
		action = "[] call dorb_interface_fnc_tfr_setFreq;";
	};
	class dorb_tfr_set : dorb_tfr_take {
		idc = 700209;
		y = _get_screen_x(0)+_get_screen_h(0.58375);	
		text = ECSTRING(INTERFACE,TFR_SET);
		toolTip = ECSTRING(INTERFACE,TFR_SET_TOOLTIP);
		action = "[] call dorb_interface_fnc_tfr_setGroup;";
	};
};
