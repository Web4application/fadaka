cmake_minimum_required(VERSION 3.10)
project(oracle-client LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)

find_package(oatpp REQUIRED)
find_package(oatpp-curl REQUIRED)

add_executable(oracle-client main.cpp)

target_link_libraries(oracle-client
    oatpp::oatpp
    oatpp::oatpp-curl
)
