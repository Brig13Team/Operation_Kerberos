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



class atest {
    idd = -1;
    class controls {
        class button1 : RSC(BaseControlsGroupNoScrollbar) {
            idc = IDC_BTTN_SHORTCUT_1 + 2;
            x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 10;
            y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 5;
            w = GUI_GRID_CENTER_W * 20;
            h = GUI_GRID_CENTER_H * 20;
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
                    onLoad = QUOTE([ARR_2('onLoad',_this)] call EFUNC(gui,bttn));
                };
                class button : RSC(BaseButton) {
                    idc = IDC_BTTN_SHORTCUT_1;
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
                    onLoad = QUOTE([ARR_2('onLoad',_this)] call EFUNC(gui,bttn));
                    onMouseEnter = QUOTE([ARR_2('onMouseEnter',_this)] call EFUNC(gui,bttn));
                    onMouseExit = QUOTE([ARR_2('onMouseExit',_this)] call EFUNC(gui,bttn));

                    onButtonDown = QUOTE([ARR_2('onButtonDown',_this)] call EFUNC(gui,bttn));
                    onButtonClick = QUOTE([ARR_2('onButtonClick',_this)] call EFUNC(gui,bttn));
                    onButtonUp = QUOTE([ARR_2('onButtonUp',_this)] call EFUNC(gui,bttn));
                };
            };
        };
        class button2 : button1 {
            //idc = IDC_BTTN_SHORTCUT_2 + 2;
            idc = 800505;
            x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 16;
            class controls : controls {
                class picture_back : picture_back {
                    idc = 800504;
                    //idc = IDC_BTTN_SHORTCUT_2 + 1;
                };
                class button : button {
                    idc = 800503;
                    //idc = IDC_BTTN_SHORTCUT_2;
                };
            };
        };
        class button3 : button1 {
            //idc = IDC_BTTN_SHORTCUT_2 + 2;
            idc = 800508;
            x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 21;
            class controls : controls {
                class picture_back : picture_back {
                    idc = 800507;
                    //idc = IDC_BTTN_SHORTCUT_2 + 1;
                };
                class button : button {
                    idc = 800506;
                    //idc = IDC_BTTN_SHORTCUT_2;
                };
            };
        };
    };
    class controlsBackground {};
};
