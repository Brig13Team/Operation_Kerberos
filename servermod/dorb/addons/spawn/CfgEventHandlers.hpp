class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_PREINIT));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        serverinit = QUOTE(call COMPILE_FILE(XEH_serverpostinit));
    };
};

class Extended_init_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_init));
    };
    class DOUBLES(ADDON,ACE) {
        init = QUOTE(call COMPILE_FILE(XEH_initACE));
    };
};

class Extended_initPost_EventHandlers {
    class ADDON {
        serverinitpost = QUOTE(call COMPILE_FILE(XEH_initPostServer));
    };
};

class Extended_hit_EventHandlers {
    class ADDON {
        hit = QUOTE(call COMPILE_FILE(XEH_hit));
    };
};
