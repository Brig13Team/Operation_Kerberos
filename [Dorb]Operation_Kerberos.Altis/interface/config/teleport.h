#define teleport_start 470470

#define CBA_OFF
#include "script_component.hpp"


#define TELEPORT_SPALTE1 _get_screen_x(0)+_get_screen_w(0.14)
#define TELEPORT_SPALTE2 _get_screen_x(0)+_get_screen_w(0.36)
#define TELEPORT_SPALTE3 _get_screen_x(0)+_get_screen_w(0.58)
#define TELEPORT_REIHE1 _get_screen_y(0)+_get_screen_h(0.25)
#define TELEPORT_REIHE2 _get_screen_y(0)+_get_screen_h(0.4)
#define TELEPORT_REIHE3 _get_screen_y(0)+_get_screen_h(0.55)



class dorb_teleporter {
	idd = 600300;
	name = "Teleporter";
	
	movingEnable = 0;
	enableSimulation = 1;
	fadein = 0;
	fadeout = 0;
	duration = 1000000;
	objects[] = {};
	onLoad = "uiNamespace setVariable ['dorb_teleportMenu', _this select 0]; ['dorb_teleportMenu', true] call dorb_interface_fnc_disp_blur; [] spawn dorb_interface_fnc_teleport_onLoad";
	onUnload = " ['dorb_teleportMenu', false] call dorb_interface_fnc_disp_blur;";
	
	controlsBackground[] = {
		teleport_CenterBackground,
		teleport_HeaderBackground
		
	};
	controls[] =	{
		teleport_bttn1,
		teleport_bttn2,
		teleport_bttn3,
		teleport_bttn4,
		teleport_bttn5,
		teleport_bttn6,
		teleport_bttn7
	};
	
	class teleport_CenterBackground: dorb_gui_backgroundBase {
		x = _get_screen_x(0)+_get_screen_w(0.1);	
		y = _get_screen_x(0)+_get_screen_h(0.2);
		w = _get_screen_w(0.7);
		h = _get_screen_h(0.5);
		text = "";
		colorBackground[] = UI_CL_BODY;
	};
	class teleport_HeaderBackground: teleport_CenterBackground {
		y = _get_screen_y(0)+_get_screen_h(0.1);
		w = _get_screen_w(0.7);
		h = _get_screen_h(0.09);
		text = "Teleporter";
		colorText[] = UI_CL_HEADER_TEXT;
		colorBackground[] = UI_CL_HEADER;
	};
	class teleport_bttn1 : dorb_gui_button {
		idc = 600301;
		x = TELEPORT_SPALTE1;
		y = TELEPORT_REIHE1;
		w = _get_screen_w(0.17);
		h = _get_screen_h(0.08);
		sizeEx = _get_screen_h(0.04);
		text = "";
		colorBackground[] = UI_CL_BTN1;
		colorBackgroundActive[] = UI_CL_BTN1_foc;
		colorFocused[] = UI_CL_BTN1;
		colorText[] = UI_CL_TEXT_DARK;
	};
	class teleport_bttn2 : teleport_bttn1 {
		idc = 600302;
		y = TELEPORT_REIHE2;
		text = "";
		colorBackground[] = UI_CL_BTN2;
		colorBackgroundActive[] = UI_CL_BTN2_foc;
		colorFocused[] = UI_CL_BTN2;
		colorText[] = UI_CL_TEXT;
	};
	class teleport_bttn3 : teleport_bttn1 {
		idc = 600303;
		x = TELEPORT_SPALTE2;
		y = TELEPORT_REIHE1;
		text = "";
		colorBackground[] = UI_CL_BTN3;
		colorBackgroundActive[] = UI_CL_BTN3_foc;
		colorFocused[] = UI_CL_BTN3;
		colorText[] = UI_CL_TEXT_DARK;
	};
	class teleport_bttn4 : teleport_bttn3 {
		idc = 600304;
		y = TELEPORT_REIHE2;
		text = "";
		colorBackground[] = UI_CL_BTN4;
		colorBackgroundActive[] = UI_CL_BTN4_foc;
		colorFocused[] = UI_CL_BTN4;
		colorText[] = UI_CL_TEXT;
	};
	class teleport_bttn5 : teleport_bttn1 {
		idc = 600305;
		x = TELEPORT_SPALTE3;
		y = TELEPORT_REIHE1;
		text = "";
		colorBackground[] = UI_CL_BTN5;
		colorBackgroundActive[] = UI_CL_BTN5_foc;
		colorFocused[] = UI_CL_BTN5;
		colorText[] = UI_CL_TEXT;
	};
	class teleport_bttn6 : teleport_bttn5 {
		idc = 600306;
		y = TELEPORT_REIHE2;
		text = "";
		colorBackground[] = UI_CL_BTN6;
		colorBackgroundActive[] = UI_CL_BTN6_foc;
		colorFocused[] = UI_CL_BTN6;
		colorText[] = UI_CL_TEXT;
	};
	class teleport_bttn7 : teleport_bttn1 {
		idc = 600307;
		y = TELEPORT_REIHE3;
		x = _get_screen_x(0)+_get_screen_w(0.28);
		w = _get_screen_w(0.34);
		text = "";
		colorBackground[] = UI_CL_BTN7;
		colorBackgroundActive[] = UI_CL_BTN7_foc;
		colorFocused[] = UI_CL_BTN7;
		colorText[] = UI_CL_TEXT;
	};
};
