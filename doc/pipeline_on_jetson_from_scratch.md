# Setup from scratch on Jetson Xavier

## JetPack and DeepStream SDK

Check https://github.com/PolySTAR-mtl/robomaster-2022-cv/tree/main/detection#deployment-on-jetson to install JetPack and DeepStream SDK, as well to check how to set DeepStream-Yolo.

## Setup ssh / git conf

1. Generate sshkey (`cd ~/.ssh && ssh-keygen`). `mkdir ~/.ssh` if the directory doesn't exist.
2. Put key on github account in the `~/.ssh` directory)
3. Setup git configuration `git config --global user.name "username" && git config --global user.email "email"`

## Setup robomaster repository

First, clone the repostiory `git clone https://github.com/PolySTAR-mtl/robomaster-2022-cv.git` in the `home/polystar` directory (if you do it somewhere else, you will need to change [deepstream-infer.txt](https://github.com/PolySTAR-mtl/robomaster-2022-cv/blob/main/ros_ws/data/deepstream-infer.txt) parameters). Then, install [submodule](https://github.com/PolySTAR-mtl/robomaster-2022-cv/tree/main/detection#small-note-on-submodules)
and install [Darknet](https://github.com/PolySTAR-mtl/robomaster-2022-cv/tree/main/detection#setting-up-darknet-environment). You can first verify everything works with detection on it's
own by running the inference presented [here](https://github.com/PolySTAR-mtl/robomaster-2022-cv/tree/main/detection#setting-up-darknet-environment). Make sure you also properly setup up DeepStream as described [here](https://github.com/PolySTAR-mtl/robomaster-2022-cv/tree/main/detection#deployment-on-jetson). 

You can then download the weights (on our google drive in RoboMaster/Equipe-Computer vision/weights/yolov3_custom_best.weights) and put them at the root of `detection/data/`.

## Setup ros

First, install the correct ros distribution, in Jetson case `melodic`, check [here](http://wiki.ros.org/melodic/Installation/Ubuntu).
Then, you need to install the different packages used by ROS:

`sudo apt-get install ros-<ros-distribution>-cv-bridge ros-<ros-distribution>-image-view ros-<ros-distribution>-vision-opencv ros-<ros-distribution>-camera-info-manager ros-<ros-distribution>-video-stream-opencv`

## Setup python 3.8

By default, python 3.6 is installed but the 3.8 is needed. So you will need to `sudo apt-get install python3.8 python3.8-dev` as well as to make it the defaukt python version.

```
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8
```

(we use python3 in the script, but just in case!)

While you are at it, install a few libraries that are needed for tracking:

`sudo -H python -m pip install cython setuptools scipy numpy filterpy`

## Configure ROS melodic to work with python 3.8

Skip this part if Noetic is used as ROS distribution. <br>
Otherwise,
```
sudo apt-get install python3-pip python3-yaml
sudo -H python -m pip install rospkg catkin_pkg
sudo apt-get install python-catkin-tools
```

Then, create a different repostiory `cv_bridge_catkin` and: <br>
```
catkin config -DPYTHON_EXECUTABLE=/usr/bin/python3 -DPYTHON_INCLUDE_DIR=/usr/include/python3.8 -DPYTHON_LIBRARY=/usr/lib/aarch64-linux-gnu/libpython3.8.so
catkin config --install
mkdir src
cd src
git clone -b opencv4 https://github.com/fizyr-forks/vision_opencv.git
cd ../
catkin build cv_bridge
source install/setup.bash --extend
```

For the [reference](https://medium.com/@beta_b0t/how-to-setup-ros-with-python-3-44a69ca36674).

If you get an error about missing libraries, try to install it. <br>
If you get the following error: 
```
Errors     << cv_bridge:install /home/polystar/robomaster-2022-cv/cvbridge_build_ws/logs/cv_bridge/build.install.000.log
usage: setup.py [global_opts] cmd1 [cmd1_opts] [cmd2 [cmd2_opts] ...]
   or: setup.py --help [cmd1 cmd2 ...]
   or: setup.py --help-commands
   or: setup.py cmd --help

error: option --install-layout not recognized
CMake Error at catkin_generated/safe_execute_install.cmake:4 (message):

  execute_process(/home/polystar/robomaster-2022-cv/cvbridge_build_ws/build/cv_bridge/catkin_generated/python_distutils_install.sh)
  returned error code
Call Stack (most recent call first):
  cmake_install.cmake:151 (include)


make: *** [install] Error 1
cd /home/polystar/robomaster-2022-cv/cvbridge_build_ws/build/cv_bridge; catkin build --get-env cv_bridge | catkin env -si  /usr/bin/make install; cd -
```

Go to `/home/polystar/robomaster-2022-cv/<where_you_installed_it>/python_distutils_install.sh` and remove the `--install-layout=deb`.

## Build ROS

Once it is done, you can now prepare ROS by using `catkin_make -DDARKNET_PATH=../detection/darknet -DDEEPSTREAM=True` inside `ros_ws`.

*Note:* Even if Darknet is not directly used in the detection, it still need to be in the catkin_make.

*Note 2:* If some error says some packages are not found, install them. In particular, you might get error on `jibglib` (install `libglib2.0-dev libjson-glib-dev libpurple-dev`) and `gst/rtsp-server/rtsp-server.h: No such file or directory` (install `libgstrtspserver-1.0-dev`).

*Note 3:* Some components might throw an error that `OpenCV 3` is required. Just go to their `CMakeLists.txt` and change to `OpenCV 4`.

*Note 4:* Even after that, you might get error thrown that some `.h` files are not found. If so, keep doing `catkin_make -DDARKNET_PATH=../detection/darknet -DDEEPSTREAM=True` until it is gone. Problem is the link in between libraries that are not properly ordered in the CMakeLists and which need to be rethought. But it works! (just need a few retrials).

Don't forget to  `source devel/setup.bash`.

## Launching the pipeline

Once everything is set, you can `roslaunch robomaster.launch` directly from `ros_ws`. If the `model_b1_gpu0_fp16.engine` isn't present in `detection/` it will create it, in that case might be better to create it separetly (by running `deepstream-app -c deepstream_app_config.txt` from `ros_ws/data/` for instance). Otherwise it will process accordingly.

*Note* if you get an error `what():  Could not open device /dev/ttyTHS0Permission denied`, check [here](https://github.com/PolySTAR-mtl/robomaster-2022-cv/blob/main/doc/serial.md#jetson-setup).

*Note*  if you get an error `nvbufsurftransform: Could not get EGL display connection`, you can try `unset DISPLAY` an rerun (can happend if you are connected using `ssh -X` or equivalent)

## Topics used 

(TO DO: Update if needed)

If you use `rostopic list -v` you should get:

```
Published topics:
 * /decision/target [serial/Target] 1 publisher
 * /rosout [rosgraph_msgs/Log] 3 publishers
 * /rosout_agg [rosgraph_msgs/Log] 1 publisher
 * /serial/switch [serial/SwitchOrder] 1 publisher
 * /serial/hp [serial/HP] 1 publisher
 * /detection/detections [detection/Detections] 1 publisher

Subscribed topics:
 * /serial/rune [serial/Rune] 1 subscriber
 * /rosout [rosgraph_msgs/Log] 1 subscriber
 * /detection/detections [detection/Detections] 1 subscriber
 * /serial/target [serial/Target] 1 subscriber
 ```
 
 You can check the `doc` for specific node publishers/subsribers. Basically, the `detection` node will take in images and publish on `/detection/detections` the bounding boxes. It will then get picked up by the `decision` node which will in turn publish on `/decision/target/` which is then sent to C&S using `serial` node.
