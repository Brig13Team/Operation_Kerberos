
class APP(dialog) : RSC(guiMenu) {
    idd = IDD_GUI_TELEPORT;
    name = "Teleporter";

    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_main,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this call EFUNC(gui_main,OnLoad); _this call FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_main,OnUnload););

    controlsBackground[] = {
        background_header,
        background_body,
        background_gradiend,
        background_table
    };
    controls[] = {
        //background_logo,
        headertext,
        clock,
        player_button,
        menu_button,
        controlTable
    };

    class background_body : background_body {
        colorBackground[] = COLOR_TELEPORT_BACKGROUND;
    };

    class background_gradiend : background_gradiend {
        colorText[] = COLOR_TELEPORT_BACKGROUND_GRADIEND;
    };

    class background_table: RSC(BaseText) {
        x = GUI_DISP_X+GUI_DISP_W*4;
        y = GUI_DISP_Y+GUI_DISP_H*10;
        w = GUI_DISP_WAbs-GUI_DISP_W*22;
        h = GUI_DISP_HAbs-GUI_DISP_H*18;
        style = "0x02";
        text = "";
        colorText[] = COLOR_TELEPORT_LIST_TEXT;
        colorBackground[] = COLOR_TELEPORT_BACKGROUND3;
    };

    class controlTable : RSC(ControlsTable) {
        idc = IDC_GUI_TELEPORT_TABLE;
        x = GUI_DISP_X+GUI_DISP_W*6;
        y = GUI_DISP_Y+GUI_DISP_H*12;
        w = GUI_DISP_W*134;
        h = GUI_DISP_HAbs-GUI_DISP_H*20;
        rowHeight = GUI_DISP_H*3.5;
        headerHeight = GUI_DISP_H*3.5;
        firstIDC = IDC_GUI_TELEPORT_TABLE_FIRST;
        lastIDC = IDC_GUI_TELEPORT_TABLE_LAST;

        class RowTemplate {
            class RowBackground {
                controlBaseClassPath[] = {"RscText"};
                columnX = 0;
                columnW = GUI_DISP_W*134;
                controlOffsetY = 0;
            };
            class Column1 {
                controlBaseClassPath[] = {"RscText"};
                columnX = 0;
                columnW = GUI_DISP_W*4;
                controlOffsetY = 0;
                controlH = GUI_DISP_H*3.5;
            };
            class Column2 {
                controlBaseClassPath[] = {"RscText"};
                columnX = GUI_DISP_W*4;
                columnW = GUI_DISP_W*50;
                controlOffsetY = GUI_DISP_H*0.1;
            };
            class Column3 {
                controlBaseClassPath[] = {"RscButton"};
                columnX = GUI_DISP_W*100;
                columnW = GUI_DISP_W*30;
                controlOffsetY = GUI_DISP_H*0.5;
            };
        };
        class HeaderTemplate {
            class HeaderBackground {
                controlBaseClassPath[] = {"RscText"};
                columnX = 0;
                columnW = GUI_DISP_W*134;
                controlOffsetY = 0;
            };
            class Column1 {
                controlBaseClassPath[] = {"RscText"};
                columnX = GUI_DISP_W*4;
                columnW = GUI_DISP_W*102;
                controlOffsetY = GUI_DISP_H*0.1;
                controlH = GUI_DISP_H*3;
            };
        };
    };
};
