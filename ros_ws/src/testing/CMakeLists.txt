cmake_minimum_required(VERSION 3.0.2)
project(testing)

# Compile as C++11, supported in ROS Kinetic and newer
add_compile_options(-std=c++17)

## Find catkin macros and libraries
find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  sensor_msgs
  serial
)



###################################
## catkin specific configuration ##
###################################

catkin_package(
  CATKIN_DEPENDS serial
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
  ${catkin_INCLUDE_DIRS}
)

add_executable(serial_testing
  src/serial_testing.cpp
)

target_link_libraries(serial_testing
  ${catkin_LIBRARIES}
)

add_dependencies(serial_testing ${catkin_EXPORTED_TARGETS})
