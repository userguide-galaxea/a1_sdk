The A1_SDK includes both the CONTROL_SDK and DRIVER_SDK. 
For detailed usage instructions, please refer to the documentation below. 
The URDF files can be found at install/share/mobiman/urdf. 
Details of the URDF file updates are available in the repository [URDF repository](https://github.com/userguide-galaxea/URDF).

## Software Dependency
1. Ubuntu 22.04 LTS
2. ROS Humble


## A1 eeTrackerDemo
```bash
#first terminal
source /opt/ros/humble/setup.bash
source ${ros2_ws}/install/setup.bash
sudo chmod 777 /dev/ttyACM0
ros2 launch signal_arm single_arm_node_launch.py

#second terminal
source /opt/ros/humble/setup.bash
source ${ros2_ws}/install/setup.bash
ros2 launch mobiman eeTrackerdemo_launch.py

#third terminal
source /opt/ros/humble/setup.bash
source ${ros2_ws}/install/setup.bash
python3 ${ros2_ws}/install/mobiman/share/mobiman/scripts/eeTrackerdemo.py
```

After, you can see A1 move as video display.(video path is : `resource/a1_eeTrajTrackerdemo.mp4`)

**Also, the position of arm can be displayed in RViz.**
<video width="600" controls>
  <source src="resource/a1_eeTrajTrackerdemo.mp4" type="video/mp4">
</video>

