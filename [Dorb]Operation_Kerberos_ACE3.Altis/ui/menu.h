#define teleport_start 470470
// vehiclespawn 	= 600100
// CRATE		 	= 600200
// Task_force	 	= 700200


class dorb_veh_spawn {
	idd = 600100;
	
	name = "spawndialog";
	
	movingEnable = 0;
	enableSimulation = 1;
	fadein = 0;
	fadeout = 0;
	duration = 1000000;
	objects[] = {};
	onLoad = "uiNamespace setVariable ['dorb_spawnMenu', _this select 0]; ['dorb_spawnMenu', true] call dorb_fnc_disp_blur;";
	onUnload = " ['dorb_spawnMenu', false] call dorb_fnc_disp_blur;";
	
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
		onLBSelChanged = "_this spawn dorb_fnc_spawn_ui_select;";
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
		text = "$STR_DORB_SPAWN_DRIVER";
		colorBackground[] = UI_CL_BTN6_foc;
		colorBackgroundActive[] = UI_CL_BTN6_foc;
		colorShadow[] = UI_CL_BTN6;
		colorFocused[] = UI_CL_BTN6_foc;
		default = false;
		shadow = 1;
		onMouseEnter = "";
		onMouseExit = "";
		action = "[""driver""]call dorb_fnc_spawn_ui_create;";
	};
	class spawn_bttn_spawn : spawn_bttn_moveIn {
		idc = 600106;
		y = _get_screen_y(0)+_get_screen_h(0.615);
		text = "$STR_DORB_SPAWN_EMPTY";
		colorBackground[] = UI_CL_BTN2_foc;
		colorBackgroundActive[] = UI_CL_BTN2_foc;
		colorShadow[] = UI_CL_BTN2;
		colorFocused[] = UI_CL_BTN2_foc;
		onSetFocus = "";
		action = "[]call dorb_fnc_spawn_ui_create;";
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
	onLoad = "uiNamespace setVariable ['dorb_teleportMenu', _this select 0]; ['dorb_teleportMenu', true] call dorb_fnc_disp_blur; [] spawn dorb_fnc_teleport_onLoad";
	onUnload = " ['dorb_teleportMenu', false] call dorb_fnc_disp_blur;";
	
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

class dorb_teleport {
	idd = 470470;
	name = "teleport_tafel";
	
	movingEnable = 0;
	enableSimulation = 1;
	fadein = 0;
	fadeout = 0;
	duration = 1000000;
	objects[] = {};
	onLoad = "";
	onUnload = "";
	
	controlsBackground[] = 
	{
		dorb_teleport_body,
		dorb_teleport_header
	};
	
	controls[] =
	{
		dorb_teleport_base_btn,
		dorb_teleport_base_pic,
		dorb_teleport_tank_btn,
		dorb_teleport_tank_pic,
		dorb_teleport_heli_btn,
		dorb_teleport_heli_pic,
		dorb_teleport_drone_btn,
		dorb_teleport_drone_pic,
		dorb_teleport_harbour_btn,
		dorb_teleport_harbour_pic,
		dorb_teleport_logistik_btn,
		dorb_teleport_logistik_pic
	};
	class dorb_teleport_body : dorb_gui_backgroundBase {
		x = _get_screen_x(0)+_get_screen_w(0.2);	
		y = _get_screen_x(0)+_get_screen_h(0.2);
		w = _get_screen_w(0.6);
		h = _get_screen_h(0.49);
		text = "";
		colorBackground[] = UI_CL_BODY;	
	};
	class dorb_teleport_header : dorb_teleport_body {
		idc = -1;
		y = _get_screen_y(0)+_get_screen_h(0.1);
		h = _get_screen_h(0.09);
		text = "Teleport";
		colorText[] = UI_CL_HEADER_TEXT;
		colorBackground[] = UI_CL_HEADER;
	};
	
	class dorb_teleport_base_btn : dorb_gui_button {
		idc = 470471;
		x = _get_screen_x(0)+_get_screen_w(0.22);	
		y = _get_screen_y(0)+_get_screen_h(0.22);
		w = _get_screen_w(0.136);
		h = _get_screen_h(0.17);
		style = ST_CENTER;
		text = "";
		colorBackground[] = UI_CL_BTN2_foc;
		colorShadow[] = UI_CL_BTN2;
		colorBackgroundActive[] = {0,0,0,0};
		colorText[] = {0,0,0,0};
		shadow = 0;
		colorBorder[] = {0,0,0,0};
		colorFocused[] = {0,0,0,0};
		//onMouseEnter = "[""enter"", _this select 0] call basis_fnc_teleport_logic;";
		//onMouseExit = "[""exit"", _this select 0] call basis_fnc_teleport_logic;";
		//onButtonClick = "[""click"", _this select 0] call basis_fnc_teleport_logic;";
//		animTextureNormal = "#(argb,8,8,3)color(0,0,0,0)";
		//animTextureDisabled = "#(argb,8,8,3)color(0,0,0,0)";
		//animTextureOver = "#(argb,8,8,3)color(0,0,0,0)";
		//animTextureFocused = "#(argb,8,8,3)color(0,0,0,0)";
		//animTexturePressed = "#(argb,8,8,3)color(0,0,0,0)";
		//animTextureDefault = "#(argb,8,8,3)color(0,0,0,0)";
		//textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	};
	
	class dorb_teleport_base_pic: dorb_gui_pictureBase {
		idc = 470472;
		x = _get_screen_x(0)+_get_screen_w(0.24);	
		y = _get_screen_y(0)+_get_screen_h(0.25);
		w = _get_screen_w(0.136);
		h = _get_screen_h(0.17);
		colorText[] = UI_CL_TEXT;
		text = "basis\data\icon\icon_base.paa";
	};
/////	
	class dorb_teleport_tank_btn : dorb_teleport_base_btn	{
		idc = 470473;
		y = _get_screen_y(0)+_get_screen_h(0.47);
		colorBackground[] = UI_CL_BTN3_foc;
		colorShadow[] = UI_CL_BTN3;
	};
	class dorb_teleport_tank_pic : dorb_teleport_base_pic {
		idc = 470474;
		y = _get_screen_y(0)+_get_screen_h(0.47);
		text = "basis\data\icon\icon_tank.paa";
		colorText[] = UI_CL_TEXT_DARK;
	};
/////	
	class dorb_teleport_heli_btn : dorb_teleport_base_btn {
		idc = 470475;
		x = _get_screen_x(0)+_get_screen_w(0.4);	
		y = _get_screen_y(0)+_get_screen_h(0.22);
		colorBackground[] = UI_CL_BTN6_foc;
		colorShadow[] = UI_CL_BTN6;
	};
	class dorb_teleport_heli_pic : dorb_teleport_base_pic {
		idc = 470476;
		x = _get_screen_x(0)+_get_screen_w(0.4);	
		y = _get_screen_y(0)+_get_screen_h(0.22);
		text = "basis\data\icon\icon_heli.paa";
	};
/////	
	class dorb_teleport_drone_btn : dorb_teleport_heli_btn {
		idc = 470477;
		y = _get_screen_y(0)+_get_screen_h(0.47);
		colorBackground[] = UI_CL_BTN5_foc;
		colorShadow[] = UI_CL_BTN5;
	};
	class dorb_teleport_drone_pic : dorb_teleport_heli_pic {
		idc = 470478;
		y = _get_screen_y(0)+_get_screen_h(0.47);	
		text = "basis\data\icon\icon_drone.paa";
	};
/////	
	class dorb_teleport_harbour_btn : dorb_teleport_base_btn {
		idc = 470479;
		x = _get_screen_x(0)+_get_screen_w(0.58);	
		y = _get_screen_y(0)+_get_screen_h(0.22);
		colorBackground[] = UI_CL_BTN4_foc;
		colorShadow[] = UI_CL_BTN4;
	};
	class dorb_teleport_harbour_pic : dorb_teleport_base_pic {
		idc = 470480;
		x = _get_screen_x(0)+_get_screen_w(0.58);	
		y = _get_screen_y(0)+_get_screen_h(0.22);
		text = "basis\data\icon\icon_harbour.paa";
	};
/////
	class dorb_teleport_logistik_btn : dorb_teleport_harbour_btn {
		idc = 470481;
		y = _get_screen_y(0)+_get_screen_h(0.47);
		colorBackground[] = UI_CL_BTN7_foc;
		colorShadow[] = UI_CL_BTN7;
	};
	class dorb_teleport_logistik_pic : dorb_teleport_harbour_pic {
		idc = 470482;
		y = _get_screen_y(0)+_get_screen_h(0.47);
		text = "basis\data\icon\icon_logistik.paa";
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
	onLoad = "uiNamespace setVariable ['dorb_crateMenu', _this select 0]; ['dorb_crateMenu', true] call dorb_fnc_disp_blur; [] spawn dorb_fnc_crate_OnLoad;";
	onUnload = " ['dorb_crateMenu', false] call dorb_fnc_disp_blur;";
	
	controlsBackground[] = 	{
		crate_CenterBackground,
		crate_RightCenterBackground,
		crate_HeaderBackground,
		crate_BottemLeftBackground,
		crate_BottemRightBackground,
		crate_ListBackground
	};
	
	controls[] =
	{
		
		crate_combo_box,
		crate_progessbar,
		crate_listbox,
		crate_list_button_add,
		crate_list_button_sub,
		crate_spawn,
		crate_clear,
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
		//crate_button20,
		crate_backgroung_pic1,
		crate_backgroung_pic2,
		crate_backgroung_pic3,
		crate_backgroung_pic4,
		crate_backgroung_pic5,
		crate_backgroung_pic6,
		crate_backgroung_pic7,
		crate_backgroung_pic8,
		crate_backgroung_pic9,
		crate_backgroung_pic10,
		crate_backgroung_pic11,
		crate_backgroung_pic12,
		crate_backgroung_pic13,
		crate_backgroung_pic14,
		crate_backgroung_pic15,
		crate_backgroung_pic16,
		crate_backgroung_pic17,
		crate_backgroung_pic18,
		crate_backgroung_pic19,
		//crate_backgroung_pic20,
		crate_pic1,
		crate_pic2,
		crate_pic3,
		crate_pic4,
		crate_pic5,
		crate_pic6,
		crate_pic7,
		crate_pic8,
		crate_pic9,
		crate_pic10,
		crate_pic11,
		crate_pic12,
		crate_pic13,
		crate_pic14,
		crate_pic15,
		crate_pic16,
		crate_pic17,
		crate_pic18,
		crate_pic19//,
		//crate_pic20
	};
	
	class crate_CenterBackground: dorb_gui_backgroundBase {
		x = _get_screen_x(0)+_get_screen_w(0.1);	
		y = _get_screen_y(0)+_get_screen_h(0.2);
		w = _get_screen_w(0.09476);
		h = _get_screen_h(0.53);
		text = "";
		colorBackground[] = UI_CL_BODY;
		colorText[] = UI_CL_BODY_TEXT;
	};
	class crate_RightCenterBackground: crate_CenterBackground {
		x = _get_screen_x(0)+_get_screen_w(0.19976);	
		w = _get_screen_w(0.70024);
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
		text = "$STR_DORB_CRATE_HEADER";
		colorText[] = UI_CL_HEADER_TEXT;
		colorBackground[] = UI_CL_HEADER;
	};
	
	
	class crate_spawn : dorb_gui_button {
		idc = 600206;
		x = _get_screen_x(0)+_get_screen_w(0.525);
		y = _get_screen_y(0)+_get_screen_h(0.755);
		w = _get_screen_w(0.14);
		h = _get_screen_h(0.06);
		text = "$STR_DORB_CRATE_SPAWN";
		sizeEx = _get_screen_h(0.03);
		colorBackground[] = UI_CL_BTN2_foc;
		colorBackgroundActive[] = UI_CL_BTN2_foc;
		colorShadow[] = UI_CL_BTN2;
		colorFocused[] = UI_CL_BTN2_foc;
		action = "[true]call dorb_fnc_crate_spawn;false";
	};
	class crate_clear : crate_spawn {
		idc = 600207;
		x = _get_screen_x(0)+_get_screen_w(0.725);
		text = "$STR_DORB_CRATE_CLEAR";
		action = "DORB_CRATE_CURRENT=[[],[],[],[],[],[]];DORB_CRATE_CURRENT_BOXID=0;[]call dorb_fnc_crate_OnLoad;false";
	};
	
	
	class crate_list_button_add : crate_spawn {
		idc = 1000;
		text = "+";
		borderSize = 0;
		colorShadow[] = {0,0,0,0};
		action = "[true]call dorb_fnc_crate_add;false";
	};
	class crate_list_button_sub : crate_list_button_add {
		idc = 1001;
		text = "-";
		action = "[false]call dorb_fnc_crate_add;false";
	};
	
	class crate_ListBackground: crate_CenterBackground {
		x = _get_screen_x(0)+_get_screen_w(0.20976);	
		y = _get_screen_y(0)+_get_screen_h(0.21);
		w = _get_screen_w(0.68024);
		h = _get_screen_h(0.51);
		colorText[] = UI_CL_HEADER_TEXT;
		colorBackground[] = UI_CL_CTRL_GRAU2;
	};
	
	class crate_listbox : dorb_gui_listboxN {
		idc = 600201;
		access = 2;
		x = _get_screen_x(0)+_get_screen_w(0.21976);	
		y = _get_screen_y(0)+_get_screen_h(0.22);
		w = _get_screen_w(0.66024);
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
		onLBSelChanged = "DORB_CRATE_CURRENT_BOXID=(_this select 1);['changebox',_config] call dorb_fnc_crate_mass;;false";
	};

	class crate_progessbar : dorb_gui_loadingbarBase {
		idc = 600204;
		x = _get_screen_x(0)+_get_screen_w(0.11);
		y = _get_screen_y(0)+_get_screen_h(0.78);
		w = _get_screen_w(0.375);
		h = _get_screen_h(0.03);
	};
	
	
	class crate_button1 : dorb_gui_button {
		idc = 600211;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE1;
		w = CRATE_BTTN_W;
		h = CRATE_BTTN_H;
		shadow = 0;
		colorBackground[] = {0.6,0.6,0.6,0};
		colorBackgroundActive[] = {0.6,0.6,0.6,0};
		colorFocused[] = {0.6,0.6,0.6,0};
		colorBackgroundDisabled[] = {0.6,0.6,0.6,0};
		colorShadow[] = {0,0,0,0};
		colorBorder[] = {0,0,0,0};
		toolTip = "$STR_DORB_CRATE_BTTN_1";
	};
	class crate_backgroung_pic1 : dorb_gui_backgroundBase {
		idc = 600251;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE1;
		w = CRATE_BTTN_W;
		h = CRATE_BTTN_H;
		colorText[] = UI_CL_CTRL_GRAU1;
		colorBackground[] = UI_CL_CTRL_GRAU4;
		text = "";
	};
	class crate_pic1 : dorb_gui_pictureBase {
		idc = 600231;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE1;
		w = CRATE_BTTN_W;
		h = CRATE_BTTN_H;
		colorText[] = UI_CL_CTRL_GRAU1;
		colorBackground[] = UI_CL_CTRL_GRAU1;
		shadow = 0;
		text = "\A3\ui_f\data\IGUI\Cfg\MPTable\total_ca.paa";
	};
	
	class crate_button2 : crate_button1 {
		idc = 600212;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE1;
		toolTip = "$STR_DORB_CRATE_BTTN_2";
	};
	class crate_backgroung_pic2 : crate_backgroung_pic1 {
		idc = 600252;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE1;
		colorText[] = UI_CL_CTRL_GRAU1;
		colorBackground[] = UI_CL_CTRL_GRAU1;
		text = "";
	};
	class crate_pic2 : crate_pic1 {
		idc = 600232;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE1;
		colorText[] = UI_CL_CTRL_GRAU4;
		colorBackground[] = UI_CL_CTRL_GRAU1;
		//text = "\A3\ui_f\data\gui\Rsc\RscDisplayArsenal\primaryweapon_ca.paa";
		text = "A3\ui_f\data\gui\cfg\Hints\rifle_ca.paa";
	};
	
	class crate_button3 : crate_button1 {
		idc = 600213;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE2;
		toolTip = "$STR_DORB_CRATE_BTTN_3";
	};
	class crate_backgroung_pic3 : crate_backgroung_pic2 {
		idc = 600253;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE2;
		text = "";
	};
	class crate_pic3 : crate_pic2 {
		idc = 600233;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE2;
		//text = "\A3\ui_f\data\gui\Rsc\RscDisplayArsenal\handgun_ca.paa";
		//text = "A3\ui_f\data\gui\cfg\Hints\rifles_ca.paa";
		text = "A3\ui_f\data\gui\cfg\Hints\automatic_ca.paa";
	};
	
	class crate_button4 : crate_button1 {
		idc = 600214;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE2;
		toolTip = "$STR_DORB_CRATE_BTTN_4";
	};
	class crate_backgroung_pic4 : crate_backgroung_pic2 {
		idc = 600254;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE2;
		text = "";
	};
	class crate_pic4 : crate_pic2 {
		idc = 600234;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE2;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\secondaryweapon_ca.paa";
		//text = "A3\ui_f\data\gui\cfg\Hints\shotguns_ca.paa";
		text = "A3\ui_f\data\gui\cfg\Hints\sniper_ca.paa";
	};
	
	class crate_button5 : crate_button1 {
		idc = 600215;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE3;
		toolTip = "$STR_DORB_CRATE_BTTN_5";
	};
	class crate_backgroung_pic5 : crate_backgroung_pic2 {
		idc = 600255;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE3;
		text = "";
	};
	class crate_pic5 : crate_pic2 {
		idc = 600235;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE3;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\itemoptic_ca.paa";
		//text = "A3\ui_f\data\gui\cfg\Hints\sniper_ca.paa";
		text = "A3\ui_f\data\gui\cfg\Hints\shotguns_ca.paa";
	};
	
	class crate_button6 : crate_button1 {
		idc = 600216;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE3;
		toolTip = "$STR_DORB_CRATE_BTTN_6";
	};
	class crate_backgroung_pic6 : crate_backgroung_pic2 {
		idc = 600256;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE3;
		text = "";
	};
	class crate_pic6 : crate_pic2 {
		idc = 600236;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE3;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\itemmuzzle_ca.paa";
		//text = "A3\ui_f\data\gui\cfg\Hints\ranged_ca.paa";
		text = "A3\ui_f\data\gui\cfg\Hints\launcher_ca.paa";
	};
	
	class crate_button7 : crate_button1 {
		idc = 600217;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE4;
		toolTip = "$STR_DORB_CRATE_BTTN_7";
	};
	class crate_backgroung_pic7 : crate_backgroung_pic2 {
		idc = 600257;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE4;
		text = "";
	};
	class crate_pic7 : crate_pic2 {
		idc = 600237;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE4;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\itemacc_ca.paa";
		//text = "A3\ui_f\data\gui\cfg\Hints\launcher_ca.paa";
		text = "A3\ui_f\data\gui\cfg\Hints\handgun_ca.paa";
	};
	
	class crate_button8 : crate_button1 {
		idc = 600218;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE4;
		toolTip = "$STR_DORB_CRATE_BTTN_8";
	};
	class crate_backgroung_pic8 : crate_backgroung_pic2 {
		idc = 600258;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE4;
		text = "";
	};
	class crate_pic8 : crate_pic2 {
		idc = 600238;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE4;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargomag_ca.paa";
		//text = "A3\ui_f\data\gui\cfg\Hints\automatic_ca.paa";
		text = "A3\ui_f\data\gui\cfg\Hints\optics_ca.paa";
	};
	
	class crate_button9 : crate_button1 {
		idc = 600219;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE5;
		toolTip = "$STR_DORB_CRATE_BTTN_9";
	};
	class crate_backgroung_pic9 : crate_backgroung_pic2 {
		idc = 600259;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE5;
		text = "";
	};
	class crate_pic9 : crate_pic2 {
		idc = 600239;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE5;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa";
		//text = "A3\ui_f\data\gui\cfg\Hints\handgun_ca.paa";
		text = "A3\ui_f\data\gui\cfg\Hints\grenades_ca.paa";
	};
	
	class crate_button10 : crate_button1 {
		idc = 600220;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE5;
		toolTip = "$STR_DORB_CRATE_BTTN_10";
	};
	class crate_backgroung_pic10 : crate_backgroung_pic2 {
		idc = 6002560;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE5;
		text = "";
	};
	class crate_pic10 : crate_pic2 {
		idc = 600240;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE5;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargothrow_ca.paa";
		//text = "A3\ui_f\data\gui\cfg\Hints\grenades_ca.paa";
		text = "A3\ui_f\data\gui\cfg\Hints\ieds_ca.paa";
	};
	
	class crate_button11 : crate_button1 {
		idc = 600221;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE6;
		toolTip = "$STR_DORB_CRATE_BTTN_11";
	};
	class crate_backgroung_pic11 : crate_backgroung_pic2 {
		idc = 600261;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE6;
		text = "";
	};
	class crate_pic11 : crate_pic2 {
		idc = 600241;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE6;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\gps_ca.paa";
		//text = "A3\ui_f\data\gui\cfg\Hints\ammotype_ca.paa";
		text = "A3\ui_f\data\gui\cfg\Hints\gear_ca.paa";
	};
	
	class crate_button12 : crate_button1 {
		idc = 600222;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE6;
		toolTip = "$STR_DORB_CRATE_BTTN_12";
	};
	class crate_backgroung_pic12 : crate_backgroung_pic1 {
		idc = 600262;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE6;
		text = "";
	};
	class crate_pic12 : crate_pic1 {
		idc = 600242;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE6;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargomisc_ca.paa";
		//text = "A3\ui_f\data\gui\cfg\Hints\muzzles_ca.paa";
		text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\vest_ca.paa";
	};
	
	class crate_button13 : crate_button1 {
		idc = 600223;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE7;
		toolTip = "$STR_DORB_CRATE_BTTN_13";
	};
	class crate_backgroung_pic13 : crate_backgroung_pic1 {
		idc = 600263;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE7;
		text = "";
	};
	class crate_pic13 : crate_pic1 {
		idc = 600243;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE7;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\nvgs_ca.paa";
		//text = "A3\ui_f\data\gui\cfg\Hints\pointer_ca.paa";
		text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\uniform_ca.paa";
	};
	
	class crate_button14 : crate_button1 {
		idc = 600224;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE7;
		toolTip = "$STR_DORB_CRATE_BTTN_14";
	};
	class crate_backgroung_pic14 : crate_backgroung_pic1 {
		idc = 600264;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE7;
		text = "";
	};
	class crate_pic14 : crate_pic1 {
		idc = 600244;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE7;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\binoculars_ca.paa";
		//text = "A3\ui_f\data\gui\cfg\Hints\pointers_ca.paa";
		text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\headgear_ca.paa";
	};
	
	class crate_button15 : crate_button1 {
		idc = 600225;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE8;
		toolTip = "$STR_DORB_CRATE_BTTN_15";
	};
	class crate_backgroung_pic15 : crate_backgroung_pic1 {
		idc = 600265;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE8;
		text = "";
	};
	class crate_pic15 : crate_pic1 {
		idc = 600245;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE8;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\goggles_ca.paa";
		//text = "A3\ui_f\data\gui\cfg\Hints\ieds_ca.paa";
		text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\radio_ca.paa";
	};
	
	class crate_button16 : crate_button1 {
		idc = 600226;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE8;
		toolTip = "$STR_DORB_CRATE_BTTN_16";
	};
	class crate_backgroung_pic16 : crate_backgroung_pic2 {
		idc = 600266;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE8;
		text = "";
	};
	class crate_pic16 : crate_pic2 {
		idc = 600246;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE8;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\radio_ca.paa";
		text = "A3\ui_f\data\gui\cfg\Hints\map_ca.paa";
	};
	
	class crate_button17 : crate_button1 {
		idc = 600227;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE9;
		toolTip = "$STR_DORB_CRATE_BTTN_17";
	};
	class crate_backgroung_pic17 : crate_backgroung_pic2 {
		idc = 600267;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE9;
		text = "";
	};
	class crate_pic17 : crate_pic2 {
		idc = 600247;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE9;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\uniform_ca.paa";
		text = "A3\ui_f\data\gui\cfg\Hints\injury_ca.paa";
	};
	
	class crate_button18 : crate_button1 {
		idc = 600228;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE9;
		toolTip = "$STR_DORB_CRATE_BTTN_18";
	};
	class crate_backgroung_pic18 : crate_backgroung_pic2 {
		idc = 600268;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE9;
		text = "";
	};
	class crate_pic18 : crate_pic2 {
		idc = 600248;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE9;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\headgear_ca.paa";
		text = "A3\ui_f\data\gui\cfg\Hints\slots_ca.paa";
	};
	
	class crate_button19 : crate_button1 {
		idc = 600229;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE10;
		toolTip = "$STR_DORB_CRATE_BTTN_19";
	};
	class crate_backgroung_pic19 : crate_backgroung_pic2 {
		idc = 600269;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE10;
		text = "";
	};
	class crate_pic19 : crate_pic2 {
		idc = 600249;
		x = CRATE_SPALTE1;
		y = CRATE_REIHE10;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\vest_ca.paa";
		text = "A3\ui_f\data\gui\cfg\Hints\actionmenu_ca.paa";
	};
	
	class crate_button20 : crate_button1 {
		idc = 600230;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE10;
		toolTip = "$STR_DORB_CRATE_BTTN_20";
	};
	class crate_backgroung_pic20 : crate_backgroung_pic2 {
		idc = 600270;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE10;
		text = "";
	};
	class crate_pic20 : crate_pic2 {
		idc = 600250;
		x = CRATE_SPALTE2;
		y = CRATE_REIHE10;
		//text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\backpack_ca.paa";
		//text = "A3\ui_f\data\gui\cfg\Hints\gear_ca.paa";
		text = "A3\ui_f\data\gui\cfg\Hints\actionmenu_ca.paa";
	};
	
	
	
	
	
	
	
	
};



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
	onLoad = "uiNamespace setVariable ['dorb_tfrMenu', _this select 0]; ['dorb_tfrMenu', true] call dorb_fnc_disp_blur;";
	onUnload = " ['dorb_tfrMenu', false] call dorb_fnc_disp_blur; ['DORB_TFR_onOpenEH', 'onEachFrame'] call BIS_fnc_removeStackedEventHandler;";
	
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
		text = "$STR_DORB_TFR_HEADER";
		colorText[] = UI_CL_HEADER_TEXT;
		colorBackground[] = UI_CL_HEADER;
	};
	class dorb_tfr_frequenzen : dorb_tfr_body {
		x = _get_screen_x(0)+_get_screen_w(0.605);
		y = _get_screen_x(0)+_get_screen_h(0.2);
		w = _get_screen_w(0.295);
		h = _get_screen_h(0.06);
		sizeEx = _get_screen_h(0.035);
		text = "$STR_DORB_TFR_FREQ_SQUAD";
		colorBackground[]=UI_CL_HEADER2;
	};
	class dorb_tfr_frequenzen_neu : dorb_tfr_frequenzen {
		y = _get_screen_x(0)+_get_screen_h(0.465);
		text = "$STR_DORB_TFR_FREQ_NEW";
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
		text = "$STR_DORB_TFR_TAKE";
		toolTip = "$STR_DORB_TFR_TAKE_TOOLTIP";
		sizeEx = _get_screen_h(0.03);
		colorBackground[] = UI_CL_CTRL_WEINROT1;
		colorBackgroundActive[] = UI_CL_CTRL_WEINROT2;
		colorFocused[] = UI_CL_CTRL_WEINROT1;
		action = "[]call dorb_fnc_tfr_setFreq;";
	};
	class dorb_tfr_set : dorb_tfr_take {
		idc = 700209;
		y = _get_screen_x(0)+_get_screen_h(0.58375);	
		text = "$STR_DORB_TFR_SET";
		toolTip = "$STR_DORB_TFR_SET_TOOLTIP";
		action = "[]call dorb_fnc_tfr_setGroup;";
	};
};