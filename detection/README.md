# Architecture

. <br>
├── README.md <br>
├── DeepStream-Yolo # External lib, you should follow the procedure mentioned in the README and run inference from here <br>
├── darknet # External lib, You should just modify the Makefile as you need it before building <br>
├── data # where the data for training/testing should be ! <br>
│   ├── backup/ <br>
│   ├── dji.data <br>
│   ├── dji.names <br>
│   ├── labels/ <br>
│   ├── test_data.txt <br>
│   ├── train_data.txt <br>
│   └── yolov3_custom.cfg <br>
├── data_processing # Contains file to process data <br>
│   └── label_processing.py <br>
├── dataset # Directory to put the datasets <br> 
│   └── robomaster_Central China Regional Competition <br>
│&nbsp;&nbsp;&nbsp;&nbsp;   ├── image/ <br>
│&nbsp;&nbsp;&nbsp;&nbsp;   ├── image_annotation/ <br>
│&nbsp;&nbsp;&nbsp;&nbsp;   ├── labels/ <br>
│&nbsp;&nbsp;&nbsp;&nbsp;   ├── robomaster_Central China Regional Competition.txt <br>
├── exemple # Some example of prediction over a video <br>
│&nbsp;&nbsp;&nbsp;&nbsp;├── vid_test.mp4 <br>
│&nbsp;&nbsp;&nbsp;&nbsp;└── vid_test_pred.avi <br>
└── patch # directory with files to patch camera issue <br>
&nbsp;&nbsp;&nbsp;&nbsp;├── Makefile <br>
&nbsp;&nbsp;&nbsp;&nbsp;└── deepstream_source_bin.c <br>

# Note before beginning

This doc is thought to detail how detection part was trained/tested both on computer using a GPU or on Jetson WITHOUT using ROS. 
If you want to have the setup with ROS, please check https://github.com/PolySTAR-mtl/robomaster-2022-cv/edit/main/doc/ros_from_scratch.md.

# Small note on submodules

The `darknet` [repository](git@github.com:AlexeyAB/darknet.git) is included as a git submodule. In
order to download the submodule on your machine, execute the following commands :

```bash
git submodule init  # Create submodule index
git submodule update  # Download the actual submodules
```

A git submodule is basically just a pointer to a specific commit from another repo.

# How to use

## Summary

* [Setting up darknet environment](#setting-up-darknet-environment)
* [Preparing for training the model](#preparing-for-training-the-model)
  * [Pre-processing](#pre-processing)
  * [A note on the labels](#a-note-on-the-labels)
  * [Configuration files](#configuration-files)
  * [How to generate train and test txt files](#how-to-generate-train-and-test-txt-files)
  * [Moving images to data](#moving-images-to-data)
  * [Downloading pre-trained weights](#downloading-pre-trained-weights)
  * [Running train](#running-train)
  * [Train Results](#train-results)
* [Inference](#inference)
  * [Darknet](#darknet) 
  * [Deployment on Jetson](#deployment-on-jetson)
  * [Inference Results](#inference-results)
* [Benchmark](#benchmark)
* [Where to go from here](#where-to-go-from-here)

## Setting up darknet environment

First, you need to install OpenCV (if it's not on the system already). You can check here: https://vitux.com/opencv_ubuntu/ to build it from source (more realiable!).
Then, you need to `make` the darknet repository on your system to use it.
Generally, you should set the flags `GPU`, `CUDNN`, `CUDNN_HALF`, `OPENMP` and `OPENCV` to `1` depending if you can actually use them. `LIBSO` might need to be setup to `1` on your machine (not the case everytime, try and see!). To run on Jetson, you will need to set all of them (including `LIBSO`) to `1` to build darknet. See https://pjreddie.com/darknet/install/ for more information.
You also need to change the `ARCH=` flag in order to set the configuration used of your system (for Jetson Xavier: `ARCH= -gencode arch=compute_72,code=[sm_72,compute_72]`)

## Preparing for training the model

### Pre-processing

The pre-processing consists of two steps: 1) using `image_zooming.py` in order to generate 'zoomed' versions of the dji_roco dataset to simulate what a robot would see (in practice, we parse each xml file and cut out part of the image based on available bounding box), 2) process the images to generate the labels that YOLO expects with `label_processing.py`. First, you should download the cleaned dataset from the drive (RoboMaster -> Equipe-Computer vision -> dataset -> dji_roco_clean -> raw) and extract everything in the dataset directory. Be careful, it should keep for each `robomaster_XXXX.zip` the same structure as the dataset directory that is shown above (minus the `labels/` and `XXX.txt` that are generated after executing `label_processing.py`). You can then execute the script mentioned above in the correct order. You should end up with the structure of the `dataset` directory you can see in the tree above. You also have files examples you would obtain. The notation we used is that for instance `AllianceVsArtisans_BO2_2_1` is the original image/xml file from dji_roco, and any generated data from `image_zooming.py` will be named `AllianceVsArtisans_BO2_2_1_X` where X is an integer.

Here, an example of images obtained after using `image_zooming.py`. All images are included in the train data. The big image is the original data we have from DJI. We crop the image around the robots using their bounding box to get 'zoomed' version which simulate what the robot could see in deployment settings.

![AllianceVsArtisans_BO2_2_1](https://user-images.githubusercontent.com/31957192/160457671-9fa5f0c2-7fbb-4f44-a2bf-e466756f9432.jpg)
![AllianceVsArtisans_BO2_2_1_0](https://user-images.githubusercontent.com/31957192/160457672-a8250c62-75ee-46ea-821b-d38c37344e7a.jpg)
![AllianceVsArtisans_BO2_2_1_1](https://user-images.githubusercontent.com/31957192/160457802-96a9695e-6a73-4407-9076-2864fdadef9c.jpg)
![AllianceVsArtisans_BO2_2_1_5](https://user-images.githubusercontent.com/31957192/160457731-b6248a2e-029d-48ab-8ba6-0af3bf6748c3.jpg)
![AllianceVsArtisans_BO2_2_1_2](https://user-images.githubusercontent.com/31957192/160457739-8e9c015e-960d-46d9-9c7f-11d215f39963.jpg)
![AllianceVsArtisans_BO2_2_1_3](https://user-images.githubusercontent.com/31957192/160457740-6c30bddb-6a91-41b9-9915-4516c805ea12.jpg)
![AllianceVsArtisans_BO2_2_1_4](https://user-images.githubusercontent.com/31957192/160457742-9655e406-c433-4d94-91f7-3fe83cc02960.jpg)

### A note on the labels

Currently, we only consider the following class: `classes = ["red_armor", "blue_armor", "grey_armor", "base", "watcher", "car"]` (see `label_processing.py`), where "car" means robot for dji. If you want to include more classes, just add them in this list. However, any string you add in this list should be in the .xml file provided by dji (in `image_annotation/`). Here, we don't distinguish in between robots type (standard, hero, engineer...). If you want to include them, you should use the armor number and thus modify the scripts.

### Configuration files

In `data/`, you currently have two configuration files for the data (`dji.names` and `dji.data`), one for the model `yolov3_custom.cfg`. `dji.names` describes your class (so change it if you change the classes!), `dji.data` contains the path to important files for YOLO, such as your train/test files list. The `train_data.txt` and `test_data.txt`  contains the list of the images used in the training and testing. The `backup` directory is where the weights of the model are saved during training.

### How to generate train and test txt files

A simple way is to pull together the "XXXX.txt" files of each dataset (for instancem `robomaster_Central China Regional Competition.txt`), obtain after using `label_processing.py`.
This will give you a global list of files `glob.txt`. You can then shuffle this file (for instance, using cmd such as `cat glob.txt | shuf > glob_shuf.txt`) and then generate train/test list by taking a ~0.8/0.2 ratio (for instancem using `head -n X glob_shuf.txt > train_data.txt` where X is an integer of 80% of the number of lines of `glob_shuf.txt`).

### Moving images to data

You can then copy all processed data in `image/` and `labels/` from each dataset from `dataset/` at the root of `data/` (so, no sub directory such as `robomaster_Central China Regional Competition/`).

### Downloading pre-trained weights

Training from scratch would take too much time, so generally pre-trained weights are used. It is basically the weights of a model trained on another image dataset.
Check https://github.com/AlexeyAB/darknet#pre-trained-models and scroll to the 'Yolo v3 models', unroll and download `yolov3.weights`. You can leave it at the root of `detection/`

Note that if you choose to change Yolo version, you can find here basic .cfg file and pre-trained weights for all Yolo versions.

Congrats, you are ready to train the model!

### Running train

You can then use the command, when you are at the root of `detection/`:

`./darknet/darknet detector train data/dji.data data/yolov3_custom.cfg yolov3.weights -map`

`-map` allows to evaluate mAP (mean Average Precision) on a test dataset (if such dataset path was given in `dji.data`)
See: https://github.com/AlexeyAB/darknet#how-to-use-on-the-command-line if you want to see how the command line of darknet works
If you want more information on how to parametrize the ".cfg" file of the model or how everything works, check https://github.com/AlexeyAB/darknet/wiki => the colab at the beginning talking about Detection/Traning!

WARNING: The training will take several hours, even on GPU. Make sure you have a computer that can do so! Even on the Jetson, it will be slow!

### Train Results

Here the kind of chart you should obtain in the end, blue being the loss function score (ideally, we want to have it like this around 1) and in red the mAP score.
![chart_yolov3_custom](https://user-images.githubusercontent.com/31957192/160454134-82696932-78b6-48c8-a920-05326fbb5bfe.png)


## Inference

### Darknet

You can first try to check the results using darknet framework. Be careful though, the FPS (Frame Per Seconds, that is, how many detections are done in a second) you will get won't reflect the FPS you will get on the Jetson (it is just for testing). 

Benchmark we did show between 7-10 FPS using this (which is far from ideal, since we would like around 20 FPS minimum, 30 FPS being real time).

To test the model based on the configuration that already exists, you can download the weights avaiable on the drive (RoboMaster -> Equipe-Computer vision -> weights -> yolov3_custom_best.weights). On the same path you also have the .cfg file used (same as the one presented in the tree).

Command example (to execute at the root of `detection/`):

`./darknet/darknet detector test data/dji.data data/yolov3_custom.cfg data/backup/yolov3_custom_best.weights data/WMJVsWolfTooth_BO2_2_368.jpg`

which could yield something similar to:

![predictions](https://user-images.githubusercontent.com/31957192/160458374-5e2c4bc6-3b60-4a37-99e0-2b90fb732eed.jpg)

This run the model to infer on a given image in the `data/` directory.

`./darknet/darknet detector demo data/dji.data data/yolov3_custom.cfg data/backup/yolov3_custom_best.weights example/vid_test.mp4 -out_filename exemple/vid_test.avi`

This allows to generate the prediction over the video in `exemple/` (some clip from DJI video found on their Twitch channel). Can be a good first trial to evaluate your model on 'real' data!


![vid_test_pred_gif](https://user-images.githubusercontent.com/31957192/160458417-14272412-5472-4f37-9889-e7c02a704159.gif)

Check  https://github.com/AlexeyAB/darknet#how-to-use-on-the-command-line and https://github.com/AlexeyAB/darknet for more information!

## Deployment on Jetson

As mentioned in the previous section, we need to optimize the network to yield good performance on the Jetson. To do so, we will use DeepStream which is a Software Development Kit (SDK) developped by NVIDIA to run AI app on Jetson with better performance (since it is optimized for it!). See for more information: https://developer.nvidia.com/deepstream-sdk

We will actually use a wrapper of this SDK which allow to automatically parse and optimize Darknet network. The repository is: https://github.com/marcoslucianops/DeepStream-Yolo

Follow requirements to install dependencies. In the case of simple Yolov3, everything should be installed on the Jetson already (but, if needed, here the getting started for Jetson NX: https://developer.nvidia.com/embedded/learn/get-started-jetson-xavier-nx-devkit to install *JetPack 4.6.1* and https://developer.nvidia.com/deepstream-sdk to install *DeepStream SDK*. If you did the submodule command at the beginning, you should have *DeepStream-Yolo* installed already. 

You might need to add to the path the cuda library. To do that, add at the end of the `~/.bashrc` the following lines and restart the terminal:

```
export PATH="/usr/local/cuda-10.2/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-10.2/lib64:$LD_LIBRARY_PATH"
```

Just follow the DeepStream-Yolo repostiory instructions: https://github.com/marcoslucianops/DeepStream-Yolo#basic-usage to see how it works. DON'T FORGET TO ACTUALLY BUILD INSIDE DEEPSTREAM-YOLO REPOSITORY: `CUDA_VER=10.2 make -C nvdsinfer_custom_impl_Yolo`, otherwise it will fail!

To test the installation, just put the *.weights* and *.cfg* previously trained in the DeepStream-Yolo repository. Modify the `labels.txt` file in the repostiory by putting the labels (corresponds to the `dji.names` file in darknet training). Then, modify the `config_infer_primary.txt` file as follow:

```
[property]
...
# 0=RGB, 1=BGR, 2=GRAYSCALE
model-color-format=0

# YOLO cfg, insert the name of the .cfg
custom-network-config=yolov3_custom.cfg

# YOLO weights, same but for .weights
model-file=yolov3_custom_best.weights

# Generated TensorRT model (will be created if it doesn't exist)
# This is the new optimized network DeepStream will create/use
# *b1* corresponds to batch size (since we are in inference mode, leave to 1)
# *gpu0* which gpu to use, we only have one on Jetson so leave as it is
# *fp16* what precision to use for the variable. It has to be consistent with *network-mode* below
# FP16 means precision is reduced to Float 16 bits instead of Float 32 bits. 
# It will slightly lower accuracy but drastically improve performance!
model-engine-file=model_b1_gpu0_fp16.engine

# Model labels file (dji.names of darknet), either update *labels.txt* or put *dji.names* in the repository and modify this line
labelfile-path=labels.txt

# Batch size
batch-size=1

# 0=FP32, 1=INT8, 2=FP16 mode
# The precision we talked earlier
network-mode=2

# Number of classes in label file
num-detected-classes=6
...
[class-attrs-all]
# You can modify IOU and Confidence threshold here
# But we can leave default
# IOU threshold
nms-iou-threshold=0.6
# Socre threshold
pre-cluster-threshold=0.25
```

Once it is done, you can test on the *vid_test.mp4* from the example file, either by putting it at the root of DeepStream-Yolo or by changing the file path. You just need to change a few things in the *deepstream_app_config.txt* file:


```
[tiled-display]
...
# Just control the display, no need to change it
# But you can probably set the same value as in [streammux] below
# for debugging purposes
width=1280
height=720
...
[source0]
enable=1
type=3
# Here change the source. Don't forget to put the '/'!
uri=file:/vid_test.mp4 # or put the location of the video, without forgetting '/'
num-sources=1
gpu-id=0
cudadec-memtype=0
...
[streammux]
...
width=416 #Put YOLO input width/height
height=416
...
```

As explained in DeepStream-Yolo doc, you can then run `deepstream-app -c deepstream_app_config.txt`

After testing it works on a video, it is time to connect the Raspberry-Pi camera. Make sure to connect it to the CAM0 slot BEFORE turning on the Jetson. You can verify it is recognized by the Jetson by checking that `ls /dev/video0` returns something. Then, get the camera parameters by running `v4l2-ctl -d /dev/video0 --list-formats-ext` and write down the output couple size/fps desired (for instance: 1920x1080 (30 FPS)). The library `v4l` should be install on the Jetson, if not run `sudo apt-get install v4l-utils`. You can now change the *deepstream_app_config.txt* to take into account the camera:

```
...
[source0]
enable=1
type=5 # CSI camera type
# Modify height, width and fps based on what you wrote down earlier
camera-width=1920 
camera-height=1080
camera-fps-n=30
# number of inference return, leave to 1
camera-fps-d=1
# which camera slot
camera-v4l2-dev-node=0
num-sources=1
gpu-id=0
cudadec-memtype=0
...
[streammux]
...
# Set livesource to 1 instead of 0
livesource=1
width=416 #Put YOLO input width/height
height=416
```

You can then run the same command as with the video. We found that one camera gave a flipped image. If the problem is still there you will have to patch it. To patch it, you will need to take the files *deepstream_source_bin.c* and *Makefile* from the `patch/` directory and paste the first one in `/opt/nvidia/deepstream/deepstream-6.0/sources/apps-common/src/` and the second one in `opt/nvidia/deepstream/deepstream-6.0/sources/sample_apps/deepstream-app/`. For reference, the files were modified following this fix: https://forums.developer.nvidia.com/t/jetson-nano-csi-raspberry-pi-camera-v2-upside-down-video-when-run-an-example-with-deepstream-app/82077/7?u=utilisateur1813. Then you just need to `sudo CUDA_VER=10.2 make` from inside `opt/nvidia/deepstream/deepstream-6.0/sources/sample_apps/deepstream-app/` to compile the changes and then `sudo CUDA_VER=10.2 make install` to put the bin correctly. With this, the video stream should be normal again.

// TODO: Add the way to get inference!


### Inference Results
Here the results (Top is DeepStream optimized inference, Bottom is base Darknet Inference):
![image](https://user-images.githubusercontent.com/31957192/160440797-e2077011-10d1-4ed3-9aba-0dc321895935.png)
![image](https://user-images.githubusercontent.com/31957192/160440818-4c59f1b0-002f-4ef8-8c1d-130d187074f7.png)

We can see we managed to improve drastically the performance, going from ~10 FPS to over 30 FPS!

## Benchmark

Here adding a benchmark to compare to future model (add as new model are tried):

**Jetson Xavier NX**

*Yolov3 (2021-2022 Polystar version)*

|                       | Darknet | DeepStream <br> (Darknet weights) <br> 32FP | DeepStream <br> (Darknet weights) <br> 16FP |
|:---------------------:|:----------:|:-------:|:-------:|
| FPS  | 8.5      | 15   | 36   |

(TODO: ADD mAP and recalculate on 32FP to be sure)



## Where to go from here?

Here I will list down what could be improved from what we did in the detection:

* Improvement over Yolov3: We used Yolov3 as it was a simple and straight forward model with relative good performance (mAP and FPS), but feel free to explore more recent model (Yolov5...). Keep in mind you will have a trade-off to decide between mAP/FPS (especially with the Jetson)
* Improvement over the class used: We considered so far only 6 classes, that is the 3 types of target (any robot, base and sentry), as well as the armor colours (red, blue and gray). We only used the armor colours to track our target without paying attention to the type of robots, but it could be taken into account for the decision/tracking. You could also expand on the data processing we have made and include as classes the type of robots based on the armor number (ex: '1' is engineer, '2' is hero....)
* Improvement over data processing: Since we didn't have access to any kind of data matching what the camera of the robot would see, we simulated them by 'zooming' on those image (see `data_processing/image_zooming.py`). You could add more level of zoom to have more 'fine-grained' predictions. (TO DO: ADD A PART ABOUT LIGHTHING CONDITION, ROTATED IMAGE...)
* Wrapping the library: Currently, we use two different external library. It could be good to wrap everything in one package. It could also allow you to customize some function in order to adapt to your need or fit better with ROS.


