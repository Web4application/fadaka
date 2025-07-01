# Warnings.cmake - extra strict warning options
include_guard(GLOBAL)

function(fadaka_set_warnings TARGET)
  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    target_compile_options(${TARGET} PRIVATE
      -Wall -Wextra -Wpedantic
      -Wconversion -Wsign-conversion
      -Wold-style-cast -Woverloaded-virtual
      -Wduplicated-cond -Wmismatched-new-delete
    )
  elseif(MSVC)
    target_compile_options(${TARGET} PRIVATE /W4 /permissive-)
  endif()
endfunction()
