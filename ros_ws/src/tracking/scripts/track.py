#!/usr/bin/env python
"""
@file track.py

@author Sébastien Darche <sebastien.darche@polymtl>
"""

import rospy

from sensor_msgs.msg import Image
from detection.msg import Detections, Detection
from tracking.msg import Tracklets, Tracklet


class Tracker:

    def __init__(self):
        self.sub_detection = rospy.Subscriber(
            'detections_in', Image, self.detections_callback, queue_size=1)

        self.pub_tracks = rospy.Publisher('tracks', Tracklets, queue_size=1)

    def detections_callback(self, dets: Detections):
        return


if __name__ == '__main__':
    rospy.init_node('tracking', anonymous=False)
    tracker = Tracker()

    while not rospy.is_shutdown():
        rospy.spin()

