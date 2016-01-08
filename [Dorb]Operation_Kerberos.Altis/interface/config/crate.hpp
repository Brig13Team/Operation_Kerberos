/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"

class GVAR(crate) {
    idd = 600200;
    name = "Kisten-Füller";
    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;
    objects[] = {};
    onLoad = QUOTE( uiNamespace setVariable [ARR_2('GVAR(crateMenu)',_this select 0)]; [ARR_2('GVAR(crateMenu)',true)] call FUNC(disp_blur); [] spawn FUNC(crate_OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(crateMenu)',false)] call FUNC(disp_blur););

    controlsBackground[] =  {
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
        x = GUI_XW(0,0.1);
        y = GUI_YH(0,0.2);
        w = GUI_W(0.118);
        h = GUI_H(0.53);
        text = "";
        colorBackground[] = UI_CL_BODY;
        colorText[] = UI_CL_BODY_TEXT;
    };

    class crate_RightCenterBackground: crate_CenterBackground {
        x = GUI_XW(0,0.223);
        w = GUI_W(0.677);
    };

    class crate_BottemLeftBackground: dorb_gui_backgroundBase {
        x = GUI_XW(0,0.1);
        y = GUI_YH(0,0.74);
        w = GUI_W(0.395);
        h = GUI_H(0.16);
        text = "";
        colorBackground[] = UI_CL_BODY;
        colorText[] = UI_CL_BODY_TEXT;
    };

    class crate_BottemRightBackground: dorb_gui_backgroundBase {
        x = GUI_XW(0,0.505);
        y = GUI_YH(0,0.74);
        w = GUI_W(0.395);
        h = GUI_H(0.16);
        text = "";
        colorBackground[] = UI_CL_BODY;
        colorText[] = UI_CL_BODY_TEXT;
    };

    class crate_HeaderBackground: crate_CenterBackground {
        x = GUI_XW(0,0.1);
        y = GUI_YH(0,0.1);
        w = GUI_W(0.8);
        h = GUI_H(0.09);
        text = ECSTRING(INTERFACE,CRATE_HEADER);
        colorText[] = UI_CL_HEADER_TEXT;
        colorBackground[] = UI_CL_HEADER;
    };

    class crate_spawn : dorb_gui_button {
        idc = 600206;
        x = GUI_XW(0,0.525);
        y = GUI_YH(0,0.755);
        w = GUI_W(0.14);
        h = GUI_H(0.06);
        text = ECSTRING(INTERFACE,CRATE_SPAWN);
        sizeEx = GUI_H(0.03);
        colorBackground[] = UI_CL_BTN2_foc;
        colorBackgroundActive[] = UI_CL_BTN2_foc;
        colorShadow[] = UI_CL_BTN2;
        colorFocused[] = UI_CL_BTN2_foc;
        action = QUOTE([true] call FUNC(crate_spawn);false);
    };

    class crate_clear : crate_spawn {
        idc = 600207;
        x = GUI_XW(0,0.725);
        text = ECSTRING(INTERFACE,CRATE_CLEAR);
        action = QUOTE( GVAR(crate_current) = [ARR_6([],[],[],[],[],[])] ; GVAR(crate_current_boxid) = 0; [] call FUNC(crate_onLoad); false);
    };

    class crate_save : crate_spawn {
        idc = 600208;
        y = GUI_YH(0,0.82);
        text = ECSTRING(INTERFACE,CRATE_SAVE);
        action = QUOTE([true] spawn FUNC(crate_save);false);
    };

    class crate_load : crate_clear {
        idc = 600209;
        y = GUI_YH(0,0.82);
        text = ECSTRING(INTERFACE,CRATE_LOAD);
        action = QUOTE([false] spawn FUNC(crate_save);false);
    };

    class crate_list_button_add : crate_spawn {
        idc = 1000;
        text = "+";
        borderSize = 0;
        colorShadow[] = {0,0,0,0};
        action = QUOTE([true] call FUNC(crate_add);false);
    };

    class crate_list_button_sub : crate_list_button_add {
        idc = 1001;
        text = "-";
        action = QUOTE([false] call FUNC(crate_add);false);
    };

    class crate_ListBackground: crate_CenterBackground {
        x = GUI_XW(0,0.233);
        y = GUI_YH(0,0.21);
        w = GUI_W(0.657);
        h = GUI_H(0.51);
        colorText[] = UI_CL_HEADER_TEXT;
        colorBackground[] = UI_CL_CTRL_GRAU2;
    };

    class crate_listbox : dorb_gui_listboxN {
        idc = 600201;
        access = 2;
        x = GUI_XW(0,0.243);
        y = GUI_YH(0,0.22);
        w = GUI_W(0.637);
        h = GUI_H(0.49);
        rowHeight = GUI_H(0.035);
        sizeEx = GUI_H(0.022);
        columns[] = {GUI_W(0.027),GUI_W(0.09),GUI_W(0.15),GUI_W(0.55)};
        drawSideArrows = 1;
        idcLeft = 1001;
        idcRight = 1000;
    };

    class crate_combo_box : dorb_gui_combo {
        idc = 600205;
        x = GUI_XW(0,0.11);
        y = GUI_YH(0,0.85);
        w = GUI_W(0.375);
        h = GUI_H(0.03);
        sizeEx = GUI_H(0.025);
        rowHeight = GUI_H(0.025);
        wholeHeight = GUI_H(0.2);
        onLBSelChanged = QUOTE(GVAR(crate_current_boxid) = (_this select 1); [ARR_2('changebox',_config)] call FUNC(crate_mass);false);
    };

    class crate_progessbar : dorb_gui_loadingbarBase {
        idc = 600204;
        x = GUI_XW(0,0.11);
        y = GUI_YH(0,0.78);
        w = GUI_W(0.375);
        h = GUI_H(0.03);
    };

    #define CRATE_SPALTE1 GUI_XW(0,0.11)
    #define CRATE_SPALTE2 GUI_XW(0,0.1615)
    #define CRATE_REIHE1 GUI_YH(0,0.21)
    #define CRATE_REIHE2 GUI_YH(0,0.2615)
    #define CRATE_REIHE3 GUI_YH(0,0.313)
    #define CRATE_REIHE4 GUI_YH(0,0.3645)
    #define CRATE_REIHE5 GUI_YH(0,0.416)
    #define CRATE_REIHE6 GUI_YH(0,0.4675)
    #define CRATE_REIHE7 GUI_YH(0,0.519)
    #define CRATE_REIHE8 GUI_YH(0,0.5705)
    #define CRATE_REIHE9 GUI_YH(0,0.622)
    #define CRATE_REIHE10 GUI_YH(0,0.6735)

    #define CRATE_BTTN_W GUI_W(0.0465) //GUI_W(0.03488)
    #define CRATE_BTTN_H GUI_H(0.0465)

    class crate_button1 : dorb_gui_button {
        idc = 600211;
        x = CRATE_SPALTE1;
        y = CRATE_REIHE1;
        w = CRATE_BTTN_W;
        h = CRATE_BTTN_H;
        shadow = 0;
        sizeEx = CRATE_BTTN_W + GUI_W(0.004);
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