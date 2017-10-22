
class APP(dialog) : RSC(guiMenu) {
    idd = IDD_GUI_ARSENAL;
    controlsBackground[] = {
        background_header,
        background_body,
        background_gradiend,
        background_templatelist
    };
    controls[] = {
        headertext,
        clock,
        player_button,
        menu_button,
        templatelist,
        loadButton
    };

    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_main,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this call EFUNC(gui_main,OnLoad); _this call FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_main,OnUnload););

    class background_body : background_body {
        colorBackground[] = COLOR_ARSENAL_BACKGROUND;
    };

    class background_gradiend : background_gradiend {
        colorText[] = COLOR_ARSENAL_BACKGROUND_GRADIEND;
    };

    class background_templatelist: RSC(BaseText) {
        idc = -1;
        x = GUI_DISP_X+GUI_DISP_W*2;
        y = GUI_DISP_Y+GUI_DISP_H*10;
        w = GUI_DISP_W*121;
        h = GUI_DISP_H*78;
        text = "";
        colorBackground[] = COLOR_ARSENAL_BACKGROUND2;
        colorText[] = COLOR_DISABLED;
    };
    class templatelist : RSC(BaseListbox) {
        access = 1;
        idc = IDC_GUI_ARSENAL_LIST;
        x = GUI_DISP_X+GUI_DISP_W*3;
        y = GUI_DISP_Y+GUI_DISP_H*11;
        w = GUI_DISP_W*120;
        h = GUI_DISP_H*76;
        sizeEx = GUI_DISP_H*3;
        rowHeight = GUI_DISP_H*3.5;
        tooltip = "";
        color[] = COLOR_ARSENAL_LIST_TEXT;
        colorScrollbar[] = COLOR_ARSENAL_BACKGROUND;
        colorSelect[] = COLOR_ARSENAL_LIST_TEXT;
        colorSelect2[] = COLOR_ARSENAL_LIST_TEXT;
        colorDisabled[] = COLOR_DISABLED;
        colorSelectBackground[] = COLOR_ARSENAL_LIST_SELECTBG;
        colorSelectBackground2[] = COLOR_ARSENAL_LIST_SELECTBG;
        colorText[] = COLOR_ARSENAL_LIST_TEXT;
        colorBackground[] = COLOR_ARSENAL_BACKGROUND;
    };
    class loadButton : RSC(BaseButton) {
        idc = IDC_GUI_ARSENAL_BTTN;
        x = GUI_DISP_X+GUI_DISP_WAbs-GUI_DISP_W*14;
        y = GUI_DISP_Y+GUI_DISP_HAbs-GUI_DISP_H*6;
        w = GUI_DISP_W*10;
        h = GUI_DISP_H*4;
        text = "load";
    };
};
