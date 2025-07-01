# GitVersion.cmake - embed git commit into BuildInfo
include_guard(GLOBAL)

find_package(Git QUIET)
if(GIT_FOUND AND EXISTS "${CMAKE_SOURCE_DIR}/.git")
  execute_process(
    COMMAND ${GIT_EXECUTABLE} rev-parse --short HEAD
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_COMMIT_HASH
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
else()
  set(GIT_COMMIT_HASH "unknown")
endif()

# Expose variable for BuildInfo
set(FADAKA_GIT_COMMIT_HASH "${GIT_COMMIT_HASH}" CACHE INTERNAL "")
