Extract EMG

This file is supplied to illustrate the normal operation of the Nexus to Python interface.
Oxford Metrics and Vicon Motion Systems accept no responsibility for its
correct operation

This code will import the raw EMG data, run a high pass Butterworth filter, apply a DC offset, rectify and
perform a low pass Butterworth filter. There will be two dropdown menus. The user will select the subject in the first
and the Butterworth filter order type (2nd order with lag or 4 th order with no lag). The user will have to enter
the high and low-pass filter cut-off frequencies. Once the inputs have been selected, press the "Submit" button.

In order to be written to a model output, the EMG data will be down sampled to match the video frame rate using a
cubic spline interpolation.

The rectified EMG and linear envelope will be recorded in the model outputs under the EMG heading.

The customer must have the following modules installed prior to the running of this code:

easygui
numpy
scipy
viconnexusapi
tkinter

Written in Python 3.9

The customer must have the EMG device named 'EMG' in the system file. The customer must also have a VSK

Written by Nev Pires