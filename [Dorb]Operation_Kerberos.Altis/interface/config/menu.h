#define teleport_start 470470
// vehiclespawn 	= 600100
// CRATE		 	= 600200
// Task_force	 	= 700200
#include "macros_rsc.hpp"

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

#define CRATE_SPALTE1 _get_screen_x(0)+_get_screen_w(0.11)
#define CRATE_SPALTE2 _get_screen_x(0)+_get_screen_w(0.14988)
#define CRATE_REIHE1 _get_screen_y(0)+_get_screen_h(0.21)
#define CRATE_REIHE2 _get_screen_y(0)+_get_screen_h(0.2615)
#define CRATE_REIHE3 _get_screen_y(0)+_get_screen_h(0.313)
#define CRATE_REIHE4 _get_screen_y(0)+_get_screen_h(0.3645)
#define CRATE_REIHE5 _get_screen_y(0)+_get_screen_h(0.416)
#define CRATE_REIHE6 _get_screen_y(0)+_get_screen_h(0.4675)
#define CRATE_REIHE7 _get_screen_y(0)+_get_screen_h(0.519)
#define CRATE_REIHE8 _get_screen_y(0)+_get_screen_h(0.5705)
#define CRATE_REIHE9 _get_screen_y(0)+_get_screen_h(0.622)
#define CRATE_REIHE10 _get_screen_y(0)+_get_screen_h(0.6735)

#define CRATE_BTTN_W _get_screen_w(0.03488)
#define CRATE_BTTN_H _get_screen_h(0.0465)

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


class dorb_crate {
	idd = 600200;
	name = "Kisten-Füller";
	/// von Dorbedo - wer das Ding nutzen will: Fragen!
	movingEnable = 0;
	enableSimulation = 1;
	fadein = 0;
	fadeout = 0;
	duration = 1000000;
	objects[] = {};
	onLoad = "uiNamespace setVariable ['dorb_crateMenu', _this select 0]; ['dorb_crateMenu', true] call dorb_interface_fnc_disp_blur; [] spawn dorb_interface_fnc_crate_OnLoad;";
	onUnload = " ['dorb_crateMenu', false] call dorb_interface_fnc_disp_blur;";
	
	controlsBackground[] = 	{
		crate_CenterBackground,
		crate_RightCenterBackground,
		crate_HeaderBackground,
		crate_BottemLeftBackground,
		crate_BottemRightBackground,
		crate_ListBackground
	};
	
	controls[] = {
		crate_combo_box,
		crate_progessbar,
		crate_listbox,
		crate_list_button_add,
		crate_list_button_sub,
		crate_spawn,
		crate_clear,
		crate_save,
		crate_load,
		crate_button1,
		crate_button2,
		crate_button3,
		crate_button4,
		crate_button5,
		crate_button6,
		crate_button7,
		crate_button8,
		crate_button9,
		crate_button10,
		crate_button11,
		crate_button12,
		crate_button13,
		crate_button14,
		crate_button15,
		crate_button16,
		crate_button17,
		crate_button18,
		crate_button19,
	};
	
	class crate_CenterBackground: dorb_gui_backgroundBase {
		x = _get_screen_x(0)+_get_screen_w(0.1);	
		y = _get_screen_y(0)+_get_screen_h(0.2);
		w = _get_screen_w(0.118);
		h = _get_screen_h(0.53);
		text = "";
		colorBackground[] = UI_CL_BODY;
		colorText[] = UI_CL_BODY_TEXT;
	};
	class crate_RightCenterBackground: crate_CenterBackground {
		x = _get_screen_x(0)+_get_screen_w(0.223);	
		w = _get_screen_w(0.677);
	};
	class crate_BottemLeftBackground: dorb_gui_backgroundBase {
		x = _get_screen_x(0)+_get_screen_w(0.1);
		y = _get_screen_y(0)+_get_screen_h(0.74);
		w = _get_screen_w(0.395);
		h = _get_screen_h(0.16);
		text = "";
		colorBackground[] = UI_CL_BODY;
		colorText[] = UI_CL_BODY_TEXT;
	};
	class crate_BottemRightBackground: dorb_gui_backgroundBase {
		x = _get_screen_x(0)+_get_screen_w(0.505);
		y = _get_screen_y(0)+_get_screen_h(0.74);
		w = _get_screen_w(0.395);
		h = _get_screen_h(0.16);
		text = "";
		colorBackground[] = UI_CL_BODY;
		colorText[] = UI_CL_BODY_TEXT;
	};
	class crate_HeaderBackground: crate_CenterBackground {
		x = _get_screen_x(0)+_get_screen_w(0.1);
		y = _get_screen_y(0)+_get_screen_h(0.1);
		w = _get_screen_w(0.8);
		h = _get_screen_h(0.09);
		text = ECSTRING(INTERFACE,CRATE_HEADER);
		colorText[] = UI_CL_HEADER_TEXT;
		colorBackground[] = UI_CL_HEADER;
	};
	
	
	class crate_spawn : dorb_gui_button {
		idc = 600206;
		x = _get_screen_x(0)+_get_screen_w(0.525);
		y = _get_screen_y(0)+_get_screen_h(0.755);
		w = _get_screen_w(0.14);
		h = _get_screen_h(0.06);
		text = ECSTRING(INTERFACE,CRATE_SPAWN);
		sizeEx = _get_screen_h(0.03);
		colorBackground[] = UI_CL_BTN2_foc;
		colorBackgroundActive[] = UI_CL_BTN2_foc;
		colorShadow[] = UI_CL_BTN2;
		colorFocused[] = UI_CL_BTN2_foc;
		action = "[true] call dorb_interface_fnc_crate_spawn;false";
	};
	class crate_clear : crate_spawn {
		idc = 600207;
		x = _get_screen_x(0)+_get_screen_w(0.725);
		text = ECSTRING(INTERFACE,CRATE_CLEAR);
		action = "dorb_interface_crate_current=[[],[],[],[],[],[]];dorb_interface_crate_current_boxid=0;[] call dorb_interface_fnc_crate_OnLoad;false";
	};
	
	class crate_save : crate_spawn {
		idc = 600208;
		y = _get_screen_y(0)+_get_screen_h(0.82);
		text = ECSTRING(INTERFACE,CRATE_SAVE);
		action = "[true] spawn dorb_interface_fnc_crate_save;false";
	};
	
	class crate_load : crate_clear {
		idc = 600209;
		y = _get_screen_y(0)+_get_screen_h(0.82);
		text = ECSTRING(INTERFACE,CRATE_LOAD);
		action = "[false] spawn dorb_interface_fnc_crate_save;false";
	};
	
	
	class crate_list_button_add : crate_spawn {
		idc = 1000;
		text = "+";
		borderSize = 0;
		colorShadow[] = {0,0,0,0};
		action = "[true]call dorb_interface_fnc_crate_add;false";
	};
	class crate_list_button_sub : crate_list_button_add {
		idc = 1001;
		text = "-";
		action = "[false]call dorb_interface_fnc_crate_add;false";
	};
	
	class crate_ListBackground: crate_CenterBackground {
		x = _get_screen_x(0)+_get_screen_w(0.233);	
		y = _get_screen_y(0)+_get_screen_h(0.21);
		w = _get_screen_w(0.657);
		h = _get_screen_h(0.51);
		colorText[] = UI_CL_HEADER_TEXT;
		colorBackground[] = UI_CL_CTRL_GRAU2;
	};
	
	class crate_listbox : dorb_gui_listboxN {
		idc = 600201;
		access = 2;
		x = _get_screen_x(0)+_get_screen_w(0.243);	
		y = _get_screen_y(0)+_get_screen_h(0.22);
		w = _get_screen_w(0.637);
		h = _get_screen_h(0.49);
		rowHeight = _get_screen_h(0.035);
		sizeEx = _get_screen_h(0.022);
		columns[] = {_get_screen_w(0.027),_get_screen_w(0.09),_get_screen_w(0.15),_get_screen_w(0.55)};
		
			//colorText[] = UI_CL_BODY_TEXT; 
			//colorBackground[] = {0.5, 0.5, 0, 1}; 
			//shadow = 1; 
			
			// color[] = {0.5, 0.5, 0, 1}; 
			// colorScrollbar[] = {0.8, 0.8, 0.8, 1}; 
			 //colorSelect[] = {0.8, 0.8, 0.8, 1}; 
			 //colorSelect2[] = {0.8, 0.8, 0.8, 1}; 
			 //colorSelectBackground[] = {0, 0, 0, 1}; 
			 //colorSelectBackground2[] = {0.8784, 0.8471, 0.651, 1}; 
			
			drawSideArrows = 1; // 1 to draw buttons linked by idcLeft and idcRight on both sides of selected line. They are resized to line height
			idcLeft = 1001; // Left button IDC
			idcRight = 1000;
			
			//onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
			//onDestroy = "systemChat str ['onDestroy',_this]; false";
			//onSetFocus = "systemChat str ['onSetFocus',_this]; false";
			//onKillFocus = "systemChat str ['onKillFocus',_this]; false";
			//onKeyDown = "systemChat str ['onKeyDown',_this]; false";
			//onKeyUp = "systemChat str ['onKeyUp',_this]; false";
			//onMouseButtonDown = "systemChat str ['onMouseButtonDown',_this]; false";
			//onMouseButtonUp = "systemChat str ['onMouseButtonUp',_this]; false";
			//onMouseButtonClick = "systemChat str ['onMouseButtonClick',_this]; false";
			//onMouseButtonDblClick = "systemChat str ['onMouseButtonDblClick',_this]; false";
			//onMouseZChanged = "systemChat str ['onMouseZChanged',_this]; false";
			//onMouseMoving = "";
			//onMouseHolding = "";

			//onLBSelChanged = "systemChat str ['onLBSelChanged',_this]; false";
			//onLBDblClick = "systemChat str ['onLBDblClick',_this]; false";
	};
	
	class crate_combo_box : dorb_gui_combo {
		idc = 600205;
		x = _get_screen_x(0)+_get_screen_w(0.11);
		y = _get_screen_y(0)+_get_screen_h(0.85);
		w = _get_screen_w(0.375);
		h = _get_screen_h(0.03);
		sizeEx = _get_screen_h(0.025);
		rowHeight = _get_screen_h(0.025);
		wholeHeight = _get_screen_h(0.2);
		onLBSelChanged = "dorb_interface_crate_current_boxid=(_this select 1);['changebox',_config] call dorb_interface_fnc_crate_mass;false";
	};

	class crate_progessbar : dorb_gui_loadingbarBase {
		idc = 600204;
		x = _get_screen_x(0)+_get_screen_w(0.11);
		y = _get_screen_y(0)+_get_screen_h(0.78);
		w = _get_screen_w(0.375);
		h = _get_screen_h(0.03);
	};
	
	#define CRATE_SPALTE1 _get_screen_x(0)+_get_screen_w(0.11)
	#define CRATE_SPALTE2 _get_screen_x(0)+_get_screen_w(0.1615)
	#define CRATE_REIHE1 _get_screen_y(0)+_get_screen_h(0.21)
	#define CRATE_REIHE2 _get_screen_y(0)+_get_screen_h(0.2615)
	#define CRATE_REIHE3 _get_screen_y(0)+_get_screen_h(0.313)
	#define CRATE_REIHE4 _get_screen_y(0)+_get_screen_h(0.3645)
	#define CRATE_REIHE5 _get_screen_y(0)+_get_screen_h(0.416)
	#define CRATE_REIHE6 _get_screen_y(0)+_get_screen_h(0.4675)
	#define CRATE_REIHE7 _get_screen_y(0)+_get_screen_h(0.519)
	#define CRATE_REIHE8 _get_screen_y(0)+_get_screen_h(0.5705)
	#define CRATE_REIHE9 _get_screen_y(0)+_get_screen_h(0.622)
	#define CRATE_REIHE10 _get_screen_y(0)+_get_screen_h(0.6735)

	#define CRATE_BTTN_W _get_screen_w(0.0465) //_get_screen_w(0.03488)
	#define CRATE_BTTN_H _get_screen_h(0.0465)

	
	
	class crate_button1 : dorb_gui_button {
		idc = 600211;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE1;
		w = CRATE_BTTN_W;
		h = CRATE_BTTN_H;
		shadow = 0;	//_get_screen_h(0.0465) // _get_screen_w(0.03488)
		sizeEx = CRATE_BTTN_W + _get_screen_w(0.004);
		
		color[] = {0, 1, 0, 1};  //seems nothing to change, but define to avaoid errors
	
		colorBackground[] = UI_CL_CTRL_GRAU4;
		colorBackgroundActive[] = UI_CL_CTRL_GRAU2;
		colorFocused[] = UI_CL_CTRL_GRAU3;
		
		colorText[] = UI_CL_CTRL_GRAU1;
		colorTextSelect[] = UI_CL_CTRL_GRAU4;
		
		
		colorShadow[] = UI_CL_CTRL_GRAU4;
		colorBorder[] = UI_CL_CTRL_GRAU4;
		
		colorDisabled[] = {0.1, 0.1, 0.1, 0.4};
		colorBackgroundDisabled[] = {0, 0, 0, 0.2};
		
		offsetX = 0;
		offsetY = 0;
		
		
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_1);
		style = ST_PICTURE;
		text = "\A3\ui_f\data\IGUI\Cfg\MPTable\total_ca.paa";
	};
	
	class crate_button2 : crate_button1 {
		idc = 600212;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE1;
		
		default=false;
		
		colorBackground[] = UI_CL_CTRL_GRAU1;
		colorBackgroundActive[] = UI_CL_CTRL_GRAU3;
		colorFocused[] = UI_CL_CTRL_GRAU2;
		
		colorText[] = UI_CL_CTRL_GRAU4;
		colorTextSelect[] = UI_CL_CTRL_GRAU1;
		
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_2);
		text = "A3\ui_f\data\gui\cfg\Hints\rifle_ca.paa";
	};
	
	class crate_button3 : crate_button2 {
		idc = 600213;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE2;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_3);
		text = "A3\ui_f\data\gui\cfg\Hints\automatic_ca.paa";
	};
	
	class crate_button4 : crate_button2 {
		idc = 600214;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE2;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_4);
		text = "A3\ui_f\data\gui\cfg\Hints\sniper_ca.paa";
	};
	
	class crate_button5 : crate_button2 {
		idc = 600215;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE3;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_5);
		text = "A3\ui_f\data\gui\cfg\Hints\shotguns_ca.paa";
	};
	
	class crate_button6 : crate_button2 {
		idc = 600216;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE3;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_6);
		text = "A3\ui_f\data\gui\cfg\Hints\launcher_ca.paa";
	};
	
	class crate_button7 : crate_button2 {
		idc = 600217;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE4;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_7);
		text = "A3\ui_f\data\gui\cfg\Hints\handgun_ca.paa";
	};
	
	class crate_button8 : crate_button2 {
		idc = 600218;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE4;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_8);
		text = "A3\ui_f\data\gui\cfg\Hints\optics_ca.paa";
	};
	
	class crate_button9 : crate_button2 {
		idc = 600219;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE5;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_9);
		text = "A3\ui_f\data\gui\cfg\Hints\grenades_ca.paa";
	};
	
	class crate_button10 : crate_button2 {
		idc = 600220;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE5;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_10);
		text = "A3\ui_f\data\gui\cfg\Hints\ieds_ca.paa";
	};
	
	class crate_button11 : crate_button2 {
		idc = 600221;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE6;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_11);
		text = "A3\ui_f\data\gui\cfg\Hints\gear_ca.paa";
	};
	
	class crate_button12 : crate_button1 {
		idc = 600222;
		default=false;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE6;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_12);
		text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\vest_ca.paa";
	};
	
	class crate_button13 : crate_button1 {
		idc = 600223;
		default=false;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE7;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_13);
		text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\uniform_ca.paa";
	};
	
	class crate_button14 : crate_button1 {
		idc = 600224;
		default=false;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE7;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_14);
		text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\headgear_ca.paa";
	};
	
	class crate_button15 : crate_button1 {
		idc = 600225;
		default=false;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE8;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_15);
		text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\radio_ca.paa";
	};
	
	class crate_button16 : crate_button2 {
		idc = 600226;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE8;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_16);
		text = "A3\ui_f\data\gui\cfg\Hints\map_ca.paa";
	};
	
	class crate_button17 : crate_button2 {
		idc = 600227;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE9;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_17);
		text = "A3\ui_f\data\gui\cfg\Hints\injury_ca.paa";
	};
	
	class crate_button18 : crate_button2 {
		idc = 600228;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE9;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_18);
		text = "A3\ui_f\data\gui\cfg\Hints\slots_ca.paa";
	};
	
	class crate_button19 : crate_button2 {
		idc = 600229;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE10;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_19);
		text = "A3\ui_f\data\gui\cfg\Hints\actionmenu_ca.paa";
	};
	
	class crate_button20 : crate_button2 {
		idc = 600230;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE10;
		toolTip = ECSTRING(INTERFACE,CRATE_BTTN_20);
		text = "A3\ui_f\data\gui\cfg\Hints\actionmenu_ca.paa";
	};
	
};

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


