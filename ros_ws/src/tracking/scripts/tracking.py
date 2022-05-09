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
        self.pub = rospy.Publisher('tracks', Tracklets, queue_size=1)

        # motpy - no confidence with the motion model (0.1)
        #       - more confidence with detections (5000)
        model_spec = {'order_pos': 1, 'dim_pos': 2,
                    'order_size': 0, 'dim_size': 2,
                    'q_var_size': 100., 'r_var_size': 10.,
                    'q_var_pos': 5000., 'r_var_pos': 0.1}

        matching_fn_kwargs = {
            'min_iou': 0.5,
            #'feature_similarity_beta': 0 
            # always compare with the cups of the 1st frame
        }
        
        self.model_spec = model_spec
        self.rate = rate
        self.mots = defaultdict(lambda: MultiObjectTracker(
            dt=1/rate,
            model_spec=model_spec, 
            matching_fn_kwargs=matching_fn_kwargs,
            #active_tracks_kwargs={'max_staleness_to_positive_ratio': 2000}
            # no early stage, one track per tracker, always active
        ))

    def detections_callback(self, detections_ros: Detections) -> Tracklets:
        rospy.loginfo(detections_ros.detections)

        # Keys are classes (c)
        class2detections = defaultdict(list)
        class2confs = defaultdict(float)
        for detection_ros in detections_ros.detections:
            detection, c, conf = self.det_ros2mot(detection_ros)
            class2detections[c].append(detection)
            class2confs[c].append(conf)
        
        tracklets = []
        for c, detections in class2detections.items():
            tracks, det_indices = self.mots[c].step(detections)
            for i, track in enumerate(tracks):
                det_idx = det_indices[i]
                tracklet = self.trk_mot2ros(track=track, class_=c, 
                                            conf=class2confs[c][det_idx])
                tracklets.append(tracklet)
        tracklets = Tracklets(tracklets=tracklets)
        self.pub.publish(tracklets)
        rospy.loginfo(tracklets.tracklets)
        return tracklets
        
    def det_ros2mot(self, detection: DetectionROS) -> DetectionMOT:
        box = np.array([detection.x, detection.y, 
                        detection.x + detection.w, detection.y + detection.h])
        return DetectionMOT(box=box), detection.cls, detection.confidence

    def trk_mot2ros(self, track: Track, cls_: int, conf: float) -> Tracklet:
        xmin, ymin, xmax, ymax = track.box
        x, y, w, h = xmin, ymin, xmax - xmin, ymax - ymin
        tracklet = Tracklet(x=x, y=y, w=w, h=h, cls=cls_, confidence=conf)
        return tracklet

def main():
    tracker = Tracker()
    rospy.Subscriber('detections', Detections, tracker.detections_callback)
    r = rospy.Rate(tracker.rate)
    while not rospy.is_shutdown():
        r.sleep()

if __name__ == '__main__':
    main()
