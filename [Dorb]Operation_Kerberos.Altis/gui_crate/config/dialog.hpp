/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"

class APP(dialog) {
    idd = IDD_CRATE_DLG;
    name = "Kisten-Füller";
    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;
    objects[] = {};
    onLoad = QUOTE( uiNamespace setVariable [ARR_2('GVAR(crateMenu)',_this select 0)]; [ARR_2('GVAR(crateMenu)',true)] call EFUNC(gui,blur); [] spawn FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(crateMenu)',false)] call EFUNC(gui,blur););

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

    class crate_CenterBackground: RSC(BaseText) {
        x = GUI_GRID_CENTER_X;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 3;
        w = GUI_GRID_CENTER_W * 6;
        h = GUI_GRID_CENTER_H * 16.5;

//        x = GUI_XW(0,0.1);
//        y = GUI_YH(0,0.2);
//        w = GUI_W(0.118);
//        h = GUI_H(0.53);
        text = "";
        colorBackground[] = UI_CL_BODY;
        colorText[] = UI_CL_BODY_TEXT;
    };

    class crate_RightCenterBackground: crate_CenterBackground {
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 6.5;
        w = GUI_GRID_CENTER_W * 33.5;
//        x = GUI_XW(0,0.223);
//        w = GUI_W(0.677);
    };

    class crate_BottemLeftBackground: RSC(BaseText) {
        x = GUI_GRID_CENTER_X;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 19.8;
        w = GUI_GRID_CENTER_W * 19.75;
        h = GUI_GRID_CENTER_H * 5.2;
//        x = GUI_XW(0,0.1);
//        y = GUI_YH(0,0.74);
//        w = GUI_W(0.395);
//        h = GUI_H(0.16);
        text = "";
        colorBackground[] = UI_CL_BODY;
        colorText[] = UI_CL_BODY_TEXT;
    };

    class crate_BottemRightBackground: crate_BottemLeftBackground {
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 20.25;
//        x = GUI_XW(0,0.505);
//        y = GUI_YH(0,0.74);
//        w = GUI_W(0.395);
//        h = GUI_H(0.16);
    };

    class crate_HeaderBackground: crate_CenterBackground {
        x = GUI_GRID_CENTER_X;
        y = GUI_GRID_CENTER_Y;
        w = GUI_GRID_CENTER_W * 40;
        h = GUI_GRID_CENTER_H * 2.7;
//        x = GUI_XW(0,0.1);
//        y = GUI_YH(0,0.1);
//        w = GUI_W(0.8);
//        h = GUI_H(0.09);
        text = CSTRING(HEADER);
        style = 0x02;
        colorText[] = UI_CL_HEADER_TEXT;
        colorBackground[] = UI_CL_HEADER;
    };

    class crate_spawn : RSC(BaseButton) {
        idc = IDC_CRATE_BTTN_SPAWN;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 21.25;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 20.47;
        w = GUI_GRID_CENTER_W * 7;
        h = GUI_GRID_CENTER_H * 1.875;
//        x = GUI_XW(0,0.525);
//        y = GUI_YH(0,0.755);
//        w = GUI_W(0.14);
//        h = GUI_H(0.06);
        text = CSTRING(SPAWN);
        sizeEx = GUI_GRID_CENTER_H * 1.5
//        sizeEx = GUI_H(0.03);
        colorBackground[] = UI_CL_BTN2_foc;
        colorBackgroundActive[] = UI_CL_BTN2_foc;
        colorShadow[] = UI_CL_BTN2;
        colorFocused[] = UI_CL_BTN2_foc;
        action = QUOTE([true] call FUNC(spawn);false);
    };

    class crate_clear : crate_spawn {
        idc = IDC_CRATE_BTTN_CLEAR;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 31.25;
//        x = GUI_XW(0,0.725);
        text = CSTRING(CLEAR);
        action = QUOTE( GVAR(current) = [ARR_6([],[],[],[],[],[])] ; GVAR(current_boxid) = 0; [] call FUNC(onLoad); false);
    };

    class crate_save : crate_spawn {
        idc = IDC_CRATE_BTTN_SAVE;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 22.5;
//        y = GUI_YH(0,0.82);
        text = CSTRING(SAVE);
        action = QUOTE([true] spawn FUNC(save);false);
    };

    class crate_load : crate_clear {
        idc = IDC_CRATE_BTTN_LOAD;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 22.5;
//        y = GUI_YH(0,0.82);
        text = CSTRING(LOAD);
        action = QUOTE([false] spawn FUNC(save);false);
    };

    class crate_list_button_add : crate_spawn {
        idc = IDC_CRATE_LB_BTTN_ADD;
        text = "+";
        borderSize = 0;
        colorShadow[] = {0,0,0,0};
        action = QUOTE([true] call FUNC(add);false);
    };

    class crate_list_button_sub : crate_list_button_add {
        idc = IDC_CRATE_LB_BTTN_SUB;
        text = "-";
        action = QUOTE([false] call FUNC(add);false);
    };

    class crate_ListBackground: crate_CenterBackground {
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 6.8;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 3.2;
        w = GUI_GRID_CENTER_W * 32.9;
        h = GUI_GRID_CENTER_H * 16.1;

//        x = GUI_XW(0,0.233);
//        y = GUI_YH(0,0.21);
//        w = GUI_W(0.657);
//        h = GUI_H(0.51);
        colorText[] = UI_CL_HEADER_TEXT;
        colorBackground[] = UI_CL_CTRL_GRAU2;
    };

    class crate_listbox : RSC(BaseListboxN) {
        idc = IDC_CRATE_LB;
        access = 2;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 6.8;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 3.2;
        w = GUI_GRID_CENTER_W * 32.9;
        h = GUI_GRID_CENTER_H * 16.1;
//        x = GUI_XW(0,0.243);
//        y = GUI_YH(0,0.22);
//        w = GUI_W(0.637);
//        h = GUI_H(0.49);
        rowHeight = GUI_GRID_CENTER_H * 1.1;
//        rowHeight = GUI_H(0.035);
        sizeEx = GUI_GRID_CENTER_H * 0.8;
//        sizeEx = GUI_H(0.022);
        columns[] = {(GUI_GRID_CENTER_W * 1.35),(GUI_GRID_CENTER_W * 4.5),(GUI_GRID_CENTER_W * 7.5),(GUI_GRID_CENTER_W * 27.5)};
//        columns[] = {GUI_W(0.027),GUI_W(0.09),GUI_W(0.15),GUI_W(0.55)};
        drawSideArrows = 1;
        idcLeft = 1001;
        idcRight = 1000;
        colorText[] = {RAL9005,1};
    };

    class crate_combo_box : RSC(BaseCombobox) {
        idc = IDC_CRATE_COMBOBOX;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 0.5;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 23.4;
        w = GUI_GRID_CENTER_W * 18.75;
        h = GUI_GRID_CENTER_H * 0.94;
//        x = GUI_XW(0,0.11);
//        y = GUI_YH(0,0.85);
//        w = GUI_W(0.375);
//        h = GUI_H(0.03);
//        sizeEx = GUI_H(0.025);
//        rowHeight = GUI_H(0.025);
//        wholeHeight = GUI_H(0.2);
        sizeEx = GUI_GRID_CENTER_H * 0.78;
        rowHeight = GUI_GRID_CENTER_H * 0.78;
        wholeHeight = GUI_GRID_CENTER_H * 6.25;
        onLBSelChanged = QUOTE(GVAR(current_boxid) = (_this select 1); [ARR_2('changebox',_config)] call FUNC(mass);false);
    };

    class crate_progessbar : RSC(BaseLoadingbar) {
        idc = IDC_CRATE_PROGRESSBAR;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 0.5;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 21.25;
        w = GUI_GRID_CENTER_W * 18.75;
        h = GUI_GRID_CENTER_H * 0.94;
//        x = GUI_XW(0,0.11);
//        y = GUI_YH(0,0.78);
//        w = GUI_W(0.375);
//        h = GUI_H(0.03);
    };

    #define CRATE_SPALTE1 (GUI_GRID_CENTER_X)
    #define CRATE_SPALTE2 (GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 3)
    #define CRATE_REIHE1 (GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 3)
    #define CRATE_REIHE2 (GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 4.65)
    #define CRATE_REIHE3 (GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 6.3)
    #define CRATE_REIHE4 (GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 7.95)
    #define CRATE_REIHE5 (GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 9.6)
    #define CRATE_REIHE6 (GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 11.25)
    #define CRATE_REIHE7 (GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 12.9)
    #define CRATE_REIHE8 (GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 14.55)
    #define CRATE_REIHE9 (GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 16.2)
    #define CRATE_REIHE10 (GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 17.85)

    #define CRATE_BTTN_W (GUI_GRID_CENTER_W * 2.56)
    #define CRATE_BTTN_H (GUI_GRID_CENTER_H * 1.65)

    class crate_button1 : RSC(BaseButton) {
        idc = IDC_CRATE_BTTN1;
        x = CRATE_SPALTE1;
        y = CRATE_REIHE1;
        w = CRATE_BTTN_W;
        h = CRATE_BTTN_H;
        shadow = 0;
//        sizeEx = CRATE_BTTN_W + GUI_W(0.004);
        sizeEx = CRATE_BTTN_W + (GUI_GRID_CENTER_W * 0.2);
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

        toolTip = CSTRING(BTTN_1);
        style = 48;
        text = "\A3\ui_f\data\IGUI\Cfg\MPTable\total_ca.paa";
    };

    class crate_button2 : crate_button1 {
        idc = IDC_CRATE_BTTN2;
        x = CRATE_SPALTE2;
        y = CRATE_REIHE1;
        default=false;
        colorBackground[] = UI_CL_CTRL_GRAU1;
        colorBackgroundActive[] = UI_CL_CTRL_GRAU3;
        colorFocused[] = UI_CL_CTRL_GRAU2;
        colorText[] = UI_CL_CTRL_GRAU4;
        colorTextSelect[] = UI_CL_CTRL_GRAU1;
        toolTip = CSTRING(BTTN_2);
        text = "A3\ui_f\data\gui\cfg\Hints\rifle_ca.paa";
    };

    class crate_button3 : crate_button2 {
        idc = IDC_CRATE_BTTN3;
        x = CRATE_SPALTE1;
        y = CRATE_REIHE2;
        toolTip = CSTRING(BTTN_3);
        text = "A3\ui_f\data\gui\cfg\Hints\automatic_ca.paa";
    };

    class crate_button4 : crate_button2 {
        idc = IDC_CRATE_BTTN4;
        x = CRATE_SPALTE2;
        y = CRATE_REIHE2;
        toolTip = CSTRING(BTTN_4);
        text = "A3\ui_f\data\gui\cfg\Hints\sniper_ca.paa";
    };

    class crate_button5 : crate_button2 {
        idc = IDC_CRATE_BTTN5;
        x = CRATE_SPALTE1;
        y = CRATE_REIHE3;
        toolTip = CSTRING(BTTN_5);
        text = "A3\ui_f\data\gui\cfg\Hints\shotguns_ca.paa";
    };

    class crate_button6 : crate_button2 {
        idc = IDC_CRATE_BTTN6;
        x = CRATE_SPALTE2;
        y = CRATE_REIHE3;
        toolTip = CSTRING(BTTN_6);
        text = "A3\ui_f\data\gui\cfg\Hints\launcher_ca.paa";
    };

    class crate_button7 : crate_button2 {
        idc = IDC_CRATE_BTTN7;
        x = CRATE_SPALTE1;
        y = CRATE_REIHE4;
        toolTip = CSTRING(BTTN_7);
        text = "A3\ui_f\data\gui\cfg\Hints\handgun_ca.paa";
    };

    class crate_button8 : crate_button2 {
        idc = IDC_CRATE_BTTN8;
        x = CRATE_SPALTE2;
        y = CRATE_REIHE4;
        toolTip = CSTRING(BTTN_8);
        text = "A3\ui_f\data\gui\cfg\Hints\optics_ca.paa";
    };

    class crate_button9 : crate_button2 {
        idc = IDC_CRATE_BTTN9;
        x = CRATE_SPALTE1;
        y = CRATE_REIHE5;
        toolTip = CSTRING(BTTN_9);
        text = "A3\ui_f\data\gui\cfg\Hints\grenades_ca.paa";
    };

    class crate_button10 : crate_button2 {
        idc = IDC_CRATE_BTTN10;
        x = CRATE_SPALTE2;
        y = CRATE_REIHE5;
        toolTip = CSTRING(BTTN_10);
        text = "A3\ui_f\data\gui\cfg\Hints\ieds_ca.paa";
    };

    class crate_button11 : crate_button2 {
        idc = IDC_CRATE_BTTN11;
        x = CRATE_SPALTE1;
        y = CRATE_REIHE6;
        toolTip = CSTRING(BTTN_11);
        text = "A3\ui_f\data\gui\cfg\Hints\gear_ca.paa";
    };

    class crate_button12 : crate_button1 {
        idc = IDC_CRATE_BTTN12;
        default=false;
        x = CRATE_SPALTE2;
        y = CRATE_REIHE6;
        toolTip = CSTRING(BTTN_12);
        text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\vest_ca.paa";
    };

    class crate_button13 : crate_button1 {
        idc = IDC_CRATE_BTTN13;
        default=false;
        x = CRATE_SPALTE1;
        y = CRATE_REIHE7;
        toolTip = CSTRING(BTTN_13);
        text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\uniform_ca.paa";
    };

    class crate_button14 : crate_button1 {
        idc = IDC_CRATE_BTTN14;
        default=false;
        x = CRATE_SPALTE2;
        y = CRATE_REIHE7;
        toolTip = CSTRING(BTTN_14);
        text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\headgear_ca.paa";
    };

    class crate_button15 : crate_button1 {
        idc = IDC_CRATE_BTTN15;
        default=false;
        x = CRATE_SPALTE1;
        y = CRATE_REIHE8;
        toolTip = CSTRING(BTTN_15);
        text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\radio_ca.paa";
    };

    class crate_button16 : crate_button2 {
        idc = IDC_CRATE_BTTN16;
        x = CRATE_SPALTE2;
        y = CRATE_REIHE8;
        toolTip = CSTRING(BTTN_16);
        text = "A3\ui_f\data\gui\cfg\Hints\map_ca.paa";
    };

    class crate_button17 : crate_button2 {
        idc = IDC_CRATE_BTTN17;
        x = CRATE_SPALTE1;
        y = CRATE_REIHE9;
        toolTip = CSTRING(BTTN_17);
        text = "A3\ui_f\data\gui\cfg\Hints\injury_ca.paa";
    };

    class crate_button18 : crate_button2 {
        idc = IDC_CRATE_BTTN18;
        x = CRATE_SPALTE2;
        y = CRATE_REIHE9;
        toolTip = CSTRING(BTTN_18);
        text = "A3\ui_f\data\gui\cfg\Hints\slots_ca.paa";
    };

    class crate_button19 : crate_button2 {
        idc = IDC_CRATE_BTTN19;
        x = CRATE_SPALTE1;
        y = CRATE_REIHE10;
        toolTip = CSTRING(BTTN_19);
        text = "A3\ui_f\data\gui\cfg\Hints\actionmenu_ca.paa";
    };

    class crate_button20 : crate_button2 {
        idc = IDC_CRATE_BTTN20;
        x = CRATE_SPALTE2;
        y = CRATE_REIHE10;
        toolTip = CSTRING(BTTN_20);
        text = "A3\ui_f\data\gui\cfg\Hints\actionmenu_ca.paa";
    };
};
