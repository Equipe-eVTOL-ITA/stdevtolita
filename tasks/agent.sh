#!/bin/bash
set -e

# Source ROS2 setup first
source /opt/ros/humble/setup.bash

# Source the workspace setup if it exists
if [ -f install/setup.bash ]; then 
    source install/setup.bash
fi

echo "Starting MicroXRCE-DDS Agent for SIMULATION (UDP)"

# Add the MicroXRCE-Agent path to PATH if needed
export PATH=$PATH:/usr/local/bin

# Try different ways to run MicroXRCEAgent
if command -v MicroXRCEAgent &> /dev/null; then
    MicroXRCEAgent udp4 -p 8888
elif [ -f /usr/local/bin/MicroXRCEAgent ]; then
    /usr/local/bin/MicroXRCEAgent udp4 -p 8888
elif [ -f ~/Micro-XRCE-DDS-Agent/build/MicroXRCEAgent ]; then
    ~/Micro-XRCE-DDS-Agent/build/MicroXRCEAgent udp4 -p 8888
else
    echo "Error: MicroXRCEAgent not found. Please install it first:"
    echo "Run the setup script or install manually:"
    echo "cd ~ && git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git"
    echo "cd Micro-XRCE-DDS-Agent && mkdir build && cd build"
    echo "cmake .. && make && sudo make install && sudo ldconfig /usr/local/lib/"
    exit 1
fi