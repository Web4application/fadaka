# Platform.cmake - detect OS & arch specifics
include_guard(GLOBAL)

if(WIN32)
  set(PLATFORM_WINDOWS TRUE)
elseif(APPLE)
  set(PLATFORM_MACOS TRUE)
elseif(UNIX AND NOT APPLE)
  set(PLATFORM_LINUX TRUE)
endif()

message(STATUS "▶ Platform: ${CMAKE_SYSTEM_NAME} ${CMAKE_SYSTEM_PROCESSOR}")
