# Fadaka.cmake - root include for Fadaka build system
include_guard(GLOBAL)

# Project metadata
set(FADAKA_PROJECT_NAME "Fadaka" CACHE STRING "Project name")
set(FADAKA_VERSION_MAJOR 1)
set(FADAKA_VERSION_MINOR 0)
set(FADAKA_VERSION_PATCH 0)
set(FADAKA_VERSION "${FADAKA_VERSION_MAJOR}.${FADAKA_VERSION_MINOR}.${FADAKA_VERSION_PATCH}" CACHE INTERNAL "")

# Default build type
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

# Output directories
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Module path
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")

# Include helpers
include(Utils)
include(Compiler)
include(BuildInfo)
include(Sanitizers)
include(GitVersion)
include(Warnings)

message(STATUS "▶ Fadaka core configured (v${FADAKA_VERSION})")
