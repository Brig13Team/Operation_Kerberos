#define CBA_OFF
#include "script_component.hpp"


class dorb_save {
	idd = 600240;
	name = "Generic Save";
	/// von Dorbedo - wer das Ding nutzen will: Fragen!
	movingEnable = 0;
	enableSimulation = 1;
	fadein = 0;
	fadeout = 0;
	duration = 1000000;
	objects[] = {};
	onLoad = "uiNamespace setVariable ['dorb_saveMenu', _this select 0];";
	onUnload = "";
	
	controlsBackground[] = 	{
		dorb_save_CenterBackground,
		dorb_save_BottemBackground,
		dorb_save_ListBackground
	};
	
	controls[] =	{
		dorb_save_HeaderBackground,
		dorb_save_list,
		dorb_save_edit,
		dorb_save_button1,
		dorb_save_button2,
		dorb_save_button3
	};
	
	class dorb_save_CenterBackground: dorb_gui_backgroundBase {
		x = _get_screen_x(0)+_get_screen_w(0.25);	
		w = _get_screen_w(0.5);
		y = _get_screen_y(0)+_get_screen_h(0.16);
		h = _get_screen_h(0.535);
		text = "";
		colorBackground[] = UI_CL_BODY;
		colorText[] = UI_CL_BODY_TEXT;
	};
	class dorb_save_BottemBackground: dorb_save_CenterBackground {
		y = _get_screen_y(0)+_get_screen_h(0.7);	
		h = _get_screen_h(0.2);
	};
	class dorb_save_HeaderBackground: dorb_save_CenterBackground {
		idc = 600246;
		y = _get_screen_y(0)+_get_screen_h(0.1);
		h = _get_screen_h(0.055);
		text = "";
		colorText[] = UI_CL_HEADER_TEXT;
		colorBackground[] = UI_CL_HEADER;
	};
	class dorb_save_ListBackground: dorb_save_CenterBackground {
		x = _get_screen_x(0)+_get_screen_w(0.27);	
		w = _get_screen_w(0.46);
		y = _get_screen_y(0)+_get_screen_h(0.18);
		h = _get_screen_h(0.495);
		colorText[] = UI_CL_HEADER_TEXT;
		colorBackground[] = UI_CL_CTRL_GRAU2;
	};
	class dorb_save_button1 : dorb_gui_button {
		idc = 600242;
		x = _get_screen_x(0)+_get_screen_w(0.27);
		w = _get_screen_w(0.14);
		y = _get_screen_y(0)+_get_screen_h(0.8);
		h = _get_screen_h(0.08);
		colorBackground[] = UI_CL_CTRL_WEINROT1;
		colorBackgroundActive[] = UI_CL_CTRL_WEINROT2;
		colorFocused[] = UI_CL_CTRL_WEINROT1;
		text = ECSTRING(INTERFACE,SAVE_CANCEL);
		action = "dorb_interface_save_isopened=false;closeDialog 600240;";
	};
	class dorb_save_button2 : dorb_save_button1 {
		idc = 600243;
		x = _get_screen_x(0)+_get_screen_w(0.43);	
		toolTip = "";
		text = ECSTRING(INTERFACE,SAVE_DELETE);
		action = "[] call dorb_interface_fnc_save_delete;";
	};
	class dorb_save_button3 : dorb_save_button1 {
		idc = 600244;
		x = _get_screen_x(0)+_get_screen_w(0.59);
		toolTip = "";
		text = "";
		action = "";
	};
	class dorb_save_list : dorb_gui_listboxN {
		idc = 600241;
		access = 2;
		x = _get_screen_x(0)+_get_screen_w(0.275);	
		w = _get_screen_w(0.45);
		y = _get_screen_y(0)+_get_screen_h(0.185);
		h = _get_screen_h(0.485);
		rowHeight = _get_screen_h(0.035);
		sizeEx = _get_screen_h(0.03);
		columns[] = {0.02};
		onLBSelChanged = "_this call dorb_interface_fnc_save_select;false";
	};
	class dorb_save_edit : dorb_gui_editBase {
		idc = 600245;
		x = _get_screen_x(0)+_get_screen_w(0.27);	
		y = _get_screen_x(0)+_get_screen_h(0.72);
		w = _get_screen_w(0.46);
		h = _get_screen_h(0.06);
		sizeEx = _get_screen_h(0.04);
		textcolor[] = UI_CL_BODY_TEXT;
		text = "";
	};
};


