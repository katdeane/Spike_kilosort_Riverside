# -*- coding: utf-8 -*-
"""
Created on Sat May 16 15:40:00 2026

 
 TO DO: 
     - Figure out best settings for single neuron spike detection 
     🗸 create loop to run through .bin files in output folder 
         🗸 print file directory in folder
         🗸 concatonate into list
         🗸 loop
     🗸 override default to generate folder with unique names for Phy sorting
"""

import os
from os import listdir
from os.path import isfile, join, isdir
from kilosort import run_kilosort
#from tkinter import Tk
from tkinter.filedialog import askdirectory

# set the operating directory 
homedir=os.path.dirname("E:\\Spike_kilosort_Riverside")
# select the folder with .bin data for sorting; everything inside will be processed
path = askdirectory(title='Select Folder')

# pull list of bin files and the list of directories
FileList = [f for f in listdir(path) if isfile(join(path, f))]
FileList = [f for f in FileList if f.endswith('.bin')]
DirList  = [f for f in listdir(path) if isdir(join(path, f))]
# remove files for which there is already a directory (already sorted)
FileList =  [f for f in FileList if not f.startswith(tuple(DirList))]

# now loop through files to process
for ibin in FileList:
    filepath = path + '\\' + ibin
    resultpath = path + '\\' + ibin[0:-9] # cutting off '_bulk.bin'

    settings = {'filename': filepath, 'n_chan_bin': 32, 'results_dir': resultpath}

    ops, st, clu, tF, Wall, similar_templates, is_ref, est_contam_rate, kept_spikes = \
        run_kilosort(
            settings=settings, probe_name='probe.json',
            # save_preprocessed_copy=True
            )
    
    
    
    