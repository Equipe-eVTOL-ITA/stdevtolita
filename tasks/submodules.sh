git init

git submodule add -b release/1.15 https://github.com/PX4/px4_msgs.git src/px4_msgs
git submodule add -b 1.3.0 https://github.com/Auterion/px4-ros2-interface-lib.git src/px4_ros2_interface
git submodule add -b main https://github.com/Equipe-eVTOL-ITA/fsm.git src/fsm
git submodule add https://github.com/Equipe-eVTOL-ITA/camera_publisher.git src/camera_publisher
git submodule add https://github.com/Equipe-eVTOL-ITA/custom_msgs.git src/custom_msgs
git submodule add https://github.com/Equipe-eVTOL-ITA/drone_lib.git src/drone_lib

git submodule update --init --recursive