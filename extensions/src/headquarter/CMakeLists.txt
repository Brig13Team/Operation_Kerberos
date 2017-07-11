cmake_minimum_required (VERSION 3.0)

set(EXTENSION_NAME "uksf_ai")

set_property(GLOBAL PROPERTY USE_FOLDERS ON) 

if(WIN32) 
add_definitions(/DWINVER=0x0600 /D_WIN32_WINNT=0x0600)
endif()


if (NOT CMAKE_BUILD_TYPE AND CMAKE_COMPILER_IS_GNUCXX)
	message(STATUS "No build type selected, default to Debug")
	set(CMAKE_BUILD_TYPE "Debug")
endif()

option(DEVEL "DEVEL" ON)
option(USE_STATIC_LINKING "USE_STATIC_LINKING" ON)

if(CMAKE_COMPILER_IS_GNUCXX)
	SET(CMAKE_CXX_FLAGS "-std=c++17 -march=i686 -m32 -O2 -s -fPIC -fpermissive")
	set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
	set(CMAKE_SHARED_LINKER_FLAGS "-static -static-libgcc -static-libstdc++")
else()
	set(CMAKE_CXX_FLAGS_DEBUG "/D _DEBUG /MTd /Zi /Ob0 /Od /RTC1 /EHsc")
	set(CMAKE_CXX_FLAGS_MINSIZEREL     "/MT /O1 /Ob1 /D /EHsc NDEBUG")
	set(CMAKE_CXX_FLAGS_RELEASE       "/MT /O2 /Ob2 /D /EHsc NDEBUG")
	set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "/MT /Zi /O2 /Ob1 /D /EHsc NDEBUG")
endif()

include_directories("C:/SteamLibrary/_Working/addons/Dev/intercept/src/client/headers")

if(DEVEL)
    add_definitions(-DDEVEL)
endif()

message("Build Type: ${CMAKE_BUILD_TYPE}")

set(GLOBAL_SOURCES ${GLOBAL_RC})
file(GLOB_RECURSE SOURCES *.h *.hpp *.c *.cpp)

file(GLOB SOURCES *.h *.hpp *.c *.cpp)
file(GLOB SOURCES_MODULES modules/*.h modules/*.hpp modules/*.c modules/*.cpp)

add_library( ${EXTENSION_NAME} SHARED ${SOURCES} ${SOURCES_MODULES})
add_library( ${EXTENSION_NAME}_static ${SOURCES} ${SOURCES_MODULES})

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/modules)

set_linker_options()

if(USE_64BIT_BUILD)
	target_link_libraries(${EXTENSION_NAME} "C:/SteamLibrary/_Working/addons/Dev/intercept/build/win64/intercept_client/Debug/intercept_client.lib")
    set(FINAL_DLL_NAME ${EXTENSION_NAME}_x64.dll)
else()
	target_link_libraries(${EXTENSION_NAME} "C:/SteamLibrary/_Working/addons/Dev/intercept/build/win32/intercept_client/Debug/intercept_client.lib")
    set(FINAL_DLL_NAME ${EXTENSION_NAME}.dll)
endif()

add_custom_command(TARGET ${EXTENSION_NAME} POST_BUILD
    # Copy DLL to root
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${EXTENSION_NAME}> ${PROJECT_SOURCE_DIR}/../intercept/${FINAL_DLL_NAME}
    # Copy PDB to symbols
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE_DIR:${EXTENSION_NAME}>/${EXTENSION_NAME}.pdb ${PROJECT_SOURCE_DIR}/../intercept/${ARCH}/${EXTENSION_NAME}.pdb
)
