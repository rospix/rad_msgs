cmake_minimum_required(VERSION 3.1.2)
project(rad_msgs)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(catkin REQUIRED COMPONENTS
  message_generation
  roscpp
  std_msgs
  std_srvs
  sensor_msgs
  geometry_msgs
  cmake_modules
  )

add_message_files(DIRECTORY msg/misc FILES

  Vector3.msg
  )

add_message_files(DIRECTORY msg/compton_camera FILES

  ClusterList.msg
  Cluster.msg
  Pixel.msg
  Cone.msg
  )

add_message_files(DIRECTORY msg/timepix FILES

  TimepixImage.msg
  RospixStatus.msg
  )

add_service_files(DIRECTORY srv/timepix FILES

  RospixBatchExposure.srv
  RospixExposure.srv
  )

add_service_files(DIRECTORY srv/general FILES

  SetDouble.srv
  SetInt.srv
  )

## Generate added messages and services with any dependencies listed here
generate_messages(DEPENDENCIES

  std_msgs
  geometry_msgs
  sensor_msgs
  )

catkin_package(
  CATKIN_DEPENDS roscpp std_msgs geometry_msgs message_runtime sensor_msgs
  LIBRARIES rad_msgs
  )

include_directories(
  ${catkin_INCLUDE_DIRS}
  )

add_library(rad_msgs src/main.cpp)

add_dependencies(rad_msgs
  ${${PROJECT_NAME}_EXPORTED_TARGETS}
  ${catkin_EXPORTED_TARGETS}
  )

target_link_libraries(rad_msgs
  ${catkin_LIBRARIES}
  )

add_custom_command(TARGET rad_msgs
  PRE_BUILD
  WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
  COMMAND bash -c "${CMAKE_CURRENT_SOURCE_DIR}/link_msg_files.sh"
  )
