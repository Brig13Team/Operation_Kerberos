#pragma once
#include "common.hpp"
#include "caching.hpp"
#include "cleanup.hpp"

class dorb_hq: public singleton<dor_hq> {
public:
    dorb_hq();

    Signal<void()> preStart;
    Signal<void()> preInit;
    Signal<void()> postInit;
    Signal<void()> onFrame;
    Signal<void()> missionEnded;
};
