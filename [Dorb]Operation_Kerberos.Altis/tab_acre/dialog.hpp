#define INCLUDE_DIALOG
#include "script_component.hpp"

#include "defineGrids.hpp"
#include "defineResColor.hpp"
#include "defineResIncl.hpp"
#include "dialogBase.hpp"

/*extern*/ class RscControlsGroup;

class GVAR(mainMenu) : GVAR(dlgBase) {
    idd = IDC_TABLET_APP_ACRE;
    name = "Echidna-Tablet_ACRE-App";
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(dialog)',_this select 0)]; _this call FUNC(onLoad););
    onUnload = QUOTE(_this call FUNC(onUnload);uiNamespace setVariable [ARR_2('GVAR(dialog)',displayNull)];);
    class controls {
        class GVAR(AppGroup) : RscControlsGroup  {
            idc = IDC_TABLET_CTRLGROUP;
            x = GUI_TAB_X;
            y = GUI_TAB_Y;
            w = GUI_TAB_W * 160;
            h = GUI_TAB_H * 100;
            /// disable horizontal scrollbar
            class HScrollbar {
                height = 0;
            };
            class controls {};
        };
    };
}:
