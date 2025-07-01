# CodeCoverage.cmake - produce gcov/lcov reports
include_guard(GLOBAL)

option(FADAKA_ENABLE_COVERAGE "Enable coverage flags" OFF)

if(FADAKA_ENABLE_COVERAGE)
  if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    add_compile_options(-fprofile-arcs -ftest-coverage)
    add_link_options(--coverage)
  else()
    message(WARNING "Coverage currently supported only with GCC")
  endif()
endif()
