enable_language(ASM_NASM) # activates nasm support

set(ASM_SRCS ${CMAKE_CURRENT_SOURCE_DIR}/asm/foo.asm)

add_library(core STATIC
    src/bar.cpp
    ${ASM_SRCS}
)

target_compile_options(core PRIVATE    # NASM flags
    "$<$<COMPILE_LANGUAGE:ASM_NASM>:-f elf64>"
)

install(TARGETS core ARCHIVE DESTINATION lib)
