/*
    Author: Dorbedo
*/

#define CBA_OFF
#define INCLUDE_GUI
#include "script_component.hpp"


#define UI_CL_BODY   {0.98,0.941,0.902,1}
#define UI_CL_HEADER_TEXT {0.98,0.98,0.824,1}
#define UI_CL_HEADER {0.502,0,0,1}
#define UI_CL_TEXT_DARK {0.098,0.098,0.439,1}
#define UI_CL_HEADER2 {0.722,0.525,0.043,1}
#define UI_CL_CTRL_GRAU3 {0.502,0.502,0.502,1}
#define UI_CL_BTN6      {1,0.549,0,1}
#define UI_CL_BTN6_foc  {1,0.271,0,1}
#define UI_CL_BTN2      {0,0,0.545,1}
#define UI_CL_BTN2_foc  {0,0,1,1}

class dtest  {
    idd = 100000;
    name = "testdialog";
    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;
    objects[] = {};
    controlsBackground[] = {};
    controls[] = {
        background,
        header,
        bttn
    };
    class background : RSC(BaseText) {
        idc = 100;
        style = "0x02";
        x = GUI_GRID_CENTER_X;
        y = GUI_GRID_CENTER_Y;
        w = GUI_GRID_CENTER_W * 40;
        h = GUI_GRID_CENTER_H * 25;
        colorBackground[] = UI_CL_BODY;
    };
    class header : background {
        idc = 101;
        h = GUI_GRID_CENTER_H * 5;
    };
    class bttn : background {
        idc = 102;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 10;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 10;
        w = GUI_GRID_CENTER_W * 10;
        h = GUI_GRID_CENTER_H * 7;
        text = "TEEST";
    };
};



class APP(dialog) {
    idd = IDD_SPAWN_DLG;
    name = "spawndialog";
    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;
    objects[] = {};
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(spawnMenu)', _this select 0)]; [ARR_2('GVAR(spawnMenu)', true)] call EFUNC(gui,blur););
    onUnload = QUOTE([ARR_2('GVAR(spawnMenu)',false)] call EFUNC(gui,blur););

    controlsBackground[] =    {
        spawn_CenterBackground,
        spawn_RightBackground
    };
    controls[] =     {
        spawn_HeaderBackground,
        spawn_Fahrzeug,
        spawn_bttn_moveIn,
        spawn_Fahrzeug_pic,
        spawn_bttn_spawn,
        spawn_listbox
    };
    class spawn_CenterBackground: RSC(BaseText) {
        x = GUI_GRID_CENTER_X;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 3;
        w = GUI_GRID_CENTER_W * 26;
        h = GUI_GRID_CENTER_H * 22;
        //x = GUI_XW(0,0.1);
        //y = GUI_YH(0,0.2);
        //w = GUI_W(0.46);
        //h = GUI_H(0.5);
        text = "";
        colorBackground[] = UI_CL_BODY;
    };
    class spawn_HeaderBackground: spawn_CenterBackground {
        idc = IDC_SPAWN_DLG_HEADER;
        y = GUI_GRID_CENTER_Y;
        w = GUI_GRID_CENTER_W * 40;
        h = GUI_GRID_CENTER_H * 2.7;
        //y = GUI_YH(0,0.1);
        //w = GUI_W(0.7);
        //h = GUI_H(0.09);
        text = "";
        colorText[] = UI_CL_HEADER_TEXT;
        colorBackground[] = UI_CL_HEADER;
    };
    class spawn_RightBackground: spawn_CenterBackground {
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 26.3;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 7;
        w = GUI_GRID_CENTER_W * 13.7;
        h = GUI_GRID_CENTER_H * 18;
        //x = GUI_XW(0,0.565);
        //y = GUI_YH(0,0.305);
        //w = GUI_W(0.235);
        //h = GUI_H(0.395);
    };
    class spawn_Fahrzeug : spawn_RightBackground {
        idc = IDC_SPAWN_DLG_VEH;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 3;
        h = GUI_GRID_CENTER_H * 3.7;
        //y = GUI_YH(0,0.2);
        //h = GUI_H(0.1);
        sizeEx = GUI_GRID_CENTER_H * 0.9;
        //sizeEx = GUI_H(0.027);
        colorText[] = UI_CL_TEXT_DARK;
        colorBackground[] = UI_CL_HEADER2;
        text = "";
    };
    class spawn_Fahrzeug_pic : RSC(BasePicture) {
        idc = IDC_SPAWN_DLG_PICTURE;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 27.5;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 8;
        w = GUI_GRID_CENTER_W * 12.1;
        h = GUI_GRID_CENTER_H * 9;
        //x = GUI_XW(0,0.598125);
        //y = GUI_YH(0,0.315);
        //w = GUI_W(0.16875);
        //h = GUI_H(0.225);
        colorText[] = UI_CL_CTRL_GRAU3;
        colorBackground[] = UI_CL_BODY;
        text = "data\icon\icon_heli.paa";
    };

    class spawn_listbox : RSC(BaseListboxN) {
        idc = IDC_SPAWN_DLG_LIST;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 1;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 4;
        w = GUI_GRID_CENTER_W * 24;
        h = GUI_GRID_CENTER_H * 20;
        //x = GUI_XW(0,0.115);
        //y = GUI_YH(0,0.215);
        //w = GUI_W(0.43);
        //h = GUI_H(0.46);
        rowHeight = GUI_GRID_CENTER_H * 1.1;
        sizeEx = GUI_GRID_CENTER_H * 0.9;
        columns[] = {0.0,(GUI_GRID_CENTER_W * 3.2),(GUI_GRID_CENTER_W * 5.6),0.0};
        //rowHeight = GUI_H(0.035);
        //sizeEx = GUI_H(0.025);
        //columns[] = {0.0,GUI_W(0.08),GUI_W(0.14),0.0};
        onLBSelChanged = QUOTE(_this spawn FUNC(select););
        default = true;

    };
    class spawn_bttn_moveIn : RSC(BaseButton) {
        idc = IDC_SPAWN_DLG_MOVEIN;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 27.25;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 20;
        w = GUI_GRID_CENTER_W * 12;
        h = GUI_GRID_CENTER_H * 2;
        sizeEx = GUI_GRID_CENTER_H * 0.9;
        //x = GUI_XW(0,0.58);
        //y = GUI_YH(0,0.55);
        //w = GUI_W(0.205);
        //h = GUI_H(0.06);
        //sizeEx = GUI_H(0.03);
        style = "0x02";
        text = ECSTRING(GUI_SPAWN,DRIVER);
        colorBackground[] = UI_CL_BTN6_foc;
        colorBackgroundActive[] = UI_CL_BTN6_foc;
        colorShadow[] = UI_CL_BTN6;
        colorFocused[] = UI_CL_BTN6_foc;
        default = false;
        shadow = 1;
        onMouseEnter = "";
        onMouseExit = "";
        action = QUOTE(['driver'] call FUNC(create););
    };
    class spawn_bttn_spawn : spawn_bttn_moveIn {
        idc = IDC_SPAWN_DLG_CREATE;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 22.2;
        //y = GUI_YH(0,0.615);
        text = ECSTRING(GUI_SPAWN,EMPTY);
        colorBackground[] = UI_CL_BTN2_foc;
        colorBackgroundActive[] = UI_CL_BTN2_foc;
        colorShadow[] = UI_CL_BTN2;
        colorFocused[] = UI_CL_BTN2_foc;
        onSetFocus = "";
        action = QUOTE([] call FUNC(create););
    };
};
