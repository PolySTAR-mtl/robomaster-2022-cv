#!/usr/bin/env python3
"""
@file track.py

@author Tzu-yi Chiu <tzuyi.chiu@gmail.com>
"""

import os
import numpy as np
import rospy

from sensor_msgs.msg import Image
from detection.msg import Detections, Detection as DetectionROS
from tracking.msg import Tracklets, Tracklet

from motpy import MultiObjectTracker, Track, Detection as DetectionMOT
from motpy.tracker import Tracker as TrackerMOT

dt = 1 # TODO : changer

class Tracker:
    def __init__(self):
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
            'min_iou': 0.5, # imposed by TP3
            'feature_similarity_beta': 0 
            # always compare with the cups of the 1st frame
        }
        
        self.model_spec = model_spec
        self.mot = MultiObjectTracker(
            dt=dt, 
            model_spec=model_spec, 
            matching_fn_kwargs=matching_fn_kwargs,
            active_tracks_kwargs={'max_staleness_to_positive_ratio': 2000}
            # no early stage, one track per tracker, always active
        )

    def detections_callback(self, detections_ros: Detections) -> Tracklets:
        rospy.loginfo(detections_ros.frame)
        detections_mot = []
        classes = []
        confidences = []
        for detection_ros in detections_ros.detections:
            detection_mot, class_, confidence = self.det_ros2mot(detection_ros)
            detections_mot.append(detection_mot)
            classes.append(class_)
            confidences.append(confidence)
                            
        if detections_ros.frame == 1:
            for detection in detections_mot:
                tracker = TrackerMOT(box0=detection.box, model_spec=self.model_spec, 
                                    smooth_feature_gamma=1.0, max_staleness=30.0)
                self.mot.trackers.append(tracker)
        tracks, det_indices = self.mot.step(detections_mot)
        tracklets = []
        for i, track in enumerate(tracks):
            det_idx = det_indices[i]
            tracklet = self.trk_mot2ros(track=track, class_=classes[det_idx], 
                                        conf=confidences[det_idx])
            tracklets.append(tracklet)
        tracklets = Tracklets(tracklets=tracklets)
        self.pub.publish(tracklets)
        rospy.loginfo(tracklets.tracklets)
        return tracklets
        #img = cv2.imread(os.path.join(VIDEO_FOLDER, f'frame{frame}.jpg'))
        #for det in detections_mot:
        #    img = draw_rectangle(img, det.box, color=(0, 255, 0), thickness=2)
        #for trk in tracks:
        #    img = draw_rectangle(img, det.box, color=(255, 0, 0), thickness=5)
        #cv2.imshow('Main', cv2.resize(img, (960, 540)))
        
    def det_ros2mot(self, detection: DetectionROS) -> DetectionMOT:
        box = np.array([detection.x, detection.y, 
                        detection.x + detection.w, detection.y + detection.h])
        return DetectionMOT(box=box), detection.cls, detection.confidence

    def trk_mot2ros(self, track: Track, class_: int, conf: float) -> Tracklet:
        xmin, ymin, xmax, ymax = track.box
        x, y, w, h = xmin, ymin, xmax - xmin, ymax - ymin
        tracklet = Tracklet(x=x, y=y, w=w, h=h, cls=class_, confidence=conf)
        return tracklet

def main():            
    tracker = Tracker()
    rospy.Subscriber('detections', Detections, tracker.detections_callback)
    while not rospy.is_shutdown():
        rospy.spin()

if __name__ == '__main__':
    main()
