# Packaging.cmake - basic CPack config
include_guard(GLOBAL)

include(CPack)

set(CPACK_PACKAGE_NAME "Fadaka")
set(CPACK_PACKAGE_VERSION ${FADAKA_VERSION})
set(CPACK_GENERATOR "ZIP;TGZ")

message(STATUS "▶ Packaging configured")
