#!/usr/bin/env python3
"""
@file detection_test.py

@author Tzu-yi Chiu <tzuyi.chiu@gmail.com>
"""

import os
import cv2
import numpy as np
from motpy.tracker import Tracker
from detection.msg import Detections, Detection as DetectionROS

PROJECT_FOLDER = os.path.dirname(os.path.realpath(__file__))
DATASET_FOLDER = os.path.join(PROJECT_FOLDER, 'TP3_data')
VIDEO_FOLDER = os.path.join(DATASET_FOLDER, 'frames')
YOLO_FOLDER = os.path.join(PROJECT_FOLDER, 'yolo')
WEIGHTS_URL = 'https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.weights'
WEIGHTS_PATH = os.path.join(YOLO_FOLDER, 'yolov4.weights')
CONFIG_URL = 'https://raw.githubusercontent.com/AlexeyAB/darknet/master/cfg/yolov4.cfg'
CONFIG_PATH = os.path.join(YOLO_FOLDER, 'yolov4.cfg')

### YOLO ###
if not os.path.exists(YOLO_FOLDER):
    os.mkdir(YOLO_FOLDER)
if not os.path.isfile(WEIGHTS_PATH):
    logger.debug('downloading weights to' + WEIGHTS_PATH)
    urlretrieve(WEIGHTS_URL, WEIGHTS_PATH)
if not os.path.isfile(CONFIG_PATH):
    logger.debug('downloading config to' + CONFIG_PATH)
    urlretrieve(CONFIG_URL, CONFIG_PATH)
net = cv2.dnn.readNetFromDarknet(CONFIG_PATH, WEIGHTS_PATH)

def init_detections():
    """Loads the bbox provided in TP3_data/init.txt for the 1st frame
    """
    with open(os.path.join(DATASET_FOLDER, 'init.txt'), 'r') as f:
        lines = f.readlines()
    detections = []
    for line in lines:
        x, xmax, y, ymax = map(int, line.split()[2:6])
        detection = DetectionROS(x=x, y=y, w=xmax-x, h=ymax-y, confidence=1)
        detections.append(Detection(box=box,))
    return Detections(detections=detections, frame=1)

def yolo_detections(frame, img, threshold=0.3):
    """Generates bbox detections with yolo-v4.
    Adapted from https://github.com/gabilodeau/INF6804/blob/master/yolo_example.ipynb
    """
    h, w = img.shape[:2]
    scale = np.array([w, h, w, h])
    blob = cv2.dnn.blobFromImage(img, 1/255.0, (416, 416), swapRB=True, crop=False)
    net.setInput(blob)
    ln = net.getLayerNames()
    ln = [ln[i[0] - 1] for i in net.getUnconnectedOutLayers()]
    layer_outputs = net.forward(ln)

    detections = []
    for outputs in layer_outputs:
        for output in outputs:
            scores = output[5:]
            class_id = np.argmax(scores)
            conf = scores[class_id]
            if conf > threshold and class_id == 41: # cup's class id is 41
                box = output[:4] * scale
                (centerX, centerY, w, h) = box.astype('int')
                x = int(centerX - (w / 2))
                y = int(centerY - (h / 2))
                detection = DetectionROS(x=x, y=y, w=w, h=h, confidence=conf)
                detections.append(detection)
    return Detections(detections=detections, frame=frame)

def main():
    init = init_detections()
    pub = rospy.Publisher('detections', Detections, queue_size=1)
    rospy.init_node('detection_test', anonymous=False)
    r = rospy.Rate(24)
    nbframe = len(os.listdir(VIDEO_FOLDER))
    imgs = (cv2.imread(os.path.join(VIDEO_FOLDER, f'frame{frame}.jpg')) 
                for frame in range(1, nbframe+1))
    frames = iter(range(1, nbframe+1))

    while not rospy.is_shutdown():
        frame = next(frames)
        img = next(imgs)
        if frame == 1:
            detections = init_detections()
        else:
            try:
                detections = yolo_detections(frame, img)
            except StopIteration:
                break
        rospy.spin()
        pub.publish(detections)
        r.sleep()

if __name__ == '__main__':
    main()
    