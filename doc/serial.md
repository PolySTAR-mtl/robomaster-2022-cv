# Serial link with the Control & Systems team

The serial protocol is defined in the following [Google Document](https://docs.google.com/document/d/1_WRp8hKwjJ7E_uIMwRmgCmimuRtpEut-U4GsiJyBkTw).

The serial settings are as followed (and described in `ros_ws/data/serial.yaml`) :

- Device : `/dev/ttyTHS0`
- Length : 8 bits
- Baud rate : 230 400 baud
- 1 stop bit
- No parity bit

## Topics & mapping

The `serial_interface` node **listens** to the following topics : 

- `/serial/target` : Coordinates of the current target, to be passed to the turret;
- `/serial/rune` : Coordinates of the rune (unused as of today);

The `serial_interface` node **publishes** to the following topics :

- `/serial/switch` : Order coming from the pilot to switch target left/right;
- `/serial/hp` : Health points of the robots;

The corresponding messages are defined in the serial package (`ros_ws/src/serial/msg`).

## Jetson setup

Check the pins for connections: https://jetsonhacks.com/nvidia-jetson-nano-j41-header-pinout/. Make sure that RX cable goes on TX pin (8) of the Jetson and TX cable on RX pin (10) of the Jetson. Add the ground (GND) on the pin 9.

The Tegra High speed Serial (THS) device is reserved for root users, so a chmod (`sudo chmod 777 /dev/ttyTHS0`) is
necessary (at each reboot) in order to use the serial node.

By default, the port is used as a serial terminal. The service has to be disabled
in order to allow the port to be used for communication. It should be the case on the Jetson, but you can check
by using: `systemctl status nvgetty`. If the command show service is "Active" you have to do the following:

```bash
sudo systemctl stop nvgetty
sudo systemctl disable nvgetty
```

Followed by a reboot.

