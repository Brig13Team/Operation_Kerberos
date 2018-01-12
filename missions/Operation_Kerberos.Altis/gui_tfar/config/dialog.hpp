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
        background_gradiend
    };
    controls[] = {
        headertext,
        clock,
        player_button,
        menu_button,

        display_background,

        treeback,
        treeview,

        edit_sr,
        edit_sr_add,
        edit_lr,
        edit_lr_add,

        checkbox,
        save

    };

    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_main,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this call EFUNC(gui_main,OnLoad);_this call FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_main,OnUnLoad););

    class headertext: headertext {
        text = CSTRING(HEADER);
    };

    class display_background: RSC(BaseText) {
        idc = IDC_TFAR_MENU_BACK;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        text = "";
        colorBackground[] = COLOR_DISABLED;
        colorText[] = COLOR_DISABLED;
    };

    class treeview : RSC(BaseTree) {
        idc = IDC_ACRE_MENU_TREE;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        colorBackground[] = COLOR_BASE_GREY_LIGHT;
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
};
