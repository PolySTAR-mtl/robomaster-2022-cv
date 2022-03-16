# Architecture

. <br>
├── README.md <br>
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
└── dataset # Directory to put the datasets <br> 
│   └── robomaster_Central China Regional Competition <br>
│&nbsp;&nbsp;&nbsp;&nbsp;   ├── image/ <br>
│&nbsp;&nbsp;&nbsp;&nbsp;   ├── image_annotation/ <br>
│&nbsp;&nbsp;&nbsp;&nbsp;   ├── labels/ <br>
│&nbsp;&nbsp;&nbsp;&nbsp;   ├── robomaster_Central China Regional Competition.txt <br>
└── exemple # Some example of prediction over a video <br>
&nbsp;&nbsp;&nbsp;&nbsp;├── vid_test.mp4 <br>
&nbsp;&nbsp;&nbsp;&nbsp;└── vid_test_pred.avi <br>

# Small note on submodules

The `darknet` [repository](git@github.com:AlexeyAB/darknet.git) is included as a git submodule. In
order to download the submodule on your machine, execute the following commands :

```bash
git submodule init  # Create submodule index
git submodule update  # Download the actual submodules
```

A git submodule is basically just a pointer to a specific commit from another repo.

# How to use

## Setting up darknet environment

First, you need to install OpenCV (if it's not on the system already). You can check here: https://vitux.com/opencv_ubuntu/ to build it from source (more realiable!).
Then, you need to `make` the darknet repository on your system to use it.
You should only set the flags `GPU`, `CUDNN` and `OPENCV` to `1` depending if you actually use them. See https://pjreddie.com/darknet/install/ for more information.
You also need to change the `ARCH=` flag in order to set the configuration used of your system (for Jetson Xavier: `ARCH= -gencode arch=compute_72,code=[sm_72,compute_72]`)

## Preparing for training the model

### Pre-processing

The pre-processing consists of two steps: 1) using `image_zooming.py` in order to generate 'zoomed' versions of the dji_roco dataset to simulate what a robot would see (in practice, we parse each xml file and cut out part of the image based on available bounding box), 2) process the images to generate the labels that YOLO expects with `label_processing.py`. First, you should download the cleaned dataset from the drive (RoboMaster -> Equipe-Computer vision -> dataset -> dji_roco_clean -> raw) and extract everything in the dataset directory. Be careful, it should keep for each `robomaster_XXXX.zip` the same structure as the dataset directory that is shown above (minus the `labels/` and `XXX.txt` that are generated after executing `label_processing.py`). You can then execute the script mentioned above in the correct order. You should end up with the structure of the `dataset` directory you can see in the tree above. You also have files examples you would obtain. The notation we used is that for instance `AllianceVsArtisans_BO2_2_1` is the original image/xml file from dji_roco, and any generated data from `image_zooming.py` will be named `AllianceVsArtisans_BO2_2_1_X` where X is an integer. (TODO SEE IF WE HAVE ENOUGH GDRIVE SPACE TO PUT A PROCESSED VERSION OF DATASET).

### A note on the labels

Currently, we only consider the following class: `classes = ["red_armor", "blue_armor", "grey_armor", "base", "watcher", "car"]` (see `label_processing.py`), where "car" means robot for dji. If you want to include more classes, just add them in this list. However, any string you add in this list should be in the .xml file provided by dji (in `image_annotation/`). Here, we don't distinguish in between robots type (standard, hero, engineer...). If you want to include them, you should use the armor number and thus modify the scripts.

### Configuration files

In `data/`, you currently have two configuration files for the data (`dji.names` and `dji.data`), one for the model `yolov3_custom.cfg`. `dji.names` describes your class (so change it if you change the classes!), `dji.data` contains the path to important files for YOLO, such as your train/test files list. The `train_data.txt` and `test_data.txt`  contains the list of the images used in the training and testing. The `backup` directory is where the weights of the model are saved during training.

### How to generate `train_data.txt` and `test_data.txt`

(TODO: CHANGE THE PATH IN `label_processing.py`)
A simple way is to pull together the "XXXX.txt" files of each dataset (for instancem `robomaster_Central China Regional Competition.txt`), obtain after using `label_processing.py`.
This will give you a global list of files `glob.txt`. You can then shuffle this file (for instance, using cmd such as `cat glob.txt | shuf > glob_shuf.txt`) and then generate train/test list by taking a ~0.8/0.2 ratio (for instancem using `head -n X glob_shuf.txt > train_data.txt` where X is an integer of 80% of the number of lines of `glob_shuf.txt`).

### Moving images to `data/`

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

WARNING: The training will take several hours, even on GPU. Make sure you have a computer that can do so or use the Jetson.

## Testing

If you want to just test the model based on the configuration that alreaady exists, you can download the weights avaiable on the drive (RoboMaster -> Equipe-Computer vision -> weights -> yolov3_custom_best.weights). On the same path you also have the .cfg file used (same as the one presented in the tree).

Command example (to execute at the root of `detection/`):

`./darknet/darknet detector test data/dji.data data/yolov3_custom.cfg data/backup/yolov3_custom_best.weights data/WMJVsWolfTooth_BO2_2_368.jpg`

This run the model to infer on a given image in the `data/` directory.

`./darknet/darknet detector demo data/dji.data data/yolov3_custom.cfg data/backup/yolov3_custom_best.weights example/vid_test.mp4 -out_filename exemple/vid_test.avi`

This allows to generate the prediction over the video in `exemple/` (some clip from DJI video found on their Twitch channel). Can be a good first trial to evaluate your model on 'real' data.

Check  https://github.com/AlexeyAB/darknet#how-to-use-on-the-command-line and https://github.com/AlexeyAB/darknet for more information!



