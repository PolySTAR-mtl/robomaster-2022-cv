# Serial link with the Control & Systems team

The serial protocol is defined in the following [Google Document](https://docs.google.com/document/d/1_WRp8hKwjJ7E_uIMwRmgCmimuRtpEut-U4GsiJyBkTw).

The serial settings are as followed (and described in `ros_ws/data/serial.yaml`) :

- Device : `/dev/ttyASM0`
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
