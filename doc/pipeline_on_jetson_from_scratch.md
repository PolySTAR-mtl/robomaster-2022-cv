# Setup from scratch on Jetson Xavier

## JetPack and DeepStream SDK

Check https://github.com/PolySTAR-mtl/robomaster-2022-cv/tree/main/detection#deployment-on-jetson to install JetPack and DeepStream SDK, as well to check how to set DeepStream-Yolo.

## Setup ssh / git conf

1. Generate sshkey (`cd ~/.ssh && ssh-keygen`). `mkdir ~/.ssh` if the directory doesn't exist.
2. Put key on github account in the `~/.ssh` directory)
3. Setup git configuration `git config --global user.name "username" && git config --global user.email "email"`

## Setup robomaster repository

First, clone the repostiory `git clone https://github.com/PolySTAR-mtl/robomaster-2022-cv.git`. Then, install [submodule](https://github.com/PolySTAR-mtl/robomaster-2022-cv/tree/main/detection#small-note-on-submodules)
and install [Darknet](https://github.com/PolySTAR-mtl/robomaster-2022-cv/tree/main/detection#setting-up-darknet-environment). You can first verify everything works with detection on it's
own by running the inference presented [here](https://github.com/PolySTAR-mtl/robomaster-2022-cv/tree/main/detection#setting-up-darknet-environment). Make sure you also properly setup up DeepStream as described [here](https://github.com/PolySTAR-mtl/robomaster-2022-cv/tree/main/detection#deployment-on-jetson). 

You can then download the weights (on our google drive in RoboMaster/Equipe-Computer vision/weights/yolov3_custom_best.weights) and put them at the root of `detection/data/`.

## Setup ros

Then, you need to install the different packages used by ROS:

`sudo apt-get install ros-<ros-distribution>-cv-bridge ros-<ros-distribution>-image-view ros-<ros-distribution>-vision-opencv ros-<ros-distribution>-camera-info-manager ros-<ros-distribution>-video-stream-opencv`

Once it is done, you can now prepare ROS by using `catkin_make -DDARKNET_PATH=../detection/darknet -DDEEPSTREAM=True` inside `ros_ws`.

*Note:* Even if Darknet is not directly used in the detection, it still need to be in the catkin_make.


*Note 2:* You might get error thrown. If so, keep doing `catkin_make -DDARKNET_PATH=../detection/darknet -DDEEPSTREAM=True` until it is gone. Problem is the link in between libraries that are not properly ordered in the CMakeLists and which need to be rethought. But it works! (just need a few retrials).

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
