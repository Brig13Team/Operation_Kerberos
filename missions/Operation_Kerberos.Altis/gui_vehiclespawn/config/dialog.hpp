class APP(dialog) : RSC(guiMenu) {
    iddd = IDD_GUI_VEHICLESPAWN;
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_main,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this call EFUNC(gui_main,OnLoad); _this call FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_main,OnUnload););

    controlsBackground[] = {
        background_header,
        background_body,
        background_gradiend,
        background_vehiclelist
    };
    controls[] = {
        //background_logo,
        headertext,
        clock,
        player_button,
        menu_button,
        vehiclelist_names,
        vehiclelist_sortNames,
        vehicleList_editNames,
        vehiclelist_mods,
        vehiclelist_sortMods,
        vehicleList_editMods,
        vehiclelist,
        properties
    };

    class background_body : background_body {
        colorBackground[] = COLOR_SPAWN_BACKGROUND;
    };

    class background_gradiend : background_gradiend {
        colorText[] = COLOR_SPAWN_BACKGROUND_GRADIEND;
    };

    class background_vehiclelist : RSC(BaseText) {
        idc = -1;
        x = GUI_DISP_X+GUI_DISP_W*2;
        y = GUI_DISP_Y+GUI_DISP_H*10;
        w = GUI_DISP_W*70;
        h = GUI_DISP_H*78;
        colorBackground[] = COLOR_SPAWN_BACKGROUND2;
        colorText[] = COLOR_DISABLED;
    };

    class properties : RSC(BaseControlsGroupNoHScrollbar) {
        idc = IDC_GUI_VEHICLESPAWN_PROPERTIES;
        x = GUI_DISP_X+GUI_DISP_W*74;
        y = GUI_DISP_Y+GUI_DISP_H*10;
        w = GUI_DISP_WAbs-GUI_DISP_W*78;
        h = GUI_DISP_HAbs-GUI_DISP_H*24;

        class VScrollbar : VScrollbar {
            color[] = COLOR_METRO_SCROLLBAR;
            colorBackGround[] = COLOR_METRO_SCROLLBAR;
            colorActive[] = COLOR_METRO_BACKGROUND;
            colorDisabled[] = COLOR_METRO_BACKGROUND;
            width = GUI_DISP_W;
            autoScrollEnabled = 1;
        };
        class controls {
            class background : RSC(BaseText) {
                idc = IDC_GUI_MAIN_METRO_BACK;
                x = 0;
                y = 0;
                w = GUI_DISP_WAbs-GUI_DISP_W*86;
                h = GUI_DISP_HAbs-GUI_DISP_H*24;
                colorBackground[] = COLOR_SPAWN_BACKGROUND2;
                colorText[] = COLOR_DISABLED;
            };
        };
    };

    class vehiclelist : RSC(BaseListboxN) {
        idc = IDC_GUI_VEHICLESPAWN_VEHICLELIST;

        x = GUI_DISP_X+GUI_DISP_W*3;
        y = GUI_DISP_Y+GUI_DISP_H*16;
        w = GUI_DISP_W*68;
        h = GUI_DISP_H*71;

        columns[] = {GUI_DISP_W,GUI_DISP_W*49};
        sizeEx = GUI_DISP_H*2;
        rowHeight = GUI_DISP_H*3;
        tooltip = "";
        color[] = COLOR_SPAWN_VEHICLELIST_TEXT;
        colorScrollbar[] = COLOR_SPAWN_BACKGROUND;
        colorSelect[] = COLOR_SPAWN_VEHICLELIST_TEXT;
        colorSelect2[] = COLOR_SPAWN_VEHICLELIST_TEXT;
        colorDisabled[] = COLOR_DISABLED;
        colorSelectBackground[] = COLOR_SPAWN_VEHICLELIST_SELECTBG;
        colorSelectBackground2[] = COLOR_SPAWN_VEHICLELIST_SELECTBG;
        colorText[] = COLOR_SPAWN_VEHICLELIST_TEXT;
        colorBackground[] = COLOR_SPAWN_BACKGROUND;

        pictureColor[] = COLOR_BASE_WHITE;
        pictureColorSelect[] = COLOR_BASE_WHITE;
        pictureColorDisabled[] = {0.863,0.863,0.863,1};
    };

    class vehiclelist_names : RSC(BaseText) {
        idc = IDC_GUI_VEHICLESPAWN_VEHICLELIST_NAMES;
        text = CSTRING(HEADER_NAME);
        x = GUI_DISP_X+GUI_DISP_W*3;
        y = GUI_DISP_Y+GUI_DISP_H*11;
        w = GUI_DISP_W*44;
        h = GUI_DISP_H*3;
        sizeEx = GUI_DISP_H*2;
        colorBackground[] = COLOR_SPAWN_EDIT_BACKGROUND;
        colorText[] = COLOR_SPAWN_EDIT_TEXT_BACK;
    };
    class vehiclelist_editNames : RSC(BaseEditBox) {
        idc = IDC_GUI_VEHICLESPAWN_VEHICLELIST_EDITNAMES;
        x = GUI_DISP_X+GUI_DISP_W*3;
        y = GUI_DISP_Y+GUI_DISP_H*11;
        w = GUI_DISP_W*44;
        h = GUI_DISP_H*3;
        sizeEx = GUI_DISP_H*2;
        colorBackground[] = COLOR_DISABLED;
        text = "";
        colorSelection[] = COLOR_SPAWN_EDIT_SELECT;
    };
    class vehiclelist_sortNames : RSC(SortButton) {
        idc = IDC_GUI_VEHICLESPAWN_VEHICLELIST_SORTNAMES;
        x = GUI_DISP_X+GUI_DISP_W*48;
        y = GUI_DISP_Y+GUI_DISP_H*11.5;
        w = GUI_DISP_W*3;
        h = GUI_DISP_H*3;
    };

    class vehiclelist_mods : vehiclelist_names {
        idc = IDC_GUI_VEHICLESPAWN_VEHICLELIST_MODS;
        text = CSTRING(HEADER_MODS);
        x = GUI_DISP_X+GUI_DISP_W*52;
        w = GUI_DISP_W*14;
    };
    class vehicleList_editMods : vehiclelist_editNames {
        idc = IDC_GUI_VEHICLESPAWN_VEHICLELIST_EDITMODS;
        x = GUI_DISP_X+GUI_DISP_W*52;
        w = GUI_DISP_W*14;
    };
    class vehiclelist_sortMods : vehiclelist_sortNames {
        idc = IDC_GUI_VEHICLESPAWN_VEHICLELIST_SORTMODS;
        x = GUI_DISP_X+GUI_DISP_W*67;
    };
};

class RSC(SpawnPropText) : RSC(BaseText) {
    w = GUI_DISP_W*30;
    h = GUI_DISP_H*3;
    sizeEx = GUI_DISP_H*2;
    colorText[] = COLOR_SPAWN_PROP_TEXT;
    colorBackground[] = COLOR_SPAWN_PROP_BACK;
};

class RSC(SpawnPropSwitch) : RSC(BaseCheckBoxSwitch) {
    w = GUI_DISP_W*10;
    h = GUI_DISP_H*5;
};

class RSC(Spawn3DView) : RSC(BaseObjectContainer) {
    x = 0.5;
    y = 0.5;
    z = 0.2;
    xBack = 0.5;
    yBack = 0.5;
    zBack = 1.2;
    /*
    x = GUI_DISP_X+GUI_DISP_W*84;
    y = GUI_DISP_Y+GUI_DISP_H*10;
    w = GUI_DISP_WAbs-GUI_DISP_W*86;
    h = GUI_DISP_HAbs-GUI_DISP_H*24;
    */
};
