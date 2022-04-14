# ROS Architecture : Detection node

The detection node is implemented using the YOLO (You Only Look Once) algorithm, as to extract the
bounding boxes, class and confidence of the detected objects. For more information, check out the
documentation in the `detection` folder.

We rely on the Darknet library to train and run the inference on the pictures. The submodule has to be
downloaded as well as built using the Makefile with the relevant options enabled (see the
[main readme file](../readme.md)).

## Topics & mapping

The `detection` node **listens** to the following topics :

- `/camera/image_raw` : Image input from the camera stream

The `detection` node **publishes** to the following topics :

- `/detection/boxes` : Bounding boxes output

The corresponding messages are defined in the detection package (`ros_ws/src/detection/msg`).

## Parameters

The `detection` node requires the following parameters to be set :

- `~/net/datacfg` : Path to the Yolo data configuration (eg. 'dji.data')
- `~/net/config_path` : Path to the Yolo network architecture conf (eg. 'yolov3_custom.cfg')
- `~/net/weights` : Path to the Yolo weights (eg. 'yolov3_custom_best.weights')
- `~/net/labels` : Path to the class labels (eg. 'dji.names')

All paths should be absolute. Check [the sample parameters](../ros_ws/data/param-yolo.yaml)
for an example.
