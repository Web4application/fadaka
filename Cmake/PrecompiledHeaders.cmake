# PrecompiledHeaders.cmake - simple PCH support
include_guard(GLOBAL)

function(fadaka_enable_pch TARGET HEADER)
  if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.16")
    target_precompile_headers(${TARGET} PRIVATE ${HEADER})
  else()
    message(WARNING "Precompiled headers require CMake >= 3.16")
  endif()
endfunction()
