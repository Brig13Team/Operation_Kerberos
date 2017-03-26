/*
    Author: Dorbedo
*/
#define INCLUDE_GUI
#define CBA_OFF
#include "script_component.hpp"

class APP(dialog) : RSC(Echidna) {
    idd = IDD_ECHIDNA_MAIN;
    controlsBackground[] = {
        background_taskbar,
        background_display
    };
    controls[] = {
        clock,
        menu_button,



        metro_back,
        metro,
        metro_side,
        background_device
    };
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_Echidna,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this spawn EFUNC(gui_echidna,OnLoad);_this spawn FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_Echidna,OnUnLoad););

    class artilleryData : RSC(BaseListboxN) {

    };
    class ammunitionData : RSC(BaseListboxN) {

    };
    class orderList : RSC(BaseListboxN) {

    };
    class shootingLocation : RSC(BaseControlsGroupNoScrollbar) {
        class useCurrent : RSC(BaseComboBox) {

        };
        class easting_name : RSC(BaseText) {

        };
        class easting_edit : RSC(BaseEdit) {

        };
        class northing_name : easting_name {

        };
        class northing_edit : easting_edit {

        };
        class altitude_name : easting_name {

        };
        class altitude_edit : easting_edit {

        };
    };
    class shootingparameter : RSC(BaseControlsGroupNoScrollbar) {
        class mil_name : RSC(BaseText) {

            text = CSTRING(mils);
        };
        class mil_edit : RSC(BaseEdit) {
            text = "1000";
        };
        class elevation_name : easting_name {

            text = CSTRING(elevation);
        };
        class elevation_edit : easting_edit {

            text = "45";
        };
        class ammunition_name : easting_name {

            text = CSTRING(ammo);
        };
        class ammunition_combo : RSC(BaseCombo) {

        };
        class charge_name : easting_name {

            text = CSTRING(charge);
        };
        class charge_combo : RSC(BaseCombo) {

        };
        class fuze_name : easting_name {

            text = CSTRING(ammo);
        };
        class fuze_combo : RSC(BaseCombo) {

        };
    };

    /*
        Warning Order

            a)* Observer-Identification

            b)* MissionType
                - "FireMission"
                - "Adjust Fire"
                - "Fire for Effect"
                - "Polar"

            c)* TargetNumber
                - 2Letter + 4 Digits

            d) Number of Guns
                - used in FFE

        Location of Target

            a) By Grid Coordinates
                1) Grid easting-> norhting
                    - East (3-5 digits)
                    - north (3-5 digits)
                b) ALtitude
                    - sealevel
                c) Target Grid Zone
            b) By Ref/Shift from a TargetNumber
                Offset from a Targetlocation
            c) by Poloar coordinates

                “Direction 1240, Distance 2000, Up 50”.
            d) by Target number

        Direction
            Direction GT

        Target Description
            a) Description
                1)* Target Type and Subtype
                2) Degree of Protection (only for Personal)
                    e.g. Prone
                3)* Target size
                    radius or retangular
                4) Target activity
                    "Prepared to move"
                5) combination of all
            b) Target strenght
                1-4 digits
            c) Report value accuracy
                1-3 digits
            d) Trajectory type
                high angle (default for arty) or low angel (default for mortar)
            e) Dange close Missions
            f) Ammunition
                1) Number of Rounds
                2) Type
                    shell and fuze
            g) effect required
                1) traditional ammunition (HE, ICM)
                    1-30% (default neutralization 20-29%)
                2) special effects
                    mark, mark illuminating, smoke, quick smoke, blinding,
            h) Method of Fire and method of COntol
                A)
                    1) "Fire for Effect" - effect without adjustment
                    2) "Adjust Fire" - fire is qdjusted by observer
                    3) "Battery left (or Right)" 5 sec. between guns
                        "Battery Right 10 Seconds"
                    4) "Continous Illumination"
                    5) "Co-Ordinated Illumination"
                    6) "Continous Fire" - Stop via "End of Mission" or "Cease Loading" or "Check FIre"
                B) Method of control
                    1) "At my Command" -
                    2) "Resticted when Ready"
                        "Rsticted when Ready from 2359, for 65 Minutes"
                    3) "Time on Target"
                        "TOT 1545"
                    4) "Time to fire"
                    5) "When ready"
                C) Firing Interval
                    "Interval 5 rounds 20 sec"
                D) Duration of Fire
                    * Mainly used for smoke or Illumination
    */
};
