cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

project(Fadakablockchain VERSION 1.0 LANGUAGES CXX)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find dependencies
find_package(oatpp 1.3.0 REQUIRED)
find_package(OpenSSL REQUIRED)

# Include directories
include_directories(${OATPP_INCLUDE_DIRS} ${OPENSSL_INCLUDE_DIR})

# Add the executable
add_executable(Fadakablockchain main.cpp)

# Link libraries
target_link_libraries(Fadakablockchain ${OATPP_LIBRARIES} ${OPENSSL_LIBRARIES})
