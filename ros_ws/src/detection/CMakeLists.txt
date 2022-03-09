cmake_minimum_required(VERSION 3.0.2)
project(detection)

set(CMAKE_CXX_STANDARD 17)

## Find catkin macros and libraries
find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
  sensor_msgs
  message_generation
  cv_bridge
)

if(DARKNET_PATH)
  add_subdirectory(${CMAKE_SOURCE_DIR}/../${DARKNET_PATH} ${CMAKE_CURRENT_BINARY_DIR}/darknet)
  set(Darknet_LIBRARIES dark)
else()
  message("DARKNET_PATH not set, searching for darknet in the system")
  find_package(Darknet REQUIRED)
endif()

## ----- Messages ----- ##

## Generate messages in the 'msg' folder
add_message_files(
  FILES
  Detection.msg
  Detections.msg
)

generate_messages(
  DEPENDENCIES
  std_msgs
)


###################################
## catkin specific configuration ##
###################################

catkin_package(
  INCLUDE_DIRS include
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

add_executable(detection
  src/detection_node.cpp
  src/detector.cpp
)

target_link_libraries(detection
  ${catkin_LIBRARIES}
  ${Darknet_LIBRARIES}
)

add_dependencies(detection ${${PROJECT_NAME}_EXPORTED_TARGETS})

#############
## Testing ##
#############

## Add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_serial.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
