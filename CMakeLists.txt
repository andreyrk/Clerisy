cmake_minimum_required(VERSION 3.19)
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")

project(Clerisy LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

if (NOT ANDROID)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/lib)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/lib)
endif()

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if (ANDROID)
    include("${ANDROID_SDK_ROOT}/android_openssl/CMakeLists.txt")
endif()

find_package(Qt6 COMPONENTS Core Quick QuickControls2 Xml Svg REQUIRED)

FILE(GLOB_RECURSE
    PROJECT_SOURCES
    "src/*.cpp"
    "src/*.h"
    "rsc/*.qrc"
)

qt_add_executable(
    ${PROJECT_NAME}
    ${PROJECT_SOURCES}
)

if(ANDROID)
    set_property(
        TARGET
        ${PROJECT_NAME}
        APPEND PROPERTY
        QT_ANDROID_PACKAGE_SOURCE_DIR
        ${CMAKE_CURRENT_SOURCE_DIR}/android
    )
endif()
if(WIN32)
    add_custom_command(
        TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND "${CMAKE_PREFIX_PATH}/bin/windeployqt.exe" --qmldir ${CMAKE_SOURCE_DIR} \"$<TARGET_FILE:${PROJECT_NAME}>\"
    )
endif()

target_compile_definitions(
    ${PROJECT_NAME}
    PRIVATE
    $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
)

target_link_libraries(
    ${PROJECT_NAME}
    PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Xml
    Qt6::Svg
)
