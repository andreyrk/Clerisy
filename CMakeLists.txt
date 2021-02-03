cmake_minimum_required(VERSION 3.16)

project(Prototype LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick Xml Svg REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick Xml Svg REQUIRED)

FILE(GLOB_RECURSE
    PROJECT_SOURCES
    "*.cpp"
    "*.h"
    "*.qrc"
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(Prototype
        ${PROJECT_SOURCES}
    )
else()
    if(ANDROID)
        add_library(Prototype SHARED
            ${PROJECT_SOURCES}
        )
    else()
        add_executable(Prototype
            ${PROJECT_SOURCES}
        )
    endif()
endif()

target_compile_definitions(
    Prototype
    PRIVATE
    $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
)
target_link_libraries(
    Prototype
    PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Xml
    Qt${QT_VERSION_MAJOR}::Svg
)
