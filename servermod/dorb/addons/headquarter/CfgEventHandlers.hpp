class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class DOUBLES(ADDON,SERVER) {
        serverinit = QUOTE(call COMPILE_FILE(XEH_Serverpostinit));
    };
    class DOUBLES(ADDON,CLIENT) {
        clientinit = QUOTE(call COMPILE_FILE(XEH_Clientpostinit));
    };
};

class Extended_initPost_EventHandlers {
    class ADDON {
        Serverinit = QUOTE(call COMPILE_FILE(XEH_initPostServer));
    };
};

class Extended_Killed_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_Killed));
    };
};
