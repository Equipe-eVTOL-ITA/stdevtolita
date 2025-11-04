#!/bin/bash
set -e

WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR=$WORKSPACE_DIR/src

cd $WORKSPACE_DIR
mkdir -p $SRC_DIR

# Instala dependências do ROS e PX4
sudo apt install ros-humble-vision-msgs

# Inicializa os submódulos
if [ ! -f "$WORKSPACE_DIR/.gitmodules" ]; then
    echo "Erro: Arquivo .gitmodules não encontrado. Execute o submodules.sh antes."
    exit 1
fi

echo "Inicializando submódulos..."
git submodule update --init --recursive

# Compila o workspace
cd $WORKSPACE_DIR
source /opt/ros/jazzy/setup.bash

BUILD_TYPE=RelWithDebInfo
colcon build \
    --symlink-install \
    --event-handlers console_direct+ \
    --cmake-args "-DCMAKE_BUILD_TYPE=$BUILD_TYPE" "-DCMAKE_EXPORT_COMPILE_COMMANDS=On" \
    --executor sequential \