# Utils.cmake - helper functions and macros
include_guard(GLOBAL)

# Enable LTO for a target if supported
function(fadaka_enable_lto TARGET)
  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    target_compile_options(${TARGET} PRIVATE -flto)
    target_link_options(${TARGET} PRIVATE -flto)
  elseif(MSVC)
    target_compile_options(${TARGET} PRIVATE /GL)
    target_link_options(${TARGET} PRIVATE /LTCG)
  endif()
endfunction()

# Print binary size
function(fadaka_print_target_size TARGET)
  add_custom_command(TARGET ${TARGET} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E echo "Size of $<TARGET_FILE:${TARGET}>:"
    COMMAND ${CMAKE_COMMAND} -E size $<TARGET_FILE:${TARGET}>
  )
endfunction()
