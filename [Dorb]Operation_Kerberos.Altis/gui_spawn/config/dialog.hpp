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
class testobj {
	idd=-1;


    controlsBackground[] =    {
        background2,
        Background,
        background3
    };
	objects[] = {
        TestObject
    };
    controls[] = {

    };
	class TestObject: RSC(BaseObjectContainer) {
        idc = 1001;
        onLoad = "uiNamespace setVariable ['testObject',_this select 0];";
        model="\A3\ui_f\objects\compass.p3d";
        direction[]={0,0,1};
        up[]={0,1,0};
        //scale="0.47 * 0.875 * (SafeZoneW Min SafeZoneH)";
        //positionBack[]={0,-0.02,0.075000003};

        enableZoom = 0;
        zoomDuration = 1;
        position[]={
            0,
            0,
            4
        };
        positionBack[]={
            -0.5,
            -0.5,
            5
        };
	};
    class background : RSC(BaseText) {
        colorBackground[] = {1,1,1,1};
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 27.5;
    };
    class background2 : RSC(BaseText) {
        colorBackground[] = {0,1,1,1};
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 30;
    };
    class background3 : RSC(BaseText) {
        colorBackground[] = {0,1,0,1};
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 12.5;
        w = GUI_ECHIDNA_W * 20;
        h = GUI_ECHIDNA_H * 15;
    };
};

class APP(dialog) : RSC(Echidna) {
    idd = IDD_ECHIDNA_MAIN;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_Echidna,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this spawn EFUNC(gui_echidna,OnLoad);_this spawn FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_Echidna,OnUnLoad););
    
    controlsBackground[] = {
        background_taskbar,
        background_display
    };
    controls[] = {
        clock,
        menu_button,

        spawnmenubutton_1_background,
        spawnmenubutton_2_background,
        spawnmenubutton_1,
        spawnmenubutton_2,

        vehiclelist,
        vehiclename,
        vehicleproperties,

        metro_back,
        metro,
        metro_side,
        background_device
    };
    objects[] = {
        vehicle
    };

    #define BUTTON_HELPER(NUMBER) class TRIPLES(spawnmenubutton,NUMBER,background) : RSC(BasePicture) { \
        idc = -(IDC_ECHIDNA_SPAWN_VEHICLEBUTTON + NUMBER); \
        x = 0;y = 0;w = 0;h = 0; \
        text = QEPAAPATH(buttons,button_256_normal); \
        shadow = 0; \
        style = "48"; \
        colorShadow[] = COLOR_DISABLED; \
        font = FONT_DEFAULT; \
        colorBackground[] = {ARR_4(0,0,0,1)}; \
        colorText[] = {ARR_4(0,0,0,1)}; \
    }; \
    class DOUBLES(spawnmenubutton,NUMBER) : RSC(BaseButton) { \
        idc = IDC_ECHIDNA_SPAWN_VEHICLEBUTTON + NUMBER; \
        x = 0;y = 0;w = 0;h = 0; \
        sizeEx = GUI_ECHIDNA_H * 0.7; \
        text = ""; \
        style = "48+0x800"; \
        colorBackground[]= COLOR_DISABLED; \
        colorBackgroundActive[]= COLOR_DISABLED; \
        colorFocused[]= COLOR_DISABLED; \
        colorBackgroundDisabled[]= COLOR_DISABLED; \
        colorText[] = COLOR_ECHIDNA_METRO_BTTN_DEFAULT_TEXT; \
        colorDisabled[] = COLOR_ECHIDNA_METRO_BTTN_DEFAULT_TEXT_DISABLED; \
        shadow = 0; \
        colorShadow[] = COLOR_DISABLED; \
        offsetX = 0; \
        offsetY = 0; \
        offsetPressedX = 0; \
        offsetPressedY = 0; \
    }

    BUTTON_HELPER(1);
    BUTTON_HELPER(2);


    class vehiclelist : RSC(BaseListboxN) {
        idc = IDC_ECHIDNA_SPAWN_VEHICLELIST;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
    };

    class vehicleproperties : RSC(BaseListboxN) {
        idc = IDC_ECHIDNA_SPAWN_VEHICLELIST;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
    };

    class vehicle : RSC(BaseObjectContainer) {
        idc = IDC_ECHIDNA_SPAWN_VEHICLEOBJECT;
        model = "\A3\Weapons_F\empty.p3d";
        direction[]={0,0,1};
        up[]={0,1,0};
        enableZoom = 0;
        zoomDuration = 1;
        position[]={
            0,
            0,
            4
        };
        positionBack[]={
            -0.5,
            -0.5,
            5
        };
    };

    class vehicleName : RSC(BaseText) {
        idc = IDC_ECHIDNA_SPAWN_VEHICLENAME;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
    };

};
/*
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
        style = 0x02;
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
        colorText[] = {RAL9005,1};
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
*/
