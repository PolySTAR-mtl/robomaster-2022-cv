#!/usr/bin/env python3
"""
@file track.py

@author Tzu-yi Chiu <tzuyi.chiu@gmail.com>
"""

import os
import numpy as np
import rospy
from collections import defaultdict

from sensor_msgs.msg import Image
from detection.msg import Detections
from detection.msg import Detection as DetectionROS
from tracking.msg import Tracklets, Tracklet

from motpy import MultiObjectTracker, Track 
from motpy import Detection as DetectionMOT
from motpy.tracker import Tracker as TrackerMOT

class Tracking:
    def __init__(self, rate=24):
        # ROS
        rospy.init_node('tracking', anonymous=False)
        self.pub = rospy.Publisher('tracking/tracklets', Tracklets, 
                                    queue_size=1)

        # motpy - no confidence with the motion model (0.1)
        #       - more confidence with detections (5000)
        model_spec = {'order_pos': 1, 'dim_pos': 2,
                      'order_size': 0, 'dim_size': 2,
                      'q_var_size': 100., 'r_var_size': 10.,
                      'q_var_pos': 5000., 'r_var_pos': 0.1}

        matching_fn_kwargs = {'min_iou': 0.5}
        
        self.model_spec = model_spec
        self.rate = rate
        self.no_detection = True

        # One MOT per class
        self.mots = defaultdict(lambda: MultiObjectTracker(
            dt=1/rate,
            model_spec=model_spec, 
            matching_fn_kwargs=matching_fn_kwargs,
            active_tracks_kwargs={'max_staleness_to_positive_ratio': 2000}
            # no early stage, one track per tracker, always active
        ))

    def detections_callback(self, detections_ros: Detections) -> Tracklets:
        self.no_detection = False
        length = len(detections_ros.detections)
        rospy.loginfo('\n' + f' Detections ({length}) '.center(30, '='))
        class2detections = defaultdict(list) # Keys are classes (c)
        class2confs = defaultdict(list)      # Keys are classes (c)
        for detection_ros in detections_ros.detections:
            rospy.loginfo(f'\n{detection_ros}')
            detection, clss = self.det_ros2mot(detection_ros)
            class2detections[clss].append(detection)
        
        tracklets = []
        for clss in set(self.mots.keys()).union(class2detections.keys()):
            detections = class2detections[clss]
            mot = self.mots[clss]
            tracks = mot.step(detections)
            for track in tracks:
                tracklet = self.trk_mot2ros(track=track, clss=clss)
                tracklets.append(tracklet)
        
        length = len(tracklets)
        rospy.loginfo('\n' + f' Tracklets ({length}) '.center(30, '='))
        for tracklet in tracklets:
            rospy.loginfo(f'\n{tracklet}')
        tracklets = Tracklets(tracklets=tracklets)
        self.pub.publish(tracklets)
        return tracklets
        
    def det_ros2mot(self, detection: DetectionROS) -> DetectionMOT:
        box = np.array([detection.x, detection.y, 
                        detection.x + detection.w, detection.y + detection.h])
        return DetectionMOT(box=box, score=detection.score), detection.clss

    def trk_mot2ros(self, track: Track, clss: int) -> Tracklet:
        xmin, ymin, xmax, ymax = track.box
        x, y, w, h = xmin, ymin, xmax - xmin, ymax - ymin
        tracklet = Tracklet(id=track.id, x=x, y=y, w=w, h=h, 
                            clss=clss, score=track.score)
        return tracklet

def main():
    tracking = Tracking()
    rospy.Subscriber('detection/detections', Detections, 
                        tracking.detections_callback)
    r = rospy.Rate(tracking.rate)
    while not rospy.is_shutdown():
        r.sleep()
        if tracking.no_detection:
            tracking.detections_callback(Detections(detections=[]))
        else:
            tracking.no_detection = True

if __name__ == '__main__':
    main()
