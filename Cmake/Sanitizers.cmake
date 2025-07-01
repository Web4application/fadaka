# Sanitizers.cmake - enable runtime sanitizers easily
include_guard(GLOBAL)

option(FADAKA_ENABLE_ASAN "Enable AddressSanitizer" OFF)
option(FADAKA_ENABLE_UBSAN "Enable UndefinedBehaviourSanitizer" OFF)

if(FADAKA_ENABLE_ASAN OR FADAKA_ENABLE_UBSAN)
  if(NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    message(WARNING "Sanitizers only supported with Clang/GCC")
  endif()
endif()

if(FADAKA_ENABLE_ASAN)
  add_compile_options(-fsanitize=address -fno-omit-frame-pointer)
  add_link_options(-fsanitize=address)
endif()

if(FADAKA_ENABLE_UBSAN)
  add_compile_options(-fsanitize=undefined -fno-omit-frame-pointer)
  add_link_options(-fsanitize=undefined)
endif()
