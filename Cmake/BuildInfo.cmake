# BuildInfo.cmake - generate BuildInfo.h with compile-time information
include_guard(GLOBAL)

set(BUILDINFO_TEMPLATE ${CMAKE_SOURCE_DIR}/cmake/templates/BuildInfo.h.in)
set(BUILDINFO_OUTPUT   ${CMAKE_BINARY_DIR}/generated/BuildInfo.h)

string(TIMESTAMP BUILD_TIMESTAMP "%Y-%m-%d %H:%M:%S")

configure_file(
  ${BUILDINFO_TEMPLATE}
  ${BUILDINFO_OUTPUT}
  @ONLY
)

include_directories(${CMAKE_BINARY_DIR}/generated)

message(STATUS "▶ BuildInfo.h generated")
