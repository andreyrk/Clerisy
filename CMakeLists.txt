cmake_minimum_required(VERSION 3.16)

project(Clerisy LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/lib)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if (ANDROID)
    include("${ANDROID_SDK}/android_openssl/CMakeLists.txt")
endif()

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick Xml Svg REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick Xml Svg REQUIRED)

FILE(GLOB_RECURSE
    PROJECT_SOURCES
    "*.cpp"
    "*.h"
    "*.qrc"
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    if(ANDROID)
        qt_add_executable(
            ${PROJECT_NAME}
            ${PROJECT_SOURCES}
        )
    endif()
    if(WIN32)
        qt_add_executable(
            ${PROJECT_NAME}
            ${PROJECT_SOURCES}
        )

        add_custom_command(
            TARGET ${PROJECT_NAME} POST_BUILD
            COMMAND "${CMAKE_PREFIX_PATH}/bin/windeployqt.exe" --qmldir ${CMAKE_SOURCE_DIR} \"$<TARGET_FILE:${PROJECT_NAME}>\"
        )
    endif()
else()
    if(ANDROID)
        add_library(
            ${PROJECT_NAME}
            SHARED
            ${PROJECT_SOURCES}
        )
    endif()
    if(WIN32)
        add_executable(
            ${PROJECT_NAME}
            WIN32
            ${PROJECT_SOURCES}
        )

        add_custom_command(
            TARGET ${PROJECT_NAME} POST_BUILD
            COMMAND "${CMAKE_PREFIX_PATH}/bin/windeployqt.exe" --qmldir ${CMAKE_SOURCE_DIR} \"$<TARGET_FILE:${PROJECT_NAME}>\"
        )
    endif()
endif()

target_compile_definitions(
    ${PROJECT_NAME}
    PRIVATE
    $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
)

target_link_libraries(
    ${PROJECT_NAME}
    PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Xml
    Qt${QT_VERSION_MAJOR}::Svg
)
