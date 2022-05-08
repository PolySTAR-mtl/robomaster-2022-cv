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


find_package(OpenCV)

if(DARKNET_CMAKE_PATH)
  set(CMAKE_CUDA_ARCHITECTURES 72)
  add_subdirectory(${CMAKE_SOURCE_DIR}/../${DARKNET_PATH} ${CMAKE_CURRENT_BINARY_DIR}/darknet)
  set(Darknet_LIBRARIES dark)
else()
  if(DARKNET_PATH)
    if(NOT IS_ABSOLUTE ${DARKNET_PATH})
      set(DARKNET_PATH ${CMAKE_SOURCE_DIR}/../${DARKNET_PATH})
    endif()
    set(Darknet_LIBRARIES ${DARKNET_PATH}/libdarknet.so)
    set(Darknet_INCLUDE_DIRS ${DARKNET_PATH}/include ${DARKNET_PATH}/src)
  else()
    if(NOT DEEPSTREAM)
      message("DARKNET_PATH not set, searching for darknet in the system")
      find_package(Darknet REQUIRED)
    endif()
  endif()
endif()

if(DEEPSTREAM)
  # Gstreamer
  find_package(PkgConfig) 
  pkg_search_module(GLIB REQUIRED glib-2.0) 
  pkg_search_module(GSTREAMER REQUIRED gstreamer-1.0)
  pkg_check_modules(GST_VIDEO REQUIRED gstreamer-video-1.0)
  pkg_search_module(GST_RTSP REQUIRED gstreamer-rtsp-1.0)
  pkg_check_modules(JSON_GLIB REQUIRED json-glib-1.0)

  find_package(CUDA REQUIRED)
  find_package(X11 REQUIRED)

  
  set(Deepstream_PATH /opt/nvidia/deepstream/deepstream)
  file(GLOB Deepstream_common ${Deepstream_PATH}/sources/apps/apps-common/src/*.c)

  link_directories(
    /usr/local/cuda-10.2/lib64
    ${Deepstream_PATH}/lib
  )

  add_library(deepstream-runner
    src/deepstream-app/deepstream_app_config_parser.c
    src/deepstream-app/deepstream_app_main.c
    src/deepstream-app/deepstream_app.c
    ${Deepstream_common}
  )

  target_link_libraries(deepstream-runner
    nvdsgst_meta
    nvds_meta
    nvdsgst_helper
    nvdsgst_smartrecord
    nvds_utils
    nvds_msgbroker
    nvbufsurftransform
    m
    gstrtspserver-1.0
    dl
    ${GSTREAMER_LIBRARIES}
    ${GST_VIDEO_LIBRARIES}
    ${GST_RTSP_LIBRARIES}
    ${JSON_GLIB_LIBRARIES}
    ${X11_LIBRARIES}
    ${CUDA_LIBRARIES}
  ) # That's a lot

  set(Deepstream_INCLUDE_DIRS 
    src/deepstream-app
    ${Deepstream_PATH}/sources/apps/apps-common/includes
    ${Deepstream_PATH}/sources/includes
    ${GSTREAMER_INCLUDE_DIRS}
    ${JSON_GLIB_INCLUDE_DIRS}
    ${CUDA_INCLUDE_DIRS}
    /usr/include/gstreamer-1.0
  )
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
  ${Deepstream_INCLUDE_DIRS}
  ${catkin_INCLUDE_DIRS}
  ${Darknet_INCLUDE_DIRS}
)

add_executable(detection
  src/detection_node.cpp
  src/detector.cpp
)

add_executable(deepstream_detection
  src/deepstream_node.cpp
  src/deepstream_detector.cpp
)

target_link_libraries(detection
  ${catkin_LIBRARIES}
  ${Darknet_LIBRARIES}
  ${OpenCV_LIBRARIES}
)

target_link_libraries(deepstream_detection
  ${catkin_LIBRARIES}
  deepstream-runner
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
