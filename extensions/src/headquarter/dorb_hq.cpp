#include "dorb_hq.hpp"

void __cdecl intercept::pre_start() {
    LOG(DEBUG) << "MAIN PRESTART";
    dorb_hq::getInstance()->preStart();
}

void __cdecl intercept::pre_init() {
    LOG(DEBUG) << "MAIN PREINIT";
    uksf_common::getFunctions();
    dorb_hq::getInstance()->preInit();
}

void __cdecl intercept::post_init() {
    LOG(DEBUG) << "MAIN POSTINIT";
    dorb_hq::getInstance()->postInit();
}

void __cdecl intercept::on_frame() {
    dorb_hq::getInstance()->onFrame();
}

void __cdecl intercept::mission_end() {
    LOG(DEBUG) << "MAIN MISSION ENDED";
    dorb_hq::getInstance()->missionEnded();
};

dorb_hq::dorb_hq() {
    new dorb_hq_caching();
    new dorb_hq_cleanup();
}
