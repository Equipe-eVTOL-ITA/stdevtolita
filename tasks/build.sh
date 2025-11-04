#!/bin/bash
set -e

# ========== VARIABLES ==========

WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGES=("nome-do-pacote-1" "nome-do-pacote-2")

# ===============================


if [ $# -ne 1 ]; then
    echo "Usage: $0 <targets>"
    exit 1
fi

if [ $1 = all ]
then
    BUILD_PATH=""
elif [ $1 = dependencies ]
then
    BUILD_PATH="--paths src/px4_msgs/* src/fsm/* src/custom_msgs src/px4_ros2_interface/*"
elif [ $1 = custom_msgs ]
then
    # it is necessary to delete custom_msgs build, install and log folders to avoid conflicts
    rm -rf ~/${WORKSPACE_DIR}/build/custom_msgs ~/${WORKSPACE_DIR}/install/custom_msgs ~/${WORKSPACE_DIR}/log/custom_msgs
    BUILD_PATH="--paths src/custom_msgs"
elif [[ " ${PACKAGES[@]} " =~ " $1 " ]] # verify if the argument is in the PACKAGES array
then
    BUILD_PATH="--paths src/$1/*"
else
    exit 1
fi

source /opt/ros/humble/setup.bash

if [ -e install/setup.bash ]
then
    source install/setup.bash
else
    source /opt/ros/humble/setup.bash
fi

# Set the default build type
BUILD_TYPE=RelWithDebInfo
colcon build \
    --symlink-install \
    --cmake-args "-DCMAKE_BUILD_TYPE=$BUILD_TYPE" "-DCMAKE_EXPORT_COMPILE_COMMANDS=On" \
    -Wall -Wextra -Wpedantic \
        $BUILD_PATH --executor sequential --allow-overriding custom_msgs