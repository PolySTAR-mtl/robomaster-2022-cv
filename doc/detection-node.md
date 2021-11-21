# ROS Architecture : Detection node

The detection node is implemented using the YOLO (You Only Look Once) algorithm, as to extract the bounding boxes, class and confidence of the detected objects. For more information, check out the documentation (TODO).

## Topics & mapping

The `detection` node **listens** to the following topics :

- `/camera/image_raw` : Image input from the camera stream

The `detection` node **publishes** to the following topics :

- `/detection/boxes` : Bounding boxes output

The corresponding messages are defined in the detection package (`ros_ws/src/detection/msg`).

