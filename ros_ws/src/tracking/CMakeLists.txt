cmake_minimum_required(VERSION 3.0.2)
project(tracking)

## Find catkin macros and libraries
find_package(catkin REQUIRED COMPONENTS
  rospy
  std_msgs
  sensor_msgs
<<<<<<< HEAD:ros_ws/src/tracking/CMakeLists.txt
  message_generation
  detection
)

catkin_python_setup()

## ----- Messages ----- ##

## Generate messages in the 'msg' folder
add_message_files(
  FILES
  Tracklet.msg
  Tracklets.msg
)

generate_messages(
  DEPENDENCIES
  std_msgs
)
=======
  detection
  cv_bridge
)

find_package(OpenCV)

>>>>>>> main:ros_ws/src/monitor/CMakeLists.txt

###################################
## catkin specific configuration ##
###################################

catkin_package(
<<<<<<< HEAD:ros_ws/src/tracking/CMakeLists.txt
=======
  INCLUDE_DIRS include
>>>>>>> main:ros_ws/src/monitor/CMakeLists.txt
  CATKIN_DEPENDS detection
)

###########
## Build ##
###########

<<<<<<< HEAD:ros_ws/src/tracking/CMakeLists.txt
# This is a pure python node (so far), no build to do
=======
## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
  include
  ${catkin_INCLUDE_DIRS}
  ${OpenCV_INCLUDE_DIRS}
)

add_executable(monitor_video
  src/monitor_video_node.cpp
  src/video_monitor.cpp
)

target_link_libraries(monitor_video
  ${catkin_LIBRARIES}
  ${OpenCV_LIBRARIES}
)

add_executable(monitor_logger
  src/monitor_logger.cpp
)

target_link_libraries(monitor_logger
  ${catkin_LIBRARIES}
)
>>>>>>> main:ros_ws/src/monitor/CMakeLists.txt

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
