/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"
class APP(dialog) : RSC(guiMenu) {
    idd = IDD_GUI_TFAR;

    controlsBackground[] = {
        background_header,
        background_body,
        background_gradiend,
        background_tree,

        edit_sr_text,
        edit_sr_add_text,
        edit_lr_text,
        edit_lr_add_text,
        checkbox_text
    };
    controls[] = {
        headertext,
        clock,
        player_button,
        menu_button,

        treeview,

        edit_sr,
        edit_sr_add,
        edit_lr,
        edit_lr_add,

        checkbox
    };

    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_main,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this call EFUNC(gui_main,OnLoad); _this call FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_main,OnUnload););

    class background_gradiend : background_gradiend {
        colorBackground[] = COLOR_TFAR_BACKGROUND_GRADIENT;
    };

    class background_body : background_body {
        colorBackground[] = COLOR_TFAR_BACKGROUND;
    };

    class background_tree : RSC(BaseText) {
        x = GUI_DISP_X+GUI_DISP_W*3;
        y = GUI_DISP_Y+GUI_DISP_H*9;
        w = GUI_DISP_W*94;
        h = GUI_DISP_H*78;
        colorBackground[] = COLOR_TFAR_TREE_BACKGROUND;
    };

    class treeview : RSC(BaseTree) {
        idc = IDC_TFAR_TREE;
        x = GUI_DISP_X+GUI_DISP_W*4;
        y = GUI_DISP_Y+GUI_DISP_H*10;
        w = GUI_DISP_W*92;
        h = GUI_DISP_H*76;
        colorBackground[] = COLOR_TFAR_TREE_BACKGROUND;
        colorArrow[] = COLOR_BASE_BLACK;
        colorText[] = COLOR_BASE_BLACK;
        colorSelect[] = COLOR_BASE_GREY_LIGHT;
        multiselectEnabled = 0;
        class ScrollBar : ScrollBar {
            color[] = COLOR_BASE_BLACK;
        };
        colorPicture[]={1,1,1,1};
        colorPictureSelected[]={1,1,1,1};
        colorPictureDisabled[]={1,1,1,0.25};
        colorPictureRight[]={1,1,1,1};
        colorPictureRightSelected[]={1,1,1,1};
        colorPictureRightDisabled[]={1,1,1,0.25};
        hiddenTexture = MPATH(gui\data\tree\add_b_nb.paa);
        expandedTexture = MPATH(gui\data\tree\dec_b_nb.paa);
    };

    class edit_sr : RSC(BaseEditBox) {
        idc = IDC_TFAR_EDIT_SR;
        x = GUI_DISP_X+GUI_DISP_W*146;
        y = GUI_DISP_Y+GUI_DISP_H*16;
        w = GUI_DISP_W*10;
        h = GUI_DISP_H*4;
        sizeEx = GUI_DISP_H*3;
        text = "00";
        colorBackground[] = COLOR_TFAR_EDIT_SR;
    };
    class edit_sr_text : RSC(BaseText) {
        text = CSTRING(TEXT_SR);
        x = GUI_DISP_X+GUI_DISP_W*102;
        y = GUI_DISP_Y+GUI_DISP_H*16;
        w = GUI_DISP_W*42;
        h = GUI_DISP_H*4;
        sizeEx = GUI_DISP_H*3;
        style = 1;
        colorBackground[] = COLOR_DISABLED;
        colorText[] = COLOR_TFAR_TEXT;
    };

    class edit_sr_add : edit_sr {
        idc = IDC_TFAR_EDIT_SR_ADD;
        y = GUI_DISP_Y+GUI_DISP_H*22;
        text = "00";
        colorBackground[] = COLOR_TFAR_EDIT_SR_ADD;
    };
    class edit_sr_add_text : edit_sr_text {
        text = CSTRING(TEXT_SR_ADD);
        y = GUI_DISP_Y+GUI_DISP_H*22;
    };

    class edit_lr : edit_sr {
        idc = IDC_TFAR_EDIT_LR;
        y = GUI_DISP_Y+GUI_DISP_H*30;
        text = "00";
        colorBackground[] = COLOR_TFAR_EDIT_LR;
    };
    class edit_lr_text : edit_sr_text {
        text = CSTRING(TEXT_LR);
        y = GUI_DISP_Y+GUI_DISP_H*30;
    };

    class edit_lr_add : edit_sr {
        idc = IDC_TFAR_EDIT_LR_ADD;
        y = GUI_DISP_Y+GUI_DISP_H*36;
        text = "00";
        colorBackground[] = COLOR_TFAR_EDIT_LR_ADD;
    };
    class edit_lr_add_text : edit_sr_text {
        text = CSTRING(TEXT_LR_ADD);
        y = GUI_DISP_Y+GUI_DISP_H*36;
    };

    class checkbox_text : edit_sr_text {
        y = GUI_DISP_Y+GUI_DISP_H*50;
        text = CSTRING(CHECKBOX);
    };
    class checkbox : RSC(BaseCheckbox) {
        idc = IDC_TFAR_CHECKBOX;
        x = GUI_DISP_X+GUI_DISP_W*146;
        y = GUI_DISP_Y+GUI_DISP_H*50;
        w = GUI_DISP_W*5;
        h = GUI_DISP_H*5;
        sizeEx = GUI_DISP_H*3;
    };
};
