# PolySTAR - CV Robomaster 2023

Work repository for the Computer Vision team

## Introduction

This repository contains the work of PolySTAR's computer vision team for the 2023 RoboMaster
competition, organized by DJI. Based on last year's repo.

For a step by step example of how to run the code on Jetson, please check [here](https://github.com/PolySTAR-mtl/robomaster-2022-cv/blob/main/doc/pipeline_on_jetson_from_scratch.md)

## Repo organization

- `doc/` : General & specific documentation about our work. Everything should be documented ;)
- `ros_ws/` : ROS workspace. This directory contains everything needed to run the detection
- `detection/` : CV dataset pre-processing & training

## Requirements

### ROS

- ROS melodic / noetic
- ROS packages
  - `ros-<ros-distribution>-cv-bridge`
  - `ros-<ros-distribution>-image-view`
  - `ros-<ros-distribution>-vision-opencv`
  - `ros-<ros-distribution>-camera-info-manager`
  - `ros-<ros-distribution>-video-stream-opencv`
- OpenCV & Python bindings

### Detection

This project relies on the `darknet` library to train/test the model as well as the `deepstream` library to run on Jetson.
`darknet` is included as a [submodule](https://github.com/PolySTAR-mtl/robomaster-2022-cv/blob/main/detection/README.md#small-note-on-submodules) and `deepstream` is already installed on the Jetson. They are both required
to build the ROS workspace. 

To setup darknet, please check [here](https://github.com/PolySTAR-mtl/robomaster-2022-cv/blob/main/detection/README.md#setting-up-darknet-environment). To train/test the model with `darknet` on computer, please check [here](https://github.com/PolySTAR-mtl/robomaster-2022-cv/blob/main/detection/README.md#preparing-for-training-the-model). 

If `deepstream` is already installed, you still need to add up a wrapper to run darknet model, check [here](https://github.com/PolySTAR-mtl/robomaster-2022-cv/blob/main/detection/README.md#deployment-on-jetson)

## Code guidelines

Please format your code before commiting :

- For C++ code, a `.clang-format` file is at the root of the ROS workspace to ensure consistency.
- Python code is formatted using `autopep8`

## Datasets & Training

**TODO**
