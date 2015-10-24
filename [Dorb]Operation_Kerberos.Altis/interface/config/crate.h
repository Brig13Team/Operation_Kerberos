
#define CBA_OFF
#include "script_component.hpp"

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


