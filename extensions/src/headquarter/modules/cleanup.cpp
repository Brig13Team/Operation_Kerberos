#include "cleanup.hpp"

bool dorb_ai_cleanup::cleanupEnabled = CLEANUP_ENABLED_DEFAULT;
float dorb_ai_cleanup::cleanupDelay = CLEANUP_DELAY_DEFAULT;

bool dorb_ai_cleanup::serverThreadStop = true;
std::unordered_map<size_t, killed_map_type> killedMap{};

dorb_ai_cleanup::dorb_ai_cleanup() {
    dorb_ai::getInstance()->preStart.connect([this]() {
        LOG(DEBUG) << "CLEANUP SIGNAL PRESTART";
        uksfCleanupKilled = client::host::registerFunction(
            "uksfCleanupKilled",
            "Adds object to killed list for cleanup",
            userFunctionWrapper<uksfCleanupKilledFunction>,
            types::GameDataType::NOTHING,
            types::GameDataType::OBJECT
        );
        uksfCleanupToggle = client::host::registerFunction(
            "uksfCleanupToggle",
            "Excludes/includes object in cleanup system",
            userFunctionWrapper<uksfCleanupToggleFunction>,
            types::GameDataType::NOTHING,
            types::GameDataType::ARRAY
        );
    });

    dorb_ai::getInstance()->preInit.connect([this]() {
        LOG(DEBUG) << "CLEANUP SIGNAL PREINIT";
        game_value enabled_args({
            "dorb_ai_cleanup_enabled",
            "CHECKBOX",
            "Cleanup System",
            "UKSF",
            CLEANUP_ENABLED_DEFAULT,
            true
        });
        sqf::call(dorb_common::CBA_Settings_fnc_init, enabled_args);
        game_value delay_args({
            "dorb_ai_cleanup_delay",
            "SLIDER",
            "Cleanup System Delay",
            "UKSF",
            { 30, 600, CLEANUP_DELAY_DEFAULT, 0 },
            true
        });
        sqf::call(dorb_common::CBA_Settings_fnc_init, delay_args);

        if (sqf::is_server()) {
            getInstance()->stopServerThread();
        }
    });

    dorb_ai::getInstance()->postInit.connect([this]() {
        LOG(DEBUG) << "CLEANUP SIGNAL POSTINIT";
        cleanupEnabled = (sqf::get_variable(sqf::mission_namespace(), "dorb_ai_cleanup_enabled", CLEANUP_ENABLED_DEFAULT));
        cleanupDelay = (sqf::get_variable(sqf::mission_namespace(), "dorb_ai_cleanup_distance", CLEANUP_DELAY_DEFAULT));

        if (!cleanupEnabled) {
            LOG(INFO) << "Cleanup system is disabled";
        } else {
            LOG(INFO) << "Cleanup system is enabled";
            if (sqf::is_server()) {
                getInstance()->startServerThread();
            }
        };
    });

    dorb_ai::getInstance()->onFrame.connect([this]() {

    });

    dorb_ai::getInstance()->missionEnded.connect([this]() {
        LOG(DEBUG) << "CLEANUP SIGNAL MISSION ENDED";
        getInstance()->stopServerThread();
    });
}

dorb_ai_cleanup::~dorb_ai_cleanup() {
    stopServerThread();
}

void dorb_ai_cleanup::startServerThread() {
    serverThreadStop = false;
    serverThread = std::thread(&dorb_ai_cleanup::serverThreadFunction, this);
    serverThread.detach();
}

void dorb_ai_cleanup::stopServerThread() {
    if (serverThread.joinable()) {
        serverThreadStop = true;
        serverThread.join();
    }
}

void dorb_ai_cleanup::serverThreadFunction() {
    while (!serverThreadStop) {
        {
            client::invoker_lock cleanupLock(true);
            if (serverThreadStop) return;
            cleanupLock.lock();
            for (auto entry = killedMap.begin(); entry != killedMap.end();) {
                auto killed = std::get<0>(entry->second);
                auto time = std::get<1>(entry->second);
                auto excluded = std::get<2>(entry->second);
                if ((!excluded && (time < (clock() / CLOCKS_PER_SEC)) && !sqf::alive(killed)) || killed.is_null()) {
                    sqf::delete_vehicle(killed);
                    entry = killedMap.erase(entry);
                } else {
                    entry++;
                }
            }
        }
        Sleep((DWORD)((cleanupDelay / 4) * CLOCKS_PER_SEC));
    }
}

game_value dorb_ai_cleanup::uksfCleanupKilledFunction(game_value rawKilled) {
    if (cleanupEnabled) {
        object killed = (object)rawKilled;
        auto &killedMap = getInstance()->killedMap;
        auto entry = killedMap.find(killed.hash());
        if (entry != killedMap.end()) {
            if (!std::get<2>(entry->second)) { // Not excluded
                std::get<1>(entry->second) = (clock_t)((clock() / CLOCKS_PER_SEC) + (cleanupDelay * ((sqf::is_kind_of(std::get<0>(entry->second), "CAManBase")) ? 1 : 2))); // Update time killed
            }
        } else {
            killedMap.insert({ killed.hash(), killed_map_type({ killed, (clock_t)((clock() / CLOCKS_PER_SEC) + (cleanupDelay * ((sqf::is_kind_of(killed, "CAManBase")) ? 1 : 2))), false }) });
        }
    }
    return "";
}

game_value dorb_ai_cleanup::uksfCleanupToggleFunction(game_value params) {
    if (cleanupEnabled) {
        object killed = (object)params[0];
        bool forceExclude = (bool)params[1];
        auto &killedMap = getInstance()->killedMap;
        auto entry = killedMap.find(killed.hash());
        auto message = "Excluded from cleanup";
        if (entry != killedMap.end()) {
            if (!std::get<2>(entry->second) || forceExclude) { // Not excluded
                std::get<2>(entry->second) = true; // Exclude
            } else {
                std::get<2>(entry->second) = false; // Include
                message = "Included in cleanup";
            }
        } else {
            // Doesn't exist, add and exclude
            killedMap.insert({ killed.hash(), killed_map_type({ killed, (clock_t)((clock() / CLOCKS_PER_SEC) + (cleanupDelay * ((sqf::is_kind_of(killed, "CAManBase")) ? 1 : 2))), true }) });
        }

        object player = (object)params[2];
        if (!player.is_null()) {
            sqf::remote_exec_call({ message }, "ace_common_fnc_displayTextStructured", player, false);
        }
    }
    return "";
}
