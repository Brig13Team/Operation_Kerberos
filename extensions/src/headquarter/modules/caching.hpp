#pragma once
#include "common.hpp"
#include "uksf_ai.hpp"

#define CACHING_ENABLED_DEFAULT true
#define CACHING_DISTNACE_DEFAULT 750

class uksf_ai_caching: public singleton<uksf_ai_caching> {
public:
    uksf_ai_caching();
    ~uksf_ai_caching();

    void startServerThread();
    void startClientThread();
    void stopServerThread();
    void stopClientThread();
    void onFrameFunction();

    static bool cachingEnabled;
    static float cachingDistance;

    types::registered_sqf_function uksfCachingToggle;
    static game_value uksfCachingToggleFunction(game_value object);

private:
    static bool serverThreadStop;
    static bool clientThreadStop;
    std::thread serverThread, clientThread;

    void serverThreadFunction();
    void clientThreadFunction();
};
