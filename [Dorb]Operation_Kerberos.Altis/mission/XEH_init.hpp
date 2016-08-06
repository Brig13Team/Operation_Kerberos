#define CBA_OFF
#include "script_component.hpp"

#define XEH_INIT(CLASSNAME,COMMAND) class CLASSNAME { \
    class ADDON { \
        init = QUOTE(COMMAND); \
    }; \
}; \

// Intel
XEH_INIT(Land_File1_F,_this call FUNC(objects_intel_init));
XEH_INIT(Land_File2_F,_this call FUNC(objects_intel_init));
XEH_INIT(Land_FilePhotos_F,_this call FUNC(objects_intel_init));
XEH_INIT(Land_Laptop_F,_this call FUNC(objects_intel_init));
XEH_INIT(Land_Laptop_unfolded_F,_this call FUNC(objects_intel_init));
XEH_INIT(Land_SatellitePhone_F,_this call FUNC(objects_intel_init));
XEH_INIT(Land_MobilePhone_smart_F,_this call FUNC(objects_intel_init));
