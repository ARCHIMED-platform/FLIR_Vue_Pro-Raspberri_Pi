# Controlling a FLIR Vue Pro with a Raspberry Pi

This repository is used to control a FLIR camera from a Raspberry Pi.

To do so, we have to use the accessory cable to connect through the PWM3 or 4 ports. Then, we can trigger up to 3 instructions using standard PWM inputs for the R/C industry: 3.3-5vdc, 50Hz. LOW = 1ms/20ms, MID = 1.5ms/20ms, HIGH = 2ms/20ms.

The instruction associated to the PWM inputs can be configured using the Vue Pro smartphone application. In this exemple we only use one instruction: trigger an image capture.

## Use the code

To use the code, you can simply download or clone this repository onto your Raspberry, then open Julia
(*e.g.* using VS Code), activate the project and instantiate the packages:

```julia
using Pkg
Pkg.activate(".")
Pkg.instantiate()
```

It will download the right packages for you.

Then open the script called `take_picture.jl`.

## External references

### Raspberry

[Follow this link](https://embeddedcircuits.com/raspberry-pi/tutorial/how-to-generate-pwm-signal-from-raspberry-pi) to better understand PWM.

[Follow this one](https://www.raspberrypi.org/documentation/usage/gpio/) for a list of GPIO (*i.e.* the pins) you can use for PWM.

### Arduino

See [this use case](https://forum.arduino.cc/index.php?topic=530180.0) for another example with an Arduino (French).

See this [link](https://randomnerdtutorials.com/esp32-pinout-reference-gpios/) to get the ESP32 pins that are compatible with PWM.
