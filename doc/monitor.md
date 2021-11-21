# Monitoring nodes

The monitoring nodes are meant to be executed on a different computer (e.g. your laptop) while having a network connection with the Jetsons, in order to minimize their impact on the performance.

## Network setup

The roscore is run by the Jetson. They should (?) have a correctly configured network, each being assigned a hostname which should be found somewhere on the board. Try to `ping <jetson-hostname>` to see if you can reach them.

In your terminal, export the following environment variables :

```bash
export ROS_HOSTNAME=monitor
export ROS_MASTER_URI=http://<jetson-hostname>:11311
```

The following calls to ROS utilities (`rosnode list`, `rostopic list`, ..) should successfully connect to the remote roscore. You can then run the monitor launch file.

For more information, check out the [Official ROS Tutorial](http://wiki.ros.org/ROS/NetworkSetup).

# `monitor_logger` node
## Topics & mapping

The `monitor_logger` node **listens** to the following topics :

- `/detection/boxes` : Bounding boxes output
- `/serial/target` : Target order
- ... (*TODO*)

It then prints the relevant information to its standard output.

# `monitor_video` node
## Topics & mapping

The `monitor_video` node **listens** to the following topics :

- `/camera/image` : Compressed video stream
- `/detection/boxes` : Bounding boxes output
- `/serial/target` : Coordinates of the current target, to be passed to the turret

The `monitor_video` node **publishes** to the following topics :

- `/monitor_video/image` : Output image, with drawn bounding boxes, tracklets and current target

