# Julia script to take IR images using the FLIR VUE PRO R and a Raspberry Pi.
# Author: R. Vezy
# Date: 07/03/2021

# First, don't forget to activate and instantiate the project:
# using Pkg; Pkg.activate("."); Pkg.instantiate()

# !NB: please use `sudo pigpiod` in the terminal of your Raspberry Pi before using this
# ! script and after install of the PiGPIO package. See https://github.com/JuliaBerry/PiGPIO.jl

# Import the library:
using PiGPIO

# Select the pin you use for the signal (must be PWM-compatible):
pin = 18

# Instantiate the connexion:
p = Pi()

# Set the mode of the Pin to output
set_mode(p, pin, PiGPIO.OUTPUT)

# Set the PWM frequency at 100 Hz:
PiGPIO.set_PWM_frequency(p, pin, 50)
# NB: the FLIR Vue Pro uses LOW = 1ms/20ms,
# MID = 1.5ms/20ms, HIGH = 2ms/20ms at 3.3-5vdc, 50Hz.
# So we need a 0.002 s pulse. At 50Hz, we need a duty cycle
# of 10%.

# Set the range to 0-100 (easier):
PiGPIO.set_PWM_range(p, pin, 100)

waiting_time = 60 # (seconds) time between two pictures
time_for_transfer = 0.5

# This is the code doing the work:
while true
    try
        PiGPIO.set_PWM_dutycycle(p, pin, 10)
        sleep(time_for_transfer) # wait for the signal to transfer
        PiGPIO.set_PWM_dutycycle(p, pin, 1) # Reset the signal to LOW
        sleep(waiting_time - time_for_transfer) # wait `waiting_time` seconds
    catch e
        println("Error in execution: $e")
    end
end
# The while loop above will execute until the end of time if you let it continue. It also
# catches any issues such as disconnection or anything else, it will then proceed to usual
# whenever the connexion is right again.

# In case you need to stop the script, don't forget to put the pin to INPUT mode again:
set_mode(p, pin, PiGPIO.INPUT) # changed it back to INPUT mode
