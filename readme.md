# PolySTAR - CV Robomaster 2022

Work repository for the Computer Vision team

## Introduction

This repository contains the work of PolySTAR's computer vision team for the 2022 RoboMaster
competition, organized by DJI.

## Repo organization

- `doc/` : General & specific documentation about our work. Everything should be documented ;)
- `ros_ws/` : ROS workspace. This directory contains everything needed to run the detection
- `detection/` : CV dataset pre-processing & training

## Requirements

### ROS

- ROS noetic
  - **TODO** List of ROS packages
- OpenCV & Python bindings

### Detection

This project relies on the `darknet` library, which is included as a submodule. It is required
to build the ROS workspace. You can either install the library (`make install`) in a common
place, or specify the path of the CMakeLists.txt file when building :

```bash
catkin_make -DDARKNET_PATH=../detection/darknet
```

**TODO** : list of package requirements

## Code guidelines

Please format your code before commiting :

- For C++ code, a `.clang-format` file is at the root of the ROS workspace to ensure consistency.
- Python code is formatted using `autopep8`

## Datasets & Training

**TODO**
