cmake_minimum_required(VERSION 3.14)

project(MichaelPlayer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick REQUIRED)

set(PROJECT_SOURCES
        main.cpp
        qml.qrc
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(MichaelPlayer
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )
# Define target properties for Android with Qt 6 as:
#    set_property(TARGET MichaelPlayer APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    if(ANDROID)
        add_library(MichaelPlayer SHARED
            ${PROJECT_SOURCES}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(MichaelPlayer
          ${PROJECT_SOURCES}
        )
    endif()
endif()

set(FFMPEG_ROOT ${PROJECT_SOURCE_DIR}/depend/ffmpeg/build)
set(LIBX264_ROOT ${PROJECT_SOURCE_DIR}/depend/x264/build)

set(FFMPEG_INCLUDE_PATH ${FFMPEG_ROOT}/include)
set(FFMPEG_LIB_PATH ${FFMPEG_ROOT}/bin)
set(X264_INCLUDE_PATH ${LIBX264_ROOT}/include)
set(X264_LIB_PATH ${LIBX264_ROOT}/lib)
    
include_directories(${FFMPEG_INCLUDE_PATH})
include_directories(${X264_INCLUDE_PATH})
link_directories(${FFMPEG_LIB_PATH})
link_directories(${X264_LIB_PATH})
message(STATUS "FFMPEG_LIB_PATH=${FFMPEG_LIB_PATH}")
message(STATUS "X264_LIB_PATH=${X264_LIB_PATH}")

target_compile_definitions(MichaelPlayer
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(MichaelPlayer
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick 
  ${FFMPEG_LIB_PATH}/avutil.lib 
  ${FFMPEG_LIB_PATH}/avcodec.lib 
  ${FFMPEG_LIB_PATH}/avfilter.lib  
  ${FFMPEG_LIB_PATH}/avdevice.lib  
  ${FFMPEG_LIB_PATH}/avformat.lib  
  ${FFMPEG_LIB_PATH}/postproc.lib 
  ${FFMPEG_LIB_PATH}/swresample.lib 
  ${X264_LIB_PATH}/libx264.lib )

set_target_properties(MichaelPlayer PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(MichaelPlayer)
    qt_finalize_executable(MichaelPlayer)
endif()
