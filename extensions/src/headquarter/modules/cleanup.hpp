#pragma once
#include "common.hpp"
#include "uksf_ai.hpp"

#define CLEANUP_ENABLED_DEFAULT true
#define CLEANUP_DELAY_DEFAULT 300

typedef std::tuple<object, clock_t, bool> killed_map_type;

class uksf_ai_cleanup : public singleton<uksf_ai_cleanup> {
public:
    uksf_ai_cleanup();
    ~uksf_ai_cleanup();

    void startServerThread();
    void stopServerThread();

    static bool cleanupEnabled;
    static float cleanupDelay;

    std::unordered_map<size_t, killed_map_type> killedMap;

    types::registered_sqf_function uksfCleanupKilled;
    static game_value uksfCleanupKilledFunction(game_value object);
    types::registered_sqf_function uksfCleanupToggle;
    static game_value uksfCleanupToggleFunction(game_value object);

private:
    static bool serverThreadStop;
    std::thread serverThread;

    void serverThreadFunction();
};

