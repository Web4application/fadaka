# Docs.cmake - generate Doxygen documentation
include_guard(GLOBAL)

find_package(Doxygen QUIET)
option(FADAKA_BUILD_DOCS "Generate API docs with Doxygen" OFF)

if(FADAKA_BUILD_DOCS AND DOXYGEN_FOUND)
  set(DOXYGEN_IN ${CMAKE_CURRENT_LIST_DIR}/templates/Doxyfile.in)
  set(DOXYGEN_OUT ${CMAKE_BINARY_DIR}/Doxyfile)
  configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)

  add_custom_target(docs
    COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Generating API documentation with Doxygen"
    VERBATIM
  )
elseif(FADAKA_BUILD_DOCS)
  message(WARNING "Doxygen not found. Docs will not be generated.")
endif()
