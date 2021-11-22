#!/usr/bin/env python
"""
@file detection.py
@brief Main detection node : bounding box extraction from the video stream

@author Sébastien Darche <sebastien.darche@polymtl>
"""

import rospy

from cv_bridge import CvBridge, CvBridgeError
from sensor_msgs.msg import Image
from detection.msg import Detections, Detection


class Detector:

    def __init__(self):
        self.bridge = CvBridge()

        self.sub_image = rospy.Subscriber(
            'camera_in', Image, self.image_callback, queue_size=1)

        self.pub_detect = rospy.Publisher('boxes', Detections, queue_size=1)

    def image_callback(self, im: Image):
        try:
            im = self.bridge.imgmsg_to_cv2(im)
        except CvBridgeError as e:
            rospy.logerr(f'Could not get cv2 image : {e}')
            return

        rospy.logdebug('Detector.image_callback TODO')
        return


if __name__ == '__main__':
    rospy.init_node('detection', anonymous=False)
    detector = Detector()

    while not rospy.is_shutdown():
        rospy.spin()
