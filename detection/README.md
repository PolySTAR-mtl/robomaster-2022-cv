# Detection

## Architecture

. <br>
├── AllianceVsArtisans_BO2_2_1.jpg <br>
├── AllianceVsArtisans_BO2_2_1.xml <br>
├── README.md <br>
├── darknet # External lib, You should just modify the Makefile as you need it before building <br>
│   ├── 3rdparty <br>
│   ├── CMakeLists.txt <br>
│   ├── DarknetConfig.cmake.in <br>
│   ├── LICENSE <br>
│   ├── Makefile <br>
│   ├── README.md <br>
│   ├── backup <br>
│   ├── build <br>
│   ├── build.ps1 <br>
│   ├── cfg <br>
│   ├── cmake <br>
│   ├── darknet <br>
│   ├── darknet.py <br>
│   ├── darknet_images.py <br>
│   ├── darknet_video.py <br>
│   ├── data <br>
│   ├── image_yolov3.sh <br>
│   ├── image_yolov4.sh <br>
│   ├── include <br>
│   ├── json_mjpeg_streams.sh <br>
│   ├── net_cam_v3.sh <br>
│   ├── net_cam_v4.sh <br>
│   ├── obj <br>
│   ├── results <br>
│   ├── scripts <br>
│   ├── src <br>
│   ├── vcpkg.json <br>
│   ├── video_yolov3.sh <br>
│   └── video_yolov4.sh <br>
├── data # where the data for training/testing should be ! <br>
│   ├── backup <br>
│   ├── dji.data <br>
│   ├── dji.names <br>
│   ├── test_data.txt <br>
│   ├── train_data.txt <br>
│   └── yolov3_custom.cfg <br>
├── data_processing # Contains file to process data <br>
│   └── label_processing.py <br>
└── dataset # Directory to put the datasets <br> 
&nbsp;&nbsp;&nbsp;&nbsp;└── robomaster_Central China Regional Competition <br>

## Small note on submodules

The `darknet` [repository](git@github.com:AlexeyAB/darknet.git) is included as a git submodule. In
order to download the submodule on your machine, execute the following commands :

```bash
git submodule init  # Create submodule index
git submodule update  # Download the actual submodules
```

A git submodule is basically just a pointer to a specific commit from another repo.

## How to use

You need to `make` the darknet repository on your system to use it.
You should only set the flags `GPU`, `CUDNN` and `OPENCV` to `1` depending if you actually use them. See https://pjreddie.com/darknet/install/ for more information.
You also need to change the `ARCH=` flag in order to set the configuration used of your system (for Jetson Xavier: `ARCH= -gencode arch=compute_72,code=[sm_72,compute_72]`)

To train, either put all the raw dataset into the `dataset` directory and modify `label_processing.py`. Otherwise, unpack the archive of the clean dji_roco dataset (TO BE ADDED SOMEWHERE). Copy/Paste all the images and .xml files into `data`.

In `data`, you currently have two configuration files for the data (`dji.names` and `dji.data`), one for the model `yolov3_custom.cfg`. The `train_data.txt` and `test_data.txt` contains the list of the images used in the training and testing. The `backup` directory is where the weights of the model are saved during training.

Command example (to execute at the root of `detection`):

`./darknet/darknet detector test data/dji.data data/yolov3_custom.cfg data/backup/yolov3_custom_1000.weights data/WMJVsWolfTooth_BO2_2_368.jpg`

This run the model to infer on a given image.
Check https://github.com/AlexeyAB/darknet for more information!

Note: If you need to change the class to be recognised, you need to change multiple things (sorry!). `label_processing.py`: you need to change here the variable `classes` and rerun the script. You also need to edit the configuration files `dji.names`, `dji.data` and `yolov3_custom.cfg`. For those 3 files, check https://github.com/AlexeyAB/darknet/wiki => the colab at the beginning talking about Detection/Traning!


