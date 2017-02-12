/*
 *  Author: Dorbedo
 *
 *  Description:
 *      specific Ressources
 *
 */
#define CBA_OFF
#define INCLUDE_GUI
#include "script_component.hpp"



class APP(LoadingScreen) : RSC(loadingScreen) {

};

class adtest {
    idd = 1000;
    controls[] = {
        back,
        back2,
        back3
    };
    class back : RSC(BaseText) {
        idc = -1;
        x = GUI_GRID_CENTER_X;
        y = GUI_GRID_CENTER_Y;
        w = GUI_GRID_CENTER_W * 40;
        h = GUI_GRID_CENTER_H * 25;
        colorBackground[] = {RAL9010,1};
    };
    class back2 : back {
        idc = 1001;
        x = safeZoneX;
        y = safeZoneY;
        w = GUI_GRID_CENTER_W;
        h = GUI_GRID_CENTER_H;
        colorBackground[] = {RAL9005,1};
    };
    class back3 : back {
        idc = 1002;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        colorBackground[] = {RAL9005,1};
    };
};



class actest {
    idd = -1;
    controls[] = {
        list,
        list2
    };
    class list : RSC(BaseListbox) {
        x = GUI_GRID_CENTER_X ;
        y = GUI_GRID_CENTER_Y ;
        w = GUI_GRID_CENTER_W * 15;
        h = GUI_GRID_CENTER_H * 15;
        onLoad=QUOTE([ARR_2('onLoad',_this)] call FUNC(listbox););
        onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
		onDestroy = "systemChat str ['onDestroy',_this]; false";
		onSetFocus = "systemChat str ['onSetFocus',_this]; false";
		onKillFocus = "systemChat str ['onKillFocus',_this]; false";
		onKeyDown = "systemChat str ['onKeyDown',_this]; false";
		onKeyUp = "systemChat str ['onKeyUp',_this]; false";
		onMouseButtonDown = "systemChat str ['onMouseButtonDown',_this]; false";
		onMouseButtonUp = "systemChat str ['onMouseButtonUp',_this]; false";
		onMouseButtonClick = "systemChat str ['onMouseButtonClick',_this]; false";
		onMouseButtonDblClick = "systemChat str ['onMouseButtonDblClick',_this]; false";
		onMouseZChanged = "systemChat str ['onMouseZChanged',_this]; false";
		onMouseMoving = "";
		onMouseHolding = "";

		onLBSelChanged = "systemChat str ['onLBSelChanged',_this]; false";
		onLBDblClick = "systemChat str ['onLBDblClick',_this]; false";
		onLBDrag = "systemChat str ['onLBDrag',_this]; false";
		onLBDragging = "systemChat str ['onLBDragging',_this]; false";
		onLBDrop = "systemChat str ['onLBDrop',_this]; false";
    };
    class list2 : list {
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 20;
    };
};

class abtest {
    idd = -1;
    controls[] = {
        test1,
        test2
    };
    controlsBackground[] = {
        background2
    };
    class test1 : RSC(BaseActiveText) {
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 10;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 4;
        w = GUI_GRID_CENTER_W * 4;
        h = GUI_GRID_CENTER_H * 4;
    };
    class test2 : RSC(BaseActiveText) {
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 10;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 9;
        w = GUI_GRID_CENTER_W * 4;
        h = GUI_GRID_CENTER_H * 4;
    };
    class background2 : RSC(BaseText) {
        x = GUI_GRID_CENTER_X ;
        y = GUI_GRID_CENTER_Y ;
        w = GUI_GRID_CENTER_W * 20;
        h = GUI_GRID_CENTER_H * 15;
    };
};


class aatest {
    idd = -1;
    controls[] = {
        button1,
        button2,
        button3
    };
    class button1 : RSC(BaseShortcutButton) {
        idc = IDC_BTTN_SHORTCUT_5;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 10;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 4;
        //w = GUI_GRID_CENTER_W * 4;
        //h = GUI_GRID_CENTER_H * 4;
        w =  pixelW * pixelGrid * 32;
        h =  pixelH * pixelGrid * 32;
        action="hintSilent 'click';";
        text = "\A3\ui_f\data\logos\arsenal_1024_ca.paa";
        style = 48;
        /*
        animTextureDefault=QEPAAPATH(buttons,scbutton2_normal);
        animTextureNormal=QEPAAPATH(buttons,scbutton2_normal);
        animTextureDisabled=QEPAAPATH(buttons,scbutton2_disabled);
        animTextureOver=QEPAAPATH(buttons,scbutton2_over);
        animTextureFocused=QEPAAPATH(buttons,scbutton2_focused);
        animTexturePressed=QEPAAPATH(buttons,scbutton2_pressed);
        */
        animTextureDefault=QEPAAPATH(buttons,button_256_normal);
        animTextureNormal=QEPAAPATH(buttons,button_256_normal);
        animTextureDisabled=QEPAAPATH(buttons,button_256_disabled);
        animTextureOver=QEPAAPATH(buttons,button_256_over);
        animTextureFocused=QEPAAPATH(buttons,button_256_focused);
        animTexturePressed=QEPAAPATH(buttons,button_256_pressed);
    };
    class button2 : button1 {
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 16;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 12;
    };
    class button3 : button1 {
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 21;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 20;
        h = GUI_GRID_CENTER_H * 12;
    };
};

class atest {
    idd = -1;
    controls[] = {
        button4,
        button1,
        button2,
        button3,
        button5,
        back2
    };
    controlsBackground[] = {
        back
    };
    class button1 : RSC(BaseControlsGroup) {
        idc = IDC_BTTN_SHORTCUT_1;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 10;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 5;
        w = GUI_GRID_CENTER_W * 20;
        h = GUI_GRID_CENTER_H * 20;
        onLoad = QUOTE([ARR_2('onLoad',_this)] call EFUNC(gui,bttn2));
        class controls : controls {
            class picture_back : RSC(BasePicture) {
                //idc = IDC_BTTN_SHORTCUT_1 + 1;
                idc = 101;
                x = 0;
                y = 0;
                w = GUI_GRID_CENTER_W * 4;
                h = GUI_GRID_CENTER_H * 4;
                text = QEPAAPATH(buttons,button_256_normal);
                shadow = 0;
                colorShadow[] = COLOR_DISABLED;
                font = FONT_DEFAULT;
                colorBackground[] = COLOR_LOADING_BACKGROUND;
                colorText[] = COLOR_LOADING_CIRCLEIN;
            };
            class button : RSC(BaseButton) {
                //idc = IDC_BTTN_SHORTCUT_1 + 2;
                idc = 102;
                x = 0;
                y = 0;
                w = GUI_GRID_CENTER_W * 4;
                h = GUI_GRID_CENTER_H * 4;
                colorText[] = COLOR_DISABLED;
                colorDisabled[] = COLOR_DISABLED;
                colorBackground[] = COLOR_DISABLED;
                colorBackgroundActive[] = COLOR_DISABLED;
                colorFocused[] = COLOR_DISABLED;
                colorBackgroundDisabled[] = COLOR_DISABLED;
                offsetX = 0;
                offsetY = 0;
                offsetPressedX = 0;
                offsetPressedY = 0;
                colorShadow[] = {0,0,0,0};
                shadow = 0;
                colorBorder[] = {0,0,0,0};
            };
        };
    };
    class button2 : button1 {
        idc = IDC_BTTN_SHORTCUT_2;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 16;
    };
    class button3 : button1 {
        idc = IDC_BTTN_SHORTCUT_3;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 21;
    };
    class button4 : RSC(BaseShortcutButton) {
        idc = IDC_BTTN_SHORTCUT_5;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 10;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 10;
        w = GUI_GRID_CENTER_W * 4;
        h = GUI_GRID_CENTER_H * 4;
        onLoad = QUOTE([ARR_2('ignore',_this)] call EFUNC(gui,bttn2));
        action="hintSilent 'click';";
    };
    class back2 : RSC(BaseText) {
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 16;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 10;
        w = GUI_GRID_CENTER_W * 4;
        h = GUI_GRID_CENTER_H * 4;
        colorBackground[] = {1,1,1,1};
    };
    class button5 : button4 {
        idc = IDC_BTTN_SHORTCUT_6;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 16;
        w = GUI_GRID_CENTER_W * 12;
    };
    class back : RSC(BaseText) {
        x = GUI_GRID_CENTER_X;
        y = GUI_GRID_CENTER_Y;
        w = GUI_GRID_CENTER_W * 40;
        h = GUI_GRID_CENTER_H * 25;
    };
};
