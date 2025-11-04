# stdstates

## Overview
The `stdstates` is a ROS 2 library designed to facilitate code reuse for state management and auxiliary functionalities in eVTOL ITAs drone projects.

## Structure
The library consists of the following components:

- **CMakeLists.txt**: Contains the build configuration for the library, specifying the project name, dependencies, and source files.
- **package.xml**: Defines the package metadata, including name, version, maintainers, and dependencies.
- **include/stdstates/aux/**: Contains auxiliary header files for movement control, PID control, and geometric transformations.
  - `movement.hpp`: Declares the `Movement` class for controlling movement.
  - `PidController.hpp`: Declares the `PidController` class for implementing PID control.
  - `transformations.hpp`: Declares utility functions for geometric transformations.
- **include/stdstates/states/**: Contains header files for various state classes.
  - `takeoff_state.hpp`: Declares the `TakeoffState` class for managing the takeoff process.
  - `landing_state.hpp`: Declares the `LandingState` class for handling the landing sequence.
  - `next_waypoints.hpp`: Declares the `NextWaypoints` class for managing navigation to waypoints.
- **src/**: Contains the implementation files for the declared classes and functions.

## Usage
To use the `stdstates` in your ROS 2 project, include the necessary headers in your source files:

```cpp
#include "stdstates/aux/movement.hpp"
#include "stdstates/aux/PidController.hpp"
#include "stdstates/aux/transformations.hpp"
#include "stdstates/states/takeoff_state.hpp"
#include "stdstates/states/landing_state.hpp"
#include "stdstates/states/next_waypoints.hpp"
```

## License
This project is licensed under the MIT License. See the LICENSE file for more details.