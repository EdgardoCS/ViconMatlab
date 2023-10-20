# Extract EMG
#
# This file is supplied to illustrate the normal operation of the Nexus to Python interface.
# Oxford Metrics and Vicon Motion Systems accept no responsibility for its
# correct operation
#
# This code will import the raw EMG data, run a high pass Butterworth filter, apply a DC offset, rectify and
# perform a low pass Butterworth filter. There will be two dropdown menus. The user will select the subject in the first
# and the Butterworth filter order type (2nd order with lag or 4 th order with no lag). The user will have to enter
# the high and low-pass filter cut-off frequencies. Once the inputs have been selected, press the "Submit" button.
#
# In order to be written to a model output, the EMG data will be down sampled to match the video frame rate using a
# cubic spline interpolation.
#
# The rectified EMG and linear envelope will be recorded in the model outputs under the EMG heading.
#
# The customer must have the following modules installed prior to the running of this code:
#
# easygui
# numpy
# scipy
# viconnexusapi
# tkinter
#
# Written in Python 3.9
#
# The customer must have the EMG device named 'EMG' in the system file. The customer must also have a VSK
#
# Written by Nev Pires

from viconnexusapi import ViconNexus
import numpy as np
from scipy import signal, misc
from scipy import interpolate
import easygui
from easygui import *
import tkinter as tk
from tkinter import ttk
import sys

# Connect to Nexus
vicon = ViconNexus.ViconNexus()

# Get the list of subject names
subject_list = vicon.GetSubjectNames()

# Define the filter order options
filter_order_options = ["4th: No lag", "2nd: Lag"]

class EMGInput(tk.Frame):
    # Creates a GUI where the user will select the subject name, the order of filter and enter the high and low pass
    # filters
    def __init__(self, parent):
        tk.Frame.__init__(self, parent)
        self.parent = parent

        # Create the subject selection header
        self.subject_selection_header = ttk.Label(root, text="Select Subject")
        self.subject_selection_header.grid(column=0, row=0)

        # Create the dropdown menu with the subject names listed
        self.subject_selection_menu = tk.StringVar()
        self.subject_selection_menu.set("Subject Name")

        self.subject_selection = tk.OptionMenu(root, self.subject_selection_menu, *subject_list)
        self.subject_selection.grid(column=0, row=1)

        # Create the filter order header
        self.filter_order_header = ttk.Label(root,
            text="Select the Butterworth filter order")
        self.filter_order_header.grid(column=1, row=0)

        # Create the dropdown menu with the list of Butterworth filter orders
        self.filter_order_selection_menu = tk.StringVar()
        self.filter_order_selection_menu.set("Choose Filter Order")

        self.filter_order_selection = tk.OptionMenu(root, self.filter_order_selection_menu, *filter_order_options)
        self.filter_order_selection.grid(column=1, row=1)

        # Create an entry for the HPF Cut-off
        self.HPF_cut_off_header = ttk.Label(root, text="Enter the High Pass Cut-Off frequency")
        self.HPF_cut_off_header.grid(column=2, row=0)

        self.HPF_cut_off_entry = ttk.Entry(root)
        self.HPF_cut_off_entry.grid(column=2, row=1)

        # Create an entry for the HPF Cut-off
        self.LPF_cut_off_header = ttk.Label(root, text="Enter the Low Pass Cut-Off frequency")
        self.LPF_cut_off_header.grid(column=3, row=0)

        self.LPF_cut_off_entry = ttk.Entry(root)
        self.LPF_cut_off_entry.grid(column=3, row=1)

        # Creates a button to close the window and continue

        self.submit_button = tk.Button(root, text="Submit", command=self.close_window)
        self.submit_button.grid(column=2, row=2)

        self.subject = []
        self.filter_order = []
        self.HPF_cut_off = []
        self.LPF_cut_off = []

    def close_window(self):
        self.subject = self.subject_selection_menu.get()
        self.filter_order = self.filter_order_selection_menu.get()
        self.HPF_cut_off = self.HPF_cut_off_entry.get()
        self.LPF_cut_off = self.LPF_cut_off_entry.get()
        self.quit()

# Executes the above function and class

if __name__ == '__main__':
    root = tk.Tk()
    app = EMGInput(root)
    root.mainloop()
    subject = app.subject
    order = app.filter_order
    HPF = int(app.HPF_cut_off)
    LPF = int(app.LPF_cut_off)
    try:
        root.destroy()
    except:
        sys.exit(1)

if order == "4th: No lag":
    order = 4
elif order == "2nd: lag":
    order = 2

# Get Frame Rate
video_frame_rate = vicon.GetFrameRate()

# Get Start and End Frame
start_frame = vicon.GetTrialRegionOfInterest()[0]
end_frame = vicon.GetTrialRegionOfInterest()[1]
trial_range = end_frame - start_frame + 1

# Get Device Names
device_names = vicon.GetDeviceNames()

# Get EMG ID
EMG_ID = vicon.GetDeviceIDFromName("EMG")

# Determine if the EMG device exists in the list and then, give a warning if no EMG device is found
EMG_exists = [True if "EMG" in device_names else False]
if not EMG_exists:
    msgbox("No EMG Device is found in this trial. Please make sure your device is named 'EMG'")

# Get the EMG Frame Rate
EMG_frame_rate = vicon.GetDeviceDetails(EMG_ID)[2]

# Get the EMG Output ID
output_ID_num = vicon.GetDeviceDetails(EMG_ID)[3]

# Assign the output ID to a dictionary where the keys are the EMG output names and the values are the output IDs
output_IDs = {vicon.GetDeviceOutputDetails(EMG_ID, ID)[0]: ID for ID in output_ID_num}

# Get the channel IDs
channel_IDs = {output_name: {vicon.GetDeviceOutputDetails(EMG_ID, output_ID)[4][0]:
                   vicon.GetDeviceOutputDetails(EMG_ID, output_ID)[5][0]}
               for output_name, output_ID in output_IDs.items()}

# Get the Raw EMG Data
EMG_raw = {output_name: {channel_name: vicon.GetDeviceChannelGlobal(EMG_ID, output_ID,
                                    vicon.GetDeviceChannelIDFromName(EMG_ID, output_ID, channel_name))[0]
                         for channel_name, channel_ID in channel_IDs[output_name].items()}
           for output_name, output_ID in output_IDs.items()}

# Apply HPF based off HPF cut-off
b_HPF, a_HPF = signal.butter(order, HPF*2/EMG_frame_rate, 'high', analog=False)
EMG_HPF = {output_name: {channel_name: signal.filtfilt(b_HPF, a_HPF, EMG_raw[output_name][channel_name])
                         for channel_name in channel_IDs[output_name].keys()}
           for output_name in output_IDs.keys()}

# Take off DC Offset
EMG_DC_offset = {output_name: {channel_name: EMG_HPF[output_name][channel_name]
                                for channel_name in channel_IDs[output_name].keys()}
                  for output_name in output_IDs.keys()}

# Rectify Data
EMG_rectified = {output_name: {channel_name: np.absolute(EMG_DC_offset[output_name][channel_name])
                               for channel_name in channel_IDs[output_name].keys()}
                 for output_name in output_IDs.keys()}

# Apply LPF based off LPF cut-off
b_LPF, a_LPF = signal.butter(order, LPF*2/EMG_frame_rate, 'low', analog=False)
EMG_LPF = {output_name: {channel_name: signal.filtfilt(b_LPF, a_LPF, EMG_rectified[output_name][channel_name])
                         for channel_name in channel_IDs[output_name].keys()}
           for output_name in output_IDs.keys()}

# Get ModelOutput List
full_model_output_list = vicon.GetModelOutputNames(subject)

# Create new model output names
rectified_names = [output_name + '_' + channel_name + '_rectified' for output_name in output_IDs.keys()
                   for channel_name in channel_IDs[output_name].keys()]

linear_envelope_names = [output_name + '_' + channel_name + '_linear_envelope' for output_name in output_IDs.keys()
                   for channel_name in channel_IDs[output_name].keys()]

new_model_output_names = rectified_names + linear_envelope_names

# Create Model Output
_ = [vicon.CreateModelOutput(subject, model_name, 'EMG', {'EMG', 'EMG', 'EMG'},
                             {'Electric Potential', 'Electric Potential', 'Electric Potential'})
     for model_name in new_model_output_names if model_name not in full_model_output_list]

# Down sample Rectified EMG and the linear envelope
x1 = range(int(trial_range * EMG_frame_rate/video_frame_rate))
y1_rectified = {output_name: {channel_name: EMG_rectified[output_name][channel_name]
                         for channel_name in channel_IDs[output_name].keys()}
           for output_name in output_IDs.keys()}

y1_linear_envelope = {output_name: {channel_name: EMG_LPF[output_name][channel_name]
                         for channel_name in channel_IDs[output_name].keys()}
           for output_name in output_IDs.keys()}

x2 = list(np.array(np.linspace(start_frame, len(x1), trial_range)))

tck_rectified = {output_name: {channel_name: interpolate.splrep(x1, y1_rectified[output_name][channel_name])
                         for channel_name in channel_IDs[output_name].keys()}
           for output_name in output_IDs.keys()}

tck_linear_envelope = {output_name: {channel_name: interpolate.splrep(x1, y1_linear_envelope[output_name][channel_name])
                         for channel_name in channel_IDs[output_name].keys()}
           for output_name in output_IDs.keys()}

y2_rectified = {output_name + "_" + channel_name + "_rectified":
                    list(interpolate.splev(x2, tck_rectified[output_name][channel_name]))
                for output_name in output_IDs.keys()
                for channel_name in channel_IDs[output_name]}

y2_linear_envelope = {output_name + "_" + channel_name + "_linear_envelope":
                    list(interpolate.splev(x2, tck_linear_envelope[output_name][channel_name]))
                for output_name in output_IDs.keys()
                for channel_name in channel_IDs[output_name]}

y2_rectified_names = y2_rectified.keys()
y2_linear_envelope_names = y2_linear_envelope.keys()

y2_rectified_output = {name: [float(frames) for frames in y2_rectified[name]] for name in y2_rectified_names}
y2_linear_envelope_output = {name: [float(frames)
                                    for frames in y2_linear_envelope[name]] for name in y2_linear_envelope_names}

# Create a True list so that data exists
exists = [True for frames in x2]

# Set Model Output
_ = [vicon.SetModelOutput(subject, name, [y2_rectified_output[name]], exists) for name in rectified_names]
_ = [vicon.SetModelOutput(subject, name, [y2_linear_envelope_output[name]], exists)
     for name in linear_envelope_names]
