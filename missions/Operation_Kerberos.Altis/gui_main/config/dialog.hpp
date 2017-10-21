class RSC(guiMenu) {
    idd = IDD_GUI_MAIN;
    name = "Main Menu";

    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 100000;

    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_main,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this call EFUNC(gui_main,OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_main,OnUnload););

    objects[] = {};
    controlsBackground[] = {
        background_header,
        background_body,
        background_gradiend
    };
    controls[] = {
        background_logo,
        headertext,
        clock,
        player_button,
        menu_button
    };

    class background_header : RSC(BaseText) {
        x = GUI_DISP_X;
        y = GUI_DISP_Y;
        w = GUI_DISP_WAbs;
        h = GUI_DISP_H*8;
        colorBackground[] = {0,0,0,1};
    };

    class background_body : background_header {
        x = GUI_DISP_X;
        y = GUI_DISP_Y+GUI_DISP_H*8;
        w = GUI_DISP_WAbs;
        h = GUI_DISP_HAbs-GUI_DISP_H*8;
        colorBackground[] = COLOR_MENU_BODY_BACKGROUND;
    };

    class background_gradiend : RSC(BasePictureNoScale) {
        idc = -1;
        x = GUI_DISP_X;
        y = GUI_DISP_Y;
        w = GUI_DISP_WAbs;
        h = GUI_DISP_HAbs;
        text = "\A3\ui_f\data\GUI\rsc\rscdisplaymain\hover_ca.paa";
        colorBackground[] = COLOR_MENU_BODY_BACKGROUND;
    };

    class background_logo : RSC(BasePicture) {
        idc = IDC_GUI_MAIN_LOGO;
        x = GUI_DISP_X+(GUI_DISP_WAbs-GUI_DISP_W*78)/2;
        y = GUI_DISP_Y+GUI_DISP_H*13;
        w = GUI_DISP_W*78;
        h = GUI_DISP_HAbs-GUI_DISP_H*18;
    };

    class headertext : RSC(BaseText) {
        idc = IDC_GUI_MAIN_HEADERTEXT;
        x = GUI_DISP_X+GUI_DISP_W*15;
        y = GUI_DISP_Y;
        w = GUI_DISP_W*50;
        h = GUI_DISP_H*8;
        sizeEx = GUI_DISP_H*6;
        text = CSTRING(HEADER);
        font = FONT_BOLD;
        colorBackground[] = COLOR_DISABLED;
        colorText[] = COLOR_MENU_HEADER_TEXT;
    };

    class clock: RSC(BaseStructuredText) {
        idc = IDC_GUI_MAIN_CLOCK;
        x = GUI_DISP_X+GUI_DISP_WAbs-GUI_DISP_W*28;
        y = GUI_DISP_Y+GUI_DISP_H;
        w = GUI_DISP_W*20;
        h = GUI_DISP_H*6;
        colorBackground[] = COLOR_DISABLED;
        colorText[] = COLOR_MENU_HEADER_TEXT;
        style = "0x02";
        size = GUI_DISP_H * 3;
        text = __EVAL("00:00"+endl+"01.01.2017");
        class attributes : attributes {
            align = "center";
            size = 1;
        };
    };

    class menu_button : RSC(BaseButton) {
        idc = IDC_GUI_MAIN_MENUBTTN;
        x = GUI_DISP_X+GUI_DISP_W*2;
        y = GUI_DISP_Y+GUI_DISP_H;
        w = GUI_DISP_W*6;
        h = GUI_DISP_H*6;
        style = "48+0x800";
        sizeEx = GUI_DISP_H*6;
        colorBackground[] = COLOR_MENU_HEADER_MENUBUTTON_BACKGROUND;
        colorBackgroundActive[] = COLOR_MENU_HEADER_MENUBUTTON_BACKGROUND_SELECTED;
        colorFocused[] = COLOR_MENU_HEADER_MENUBUTTON_BACKGROUND;
        colorText[] = COLOR_MENU_HEADER_MENUBUTTON_TEXT;
        colorDisabled[] = COLOR_DISABLED;
        colorBackgroundDisabled[] = COLOR_DISABLED;
        offsetX = 0;
        offsetY = 0;
        offsetPressedX = 0;
        offsetPressedY = 0;
        onButtonClick = QUOTE(_this call FUNC(openMetro););
    };

    class player_button : menu_button {
        idc = IDC_GUI_MAIN_PLAYERBTTN;
        x = GUI_DISP_X+GUI_DISP_WAbs-GUI_DISP_W*7;
        y = GUI_DISP_Y+GUI_DISP_H;
        w = GUI_DISP_W*6;
        h = GUI_DISP_H*6;
        text = "\A3\ui_f\data\GUI\rsc\rscdisplaymain\profile_player_ca.paa";
        onButtonClick = "";
    };
};

class APP(dialog) : RSC(guiMenu) {};

class RSC(Metro) : RSC(BaseControlsGroupNoHScrollbar) {
    idc = IDC_GUI_MAIN_METRO_GRP;
    x = GUI_DISP_X+GUI_DISP_W*2;
    y = GUI_DISP_Y+GUI_DISP_H*10;
    w = GUI_DISP_W*100;
    h = GUI_DISP_H*76;

    class VScrollbar : VScrollbar {
        color[] = COLOR_METRO_SCROLLBAR;
        colorBackGround[] = COLOR_METRO_SCROLLBAR;
        colorActive[] = COLOR_METRO_BACKGROUND;
        colorDisabled[] = COLOR_METRO_BACKGROUND;
        width = 0;
        height = GUI_DISP_H;
        autoScrollEnabled = 1;
    };
    class controls {
        class background : RSC(BaseText) {
            idc = IDC_GUI_MAIN_METRO_BACK;
            x = 0;
            y = 0;
            w = GUI_DISP_W*100;
            h = GUI_DISP_H*76;
            colorBackground[] = COLOR_METRO_BACKGROUND;
            colorText[] = COLOR_DISABLED;
            colorShadow[] = COLOR_BASE_BLACK;
            shadow = 1;
        };
    };
};

class RSC(MetroBttn_background) : RSC(BasePicture) {
    idc = -1;
    x = 0;
    y = 0;
    w = GUI_DISP_W*10;
    h = GUI_DISP_H*10;
    text = __EVAL(MISSION_ROOT + 'gui\data\buttons\button_256_normal.paa');
    shadow = 0;
    colorShadow[] = COLOR_DISABLED;
    font = FONT_DEFAULT;
    colorText[] = {0.66667,0.25098,1,1};
};

class RSC(MetroBttn) : RSC(BaseButton) {
    idc = -1;
    x = 0;
    y = 0;
    w = GUI_DISP_W*10;
    h = GUI_DISP_H*10;
    sizeEx = GUI_DISP_H*2;
    text = "";
    style = "48+0x800";
    colorBackground[]= COLOR_DISABLED;
    colorBackgroundActive[]= COLOR_DISABLED;
    colorFocused[]= COLOR_DISABLED;
    colorBackgroundDisabled[]= COLOR_DISABLED;
    //colorText[] = COLOR_DISABLED;
    //colorDisabled[] = COLOR_DISABLED;
    colorText[] = COLOR_METRO_BTTN_TEXT;
    colorDisabled[] = COLOR_METRO_BTTN_TEXT_DISABLED;
    shadow = 0;
    colorShadow[] = COLOR_DISABLED;
    font = FONT_DEFAULT;
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0;
    offsetPressedY = 0;
};

class RSC(MetroTextBttn) : RSC(MetroBttn) {
    style = "0x02";
};

class RSC(MetroCategorie) : RSC(BaseText) {
    idc = -1;
    x = 0;
    y = 0;
    w = GUI_DISP_W*22;
    h = GUI_DISP_H*8;
    text = "";
    colorText[] = COLOR_METRO_CAT_TEXT;
    sizeEx = GUI_DISP_H*4;
    font = FONT2_BOLD2;
    colorBackground[] = COLOR_DISABLED;
    tooltipColorText[] = COLOR_DISABLED;
    tooltipColorBox[] = COLOR_DISABLED;
    tooltipColorShade[] = COLOR_DISABLED;
};

class RSC(MetroSplit) : RSC(BaseText) {
    idc = -1;
    x = 0;
    y = 0;
    w = GUI_DISP_W*0.06;
    h = GUI_DISP_H*58;
    text = "";
    colorText[] = COLOR_DISABLED;
    colorBackground[] = COLOR_METRO_CAT_SPLIT;
    tooltipColorText[] = COLOR_DISABLED;
    tooltipColorBox[] = COLOR_DISABLED;
    tooltipColorShade[] = COLOR_DISABLED;
};
