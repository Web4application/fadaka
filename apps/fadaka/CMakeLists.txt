project(FadakaApp LANGUAGES CXX)

include_directories(${PROJECT_SOURCE_DIR}/include)

add_executable(FadakaApp
    ${PROJECT_SOURCE_DIR}/src/main.cpp
    ${PROJECT_SOURCE_DIR}/src/other_source.cpp
)

target_link_libraries(FadakaApp PRIVATE TrezorCrypto)

install(TARGETS FadakaApp DESTINATION bin)
install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/ DESTINATION include)
