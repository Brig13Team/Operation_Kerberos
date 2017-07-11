#include "caching.hpp"

bool uksf_ai_caching::cachingEnabled = CACHING_ENABLED_DEFAULT;
float uksf_ai_caching::cachingDistance = CACHING_DISTNACE_DEFAULT;

bool uksf_ai_caching::serverThreadStop = true;
bool uksf_ai_caching::clientThreadStop = true;

uksf_ai_caching::uksf_ai_caching() {
    uksf_ai::getInstance()->preStart.connect([this]() {
        LOG(DEBUG) << "CACHING SIGNAL PRESTART";
        uksfCachingToggle = client::host::registerFunction(
            "uksfCachingToggle",
            "Excludes/includes object in caching system",
            userFunctionWrapper<uksfCachingToggleFunction>,
            types::GameDataType::NOTHING,
            types::GameDataType::ARRAY
        );
    });

    uksf_ai::getInstance()->preInit.connect([this]() {
        LOG(DEBUG) << "CACHING SIGNAL PREINIT";
        game_value enabled_args({
            "uksf_ai_caching_enabled",
            "CHECKBOX",
            "Caching System",
            "UKSF",
            CACHING_ENABLED_DEFAULT,
            true
        });
        sqf::call(uksf_common::CBA_Settings_fnc_init, enabled_args);
        game_value distance_args({
            "uksf_ai_caching_distance",
            "SLIDER",
            "Caching System Distance",
            "UKSF",
            { 500, 2000, CACHING_DISTNACE_DEFAULT, 0 },
            true
        });
        sqf::call(uksf_common::CBA_Settings_fnc_init, distance_args);

        if (sqf::is_server()) {
            getInstance()->stopServerThread();
        }
        if (sqf::has_interface()) {
            getInstance()->stopClientThread();
        }
    });

    uksf_ai::getInstance()->postInit.connect([this]() {
        LOG(DEBUG) << "CACHING SIGNAL POSTINIT";
        cachingEnabled = (sqf::get_variable(sqf::mission_namespace(), "uksf_ai_caching_enabled", CACHING_ENABLED_DEFAULT));
        cachingDistance = (sqf::get_variable(sqf::mission_namespace(), "uksf_ai_caching_distance", CACHING_DISTNACE_DEFAULT));

        if (!cachingEnabled) {
            LOG(INFO) << "Caching system is disabled";
            sqf::enable_dynamic_simulation_system(false);
        } else {
            LOG(INFO) << "Caching system is enabled";
            sqf::enable_dynamic_simulation_system(true);
            sqf::set_dynamic_simulation_distance("Group", cachingDistance);
            sqf::set_dynamic_simulation_distance("Vehicle", cachingDistance);
            sqf::set_dynamic_simulation_distance("EmptyVehicle", 250);
            sqf::set_dynamic_simulation_distance("Prop", 50);
            sqf::set_dynamic_simulation_distance_coef("IsMoving", 1.5f);

            if (sqf::is_server()) {
                getInstance()->startServerThread();
            }
            if (sqf::has_interface()) {
                getInstance()->startClientThread();
            }
        };
    });

    uksf_ai::getInstance()->onFrame.connect([this]() {
        //getInstance()->onFrameFunction();
    });

    uksf_ai::getInstance()->missionEnded.connect([this]() {
        LOG(DEBUG) << "CACHING SIGNAL MISSION ENDED";
        getInstance()->stopServerThread();
        getInstance()->stopClientThread();
    });
}

uksf_ai_caching::~uksf_ai_caching() {
    stopServerThread();
    stopClientThread();
}

void uksf_ai_caching::startServerThread() {
    serverThreadStop = false;
    serverThread = std::thread(&uksf_ai_caching::serverThreadFunction, this);
    serverThread.detach();
}

void uksf_ai_caching::startClientThread() {
    clientThreadStop = false;
    clientThread = std::thread(&uksf_ai_caching::clientThreadFunction, this);
    clientThread.detach();
}

void uksf_ai_caching::stopServerThread() {
    if (serverThread.joinable()) {
        serverThreadStop = true;
        serverThread.join();
    }
}

void uksf_ai_caching::stopClientThread() {
    if (clientThread.joinable()) {
        clientThreadStop = true;
        clientThread.join();
    };
}

void uksf_ai_caching::serverThreadFunction() {
    //TODO: improve caching time with some sort of hashmap/cache
    while (!serverThreadStop) {
        {
            client::invoker_lock cachingLock(true);
            if (serverThreadStop) return;
            cachingLock.lock();

            auto groups = sqf::all_groups();
            for (auto& group : groups) {
                auto leader = sqf::leader(group);
                if (!(sqf::get_variable(group, "uksf_ai_caching_excluded", false)) && !sqf::dynamic_simulation_enabled(group) && !sqf::is_player(leader) && !sqf::is_kind_of(sqf::vehicle(leader), "Air") && (((float)sqf::get_variable(group, "uksf_ai_caching_time", 0) + 15) < sqf::diag_ticktime())) {
                    sqf::remote_exec_call({ group, true }, "enableDynamicSimulation", 0, false);
                }
            }
        }
        Sleep(5000);
    }
}

void uksf_ai_caching::clientThreadFunction() {
    while (!clientThreadStop) {
        {
            client::invoker_lock cachingLock(true);
            if (clientThreadStop) return;
            cachingLock.lock();
            auto player = ((object)(sqf::get_variable(sqf::mission_namespace(), "bis_fnc_moduleRemoteControl_unit", sqf::player())));
            auto uav = sqf::get_connected_uav(sqf::player());
            if (!uav.is_null()) {
                player = sqf::gunner(uav);
            };
            auto groups = sqf::all_groups();
            for (auto& group : groups) {
                auto leader = sqf::leader(group);
                if (!(sqf::get_variable(group, "uksf_ai_caching_excluded", false)) && !sqf::is_player(leader) && !sqf::is_kind_of(sqf::vehicle(leader), "Air")) {
                    auto distance = (sqf::get_pos_world(leader)).distance(sqf::get_pos_world(player));
                    if (distance > cachingDistance && (distance < sqf::get_object_view_distance().object_distance) && ((((float)sqf::get_variable(group, "uksf_ai_caching_time", 0) + 10) < sqf::diag_ticktime()) || !sqf::simulation_enabled(leader)) && uksf_common::lineOfSight(leader, player, true, true)) {
                        if (sqf::dynamic_simulation_enabled(group)) {
                            sqf::remote_exec_call({ group, false }, "enableDynamicSimulation", 0, false);
                        }
                        sqf::set_variable(group, "uksf_ai_caching_time", sqf::diag_ticktime());
                    }
                }
            }
        }
        Sleep(1000);
    }
}

game_value uksf_ai_caching::uksfCachingToggleFunction(game_value params) {
    if (cachingEnabled) {
        object cached = (object)params[0];
        bool forceExclude = (bool)params[1];
        auto group = sqf::get_group(cached);
        auto message = "Excluded from caching";
        if (!(sqf::get_variable(group, "uksf_ai_caching_excluded", false)) || forceExclude) { // Not excluded
            sqf::set_variable(group, "uksf_ai_caching_excluded", true); // Exclude
            if (sqf::dynamic_simulation_enabled(group)) {
                sqf::enable_dynamic_simulation(group, false);
                auto units = sqf::units(group);
                std::vector<object> crewUnits = {};
                auto vehicle = sqf::object_parent(sqf::leader(group));
                if (!vehicle.is_null()) {
                    crewUnits = sqf::crew(vehicle);
                }
                units.insert(std::end(units), std::begin(crewUnits), std::end(crewUnits));
                for (auto unit : units) {
                    sqf::enable_simulation_global(unit, true);
                    sqf::set_variable(sqf::get_group(unit), "uksf_ai_caching_excluded", true);
                }
            }
        } else {
            sqf::set_variable(group, "uksf_ai_caching_excluded", false); // Include            
            message = "Included in caching";
        }

        object player = (object)params[2];
        if (!player.is_null()) {
            sqf::remote_exec_call({ message }, "ace_common_fnc_displayTextStructured", player, false);
        }
    }
    return "";
}

void uksf_ai_caching::onFrameFunction() {
    auto groups = sqf::all_groups();
    for (auto& group : groups) {
        auto unit = sqf::leader(group);
        types::rv_color color{ 1.0f, 0.0f, 0.0f, 1.0f };
        if (sqf::simulation_enabled(unit)) {
            color = { 0.0f, 1.0f, 0.0f, 1.0f };
        }
        sqf::draw_icon_3d("\\a3\\ui_f_curator\\data\\logos\\arma3_curator_eye_32_ca.paa", color, sqf::get_pos_atl(unit), 0.5f, 0.5f, 0, "", 0, 0, "TahomaB", "center", true);
    }
}
