#!/usr/bin/env python
"""
@file track.py

@author Tzu-yi Chiu <tzuyi.chiu@gmail.com>
"""

PROJECT_FOLDER = os.path.dirname(os.path.realpath(__file__))
DATASET_FOLDER = os.path.join(PROJECT_FOLDER, 'TP3_data')
VIDEO_FOLDER = os.path.join(DATASET_FOLDER, 'frames')

import rospy

from sensor_msgs.msg import Image
from detection.msg import Detections, Detection as DetectionROS
from tracking.msg import Tracklets, Tracklet

from motpy import MultiObjectTracker, Track, Detection as DetectionMOT

class Tracker:
    def __init__(self):
        # ROS
        self.sub = rospy.Subscriber(
            'detections_in', Detections, self.detections_callback, queue_size=1)

        self.pub = rospy.Publisher('tracks', Tracklets, queue_size=1)

        # motpy - no confidence with the motion model (0.1)
        #       - more confidence with detections (5000)
        model_spec = {'order_pos': 1, 'dim_pos': 2,
                    'order_size': 0, 'dim_size': 2,
                    'q_var_size': 100., 'r_var_size': 10.,
                    'q_var_pos': 5000., 'r_var_pos': 0.1}
        
        self.mot = MultiObjectTracker(model_spec=model_spec)

    def detections_callback(self, detections_ros: Detections) -> Tracklets:
        detections_mot = [self.det_ros2mot(detection_ros) 
                            for detection_ros in detections_ros.detections]
        tracks = self.mot.step(detections_mot)
        tracklets = Tracklets([self.trk_mot2ros(track) for track in tracks])
        self.pub.publish(tracklets)

        frame = detections_ros.frame
        img = cv2.imread(os.path.join(VIDEO_FOLDER, f'frame{frame}.jpg'))
        for det in detections_mot:
            img = draw_rectangle(img, det.box, color=(0, 255, 0), thickness=2)
        for trk in tracks:
            img = draw_rectangle(img, det.box, color=(255, 0, 0), thickness=5)
        cv2.imshow('Main', cv2.resize(img, (960, 540)))
        
    def det_ros2mot(self, detection: DetectionROS) -> DetectionMOT:
        box = np.array([detection.x, detection.y, 
                        detection.x + detection.w, detection.y + detection.h])
        return DetectionMOT(box=box)

    def trk_mot2ros(self, track: Track) -> Tracklet:
        tracklet = Tracklet(box=list(track.box))
        return tracklet

def main():            
    rospy.init_node('tracking', anonymous=False)
    tracker = Tracker()
    while not rospy.is_shutdown():
        rospy.spin()

if __name__ == '__main__':
    main()
