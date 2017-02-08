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

class aatest {
    idd = -1;
    class controls {
        class button4 : RSC(BaseShortcutButton) {
            idc = IDC_BTTN_SHORTCUT_5;
            x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 10;
            y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 10;
            w = GUI_GRID_CENTER_W * 4;
            h = GUI_GRID_CENTER_H * 4;
            onLoad = QUOTE([ARR_2('blubb',_this)] call EFUNC(gui,bttn2));
            action="hintSilent 'click';";
            text = "blubb";
        };
    };
};

class atest {
    idd = -1;
    controls[] = {
        button4,
        button1,
        button2,
        button3
    };
    //class controls {
        class button1 : RSC(BaseControlsGroup) {
            idc = IDC_BTTN_SHORTCUT_1;
            x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 10;
            y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 5;
            w = GUI_GRID_CENTER_W * 20;
            h = GUI_GRID_CENTER_H * 20;
            onLoad = QUOTE([ARR_2('onLoad',_this)] call EFUNC(gui,bttn2));
            class controls : controls {
                class picture_back : RSC(BasePicture) {
                    idc = IDC_BTTN_SHORTCUT_1 + 1;
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
                    idc = IDC_BTTN_SHORTCUT_1 + 2;
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
            class controls : controls {
                class picture_backA : picture_back {
                    idc = IDC_BTTN_SHORTCUT_2 + 1;
                };
                class buttonA : button {
                    idc = IDC_BTTN_SHORTCUT_2 + 2;
                };
            };
        };
        class button3 : button1 {
            idc = IDC_BTTN_SHORTCUT_3;
            x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 21;
            class controls : controls {
                class picture_backB : picture_back {
                    idc = IDC_BTTN_SHORTCUT_3 + 1;
                };
                class buttonB : button {
                    idc = IDC_BTTN_SHORTCUT_3 + 2;
                };
            };
        };
        class button4 : RSC(BaseShortcutButton) {
            idc = IDC_BTTN_SHORTCUT_5;
            x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 10;
            y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 10;
            w = GUI_GRID_CENTER_W * 4;
            h = GUI_GRID_CENTER_H * 4;
            onLoad = QUOTE([ARR_2('blubb',_this)] call EFUNC(gui,bttn2));
            action="hintSilent 'click';";
            text = "blubb";
        };
        class button5 : button4 {
            idc = IDC_BTTN_SHORTCUT_6;
            x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 16;
        };
    //};
    //class controlsBackground {};
};
