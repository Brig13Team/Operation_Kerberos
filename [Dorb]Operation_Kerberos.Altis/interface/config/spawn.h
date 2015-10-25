/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"

class GVAR(veh_spawn) {
	idd = 600100;
	name = "spawndialog";
	movingEnable = 0;
	enableSimulation = 1;
	fadein = 0;
	fadeout = 0;
	duration = 1000000;
	objects[] = {};
	onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(spawnMenu)', _this select 0)]; [ARR_2('GVAR(spawnMenu)', true)] call FUNC(disp_blur););
	onUnload = QUOTE([ARR_2('GVAR(spawnMenu)',false)] call FUNC(disp_blur););
	
	controlsBackground[] =	{
		spawn_CenterBackground,
		spawn_RightBackground
	};
	controls[] = 	{
		spawn_HeaderBackground,
		spawn_Fahrzeug,
		spawn_bttn_moveIn,
		spawn_Fahrzeug_pic,
		spawn_bttn_spawn,
		spawn_listbox
	};
	class spawn_CenterBackground: dorb_gui_backgroundBase {
		x = GUI_XW(0,0.1);	
		y = GUI_YH(0,0.2);
		w = GUI_W(0.46);
		h = GUI_H(0.5);
		text = "";
		colorBackground[] = UI_CL_BODY;
	};
	class spawn_RightBackground: spawn_CenterBackground {
		x = GUI_XW(0,0.565);	
		y = GUI_YH(0,0.305);
		w = GUI_W(0.235);
		h = GUI_H(0.395);
	};
	class spawn_Fahrzeug : spawn_RightBackground {
		idc = 600103;	
		y = GUI_YH(0,0.2);
		h = GUI_H(0.1);
		sizeEx = GUI_H(0.027);
		colorText[] = UI_CL_TEXT_DARK;
		colorBackground[]=UI_CL_HEADER2;
		text = "";
	};
	class spawn_Fahrzeug_pic : dorb_gui_pictureBase {
		idc = 600104;	
		x = GUI_XW(0,0.598125);
		y = GUI_YH(0,0.315);
		w = GUI_W(0.16875);
		h = GUI_H(0.225);
		colorText[] = UI_CL_CTRL_GRAU3;
		colorBackground[]=UI_CL_BODY;
		text = "data\icon\icon_heli.paa";
	};
	class spawn_HeaderBackground: spawn_CenterBackground {
		idc = 600101;
		y = GUI_YH(0,0.1);
		w = GUI_W(0.7);
		h = GUI_H(0.09);
		text = "";
		colorText[] = UI_CL_HEADER_TEXT;
		colorBackground[] = UI_CL_HEADER;
	};
	class spawn_listbox : dorb_gui_listboxN {
		idc = 600102;
		x = GUI_XW(0,0.115);	
		y = GUI_YH(0,0.215);
		w = GUI_W(0.43);
		h = GUI_H(0.46);
		rowHeight = GUI_H(0.035);
		sizeEx = GUI_H(0.025);
		columns[] = {0.0,GUI_W(0.08),GUI_W(0.14),0.0};
		onLBSelChanged = QUOTE(_this spawn FUNC(spawn_select););
		default = true;
		
	};
	class spawn_bttn_moveIn : dorb_gui_button {
		idc = 600105;
		x = GUI_XW(0,0.58);	
		y = GUI_YH(0,0.55);
		w = GUI_W(0.205);
		h = GUI_H(0.06);
		style = ST_CENTER;
		sizeEx = GUI_H(0.03);
		text = ECSTRING(INTERFACE,SPAWN_DRIVER);
		colorBackground[] = UI_CL_BTN6_foc;
		colorBackgroundActive[] = UI_CL_BTN6_foc;
		colorShadow[] = UI_CL_BTN6;
		colorFocused[] = UI_CL_BTN6_foc;
		default = false;
		shadow = 1;
		onMouseEnter = "";
		onMouseExit = "";
		action = QUOTE(['driver'] call FUNC(spawn_create););
	};
	class spawn_bttn_spawn : spawn_bttn_moveIn {
		idc = 600106;
		y = GUI_YH(0,0.615);
		text = ECSTRING(INTERFACE,SPAWN_EMPTY);
		colorBackground[] = UI_CL_BTN2_foc;
		colorBackgroundActive[] = UI_CL_BTN2_foc;
		colorShadow[] = UI_CL_BTN2;
		colorFocused[] = UI_CL_BTN2_foc;
		onSetFocus = "";
		action = QUOTE([] call FUNC(spawn_create););
	};
};