#include "common.hpp"

game_value dorb_common::CBA_Settings_fnc_init = {};

void dorb_common::getFunctions() {
    dorb_common::CBA_Settings_fnc_init = sqf::get_variable(sqf::ui_namespace(), "CBA_Settings_fnc_init");
}

float dorb_common::getZoom() {
    float safeZoneW = sqf::safe_zone_w();
    float deltaX = ((sqf::world_to_screen(sqf::position_camera_to_world(vector3(5000, 0, 10000))).x) - 0.5f);
    float trigRatio = (((safeZoneW / 2.0f) * 5000.0f) / (10000.0f * deltaX));
    float configFOV = (trigRatio / (safeZoneW / sqf::safe_zone_h()));
    return (0.75f / configFOV);
}

bool dorb_common::lineOfSight(object& target, object& source, bool zoomCheck, bool groupCheck) {
    bool los = false;
    bool inScreen = false;
    vector2 screenPosition = sqf::world_to_screen(sqf::get_pos(target), inScreen);
    bool onScreen = (inScreen && ((std::abs(screenPosition.x) < 1.5f) && (std::abs(screenPosition.y) < 1.5f)));
    bool visible = (sqf::check_visibility(source, "VIEW", sqf::vehicle(source), sqf::eye_pos(source), sqf::eye_pos(target)) > 0);
    los = (onScreen && visible);

    if (onScreen && !los && groupCheck) {
        std::vector<object> units = sqf::units(target);
        for (auto& unit : units) {
            bool inScreen = false;
            vector2 screenPosition = sqf::world_to_screen(sqf::get_pos(unit), inScreen);
            bool onScreen = (inScreen && ((std::abs(screenPosition.x) < 1.5f) && (std::abs(screenPosition.y) < 1.5f)));
            los = (onScreen && (sqf::check_visibility(source, "VIEW", sqf::vehicle(source), sqf::eye_pos(source), sqf::eye_pos(unit)) > 0));
            if (los) {
                target = std::ref(unit);
                break;
            }
        }
    }

    if (los && zoomCheck) {
        float distanceMultiplier = (200 + (4 * 200 * (std::max(0.0f, (float) (sqf::current_vision_mode(source) - 1)))));
        if (!sqf::is_kind_of(sqf::vehicle(target), "CAManBase")) {
            distanceMultiplier *= 2.5f;
        }
        float distanceCheck = std::min(sqf::get_object_view_distance().object_distance, 1000 + (distanceMultiplier * dorb_common::getZoom()));
        float distance = (sqf::get_pos_world(target)).distance(sqf::get_pos_world(source));
        los = (distance < distanceCheck);
    }

    return los;
}
