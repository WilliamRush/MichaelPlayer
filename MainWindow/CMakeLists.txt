cmake_minimum_required(VERSION 3.13)

#Intro.
message(STATIC "|---------------|")
message(STATIC "|  mainWindow   |")
message(STATIC "|---------------|")
message(STATIC "Configuring build system...")
message(STATIC "Cmake version: ${CMAKE_VERSION}")

#--------------------------------------
#Configure project
#--------------------------------------
set(MODULE_NAME ${VE_MAINWINDOW_TAG})
project(${MODULE_NAME} LANGUAGES CXX)
SET(PROJECT_ROOT_PATH "${PROJECT_SOURCE_DIR}")
IF(WIN32)
	SET(TARGETFILENAME ${MODULE_NAME}.dll)
ENDIF()

SET(CMAKE_CXX_STANDARD_REQUIRED ON)
SET(CMAKE_CXX_STANDARD 17)

#--------------------------------------
#Configure QT relative
#--------------------------------------
SET(CMAKE_AUTOMOC ON)
SET(CMAKE_AUTORCC ON)

IF(WIN32)
SET(QtSysExtra "WinExtras")
SET(QtSysExtrasLink "Qt6::WinExtras")
ELSEIF(APPLE)
SET(QtSysExtra "MacExtras")
SET(QtSysExtrasLink "Qt6::MacExtras")
ENDIF()

IF(WIN32)
#	configure_file(
#		${TEMPLET_VERSION_FILE_PATH}
#		${CMAKE_CURRENT_SOURCE_DIR}/version.rc
#		@ONLY
#	)
ENDIF()

FIND_PACKAGE(Qt6 COMPONENTS Core Core5Compat Quick OpenGL Widgets Concurrent Svg Network QuickControls2 ${QtWebview} REQUIRED)
FIND_PACKAGE(OPENGL QUIET)

#--------------------------------------
#Configure compile files
#--------------------------------------
file(GLOB_RECURSE MAIN_QRC_FILE ${CMAKE_CURRENT_SOURCE_DIR}/*.qrc)

QT6_ADD_RESOURCES(MODULE_QT_RCC_SRCS ${MAIN_QRC_FILE})


