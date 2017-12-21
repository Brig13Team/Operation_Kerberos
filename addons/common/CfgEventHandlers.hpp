class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_PREINIT));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        serverinit = QUOTE(call COMPILE_FILE(XEH_SERVERPOSTINIT));
    };
};
