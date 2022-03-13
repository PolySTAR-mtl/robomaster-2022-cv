cmake_minimum_required(VERSION 3.0.2)
project(tracking)

## Find catkin macros and libraries
find_package(catkin REQUIRED COMPONENTS
  rospy
  std_msgs
  sensor_msgs
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

###################################
## catkin specific configuration ##
###################################

catkin_package(
  CATKIN_DEPENDS detection
)

###########
## Build ##
###########

# This is a pure python node (so far), no build to do

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
