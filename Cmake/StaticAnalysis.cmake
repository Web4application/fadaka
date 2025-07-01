# StaticAnalysis.cmake - clang-tidy / cppcheck integration
include_guard(GLOBAL)

option(FADAKA_ENABLE_CLANG_TIDY "Run clang-tidy on builds" OFF)
option(FADAKA_ENABLE_CPPCHECK "Run cppcheck on builds" OFF)

if(FADAKA_ENABLE_CLANG_TIDY)
  find_program(CLANG_TIDY_EXE NAMES clang-tidy)
  if(CLANG_TIDY_EXE)
    set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_EXE}")
  else()
    message(WARNING "clang-tidy not found!")
  endif()
endif()

if(FADAKA_ENABLE_CPPCHECK)
  find_program(CPPCHECK_EXE NAMES cppcheck)
  if(CPPCHECK_EXE)
    set(CMAKE_CXX_CPPCHECK "${CPPCHECK_EXE};--enable=all")
  else()
    message(WARNING "cppcheck not found!")
  endif()
endif()
