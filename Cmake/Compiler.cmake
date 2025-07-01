# Compiler.cmake - configure compiler flags
include_guard(GLOBAL)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
  add_compile_options(-Wall -Wextra -Wpedantic)
  if(CMAKE_BUILD_TYPE STREQUAL "Release")
    add_compile_options(-O3)
  else()
    add_compile_options(-O0 -g)
  endif()
elseif(MSVC)
  add_compile_options(/W4 /permissive-)
endif()

message(STATUS "▶ Compiler flags configured")
