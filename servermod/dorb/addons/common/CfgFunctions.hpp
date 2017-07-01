class CfgFunctions {
    class ADDON {
        class DOUBLES(EH,ClientPostinit) {
            file = QPATHTOF(DOUBLES(EH,ClientPostinit));
            RECOMPILE;
            postInit = 1;
        };
        class DOUBLES(EH,serverPostinit) {
            file = QPATHTOF(DOUBLES(EH,serverPostinit));
            RECOMPILE;
            postInit = 1;
        };
        class DOUBLES(EH,preinit) {
            file = QPATHTOF(DOUBLES(EH,preinit));
            RECOMPILE;
            preInit = 1;
        };
        class arithmeticMean {
            file = QPATHOF_FUNC(arithmeticMean);
            RECOMPILE;
        };
        class arrayGetArithmeticMean {
            file = QPATHOF_FUNC(arrayGetArithmeticMean);
            RECOMPILE;
        };
        class arraysGetMax {
            file = QPATHOF_FUNC(arraysGetMax);
            RECOMPILE;
        };
        class arraySum {
            file = QPATHOF_FUNC(arraySum);
            RECOMPILE;
        };
        class debug_marker_clean {
            file = QPATHOF_FUNC(debug_marker_clean);
            RECOMPILE;
        };
        class debug_marker_create {
            file = QPATHOF_FUNC(debug_marker_create);
            RECOMPILE;
        };
        class delete {
            file = QPATHOF_FUNC(delete);
            RECOMPILE;
        };
        class exportHashToHpp {
            file = QPATHOF_FUNC(exportHashToHpp);
            RECOMPILE;
        };
        class get_cfg_sublasses {
            file = QPATHOF_FUNC(get_cfg_sublasses);
            RECOMPILE;
        };
        class getGunLenght {
            file = QPATHOF_FUNC(getGunLenght);
            RECOMPILE;
        };
        class players {
            file = QPATHOF_FUNC(players);
            RECOMPILE;
        };
        class pos_between {
            file = QPATHOF_FUNC(pos_between);
            RECOMPILE;
        };
        class pos_flatEmpty {
            file = QPATHOF_FUNC(pos_flatEmpty);
            RECOMPILE;
        };
        class pos_mean {
            file = QPATHOF_FUNC(pos_mean);
            RECOMPILE;
        };
        class pos_random {
            file = QPATHOF_FUNC(pos_random);
            RECOMPILE;
        };
        class pos_randomFlatEmpty {
            file = QPATHOF_FUNC(pos_randomFlatEmpty);
            RECOMPILE;
        };
        class pos_relative {
            file = QPATHOF_FUNC(pos_relative);
            RECOMPILE;
        };
        class pos_square {
            file = QPATHOF_FUNC(pos_square);
            RECOMPILE;
        };
        class pos_surrounding {
            file = QPATHOF_FUNC(pos_surrounding);
            RECOMPILE;
        };
        class rotateVectorXY {
            file = QPATHOF_FUNC(rotateVectorXY);
            RECOMPILE;
        };
        class sel_array_weighted {
            file = QPATHOF_FUNC(sel_array_weighted);
            RECOMPILE;
        };
        class setOwner {
            file = QPATHOF_FUNC(setOwner);
            RECOMPILE;
        };
    };
};
