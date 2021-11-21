cmake_minimum_required(VERSION 3.0.2)
project(detection)

add_compile_options(-std=c++17)

## Find catkin macros and libraries
find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
  sensor_msgs
  message_generation
)

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
