cmake_minimum_required(VERSION 3.5)
project(stdstates)

# Find dependencies
find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)

# Include directories
include_directories(include)

# Declare the library
add_library(${PROJECT_NAME}
  src/movement.cpp
  src/PidController.cpp
  src/transformations.cpp
  src/takeoff_state.cpp
  src/landing_state.cpp
  src/next_waypoints.cpp
)

# Specify libraries to link against
ament_target_dependencies(${PROJECT_NAME}
  rclcpp
)

# Install the library
install(TARGETS
  ${PROJECT_NAME}
  DESTINATION lib/${PROJECT_NAME}
)

# Install header files
install(DIRECTORY include/
  DESTINATION include
)

# Export the package
ament_export_include_directories(include)
ament_export_targets(${PROJECT_NAME})
ament_export_dependencies(rclcpp)

# Package configuration
ament_package()