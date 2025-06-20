cmake_minimum_required(VERSION 3.10)

project(FadakaProject VERSION 1.0 LANGUAGES C CXX)

# Set global C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Define build type if not specified
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# Add subdirectories
add_subdirectory(third_party/trezor-crypto)
add_subdirectory(apps/fadaka)
add_subdirectory(apps/oracle-client)
