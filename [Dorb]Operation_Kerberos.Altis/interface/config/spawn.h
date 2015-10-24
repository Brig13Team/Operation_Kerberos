
#define CBA_OFF
#include "script_component.hpp"

class dorb_veh_spawn {
	idd = 600100;
	
	name = "spawndialog";
	
	movingEnable = 0;
	enableSimulation = 1;
	fadein = 0;
	fadeout = 0;
	duration = 1000000;
	objects[] = {};
	onLoad = "uiNamespace setVariable ['dorb_spawnMenu', _this select 0]; ['dorb_spawnMenu', true] call dorb_interface_fnc_disp_blur;";
	onUnload = " ['dorb_spawnMenu', false] call dorb_interface_fnc_disp_blur;";
	
	controlsBackground[] =
	{
		spawn_CenterBackground,
		spawn_RightBackground
	};
	controls[] = 
	{
		spawn_HeaderBackground,
		spawn_Fahrzeug,
		spawn_bttn_moveIn,
		spawn_Fahrzeug_pic,
		spawn_bttn_spawn,
		spawn_listbox
	};
	
	
	class spawn_CenterBackground: dorb_gui_backgroundBase {
		x = _get_screen_x(0)+_get_screen_w(0.1);	
		y = _get_screen_x(0)+_get_screen_h(0.2);
		w = _get_screen_w(0.46);
		h = _get_screen_h(0.5);
		text = "";
		colorBackground[] = UI_CL_BODY;
	};
	class spawn_RightBackground: spawn_CenterBackground {
		x = _get_screen_x(0)+_get_screen_w(0.565);	
		y = _get_screen_x(0)+_get_screen_h(0.305);
		w = _get_screen_w(0.235);
		h = _get_screen_h(0.395);
	};
	class spawn_Fahrzeug : spawn_RightBackground {
		idc = 600103;	
		y = _get_screen_y(0)+_get_screen_h(0.2);
		h = _get_screen_h(0.1);
		sizeEx = _get_screen_h(0.027);
		colorText[] = UI_CL_TEXT_DARK;
		colorBackground[]=UI_CL_HEADER2;
		text = "";
	};
	class spawn_Fahrzeug_pic : dorb_gui_pictureBase {
		idc = 600104;	
		x = _get_screen_x(0)+_get_screen_w(0.598125);
		y = _get_screen_x(0)+_get_screen_h(0.315);
		w = _get_screen_w(0.16875);
		h = _get_screen_h(0.225);
		colorText[] = UI_CL_CTRL_GRAU3;
		colorBackground[]=UI_CL_BODY;
		text = "data\icon\icon_heli.paa";
	};
	class spawn_HeaderBackground: spawn_CenterBackground {
		idc = 600101;
		y = _get_screen_y(0)+_get_screen_h(0.1);
		w = _get_screen_w(0.7);
		h = _get_screen_h(0.09);
		text = "";
		colorText[] = UI_CL_HEADER_TEXT;
		colorBackground[] = UI_CL_HEADER;
	};
	class spawn_listbox : dorb_gui_listboxN {
		idc = 600102;
		x = _get_screen_x(0)+_get_screen_w(0.115);	
		y = _get_screen_y(0)+_get_screen_h(0.215);
		w = _get_screen_w(0.43);
		h = _get_screen_h(0.46);
		rowHeight = _get_screen_h(0.035);
		sizeEx = _get_screen_h(0.025);
		columns[] = {0.0,_get_screen_w(0.08),_get_screen_w(0.14),0.0};
		onLBSelChanged = "_this spawn dorb_interface_fnc_spawn_select;";
		default = true;
		
	};
	class spawn_bttn_moveIn : dorb_gui_button {
		idc = 600105;
		x = _get_screen_x(0)+_get_screen_w(0.58);	
		y = _get_screen_y(0)+_get_screen_h(0.55);
		w = _get_screen_w(0.205);
		h = _get_screen_h(0.06);
		style = ST_CENTER;
		sizeEx = _get_screen_h(0.03);
		text = ECSTRING(INTERFACE,SPAWN_DRIVER);
		colorBackground[] = UI_CL_BTN6_foc;
		colorBackgroundActive[] = UI_CL_BTN6_foc;
		colorShadow[] = UI_CL_BTN6;
		colorFocused[] = UI_CL_BTN6_foc;
		default = false;
		shadow = 1;
		onMouseEnter = "";
		onMouseExit = "";
		action = "[""driver""]call dorb_interface_fnc_spawn_create;";
	};
	class spawn_bttn_spawn : spawn_bttn_moveIn {
		idc = 600106;
		y = _get_screen_y(0)+_get_screen_h(0.615);
		text = ECSTRING(INTERFACE,SPAWN_EMPTY);
		colorBackground[] = UI_CL_BTN2_foc;
		colorBackgroundActive[] = UI_CL_BTN2_foc;
		colorShadow[] = UI_CL_BTN2;
		colorFocused[] = UI_CL_BTN2_foc;
		onSetFocus = "";
		action = "[]call dorb_interface_fnc_spawn_create;";
	};
};


